import "./essentials.pp"
import "./nvm.pp"
import "./toadwart.pp"

node "node2.lxc.nag.ccl" {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }

  include essentials

  $node_version = "v0.8.15"  ## change also in supervisor erb (forced)

  class { 'nvm':
    node_version => $node_version,
  }

  class { "toadwart":
     name => 'node2.nag.ccl',
     port => '80',
     wan => 'eth0',
     wan_ip => $ipaddress_eth0,
     lxc_iface => 'lxcbr0',
     lxc_address => '192.168.73.1/24',
   }

}

node "node3.lxc.nag.ccl" {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }

  include essentials

  $node_version = "v0.8.15"  ## change also in supervisor erb (forced)

  class { 'nvm':
    node_version => $node_version,
  }

  class { "toadwart":
     name => 'node3.nag.ccl',
     port => '80',
     wan => 'eth0',
     wan_ip => $ipaddress_eth0,
     lxc_iface => 'lxcbr0',
     lxc_address => '192.168.73.1/24',
   }

}


node "mrdka" {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }

  include essentials

  $node_version = "v0.10.25"  ## change also in supervisor erb (forced)

  class { 'nvm':
    node_version => $node_version,
  }

  class { "toadwart":
     name => 'node3.nag.ccl',
     port => '80',
     wan => 'eth0',
     wan_ip => $ipaddress_eth0,
     lxc_iface => 'lxcbr0',
     lxc_address => '192.168.73.1/24',
   }

}




