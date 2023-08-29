# k8s-101

## Access Pods with Node Port

```shell
+----------+       +----------+       +-----------+
|   WWW    | <-->  | NodePort | <-->  |   Pods    |
+----------+       +----------+       |   (Web)   |
                                      +-----------+
```

### Create Web Pod

```shell
kubectl apply -f web/pod.yml
```

### Create Web Node Port 

```shell
kubectl apply -f web/node-port-service.yml
```

### Create Web Deployment

```shell
kubectl apply -f web/deployment.yaml
```

## Access Pods with Ingress Controller + Cluster IP

```shell
+------+       +----------------+       +-----------------+       +------------------+       +-------------------+       +-------------------+       +--------------------+       +--------------------+ 
| WWW  | <---> | Ingress        | <---> | Cluster IP      | <---> | Pods (Web)       | <---> | Cluster IP        | <---> | Pods (API)        | <---> | Cluster IP         | <---> | Pods (Mongo)       |
+------+       | Controller     |       |                 |       |                  |       |                   |       |                   |       |                    |       |                    |
               +----------------+       +-----------------+       +------------------+       +-------------------+       +-------------------+       +--------------------+       +--------------- ----+
```

### Create Mongo Persistent Volume Claim

```shell
kubectl apply -f mongo/persistent-volume-claim.yml
```

### Create Mongo Deployment

```shell
kubectl apply -f mongo/deployment.yaml
```

### Create Mongo Cluster IP Service

```shell
kubectl apply -f mongo/cluster-ip-service.yml
```

### Create API Deployment

```shell
kubectl apply -f api/deployment.yaml
```

### Create API Cluster IP Service

```shell
kubectl apply -f api/cluster-ip-service.yml
```

### Create Web Deployment

```shell
kubectl apply -f web/deployment.yaml
```

### Create Web Cluster IP Service

```shell
kubectl apply -f web/cluster-ip-service.yml
```

Output

```shell
NAME                                    READY   STATUS    RESTARTS   AGE
pod/api-deployment-7459464c8c-lw6xx     1/1     Running   0          121m
pod/api-deployment-7459464c8c-pjpxw     1/1     Running   0          121m
pod/api-deployment-7459464c8c-zmg4g     1/1     Running   0          121m
pod/mongo-deployment-74c5ccbfdf-28dlk   1/1     Running   0          28m
pod/web-deployment-786f4c4f69-bxwrg     1/1     Running   0          122m
pod/web-deployment-786f4c4f69-fk2n2     1/1     Running   0          122m
pod/web-deployment-786f4c4f69-vpmrd     1/1     Running   0          122m

NAME                             TYPE        CLUSTER-IP       EXTERNAL-IP   PORT(S)        AGE
service/api-service              NodePort    10.101.175.100   <none>        80:30002/TCP   121m
service/api-service-cluster-ip   ClusterIP   10.107.168.157   <none>        80/TCP         58m
service/kubernetes               ClusterIP   10.96.0.1        <none>        443/TCP        6h35m
service/mongo-service            ClusterIP   10.96.62.70      <none>        27017/TCP      112m
service/web-service              NodePort    10.101.223.48    <none>        80:30001/TCP   121m
service/web-service-cluster-ip   ClusterIP   10.103.239.203   <none>        80/TCP         59m

NAME                               READY   UP-TO-DATE   AVAILABLE   AGE
deployment.apps/api-deployment     3/3     3            3           121m
deployment.apps/mongo-deployment   1/1     1            1           112m
deployment.apps/web-deployment     3/3     3            3           122m

NAME                                          DESIRED   CURRENT   READY   AGE
replicaset.apps/api-deployment-7459464c8c     3         3         3       121m
replicaset.apps/mongo-deployment-6464768f74   0         0         0       112m
replicaset.apps/mongo-deployment-74c5ccbfdf   1         1         1       28m
replicaset.apps/web-deployment-786f4c4f69     3         3         3       122m
```