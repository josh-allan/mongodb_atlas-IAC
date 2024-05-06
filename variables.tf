variable "mongodb_atlas" {
  description = "MongoDB Atlas Access"
  type = object({
    active              = bool
    public_key          = string
    private_key         = string
    project_id          = string
    atlas_cidr_block    = string
    cluster_name        = string
    collection          = string
    database            = string
    region              = string
    username            = string
    password            = string
    role                = string
    cloud_provider_name = string
    instance_size       = string
  })
}

variable "aws" {
  description = "AWS resources"
  type = object({
    s3_bucket = string
    role_id   = string
  })
}

variable "azure" {
  description = "Azure resoures"
  type = object({
    AZURE_DIRECTORY_ID         = string
    AZURE_SUBSCRIPTION_ID      = string
    AZURE_RESOURCES_GROUP_NAME = string
    AZURE_VNET_NAME            = string
  })
}

variable "ips" {
  description = "IP List"
  type        = list(any)
}
