AWS VPC Networking Project (Terraform)

Overview

This project demonstrates the design and deployment of a complete AWS VPC networking environment using Terraform. It focuses on building secure, scalable infrastructure components through Infrastructure as Code (IaC), rather than manual configuration in the AWS console.

The project provisions a production-style VPC setup including networking, compute scaling, and load balancing components.

Why this project

To gain hands-on experience designing AWS VPC architectures

To practise Infrastructure as Code using Terraform

To understand how networking, compute, and scaling components work together

To build cloud infrastructure in a repeatable and version-controlled way

Architecture / Components

The infrastructure deployed includes:

Custom VPC

Public and private subnets

Internet Gateway and routing tables

Application Load Balancer (ALB)

Auto Scaling Group (ASG)

Launch Templates

EC2 instances

AWS Systems Manager (SSM) for instance management

User data scripts are used to install and configure Apache on EC2 instances automatically.

Technologies Used

Terraform – infrastructure as code

AWS VPC – networking

AWS EC2 – compute

AWS Auto Scaling – scalability

AWS Application Load Balancer – traffic distribution

AWS SSM – instance access and management

Linux & Shell scripting – instance bootstrapping

Git & GitHub – version control

Repository Structure

vpc.tf – VPC and networking configuration

alb.tf – Application Load Balancer resources

asg.tf – Auto Scaling Group configuration

launch_templates.tf – EC2 launch templates

provider.tf – AWS provider configuration

variables.tf – input variables

output.tf – Terraform outputs

install_apache.sh – EC2 bootstrap script

.terraform.lock.hcl – provider dependency lock file

How it was built

Infrastructure defined declaratively using Terraform

Modular Terraform files used to separate concerns

EC2 instances configured automatically via user data

Scaling and load balancing handled through managed AWS services

Documentation & Evidence

This project was completed as part of hands-on cloud engineering practice.

Additional documentation, diagrams, and screenshots were captured externally during the build process.

What I’d improve next

Store Terraform state remotely using S3 with state locking

Add monitoring and alerts using Amazon CloudWatch

Introduce security hardening (NACLs, least-privilege IAM)

Refactor into reusable Terraform modules

Add CI/CD for Terraform plan and apply

Notes

This project focuses on infrastructure design and automation rather than application development.
