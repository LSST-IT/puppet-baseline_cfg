# @summary Default firewall post rule, Drop all
#
# @example
#   include baseline_cfg::firewall::post
class baseline_cfg::firewall::post {

    firewall { '999 drop all':
        proto  => 'all',
        action => 'drop',
        before => undef,
    }

}
