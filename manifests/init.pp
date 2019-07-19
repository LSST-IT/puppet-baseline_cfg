# baseline_cfg
#
# Core set of things that apply to ALL nodes across the board (no exceptions)
#
# @summary Core set of things that apply to ALL nodes across the board (no exceptions)
#
# @example
#   include baseline_cfg
class baseline_cfg {
    include ::baseline_cfg::additional_packages
    include ::baseline_cfg::email
    include ::baseline_cfg::motd
    include ::baseline_cfg::puppet
    include ::baseline_cfg::selinux
    include ::baseline_cfg::time
}
