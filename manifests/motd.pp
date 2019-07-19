# baseline_cfg::motd
# 
# Configure motd
#
# @summary Configure motd
#
# @example
#   include baseline_cfg::motd
class baseline_cfg::motd(

  # Parameters
  Array[String] $next_maintenance, # tuple with two date stamps, e.g., '2017-10-19T08:00:00'
    # first element may be 'none' to prevent information about
    # next maintenance from showing (e.g., if next maintenance is distant)
  String $next_maintenance_timezone, # timezone used for next_maintenance
  String $next_maintenance_details,  # more details about next_maintenance
  $notice,  # optional notice string OR FALSE to disable
)
{

  ## DEFAULT MOTD TO DISPLAY SERVER CONFIGURATION

  ## PROCESS $next_maintenance AND DETERMINE $maintenance_message
  $maintenance_begins = $next_maintenance[0]
  $maintenance_ends = $next_maintenance[1]
  if ($maintenance_begins != 'none') {
    $start_array = split($next_maintenance[0], 'T')
    $start_date = $start_array[0]
    $start_time_array = split($start_array[1], ':')
    $start_time = "${start_time_array[0]}:${start_time_array[1]}"
    $end_array = split($next_maintenance[1], 'T')
    $end_date = $end_array[0]
    $end_time_array = split($end_array[1], ':')
    $end_time = "${end_time_array[0]}:${end_time_array[1]}"
    if ( $start_date == $end_date )
    {
      $date_string = "${start_date} ${start_time}-${end_time} ${next_maintenance_timezone}"
    }
    else
    {
      $date_string = "${start_date} ${start_time} - ${end_date} ${end_time} ${next_maintenance_timezone}"
    }
    $maintenance_message = "
Next scheduled maintenance: ${date_string} ${next_maintenance_details}"
  }
  else {
    $maintenance_message = ''
  }

  if $notice {
    $notice_message = "
${notice}"
  } else {
    $notice_message = ''
  }

  $hw_array = split($::manufacturer, Regexp['[\s,]'])
  $hardware = $hw_array[0]
  $memorysize_gb = ceiling($::memorysize_mb/1024)
  $cpu_array = split($::processor0, ' @ ')
  $cpu_speed = $cpu_array[1]

  ## MOTD SYSTEM INFORMATION
  $motdcontent = @("EOF")
    ${::fqdn} (${::ipaddress})
      OS: ${::operatingsystem} ${::operatingsystemrelease}   HW: ${hardware}   CPU: ${::processorcount}x ${cpu_speed}   RAM: ${memorysize_gb} GB
      Site: ${::site}  DC: ${::datacenter}  Cluster: ${::cluster}  Role: ${::role}${notice_message}${maintenance_message}
    | EOF
  file { '/etc/motd':
    ensure  => file,
    content => $motdcontent,
    mode    => '0644',
    owner   => '0',
    group   => '0',
  }

}
