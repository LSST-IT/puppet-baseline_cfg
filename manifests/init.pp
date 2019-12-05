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
    include ::baseline_cfg::vmware

    ## OTHER MODULES DEPEND ON CONTAINER/VIRTUAL TYPE
    $additional_modules = [
        '::baseline_cfg::lvm',
        '::baseline_cfg::networkmanager',
        '::baseline_cfg::firewall',
        '::unbound',
    ]
    #exclude based on virtual type
    $exclude_modules = $::virtual ? {
        'docker'     => $additional_modules,
        default      => [],
    }
    #include only relevant modules
    $select_modules = $additional_modules - $exclude_modules
    include $select_modules

    ## yum repos only valid for RedHat family
    if $facts['os']['family'] == 'RedHat' {
        include ::baseline_cfg::additional_yumrepos
    }
}
