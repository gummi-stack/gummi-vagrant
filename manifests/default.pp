node default {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }

  include essentials

  $node_version = "v0.8.15"  ## change also in supervisor erb (forced)
  
  class { 'nvm':
    node_version => $node_version,
  }
  
  class { "toadwart": 
     name => 'moje2345',
     port => '80',
     wan => 'eth1',
     lxc_iface => 'lxcbr0',
     lxc_address => '192.168.73.1/24',
   }

}
