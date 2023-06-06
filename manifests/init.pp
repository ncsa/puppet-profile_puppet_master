# @summary Configure host settings on a puppet master
#
# Depends on:
#   - github.com/ncsa/puppet-profile_docker
#   - puppetlabs/firewall
#
# @param crons
#   Hash of cron resource data (defaults to a single cron for cleaning
#   Puppet report data).
#
# @param files_remove_setuid
#   Hash of file resource parameters that need setuid removed from them
#
# @param firewall_allow_from
#     Array[ String, 1 ]
#     Open the firewall for all "sources" in this list
#     Format for sources is any valid "source" string in the puppet/firewall module
#
# @example
#   include profile_puppet_master
class profile_puppet_master (
  Hash               $crons,
  Hash               $files_remove_setuid,
  Array[String, 1] $firewall_allow_from,
) {
  include profile_puppet_master::backup

  # Manage crons
  $crons.each | $cron_name, $cron_data | {
    cron { $cron_name:
      * => $cron_data,
    }
  }

  # Remove setuid/setgid from key files
  $file_remove_setuid_defaults = {
    mode    => 'ug-s',
  }
  ensure_resources('file', $files_remove_setuid, $file_remove_setuid_defaults )

  # allow incoming on port 8140
  $firewall_allow_from.each | String $cidr | {
    firewall { "500 profile::ncsa::puppet_master - puppet access from '${cidr}'" :
      proto  => 'tcp',
      dport  => '8140',
      action => 'accept',
      source => $cidr,
    }
  }
}
