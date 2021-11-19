class tuned::params {

  case $facts['os']['family'] {
    'RedHat': {
      if versioncmp($facts['os']['release']['major'], '7') >= 0 or $facts['os']['name'] == 'Fedora' {
        $default_profile = 'balanced'
        $tuned_services  = [ 'tuned' ]
        $profile_path    = '/etc/tuned'
        $active_profile  = 'active_profile'
      } else {
        $default_profile = 'default'
        $tuned_services  = [ 'tuned', 'ktune' ]
        $profile_path    = '/etc/tune-profiles'
        $active_profile  = 'active-profile'
      }
    }
    default: {
      fail("${module_name} is not supported on ${facts['os']['family']}.")
    }
  }
}
