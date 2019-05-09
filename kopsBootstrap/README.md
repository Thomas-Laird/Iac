# KopsBootstrap

The project currently provisions a kubernetes cluster using Kops embeded within a set VPC. The script uses Kops to output infrastructure to Terraform which then provisions the instances and associated components (e.g. loadbalancers). The AWS resources are currently hard coded into the values.yaml file and will have to be changed in a future update to make the script more flexible, but for the time being setting the values in that file will configure the rest of the script to work.
