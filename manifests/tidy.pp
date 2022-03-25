# @summary Clean old Puppet report files from disk.
#
# Clean old Puppet report files from disk.
#
# @param dirlist
#   Hash containing 'String: Hash' data of the following form:
#     "dirpath": {hash of valid tidy params for Puppet "tidy" resource}
#
# @example
#   include profile_puppet_master::tidy
class profile_puppet_master::tidy (
  Hash[ String[1], Hash ] $dirlist,
) {

  ensure_resources( 'tidy',  $dirlist )

}
