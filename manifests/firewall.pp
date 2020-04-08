# @summary Initial firewall configuration (suitable for K8S)
#
# @example
#   include baseline_cfg::firewall
class baseline_cfg::firewall {

    ## SETUP FIREWALL MODULE
    include ::baseline_cfg::firewall::post
    include ::baseline_cfg::firewall::pre
    include ::firewall

    ### ADDITIONAL FIREWALL CONFIG
    Firewall {
        before => Class['baseline_cfg::firewall::post'],
        require => Class['baseline_cfg::firewall::pre'],
    }


}
