
# baseline_cfg

#### Table of Contents

1. [Description](#description)
2. [Setup - The basics of getting started with baseline_cfg](#setup)
    * [What baseline_cfg affects](#what-baseline_cfg-affects)
    * [Setup requirements](#setup-requirements)
    * [Beginning with baseline_cfg](#beginning-with-baseline_cfg)
3. [Usage - Configuration options and additional functionality](#usage)
4. [Limitations - OS compatibility, etc.](#limitations)

## Description

Puppet module for configuring standard settings of all LSST servers. Think of this as setting up the bare minimum configurations for using an LSST server.

This includes the Core set of things that apply to ALL nodes across the board (no exceptions).

## Setup

### What baseline_cfg affects

The `baseline_cfg` module affects the following services on a given server:

  * basic package installation
  * email configuration
  * firewall configuration
  * motd configuration
  * puppet client configuration

In addition, for non-container deployments this module affects the following services on a given server:

  * disk and partition configuration
  * dns resolution configuration
  * network configuration
  * selinux configuration
  * syslog configuration
  * time configuration
  * vmtools configuration
  * yum mirror repo configuration

### Setup Requirements

This module requires the following puppet modules to be installed:

  * https://forge.puppet.com/beergeek/chronyd
  * https://forge.puppet.com/crayfishx/firewalld
  * https://forge.puppet.com/puppetlabs/inifile
  * https://forge.puppet.com/puppetlabs/stdlib
  * https://forge.puppet.com/saz/timezone

### Beginning with baseline_cfg

## Usage

To load the baseline_cfg puppet module, declare this class in your manifest with `include baseline_cfg`.

## Reference

The following parameters let you extend baseline_cfg options beyond the default:

  * `baseline_cfg::additional_packages` - Array of yum packages to install
  * `baseline_cfg::email::required_pkgs` - Array of packages to install for email support
  * `baseline_cfg::email::canonical_aliases` - String of connonical email aliases
  * `baseline_cfg::email::virtual_aliases` - String of virutal email aliases
  * `baseline_cfg::email::mydomain` - String of domain used by email
  * `baseline_cfg::email::relayhost` - String of relayhost used by email (smtp server)
  * `baseline_cfg::motd::next_maintenance` - Array of start/stop date/times
  * `baseline_cfg::motd::next_maintenance_details` - String with more details for maintenance
  * `baseline_cfg::motd::next_maintenance_timezone` - String with timezone for maintenance
  * `baseline_cfg::motd::notice` - String with optional notice to include in motd
  * `baseline_cfg::puppet::config_file` - String of puppet config file full path
  * `baseline_cfg::puppet::environment` - String of puppet environment to use
  * `baseline_cfg::puppet::runinterval` - String of puppet agent run interval
  * `baseline_cfg::puppet::server` - String of puppet server to use
  * `baseline_cfg::puppet::service_state` - String of puppet agent server status
  * `baseline_cfg::selinux::status` - String of status for SElinux
  * `baseline_cfg::time::ntp_servers` - Array of ntp servers to use
  * `baseline_cfg::time::timezone` - String of timezone to use

