###############################################################################
# terraform.tfvars — *DHDP QA* (clean, AGIC-only pattern)
###############################################################################

########################
# 1. Global settings
########################
prefix              = "dhdp-lab-qa"
location            = "eastus"
resource_group_name = "dhdp-aks-qa"
tenant_id           = "c25c5028-2135-4990-9b82-d8c62774306a"

tags = {
  environment  = "QA"
  businessUnit = "Corp-IT"
  application  = "DHDP"
  owner        = "DHDP"
  managedBy    = "Terraform"
  createdBy    = "AzureDevOps"
  criticality  = "Standard"
}

########################
# 2. Networking
########################
vnet_name     = "dhdp-lab-qa-vnet"
address_space = ["10.31.0.0/16"]

subnets = {
  aks   = ["10.31.4.0/22"]
  appgw = ["10.31.64.0/24"]
  #  AzureBastionSubnet = ["10.31.80.0/27"]
}

nat_gateway_name = "dhdp-lab-qa-natgw"

########################
# 3. Network Security Group
########################
nsg_name = "dhdp-lab-qa-nsg"

nsg_security_rules = [
  {
    name                       = "allow_ssh"
    priority                   = 100
    direction                  = "Inbound"
    access                     = "Allow"
    protocol                   = "Tcp"
    source_port_range          = "*"
    destination_port_range     = "22"
    source_address_prefix      = "*"
    destination_address_prefix = "*"
  }
]

########################
# 4. Private DNS
########################
private_dns_name      = "privatelink.azurecr.io"
private_dns_link_name = "acr-dns-link"

########################
# 5. Key Vault & Encryption
########################
key_vault_name = "dhdp-lab-qa-kv"
des_name       = "dhdp-lab-qa-des"

# App Gateway SSL certificate (must be the vault URI, not an ARM ID)
#key_vault_secret_id    = "https://dhdp-lab-qa-kv.vault.azure.net/secrets/appgw-pfx" 


# Disk Encryption Set CMK (include version)
#key_vault_key_id       = "https://dhdp-lab-qa-kv.vault.azure.net/keys/dhdp-lab-qa-des-key/<version>"

# App Gateway public access / upgrade settings
public_network_access_enabled = false
upgrade_channel               = "Stable"

########################
# 6. Backup
########################
backup_vault_name = "dhdp-lab-qa-backup-vault"

########################
# 7. Azure Container Registry
########################
acr_id = "/subscriptions/acc2f242-1262-48a4-8ab5-980bdf8aa8b6/resourceGroups/dhdp-test-resource-group/providers/Microsoft.ContainerRegistry/registries/dhdptestacr"

########################
# 8. AKS cluster
########################
aks_name            = "dhdp-lab-qa-aks"
dns_prefix          = "dhdpqa"
kubernetes_version  = "1.32.3"
node_resource_group = "MC_dhdp-lab-qa-rg_dhdp-lab-qa-aks_canadacentral"

default_node_pool = {
  name                = "system"
  vm_size             = "Standard_D2s_v3"
  enable_auto_scaling = true
  min_count           = 1
  max_count           = 3
  max_pods            = 50
  os_disk_size_gb     = 50
  node_labels         = { type = "system" }
  availability_zones  = ["1", "2", "3"]
  vnet_subnet_id      = "PLACEHOLDER"
}

user_node_pools = {
  bitnobi = {
    name                = "bitnobi"
    vm_size             = "Standard_D2s_v3"
    os_disk_size_gb     = 100
    enable_auto_scaling = true
    min_count           = 3
    max_count           = 5
    max_pods            = 50
    mode                = "User"
    node_labels         = { app = "bitnobi" }
    taints              = ["app=bitnobi:NoSchedule"]
    availability_zones  = ["1", "2", "3"]
    node_count          = 3
    tags                = { app = "bitnobi" }
  }
  candig = {
    name                = "candig"
    vm_size             = "Standard_D2s_v3"
    os_disk_size_gb     = 50
    enable_auto_scaling = true
    min_count           = 3
    max_count           = 5
    max_pods            = 50
    mode                = "User"
    node_labels         = { app = "candig" }
    taints              = ["app=candig:NoSchedule"]
    availability_zones  = ["1", "2", "3"]
    node_count          = 3
    tags                = { app = "candig" }
  }
  keycloak = {
    name                = "keycloak"
    vm_size             = "Standard_D2s_v3"
    os_disk_size_gb     = 50
    enable_auto_scaling = true
    min_count           = 3
    max_count           = 5
    max_pods            = 50
    mode                = "User"
    node_labels         = { app = "keycloak" }
    taints              = ["app=keycloak:NoSchedule"]
    availability_zones  = ["1", "2", "3"]
    node_count          = 3
    tags                = { app = "keycloak" }
  }
  integrateai = {
    name                = "integrateai"
    vm_size             = "Standard_D2s_v3"
    os_disk_size_gb     = 50
    enable_auto_scaling = true
    min_count           = 3
    max_count           = 5
    max_pods            = 50
    mode                = "User"
    node_labels         = { app = "integrateai" }
    taints              = ["app=integrateai:NoSchedule"]
    availability_zones  = ["1", "2", "3"]
    node_count          = 3
    tags                = { app = "integrateai" }
  }
  webapp = {
    name                = "webapp"
    vm_size             = "Standard_D2s_v3"
    os_disk_size_gb     = 50
    enable_auto_scaling = true
    min_count           = 3
    max_count           = 5
    max_pods            = 50
    mode                = "User"
    node_labels         = { app = "webapp" }
    taints              = ["app=webapp:NoSchedule"]
    availability_zones  = ["1", "2", "3"]
    node_count          = 3
    tags                = { app = "webapp" }
  }
}

network_plugin                  = "azure"
dns_service_ip                  = "10.2.0.10"
service_cidr                    = "10.2.0.0/24"
api_server_authorized_ip_ranges = ["203.0.113.10/32"]

########################
# 9. Log Analytics
########################
log_analytics_name = "dhdp-lab-qa-log"
log_retention      = 30

########################
# 10. Application Gateway & WAF
########################
app_gateway_name                 = "dhdp-lab-qa-appgw"
app_gateway_subnet_name          = "appgw"
app_gateway_frontend_port        = 80
app_gateway_backend_port         = 80
app_gateway_backend_ip_addresses = ["10.31.4.4", "10.31.4.5"]
app_gateway_sku_name             = "WAF_v2"
app_gateway_sku_tier             = "WAF_v2"
app_gateway_capacity             = 2
app_gateway_tags = {
  Environment = "QA"
  Project     = "DHDP"
  Owner       = "HP"
  ManagedBy   = "Terraform"
}
