## Platform setup.


Use eksctl

### Dashboard

https://github.com/kubernetes/dashboard

```
kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.2.0/aio/deploy/recommended.yaml

kubectl proxy 

in chrome go to

http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/#/workloads?namespace=_all

You'll need a Token to authenticate

do this :

https://github.com/kubernetes/dashboard/blob/master/docs/user/access-control/creating-sample-user.md

```

### Istio 

https://www.eksworkshop.com/advanced/310_servicemesh_with_istio/install/

https://itnext.io/istio-external-aws-application-loadbalancer-and-istio-ingress-gateway-fce3bfd3202f

https://rtfm.co.ua/en/kubernetes-update-aws-route53-dns-from-an-ingress/

istioctl manifest apply --set profile=default

Download latest Istion bumdle from Github


#### Prometheus

kubectl apply -f istio/samples/addons/prometheus.yaml

#### Kiali

kubectl apply -f istio/samples/addons/kiali.yaml

istioctl dashboard kiali




### Kong

```
kubectl create namespace kong-istio
kubectl label namespace kong-istio istio-injection=enabled
helm install -n kong-istio platform kong/kong --set ingressController.installCRDs=false
```

### Flux2


