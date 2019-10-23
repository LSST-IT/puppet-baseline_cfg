# @summary Configure yum.conf
#
# @example
#   include baseline_cfg::yum
class baseline_cfg::yum {

    # Prevent the client from asking for delta RPMs.
    file_line { 'etc_yum.conf_deltarpm_0':
        path => '/etc/yum.conf',
        line => 'deltarpm=0',
    }

    # Limit the number of old kernels after kernel updates / upgrades.
    file_line { 'etc_yum.conf_installonly_limit_2':
        path    => '/etc/yum.conf',
        replace => true,
        line    => 'installonly_limit=2',
        match   => 'installonly_limit=5',
    }

}
