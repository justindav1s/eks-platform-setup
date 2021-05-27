# Setting up a Kubernetes cluster on AWS using Ansible and their EKS control plane

EKS vs Openshift


EKS :

   * JUST a control plane.

   * Everything runs as root !
   * No web-console
   * No registry
   * No Prometheus
   * No Cluster monitoring
   * No pod metrics
   * No ES and Kibanna
   * No Service Catalog
   * No DeploymentConfig (Deployment instead, no triggers)
   * No BuildConfig (used in Pipelines), no s2i.
   * No Routes or routing infrastructure
   * No ImageStreams pointing to RH images
   * No Templates
   * No oc command
   * No RHEL7 nodes (without work, lots actually) https://medium.com/errnothxbye/centos-7-with-cri-o-on-eks-ae9684aff764
   * No RH Containers
   * No projects, no project level resource limits

All these things are fixable, or workaroundable, but this will take time.