# @summary Start / Stop NetworkManager service
#
class baseline_cfg::networkmanager (
    String  $ensure,
    Boolean $enable,
    String  $service_name,
) {

	service { $service_name:
		ensure => $ensure,
		enable => $enable,
	}

}
