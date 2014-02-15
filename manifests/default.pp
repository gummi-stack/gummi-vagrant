import "./essentials.pp"
import "./nvm.pp"
import "./toadwart.pp"
import "./rsyslog.pp"


node "gummi_toadwart" {
  # exec { 'apt-get update':
  #   command => '/usr/bin/apt-get update'
  # }
  class { 'rsyslog': }
  include essentials

  $node_version = "v0.10.25"  ## change also in supervisor erb (forced)

  class { 'nvm':
    node_version => $node_version,
  }


}




node "mrdka" inherits gummi_toadwart {
	class { "toadwart":
		id => "8d9cb33c-d62d-43ea-b5c4-7f83edfe4969",
		port => '80'
	}
}

node "lestr" inherits gummi_toadwart {
	class { "toadwart":
		id => "98fd4ebf-b995-41c2-9e49-eb7f420799e6",
		port => '80',
	}
}

node "wision" inherits gummi_toadwart{
	class { "toadwart":
		id => "dc4daa05-ae22-4fb7-8584-73bd755f8865",
		port => '80',
	}
}



