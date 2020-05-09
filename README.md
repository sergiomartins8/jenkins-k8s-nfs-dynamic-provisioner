# jenkins-kubernetes _(ubuntu 18.04)_

## Pre-requisites

* [Docker](https://docs.docker.com/install/linux/docker-ce/ubuntu/)
* [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-kubectl-on-linux)
* [Vagrant](https://linuxize.com/post/how-to-install-vagrant-on-ubuntu-18-04/)
* [Helm](https://helm.sh/docs/intro/install/#from-script)

## Instructions

##### First

1. Install and configure nfs-server [(instructions)](docs/nfs-server.md)
1. Prepare your machine [(instructions)](docs/k8s-cluster.md)
1. Open `/nfs-provisioner/deployment.yaml` and change `<<NFS Server IP>>` to the ip of the machine where the nfs-server is running

> The steps above are only required the first time you bootstrap the cluster

##### Then

1. Go to `/vagrant-provisioning` and `$ vagrant up`
1. `$ mkdir ~/.kube`
1. `$ scp root@kmaster.example.com:/etc/kubernetes/admin.conf $HOME/.kube/config` using `kubeadmin` as the password
1. Setup the dynamic nfs provisioner (`$ kubectl create -f nfs-provisioner/`)

## Deploy jenkins

#### Dependencies

The following commands will download the required dependencies and store them on `charts/`
```shell script
$ cd jenkins-chart/
$ helm dependency update
```

#### Upgrade _(install)_ jenkins

Execute the following command on the root of the project
```shell script
$ helm upgrade --install --namespace jenkins jenkins-chart ./jenkins-chart
```

#### Access Jenkins

```text
http://kmaster:32000/login
```

> _admin/admin_ 🚨

Add _Kubernetes Service Account_ credentials
```text
http://kmaster:32000/credentials/store/system/domain/_/newCredentials
```

Change _credentials_ to the secret text
```text
http://kmaster:32000/configureClouds/
```

_Test Connection_ and you should see `Connection test successful` 🎉

## Kuddos

_kuddos to the open source project by [@justmeandopensource](https://github.com/justmeandopensource/kubernetes) that eased the bootstrap process_ 🙌
