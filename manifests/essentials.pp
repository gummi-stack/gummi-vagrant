class essentials {
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
      ensure => installed;

  }
}