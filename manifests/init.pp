# @summary Configure host settings on a puppet master
#
# Depends on:
#   - github.com/ncsa/puppet-profile_docker
#   - puppetlabs/firewall
#
# @param firewall_allow_from
#     Array[ String, 1 ]
#     Open the firewall for all "sources" in this list
#     Format for sources is any valid "source" string in the puppet/firewall module
#
# @example
#   include profile_puppet_master
class profile_puppet_master (
    Array[ String, 1 ] $firewall_allow_from,
) {

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
