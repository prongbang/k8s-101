# 03-whoami

## Generate config 

- https://k8syaml.com/
- https://syshunt.com/kubernetes-yaml-generator/

## K8s Cheatsheet

https://kubernetes.io/docs/reference/kubectl/cheatsheet/

## Create namespace

```shell
kubectl create ns metallb-system
```

## Install MetalLB

https://itnext.io/kubernetes-loadbalancer-service-for-on-premises-6b7f75187be8

```shell
helm upgrade --install -n metallb-system metallb oci://registry-1.docker.io/bitnamicharts/metallb
```

## Deploy metallb

- Change local IP address

```shell
spec:
  addresses:
    - 192.168.X.X/24
```

```shell
kubectl apply -f metallb-allocation.yaml
```

Get pods in namespace

```shell
kubectl get pods -n metallb-system
```

## Deploy deployment

```shell
kubectl apply -f deployment.yaml
```

## Deploy service

```shell
kubectl apply -f loadbalancer.yaml
```

## Scaling resources

```shell
kubectl scale deployment --replicas=3 -f deployment.yaml
```
or
```shell
kubectl scale deployment --replicas=3 -f whoami-deployment
```

## Test

```shell
curl 192.168.0.18:80
```

```shell
Hostname: whoami-deployment-67ff685-vchz4
IP: 127.0.0.1
IP: 10.1.0.36
RemoteAddr: 192.168.65.4:41590
GET / HTTP/1.1
Host: 192.168.0.18
User-Agent: curl/7.79.1
Accept: */*
```