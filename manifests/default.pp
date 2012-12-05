node default {
  # include git

  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'

  }
  include essentials


  $node_version = "v0.8.15"
  
  class { 'nvm':
    node_version => $node_version,
  }
  
  
  # class{ 'toadwart':
  #   node_version => $node_version,
  # }  
  # class { "nvm": node_version => 'v0.8.15'}
  class { "toadwart": 
     node_version => 'v0.8.15',
     name => 'moje', 
   }
 
}
