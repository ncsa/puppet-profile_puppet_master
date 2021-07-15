# Reference

<!-- DO NOT EDIT: This document was generated by Puppet Strings -->

## Table of Contents

### Classes

* [`profile_puppet_master`](#profile_puppet_master): Configure host settings on a puppet master

## Classes

### <a name="profile_puppet_master"></a>`profile_puppet_master`

Depends on:
  - github.com/ncsa/puppet-profile_docker
  - puppetlabs/firewall

#### Examples

##### 

```puppet
include profile_puppet_master
```

#### Parameters

The following parameters are available in the `profile_puppet_master` class:

* [`files_remove_setuid`](#files_remove_setuid)
* [`firewall_allow_from`](#firewall_allow_from)

##### <a name="files_remove_setuid"></a>`files_remove_setuid`

Data type: `Hash`

Hash of file resource paramters that need setuid removed from them

##### <a name="firewall_allow_from"></a>`firewall_allow_from`

Data type: `Array[ String, 1 ]`

Array[ String, 1 ]
Open the firewall for all "sources" in this list
Format for sources is any valid "source" string in the puppet/firewall module
