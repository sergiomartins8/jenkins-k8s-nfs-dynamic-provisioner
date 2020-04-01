# Prepare the cluster

### End result

The end result is going to be a k8s cluster with 1 master node and 2 worker nodes with the following specs

|Role|FQDN|IP|OS|RAM|CPU|
|----|----|----|----|----|----|
|Master|kmaster.example.com|172.42.42.100|CentOS 7|2G|2|
|Worker|kworker.example.com|172.42.42.101|CentOS 7|1G|1|

### Instructions

##### Perform all the commands as root user

```shell script
$ sudo su
```

##### Update `/etc/hosts`

```shell script
$ cat >>/etc/hosts<<EOF
172.42.42.100 kmaster.example.com kmaster
172.42.42.101 kworker.example.com kworker
EOF
```

##### Disable SELinux

```shell script
$ setenforce 0
```

##### Disable Firewall

```shell script
$ systemctl disable firewalld
$ systemctl stop firewalld
```

##### Disable swap

```shell script
$ sed -i '/swap/d' /etc/fstab
$ swapoff -a
```

##### Update sysctl settings for Kubernetes networking

```shell script
$ cat >>/etc/sysctl.d/kubernetes.conf<<EOF
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
$ sysctl --system
```
