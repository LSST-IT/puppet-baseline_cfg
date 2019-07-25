# A description of what this class does
#
# @summary Create and manage LVMs (and file systems) using lvm module. This could include:
#   - LVMs that were created in VGsystem by xCAT
#   - LVMs that first created manually
#   - LVMs that are created new by Puppet
#
# @example
#   include baseline_cfg::lvm
# @param default_fs_type
#   String
#   WARNING: default = xfs via data-in-module for this. Overrides default of ext4 from ::lvm module. 
#   It would be better to not have a default (it's very dangerous, because if you don't specify the
#   fs_type and your existing LVM has a different type, it seems that it would reformat the fs. But
#   since the ::lvm module already has a default, let's override it with a better one for the LSST
#   environment.
# @param lvms
#   Hash
#   Key-value pairs used to declare ::lvm::logical_volume resources. Lookup is merge, but not deep.
#   Form:
#     keys = names of LVM resources (String)
#     values = params for LVM resources (Hash)
#   BE VERY CAREFUL WITH WHAT YOU PUT IN HIERA FOR THIS CLASS/PARAMETER!
#   This is especially the case for LVMs that already exist (created manually or via xCAT). To 
#   manage an existing LVM you'll need to minimally specify:
#     - mountpath
#     - volume_group
#   But make sure that the fs_type is/should be xfs otherwise override that as well. And be careful 
#   if you specify size. You can often grow the LVM and its filesystem but generally cannot shrink 
#   the filesystem. (The lvm module seems to error and refuse to try, which is good. But be
#   careful! 
#   It's intended for Hiera to do a hash merge but NOT a deep merge of the lvms param. This is
#   so we intentionally and clearly specify all required parameters at each level just to be safe.
#   NOTE: If you use this class to start managing an existing (definitely an xCAT-deployed) LVM
#   it will likely insist on cleaning up your mount in fstab, e.g.,:
#     Notice: /Stage[main]/Stdcfg::Lvm/Lvm::Logical_volume[LVvar]/Mount[/var]/device:
#       device changed '/dev/mapper/VGsystem-LVvar' to '/dev/VGsystem/LVvar'
#     Notice: /Stage[main]/Stdcfg::Lvm/Lvm::Logical_volume[LVvar]/Mount[/var]/pass: pass changed '0' to '2'
#   This should not cause an actual remount.
#
class baseline_cfg::lvm (

    String $default_fs_type,
    Hash[ String[1], Hash ] $lvms,

) {

    # NOTE: Might want to revisit this in the future to set sizes of / and /var based on the 
    # Puppet fact of node being a VM.
    #   * That would save setting hiera parameters on a per node basis in some cases.

    # Include the LVM module
    include ::lvm

    # Manage any LVMs defined via Hiera data
    each( $lvms ) | String[1] $key, Hash $overrides| {
        lvm::logical_volume {
            $key:
                * => $overrides,
            ;
            default:
                fs_type => $default_fs_type,
            ;
        }
    }

}
