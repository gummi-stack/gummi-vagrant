class toadwart ($node_version, $name){
  Exec {
    path => ['/usr/local/bin','/usr/local/sbin','/usr/bin/','/usr/sbin','/bin','/sbin'],
  }


  service { "supervisor":
      ensure  => "running",
      enable  => "true",
      require => Package["supervisor"],
  }

  define userexec($command) {
      exec { "userexec-${command}":
        # unless => "test -d $directory/$name",
        command => "bash -c \"source /opt/nvm/nvm.sh && ${command}\"",
        user => "root",
        group => "root",
      }
  }

  userexec {"coffee-script":
    command => "npm install coffee-script -g",
    # require => File['toadwart.conf'],
  }
  
  
  userexec { "toadwart":
    command => "npm install http://github.com/gummi-stack/gummi-toadwart/tarball/master -g",
    require => Userexec["coffee-script"]
  }
  
  userexec {"toadwart-conf":
    command => "toadwart config ip ${ipaddress_eth1} \
      && toadwart config port 80 \
      && toadwart config name bender-xxx  \
      && toadwart config lxc.iface lxcbr0  \
      && toadwart config lxc.address 192.168.73.1/24 \
      && toadwart config wan.iface eth1",
    require => Userexec["toadwart"]
  }
  
 
  userexec {"supervisor-restart":
    command => "supervisorctl reread && supervisorctl update && supervisorctl restart all",
    require => Userexec["toadwart-conf"],
  }

  
  file { "toadwart.conf":
    name => "/etc/supervisor/conf.d/toadwart.conf",
    ensure => present,
    owner => root,
    group => $admingroup,
    mode  => 644,
    content => template("supervisor.erb"),
      
    notify  => Service["supervisor"],  # this sets up the relationship
    require => Package["supervisor"],
  }

}
