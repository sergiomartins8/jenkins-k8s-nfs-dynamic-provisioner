# NFS server

##### Install and configure NFS server

```shell script
$ sudo mkdir /srv/nfs/kubedata -p
$ sudo chown nobody: /srv/nfs/kubedata
$ sudo apt install nfs-kernel-server
$ sudo systemctl enable nfs-kernel-server
$ sudo systemctl start nfs-kernel-server
```

##### Open and append the following line to the end of the file `/etc/exports`

```text
/srv/nfs/kubedata	*(rw,sync,no_subtree_check,no_root_squash,no_all_squash,insecure)
```

##### Then execute the following command

```shell script
$ sudo exportfs -rav
```
