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

Puppet module for configuring standard settings of all servers.
This is the core set of things (packages, software, services, configuration, etc.)
that apply to ALL nodes across the board (no exceptions).

## Setup

### What baseline_cfg affects

:warning: NEEDS REVIEW

The `baseline_cfg` module affects the following services on a given server:

  * basic package installation
  * email configuration
  * firewall minimal configuration
  * motd configuration
  * syslog configuration
  * vmtools configuration

In addition, for non-container deployments this module affects the following services on a given server:

  * disk and partition configuration
  * dns resolution configuration
  * firewall basic configuration
  * network configuration
  * yum mirror repo configuration

### Setup Requirements

:warning: NEEDS REVIEW

This module requires the following puppet modules to be installed:

  * https://forge.puppet.com/aboe/chrony
  * https://forge.puppet.com/herculesteam/augeasproviders_core
  * https://forge.puppet.com/puppetlabs/firewall
  * https://forge.puppet.com/puppetlabs/lvm
  * https://forge.puppet.com/puppetlabs/stdlib
  * https://forge.puppet.com/puppet/rsyslog

### Beginning with baseline_cfg

## Usage

`include baseline_cfg`

## Reference

The following parameters let you extend baseline_cfg options beyond the default:

See: [REFERENCE.md](REFERENCE.md)
