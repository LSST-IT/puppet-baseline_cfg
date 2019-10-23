# @summary A short summary of the purpose of this class
#
# A description of what this class does
#
# @example
#   include baseline_cfg::firewall::pre
class baseline_cfg::firewall::pre {

    Firewall {
        require => undef,
    }

    firewall { '000 accept all icmp':
        proto  => 'icmp',
        action => 'accept',
    }

    firewall { '001 accept all to lo':
        proto   => 'all',
        iniface => 'lo',
        action  => 'accept',
    }

    firewall { '002 accept related established':
        proto  => 'all',
        state  => ['RELATED', 'ESTABLISHED'],
        action => 'accept',
    }

}
