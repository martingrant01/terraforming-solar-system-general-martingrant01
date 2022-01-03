# Terraforming Solar System

## Story

After we colonised the Mars, and the internet made its way to the Solar System as well, people started to move there. The new species want the best of the best technologies, therefore the application infrastructure of the Solar System people will simply just not cut it. The mission here is to Terraform everything, including the application that you already deployed to the EKS cluster that you created on the AWS Console by clicking, so whenever the species want to create an app, they can deploy it with a push of a button on their M26 processor enhanced MacBook Pro Solar System Max X laptop.

## What are you going to learn?

- How to create a larger size of infrastructure with Terraform

## Tasks

1. Create the cloud infrastructure for your application that is already deployed on EKS with the usage of Terraform
    - Your Terraform resources are seen on the AWS Console and finished the creation process
    - Your AWS resources that you created manually on the AWS Console are deleted
    - Your application is running on the AWS resources that you created by Terraform after the migration

## General requirements

None

## Hints

- Modules can make the process of configuring Terraform resources faster
- If you happen to use modules, pay extra attention to how they handle versioning, as it can cause problems if the module is outdated

## Background materials

- <i class="far fa-exclamation"></i> [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)
- <i class="far fa-exclamation"></i> [Terraform EKS Resource](https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/eks_cluster)
