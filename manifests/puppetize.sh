puppet apply --templatedir /root/gummi-vagrant/manifests/ -v -d /root/gummi-vagrant/manifests/default.pp
rsync -av --delete  root@10.1.69.105:/var/lib/lxc/child /var/lib/lxc/