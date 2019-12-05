# @summary
# Install additional yumrepos (specified in Hiera)
#
# @param repo_list Hash of (yumrepo configs) to create
#   Hash key will be used as the yumrepo 'resource_title'
#   Hash value must be a Hash of valid yumrepo attributes
#     If 'ensure' is not provided, it will default to 'present'
#     If 'enabled' is not provided, it will default to true
#
# @example
#   baseline_cfg::additional_yumrepos:repo_list:
#     'rsyslog-v8':
#       baseurl: http://rpms.adiscon.com/v8-stable/epel-$releasever/$basearch
#       descr: rsyslog official repo
#       gpgcheck: true
#       gpgkey: http://rpms.adiscon.com/RPM-GPG-KEY-Adiscon
#
# @example
#   include baseline_cfg::additional_yumrepos
class baseline_cfg::additional_yumrepos (
    Hash $repo_list,
) {
    $defaults = {
      ensure  => present,
      enabled => true,
    }

    ensure_resources( 'yumrepo', $repo_list, $defaults )
}
