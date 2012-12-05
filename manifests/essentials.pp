class essentials {
  package {
    "git-core":
      ensure => installed;
    "build-essential":
      ensure => installed;
    "supervisor":
      ensure => installed;
    "lxc":
      ensure => installed;

  }
}