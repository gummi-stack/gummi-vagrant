class essentials {

  ## todo apt-add-repository ppa:ubuntu-lxc/daily -y
  ## apt-key adv --keyserver keyserver.ubuntu.com --recv-keys 5563540C431533D8

  package {
    "git-core":
      ensure => installed;
    "curl":
      ensure => installed;
    "cgroup-lite":
      ensure => installed;
    "build-essential":
      ensure => installed;
    "supervisor":
      ensure => installed;
    "lxc":
      ensure => "1.0.0+master~20140305-2100-0ubuntu1~ppa1~precise1";
	"rsyslog":
      ensure => installed;
  }
}
