class rsyslog {
    $log_host =  "node2.lxc.nag.ccl:1222"

	file { "80-logstash.conf":
		name => "/etc/rsyslog.d/80-logstash.conf",
		ensure => present,
		owner => root,
		group => $admingroup,
		mode  => 644,

		content => template("rsyslog.erb"),
	}
}