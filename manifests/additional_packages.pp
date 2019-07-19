# baseline_cfg::additional_packages
#
# @summary 
# Install additional packages as specified in Hiera
# Hiera Keys:
#   baseline_cfg::additional_packages::<OSFAMILY>
#       where <OSFAMILY> refers to the puppet fact by the same name
#       and is spelled the same
#       Common OSFAMILY spellings: RedHat, Debian
#       Example Hiera:
#           ---
#           baseline_cfg::additional_packages::RedHat:
#               - mesa-LibGL
#               - another-package
# NOTE: This class is defined to simply ensure the package is installed. The
#       functionality of specifying a specific version of a package was purposely
#       left out. Enforcing specific versions of packages seems better handled
#       by a user environment management software (ie: modules, eups, etc.)
#
#
# @example
#   include baseline_cfg::additional_packages
class baseline_cfg::additional_packages {

    # Merge lists of package names found in Hiera
    $hiera_key = "baseline_cfg::additional_packages::${facts['os']['family']}"
    $pkg_list = lookup( $hiera_key,
                        Array[ String[1] ],
                        'unique',
    )
    # Ensure packages
    ensure_packages( $pkg_list )

}
