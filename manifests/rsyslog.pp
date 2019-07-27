# baseline_cfg::rsyslog
#
# Manage settings related to rsyslog and log forwarding
#
# @summary Manage settings related to rsyslog and log forwarding
#
# @example
#   include baseline_cfg::rsyslog
class baseline_cfg::rsyslog (
  String $yumrepo_baseurl,
  String $yumrepo_gpgkey,
  String $yumrepo_name,
  Hash   $config,
) {

  ## install Yum repo for ryslog
  yumrepo { 'rsyslog-v8-stable':
    baseurl  => $yumrepo_baseurl,
    descr    => $yumrepo_name,
    enabled  => 1,
    gpgcheck => 1,
    gpgkey   => $yumrepo_gpgkey,
    before   => Class['rsyslog::install'],
  }

  class { 'rsyslog::client':
    * => $config
  }

}
