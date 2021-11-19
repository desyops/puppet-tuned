# @summary Configure the tuned adaptive system tuning daemon (tuned)
#
# @example Basic usage
#   include tuned
#
# @see https://tuned-project.org/
#
# @param ensure
#   Presence of tuned, 'absent' to disable and remove. Default: 'present'
# @param profile
#   Profile to use, see 'tuned-adm list'. Default: 'balanced'
# @param source
#   Puppet source location for the profile's files, used only for non-default
#   profiles. Default: undef
# @param active_profile
#   Name of the file, where the currently active profile is stored. Default: OS specific value
# @param profile_path
#   Path to the directory, where tuned stores profiles. Default: OS specific value
# @param tuned_services
#   Array of service names of the tuned daemon(s). Default: OS specific value
#
class tuned (
  Enum['present', 'absent'] $ensure = 'present',
  String $profile                   = $tuned::params::default_profile,
  Optional[String] $source          = undef,
  String $active_profile            = $tuned::params::active_profile,
  String $profile_path              = $tuned::params::profile_path,
  Array $tuned_services             = $tuned::params::tuned_services,
) inherits tuned::params {

  # One package
  package {'tuned':
    ensure => $ensure,
  }

  # Only if we are 'present'
  if $ensure == 'present' {
    # Enable the service
    service { $tuned_services:
      ensure    => true,
      enable    => true,
      hasstatus => true,
      require   => Package['tuned'],
    }

    # Enable the chosen profile
    exec { "tuned-adm profile ${profile}":
      unless  => "grep -q -e '^${profile}\$' ${profile_path}/${active_profile}",
      path    => [ '/sbin', '/bin', '/usr/sbin', '/usr/bin'],
      require => Service[$tuned_services],
      # No need to notify services, tuned-adm restarts them alone
    }

    # Install the profile's file tree if source is given
    if $source {
      file { "${profile_path}/${profile}":
        ensure  => directory,
        owner   => 'root',
        group   => 'root',
        # This magically becomes 755 for directories
        mode    => '0644',
        recurse => true,
        purge   => true,
        source  => $source,
        # For the parent directory
        require => Package['tuned'],
        before  => Exec["tuned-adm profile ${profile}"],
        notify  => Service[$tuned_services],
      }
    }
  }
}
