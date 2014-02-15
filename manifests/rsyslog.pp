class rsyslog {
    $log_host =  "192.168.13.6:1222"

	file { "80-logstash.conf":
		name => "/etc/rsyslog.d/80-logstash.conf",
		ensure => present,
		owner => root,
		group => $admingroup,
		mode  => 644,

		content => template("rsyslog.erb"),
	}
}