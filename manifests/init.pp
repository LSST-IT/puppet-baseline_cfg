# stdcfg
#
# Core set of things that apply to ALL nodes across the board (no exceptions)
#
# @summary Core set of things that apply to ALL nodes across the board (no exceptions)
#
# @example
#   include stdcfg
class stdcfg {
    include ::stdcfg::additional_packages
    include ::stdcfg::email
    include ::stdcfg::selinux
    include ::stdcfg::time
}
