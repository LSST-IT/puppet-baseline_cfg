# @summary Initial firewall configuration
#
# @example
#   include baseline_cfg::firewall
class baseline_cfg::firewall {

    ## SETUP FIREWALL MODULE
    include ::baseline_cfg::firewall::post
    include ::baseline_cfg::firewall::pre
    include ::firewall

    ### FILTER TABLE RULES
    firewallchain { 'INPUT:filter:IPv4':
        ensure => present,
        purge  => true,
        ignore => [ 'docker', 'DOCKER', 'weave', 'WEAVE', 'kube', 'KUBE' ],
    }

    firewallchain { 'OUTPUT:filter:IPv4':
        ensure => present,
        purge  => true,
        ignore => [ 'docker', 'DOCKER', 'weave', 'WEAVE', 'kube', 'KUBE' ],
    }

    firewallchain { 'FORWARD:filter:IPv4':
        purge  => true,
        ignore => [ 'docker', 'DOCKER', 'weave', 'WEAVE', 'kube', 'KUBE' ],
    }

    firewallchain { 'DOCKER:filter:IPv4':
        purge  => false,
    }

    ### NAT TABLE RULES
    firewallchain { 'INPUT:nat:IPv4':
        purge  => true,
        ignore => [ 'docker', 'DOCKER', 'weave', 'WEAVE', 'kube', 'KUBE' ],
    }

    firewallchain { 'OUTPUT:nat:IPv4':
        purge  => true,
        ignore => [ 'docker', 'DOCKER', 'weave', 'WEAVE', 'kube', 'KUBE' ],
    }

    firewallchain { 'DOCKER:nat:IPv4':
        purge  => false,
    }

    firewallchain { 'POSTROUTING:nat:IPv4':
        purge  => true,
        ignore => [ 'docker', 'DOCKER', '172.17', 'weave', 'WEAVE', 'kube', 'KUBE' ],
    }

    firewallchain { 'PREROUTING:nat:IPv4':
        purge  => true,
        ignore => [ 'docker', 'DOCKER', 'weave', 'WEAVE', 'kube', 'KUBE' ],
    }

    ### ADDITIONAL FIREWALL CONFIG
    Firewall {
        before => Class['baseline_cfg::firewall::post'],
        require => Class['baseline_cfg::firewall::pre'],
    }


}
