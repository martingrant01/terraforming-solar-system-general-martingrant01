terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }
  backend "s3" {
    bucket         = "test-tf-bucket-cc"
    key            = "terraforming-solar-system/terraform.tfstate"
    region         = "eu-central-1"
    dynamodb_table = "StateLocking"
  }
}

# Configure the AWS Provider
provider "aws" {
  region = var.aws_region
}

provider "kubernetes" {
  host                   = data.aws_eks_cluster.eks.endpoint
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.eks.certificate_authority[0].data)
  token                  = data.aws_eks_cluster_auth.eks.token
}

# Create a VPC
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.64.0"

  name = var.vpc_name
  cidr = var.vpc_cidr_block

  azs            = data.aws_availability_zones.available.names
  public_subnets = slice(var.public_subnet_cidr_blocks, 0, var.public_subnet_count)

  enable_nat_gateway   = false
  enable_vpn_gateway   = false
  enable_dns_hostnames = true

  tags = var.resource_tags
}

# Create EKS Cluster
module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_version                 = "1.21"
  cluster_name                    = var.eks_cluster_name
  vpc_id                          = module.vpc.vpc_id
  version                         = "17.24.0"
  subnets                         = module.vpc.public_subnets
  cluster_endpoint_private_access = true

  worker_groups = [
    {
      name                 = "worker-group-1"
      instance_type        = "t2.micro"
      asg_desired_capacity = 2
    }
  ]

  worker_additional_security_group_ids = [aws_security_group.all_worker_mgmt.id]

  tags = var.resource_tags
}

# Create SG for Worker Nodes
resource "aws_security_group" "all_worker_mgmt" {
  name_prefix = "all_worker_management"
  vpc_id      = module.vpc.vpc_id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"

    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}