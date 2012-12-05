
 
 
class toadwart ($node_version, $name){
  Exec {
    path => ['/usr/local/bin','/usr/local/sbin','/usr/bin/','/usr/sbin','/bin','/sbin'],
  }


  service { "supervisor":
      ensure  => "running",
      enable  => "true",
      require => Package["supervisor"],
  }

  define userexec() {
      exec { "userexec-${name}":
        # unless => "test -d $directory/$name",
        command => "bash -c \"source /opt/nvm/nvm.sh && ${name}\"",
        user => "root",
        group => "root",
      }
  }

  userexec {
    "npm install coffee-script -g":
    require => File['toadwart.conf'],
  }

  userexec {
    "toadwart config ip 10.0.2.15":
  }
  userexec {
    "toadwart config port 80":
  }
  userexec {
    "toadwart config name bender-xxx":
  }
  userexec {
    "toadwart config lxc.iface lxcbr0":
  }
  userexec {
    "toadwart config lxc.address 192.168.73.1/24":
  }
  # userexec {
  #   "toadwart config lxc.iface eth1":
  # }
  
  
  
  file { "toadwart.conf":
      name => "/etc/supervisor/conf.d/toadwart.conf",
      ensure => present,
      owner => root,
      group => $admingroup,
      mode  => 644,
      content => template("supervisor.erb"),
      
      notify  => Service["supervisor"],  # this sets up the relationship
      # require => Package["supervisor"],
      
      # require => Class["postfix::install"],
  }
  userexec {
    "supervisorctl reread":
  }
  userexec {
    "supervisorctl update":
  }
  userexec {
    "supervisorctl restart all":
  }
  
  # 
  #   # npm { "vows": }
  #   # npm { "jshint": }
  #   # npm { "up": }
  # 
  #   
  # 
  # Exec {
  #   path => ['/usr/local/bin','/usr/local/sbin','/usr/bin/','/usr/sbin','/bin','/sbin'],
  # }

  # exec {
  #   command => "bash -c \"source /opt/nvm/nvm.sh""
  #   
  #   
  #   
  # }
  # 
  # file { "toadwart.conf":
  #     name => "/etc/supervisor/conf.d/toadwart.conf",
  #     ensure => present,
  #     owner => root,
  #     group => $admingroup,
  #     mode  => 644,
  #     content => template("supervisor.erb"),
  #     # require => Class["postfix::install"],
  # }
  # 
  # 
  # Exec {
  #   path => ["/opt/nvm/${node_version}/bin",'/usr/local/bin','/usr/local/sbin','/usr/bin/','/usr/sbin','/bin','/sbin'],
  # }
  # 
  # exec { "coffee-script":
  #   command => "bash -c \"source /opt/nvm/nvm.sh && npm install coffee-script -g\"",
  #   user => "root",
  #   group => "root",
  # }
  # 
  # exec { "toadwart":
  #   command => "npm install http://github.com/gummi-stack/gummi-toadwart/tarball/master -g",
  #   user => "root",
  #   group => "root",
  # }
  # 
  # exec { "toadwart-config":
  #   command => "toadwart config name ${name}",
  #   user => "root",
  #   group => "root",
  # }

}
