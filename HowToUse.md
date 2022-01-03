# Terraforming Solar System

## What does this app do
The image for the application was taken from https://hub.docker.com/r/yeasy/simple-web/.
This is a simple web server that outputs the IP addresses of the source and destination, very useful for testing loadbalancer to show real requests.

## How to use it
1. Run Terraform commands
    - terraform init
    - terraform plan
    - terraform apply

2. Run aws eks command below for connecting to EKS cluster
    - aws eks --region $(terraform output -raw region) update-kubeconfig --name $(terraform output -raw cluster_name)

3. Use kubectl for interaction with the cluster
    - kubectl get nodes
    - kubectl get pods