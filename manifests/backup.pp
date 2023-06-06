# @summary Configure Pupppet server backups
#
# @example
#   include profile_puppet_master::backup
class profile_puppet_master::backup {
  if ( lookup('profile_backup::client::enabled') ) {
    include profile_backup::client

    profile_backup::client::add_job { 'profile_puppet_master':
      paths             => [
        '/etc/puppetlabs',
        '/var/backups/puppet_enc',
        # ADD POSTGRES BACKUPS FOR PUPPETDB (UNTIL POSTGRES MODULE USED)
        '/var/lib/pgsql',
      ],
      prehook_commands  => [
        '/root/bin/enc_adm --bkup',
      ],
      posthook_commands => [
        "find /var/backups/puppet_enc \\( -name '*.sql.gz' \\) -mtime +90 -type f -exec rm -rf {} \\;",
      ],
    }
  }
}
