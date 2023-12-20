# @summary Register monitoring for the Puppet server
#
# @param enable
#   Boolean of whether monitoring is enabled
#
# @param telegraf_sslcert_check_file
#   Full path to telegraf sslcert check file
#
# @param telegraf_website_check_file
#   Full path to telegraf website check file
#
# @example
#   include profile_puppet_master::monitoring
class profile_puppet_master::monitoring (
  Boolean $enable,
  String $telegraf_sslcert_check_file,
  String $telegraf_website_check_file,
) {
  if ( $enable and $profile_monitoring::telegraf::enabled ) {
    # Export resource to populate telegraf ssl check for Puppet Service
    @@file_line { "exported_telegraf_sslcert_check_${facts['networking']['fqdn']}":
      ensure   => 'present',
      after    => 'sources',
      line     => "    \"https://${facts['networking']['fqdn']}:8140\",",
      match    => "${facts['networking']['fqdn']}:8140",
      multiple => 'false',
      notify   => Service['telegraf'],
      path     => $telegraf_sslcert_check_file,
      tag      => 'telegraf_sslcert_check',
    }

    # Export resource to populate telegraf website check for Puppet Service
    @@file_line { "exported_telegraf_website_check_${facts['networking']['fqdn']}_puppet_service":
      ensure   => 'present',
      after    => 'urls',
      #line     => "    \"https://${facts['networking']['fqdn']}:8140/puppet/v3\",",
      line     => "    \"https://${facts['networking']['fqdn']}:8140\",",
      match    => "${facts['networking']['fqdn']}:8140",
      multiple => 'false',
      notify   => Service['telegraf'],
      path     => $telegraf_website_check_file,
      tag      => 'telegraf_website_check',
    }

    # Export resource to populate telegraf website check for PuppetDB
    @@file_line { "exported_telegraf_website_check_${facts['networking']['fqdn']}_puppet_db":
      ensure   => 'present',
      after    => 'urls',
      line     => "    \"https://${facts['networking']['fqdn']}:8080\",",
      match    => "${facts['networking']['fqdn']}:8080",
      multiple => 'false',
      notify   => Service['telegraf'],
      path     => $telegraf_website_check_file,
      tag      => 'telegraf_website_check',
    }
  }
}
