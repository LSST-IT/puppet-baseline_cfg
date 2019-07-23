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

    ini_setting {
        default:
            ensure  => present,
            path    => $config_file,
            section => 'agent',
            ;
        'Puppet agent runinterval':
            setting => 'runinterval',
            value   => $runinterval,
            ;
        'Puppet agent server':
            setting => 'server',
            value   => $server,
            ;
        'Puppet agent environment':
            setting => 'environment',
            value   => $environment,
            ;
    }

    service{ 'puppet':
        ensure => $service_state,
        enable => true,
    }

}
