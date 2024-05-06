# MongoDB Atlas Terraform Bootstrapper
This repository contains everything required to bootstrap a MongoDB Atlas deployment using Terraform. 

It requires a MongoDB Atlas project, and a project owner scoped API key which is to be stored within a `terraform.tfvars` file.

* main.tf contains all the resources required to build an Atlas cluster, instantiate an Atlas database user and create entries in the Network Access list.
* variables.tf are the type declarations

