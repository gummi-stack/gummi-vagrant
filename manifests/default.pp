class git {
  exec { 'apt-get update':
    command => '/usr/bin/apt-get update'
  }

  package { "git":
    ensure => present,
  }

  # service { "apache2":
  #   ensure => running,
  #   require => Package["apache2"],
  # }
}


class nvm ($node_version) {
  Exec {
    path => ['/usr/local/bin','/usr/local/sbin','/usr/bin/','/usr/sbin','/bin','/sbin'],
  }

  exec { "set-node-version": 
    command => "bash -c \"source /opt/nvm/nvm.sh && nvm alias default ${node_version}\"",
    require => Exec["install-node"],
  }

  exec { "install-node": 
    command => "bash -c \"source /opt/nvm/nvm.sh && nvm install ${node_version}\"",
    require => Exec["clone-nvm"],
  }

  exec { "clone-nvm":
    command => "git clone git://github.com/creationix/nvm.git /opt/nvm",
    user => "root",
    group => "root",
    creates => "/opt/nvm/nvm.sh",
    require => Package["git"],
  }

  exec { "source-nvm":
    command => "echo 'source /opt/nvm/nvm.sh' >> /root/.bashrc",
    onlyif => "grep -q 'source /opt/nvm/nvm.sh' /root/.bashrc; test $? -eq 1",
  } 
 
  
}


class toadwart ($node_version, $name){
  
  package { "build-essential":
    ensure => present,
  }
  package { "supervisor":
    ensure => present,
  }
  
  
  
  Exec {
    path => ["/opt/nvm/${node_version}/bin",'/usr/local/bin','/usr/local/sbin','/usr/bin/','/usr/sbin','/bin','/sbin'],
  }
  
  exec { "coffee-script":
    command => "npm install coffee-script -g",
    user => "root",
    group => "root",
  }
  
  exec { "toadwart":
    command => "npm install http://github.com/gummi-stack/gummi-toadwart/tarball/master -g",
    user => "root",
    group => "root",
  }

  exec { "toadwart-config":
    command => "toadwart config name ${name}",
    user => "root",
    group => "root",
  }
  
  
}
# include git
# include nvm

node default {
  include git
  class { "nvm": node_version => 'v0.8.15'}
  class { "toadwart": 
    node_version => 'v0.8.15',
    name => 'moje', 
  }

}
