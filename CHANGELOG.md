# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](http://keepachangelog.com/en/1.0.0/) and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [2.0.0] - 2021-11-19

This module has been forked from [thias-tuned](https://github.com/thias/puppet-tuned) to add support for new Linux distributions and fixing some very minor issues.

### Fixed
* Hard-coded service name instead of variable

### Added
* Support for AlmaLinux and Rocky Linux
* Data types for class parameters

### Changed
* Module no longer fails gracefully on unsupported systems
* Document module with Puppet Strings

### Removed
* systemd drop-in configuration to start tuned before some DBMS services
* Support for Puppet <=5.5.17


## [1.0.4] - 2019-11-20
### Added
* Ensure systemd starts tuned before some DBMS services (#20, @osgpcq).


## [1.0.3] - 2016-02-11
### Fixed
* Fix ordering, the service must be running to set profile with tuned-adm.


## [1.0.2] - 2015-04-28
### Fixed
* Notify service(s) when the profile files change.


## [1.0.1] - 2015-04-01
### Changed
* Set default profile to 'balanced' on RHEL7 and Fedora.


## [1.0.0] - 2014-11-11
### Added
* Add support for newer RHEL/CentOS 7 (#7, @stzilli).


## [0.2.1] - 2014-04-08
### Changed
* Make tuned fail gracefully on unsupported systems (idea from cstackpole).

### Added
* Add support for CloudLinux (#3, Maurits Landewers).

### Fixed
* Fix missing /sbin from tuned-adm profile exec (#5, @mlehner616).


## [0.2.0] - 2013-03-07
### Changed
* Support external custom profiles.
* Support ensure => absent for removal.
* Change to 2 space indent.
* Add examples and use markdown for the README.


## [0.0.1] - 2012-10-11
* Initial module release.
