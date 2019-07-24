# baseline_cfg::puppet
#
# Configure puppet client
#
# @summary Configure puppet client
#
# @example
#   include baseline_cfg::puppet
class baseline_cfg::puppet (
  String $config_file,
  String $environment,
  String $runinterval,
  String $server,
  String $service_state,
) {

  ini_setting { 'Puppet agent runinterval':
    ensure  => present,
    path    => $config_file,
    section => 'agent',
    setting => 'runinterval',
    value   => $runinterval,
  }

  ini_setting { 'Puppet agent server':
    ensure  => present,
    path    => $config_file,
    section => 'agent',
    setting => 'server',
    value   => $server,
  }

  ini_setting { 'Puppet agent environment':
    ensure  => present,
    path    => $config_file,
    section => 'agent',
    setting => 'server',
    value   => $environment,
  }

# WHAT IS THIS FOR?
#  file{'/opt/puppetlabs/puppet/cache':
#    ensure => 'directory',
#    mode   => '0755',
#  }

  service{ 'puppet':
    ensure => $service_state,
    enable => true,
  }

}
