# baseline_cfg::selinux
#
# Configure selinux status
#
# @summary Configure selinux status
#
# @example
#   include baseline_cfg::selinux
class baseline_cfg::selinux (
  String $status,
) {

  $status_code = $status ? {
    'enforcing' => '1',
    default     => '0',
  }

  exec { 'set selinux status':
    command => "/usr/sbin/setenforce ${status_code}",
    unless  => "/usr/sbin/sestatus | /bin/egrep -i 'selinux status|current mode' | /bin/egrep -i '${status}'",
  }

  file_line { 'set selinux config':
    ensure => 'present',
    path   => '/etc/selinux/config',
    line   => "SELINUX=${status}",
    match  => '^SELINUX=.*$',
  }



}
