# stdcfg::time
#
# Manage settings related to time syncing, timezone, etc.
#
# @summary Manage settings related to time syncing, timezone, etc.
#
# @example
#   include stdcfg::time
class stdcfg::time (
  Array[String] $ntp_servers,
  String        $timezone,
) {

  # TIMEZONE (requires saz-timezone module)
  class { 'timezone':
    timezone => $timezone,
  }

  # DISABLE NTP
  service { 'ntpd':
    ensure => stopped,
    enable => false,
  }
  package { "ntp":
    ensure => purged,
  }

  # ENABLE CHRONY (requires beergeek-chronyd module)
    class { '::chronyd':
      servers => $ntp_servers,
    }
  }

}
