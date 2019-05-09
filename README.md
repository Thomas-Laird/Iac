# Terraform Projects

The repository contains a couple of separate Terraform projects I have been working on.

## SimpleEC"

The most basic provisioning of an instance in AWS. For future references added a few commands to add a private certificate authority to the list of certificate authorities trusted by the new instance.

## KopsBootstrap

By default Kops is set to provision all AWS infrastructure components from scratch. This project's aim is to create a Kubernetes cluster in infrastructure that is preexisting and managed by Terraform.
