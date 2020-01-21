# @summary Configure motd
#
# @param next_maintenance
#        tuple with two date stamps, e.g., '2017-10-19T08:00:00'
#        first element may be 'none' to prevent information about
#        next maintenance from showing (e.g., if next maintenance is distant)
#
# @param next_maintenance_timezone
#        timezone used for next_maintenance
#
# @param next_maintenance_details
#        more details about next_maintenance
#
# @param notice
#        An additional message to add to the end of the motd
#
# @example
#   include baseline_cfg::motd
class baseline_cfg::motd(

  # Parameters

  Array[String] $next_maintenance,   # tuple with two date stamps, e.g., '2017-10-19T08:00:00'
  String $next_maintenance_timezone, # timezone used for next_maintenance
  String $next_maintenance_details,  # more details about next_maintenance
  String $notice,                    # additional message to add to the end of the motd
)
{

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

  $notice_message = $notice ? {
    default   => '',
    String[1] => "\n${notice}",
  }

  $hardware = $::manufacturer ? {
    String[1] => split($::manufacturer, Regexp['[\s,]'])[0],
    default   => if $::is_virtual { $::virtual } else { '?' }
  }

  $ipaddr=$facts['networking']['ip']
  $os_name=$facts['os']['name']
  $os_ver=$facts['os']['release']['full']
  $cpu_num=$facts['processors']['count']
  $cpu_speed=$facts['processors']['speed']
  $ram=$facts['memory']['system']['total']

  ## MOTD SYSTEM INFORMATION
  $motdcontent = @("EOF")
    ${::fqdn} (${ipaddr})
      OS: ${os_name} ${os_ver}   HW: ${hardware}   CPU: (${cpu_num}) @ ${cpu_speed}   RAM: ${ram}
      Site: ${::site}  Cluster: ${::cluster}  Role: ${::role}${maintenance_message}${notice_message}
    | EOF

file { '/etc/motd':
    ensure  => file,
    content => $motdcontent,
    mode    => '0644',
    owner   => '0',
    group   => '0',
  }

}
