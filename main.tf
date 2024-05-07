terraform {
  required_providers {
    mongodbatlas = {
      source = "mongodb/mongodbatlas"
    version = "1.15.3" }
  }
}
provider "mongodbatlas" {
  public_key  = var.mongodb_atlas.public_key
  private_key = var.mongodb_atlas.private_key
}
// For some reason this block needs to go at the top otherwise it will ungracefully die

# resource "mongodbatlas_ldap_configuration" "name" {
#   project_id             = var.mongodbatlas_project.test.id
#   authentication_enabled = true
#   hostname               = "var.azure.hostname"
#   port                   = 636
#   bind_username          = "USERNAME"
#   bind_password          = "PASSWORD"
# }

// Uncomment this if you need VPC peering 

# resource "mongodbatlas_network_container" "name" {
#   project_id       = var.mongodb_atlas.project_id
#   atlas_cidr_block = var.mongodb_atlas.atlas_cidr_block
#   provider_name    = var.mongodb_atlas.cloud_provider_name
#   region           = var.mongodb_atlas.region
# }
#
# resource "mongodbatlas_network_peering" "name" {
#   project_id            = var.mongodb_atlas.project_id
#   container_id          = mongodbatlas_network_container.name.container_id
#   provider_name         = var.mongodb_atlas.cloud_provider_name
#   azure_directory_id    = var.azure.AZURE_DIRECTORY_ID
#   azure_subscription_id = var.azure.AZURE_SUBSCRIPTION_ID
#   resource_group_name   = var.azure.AZURE_RESOURCES_GROUP_NAME
#   vnet_name             = var.azure.AZURE_VNET_NAME
# }
#

resource "mongodbatlas_cluster" "name" {
  project_id = var.mongodb_atlas.project_id
  name       = var.mongodb_atlas.cluster_name
  num_shards = 1

  replication_factor           = 3
  cloud_backup                 = true
  auto_scaling_disk_gb_enabled = true
  mongo_db_major_version       = "5.0"

  //Provider Settings "block"
  provider_name               = var.mongodb_atlas.cloud_provider_name
  provider_instance_size_name = var.mongodb_atlas.instance_size
  provider_region_name        = var.mongodb_atlas.region
}


resource "mongodbatlas_project_ip_access_list" "name" {
  for_each = {
    for key, value in var.ips : key => value
    if var.mongodb_atlas.active == true
  }
  project_id = var.mongodb_atlas.project_id
  cidr_block = each.value
}

resource "mongodbatlas_database_user" "name" {
  username           = var.mongodb_atlas.username
  password           = var.mongodb_atlas.password
  project_id         = var.mongodb_atlas.project_id
  auth_database_name = "admin"

  roles {
    role_name     = var.mongodb_atlas.role
    database_name = "admin"
  }
}
output "connection_strings" {
  value = mongodbatlas_cluster.josh-allan.connection_strings.0.standard_srv
}
