###############################################################################
# terraform.tfvars — *DHDP QA* (clean, AGIC-only pattern)
###############################################################################

########################
# 1. Global settings
########################
prefix              = "dhdp-qa"
location            = "canadacentral"
resource_group_name = "dhdp-qa-rg"
tenant_id           = "c25c5028-2135-4990-9b82-d8c62774306a"

tags = {
  environment  = "QA"
  businessUnit = "Corp-IT"
  application  = "DHDP"
  owner        = "hp@corp.com"
  managedBy    = "Terraform"
  createdBy    = "AzureDevOps"
  criticality  = "Standard"
}

########################
# 2. Networking
########################
vnet_name     = "dhdp-qa-vnet"
address_space = ["10.31.0.0/16"]

subnets = {
  aks                = ["10.31.4.0/22"]
  appgw              = ["10.31.64.0/24"]
  AzureBastionSubnet = ["10.31.80.0/27"]
}

nat_gateway_name = "dhdp-qa-natgw"


########################
# 3. Network Security Group
########################
nsg_name = "dhdp-qa-nsg"

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
key_vault_name   = "dhdp-qa-kv"
des_name         = "dhdp-qa-des"
key_vault_key_id = "https://dhdp-qa-kv.vault.azure.net/keys/dhdp-qa-cmk/0123456789abcdef0123456789abcdef"

########################
# 6. Backup
########################
backup_vault_name = "dhdp-qa-backup-vault"

########################
# 7. Azure Container Registry
########################
acr_name = "dhdpqaaqr"

########################
# 8. AKS cluster
########################
aks_name            = "dhdp-qa-aks"
dns_prefix          = "dhdpqa"
kubernetes_version  = "1.32.3"
node_resource_group = "MC_dhdp-qa-rg_dhdp-qa-aks_canadacentral"

default_node_pool = {
  name                        = "system"
  vm_size                     = "Standard_D2s_v3"
  temporary_name_for_rotation = "system-temp"
  enable_auto_scaling         = true
  min_count                   = 1
  max_count                   = 3
  max_pods                    = 50
  os_disk_size_gb             = 50
  type                        = "System"
  node_labels                 = { type = "system" }
  tags                        = {}
  vnet_subnet_id              = "" # Always empty here; set in main.tf
  availability_zones          = ["1", "2", "3"]
}

user_node_pools = {
  bitnobi = {
    name                = "bitnobi"
    vm_size             = "Standard_D2s_v3"
    os_disk_size_gb     = 100
    enable_auto_scaling = true
    node_count          = 3
    min_count           = 3
    max_count           = 5
    max_pods            = 50
    mode                = "User"
    node_labels         = { app = "bitnobi" }
    vnet_subnet_id      = "" # Always empty in tfvars!
    tags                = { app = "bitnobi" }
    taints              = ["app=bitnobi:NoSchedule"]
    availability_zones  = ["1", "2", "3"]
  }

  candig = {
    name                = "candig"
    vm_size             = "Standard_D2s_v3"
    os_disk_size_gb     = 50
    enable_auto_scaling = true
    node_count          = 3
    min_count           = 3
    max_count           = 5
    max_pods            = 50
    mode                = "User"
    node_labels         = { app = "candig" }
    vnet_subnet_id      = ""
    tags                = { app = "candig" }
    taints              = ["app=candig:NoSchedule"]
    availability_zones  = ["1", "2", "3"]
  }

  keycloak = {
    name                = "keycloak"
    vm_size             = "Standard_D2s_v3"
    os_disk_size_gb     = 50
    enable_auto_scaling = true
    node_count          = 3
    min_count           = 3
    max_count           = 5
    max_pods            = 50
    mode                = "User"
    node_labels         = { app = "keycloak" }
    vnet_subnet_id      = ""
    tags                = { app = "keycloak" }
    taints              = ["app=keycloak:NoSchedule"]
    availability_zones  = ["1", "2", "3"]
  }

  integrateai = {
    name                = "integrateai"
    vm_size             = "Standard_D2s_v3"
    os_disk_size_gb     = 50
    enable_auto_scaling = true
    node_count          = 3
    min_count           = 3
    max_count           = 5
    max_pods            = 50
    mode                = "User"
    node_labels         = { app = "integrateai" }
    vnet_subnet_id      = ""
    tags                = { app = "integrateai" }
    taints              = ["app=integrateai:NoSchedule"]
    availability_zones  = ["1", "2", "3"]
  }

  webapp = {
    name                = "webapp"
    vm_size             = "Standard_D2s_v3"
    os_disk_size_gb     = 50
    enable_auto_scaling = true
    node_count          = 3
    min_count           = 3
    max_count           = 5
    max_pods            = 50
    mode                = "User"
    node_labels         = { app = "webapp" }
    vnet_subnet_id      = ""
    tags                = { app = "webapp" }
    taints              = ["app=webapp:NoSchedule"]
    availability_zones  = ["1", "2", "3"]
  }
}

network_plugin                  = "azure"
dns_service_ip                  = "10.2.0.10"
service_cidr                    = "10.2.0.0/24"
api_server_authorized_ip_ranges = ["203.0.113.10/32"]
upgrade_channel = "stable"

########################
# 9. Log Analytics
########################
log_analytics_name = "dhdp-qa-log"
log_retention      = 30

########################
# 10. Application Gateway & WAF
########################
app_gateway_name        = "dhdp-qa-appgw"
app_gateway_subnet_name = "appgw"

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
appgw_ssl_cert_secret_id = "/subscriptions/…/resourceGroups/rg/providers/Microsoft.KeyVault/vaults/kv/secrets/appgw-pfx"


