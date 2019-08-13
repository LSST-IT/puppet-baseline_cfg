# baseline_cfg::vmware
#
# A description of what this class does
#
# @summary Manage settings related to virtual machines, e.g. vmware
#
# @example
#   include baseline_cfg::vmware
class baseline_cfg::vmware (
  Array[ String[1] ] $packages,
  Array[ String[1] ] $services,
) {

  if ( $::virtual == 'vmware' )
  {
    # REMOVE OLDER VMware TOOLS
    service { 'vmware-tools':
      ensure     => stopped,
      enable     => false,
      hasstatus  => true,
      hasrestart => true,
    }
    exec { 'vmware-uninstall-tools':
      command => '/usr/bin/vmware-uninstall-tools.pl',
      require => Service['vmware-tools'],
      onlyif  => 'test -x /usr/bin/vmware-uninstall-tools.pl',
      path    => ['/usr/bin', '/usr/sbin'],
    }

    # INSTALL $packages
    ensure_packages(
      $packages,
      { 'notify' => Service[ $services ], }
    )
    # ENABLE services
    service { $services:
      ensure     => running,
      enable     => true,
      hasstatus  => true,
      hasrestart => true,
    }

  }

}
