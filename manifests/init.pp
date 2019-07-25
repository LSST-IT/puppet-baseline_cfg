# baseline_cfg
#
# Core set of things that apply to ALL nodes across the board (no exceptions)
#
# @summary Core set of things that apply to ALL nodes across the board (no exceptions)
#
# @example
#   include baseline_cfg
class baseline_cfg {

    ## ALL SYSTEMS INCLUDING CONTAINERS
    include ::baseline_cfg::additional_packages
    include ::baseline_cfg::email
    include ::baseline_cfg::motd
    include ::baseline_cfg::puppet

    ## NON-CONTAINER CONFIGURATION
    ## MAY NEED TO ADD ADDITIONAL CONTAINER TYPES BELOW
    if ( $::virtual !~ /docker/ )
    {
#        include ::baseline_cfg::disk
#        include ::baseline_cfg::dns_resolv
#        include ::baseline_cfg::network
        include ::baseline_cfg::selinux
#        include ::baseline_cfg::syslog
        include ::baseline_cfg::time
#        include ::baseline_cfg::vmtools
#        include ::baseline_cfg::yum_repo
    }

}
