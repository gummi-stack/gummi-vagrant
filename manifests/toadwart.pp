class toadwart ($id, $port){
	Exec {
		path => ['/usr/local/bin','/usr/local/sbin','/usr/bin/','/usr/sbin','/bin','/sbin'],
	}

	$directories = ['/srv/gummi', '/srv/gummi/stacks', '/srv/gummi/stacks/gummiglen']
	file { $directories:
		ensure => "directory",
	}


	file { "/etc/toadwart/":
		ensure => "directory",
	}



	file { "config.cson":
		name => "/etc/toadwart/config.cson",
		ensure => present,
		owner => root,
		group => $admingroup,
		mode  => 644,

		content => template("toadwart.cson.erb"),
	}



#  service { "supervisor":
#      ensure  => "running",
#      enable  => "true",
#      require => Package["supervisor"],
#  }

  define userexec($command) {
      exec { "userexec-${command}":
        # unless => "test -d $directory/$name",
        command => "bash -c \"source /opt/nvm/nvm.sh && ${command}\"",
        user => "root",
        group => "root",
      }
  }

  # userexec {"coffee-script":
  #   command => "npm install coffee-script -g",
  #   # require => File['toadwart.conf'],
  # }


#  userexec { "toadwart":
#    command => "HOME=/opt/nvm/v0.8.15/ npm install http://github.com/gummi-stack/gummi-toadwart/tarball/master -g",
#    require => Userexec["coffee-script"]
#  }

#  userexec {"toadwart-conf":
#    command => "toadwart config ip ${wan_ip} \
#      && toadwart config port ${port} \
#      && toadwart config name ${name} \
#      && toadwart config lxc.iface ${lxc_iface}  \
#      && toadwart config lxc.address ${lxc_address} \
#      && toadwart config wan.iface ${wan}",
#    require => Userexec["toadwart"]
#  }

#
# userexec {"supervisor-restart":
#    command => "supervisorctl reread && supervisorctl update && supervisorctl restart all",
#    require => Userexec["toadwart-conf"],
#  }


#  file { "toadwart.conf":
#    name => "/etc/supervisor/conf.d/toadwart.conf",
#    ensure => present,
#    owner => root,
#    group => $admingroup,
#    mode  => 644,
#    content => template("toadwart/supervisor.erb"),

#    notify  => Service["supervisor"],  # this sets up the relationship
#    require => Package["supervisor"],
#  }

}
