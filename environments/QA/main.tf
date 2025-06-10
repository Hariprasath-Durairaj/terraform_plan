###############################################################################
# QA Environment – Root Terraform Config (clean, reusable, AGIC pattern)
###############################################################################

############################
# 1. Networking
############################
module "vnet" {
  source              = "../../terraform-modules/terraform-azure-network"
  vnet_name           = var.vnet_name
  address_space       = var.address_space
  location            = var.location
  resource_group_name = var.resource_group_name
  subnets             = var.subnets # expects keys: "aks", "appgw", "AzureBastionSubnet"
  tags                = var.tags
   subnet_network_security_group_ids = {
 # Keys must match the subnet names defined above:
 aks                = module.nsg.id
 appgw              = module.appgw_nsg.id      # if you have a separate NSG for the App Gateway subnet
AzureBastionSubnet = module.bastion_nsg.id    # if you want Bastion protected
}
}

module "natgw_public_ip" {
  source              = "../../terraform-modules/terraform-azure-public-ip"
  name                = "${var.nat_gateway_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  allocation_method   = "Static"
  tags                = var.tags
}

module "nat_gateway" {
  source              = "../../terraform-modules/terraform-azure-nat-gateway"
  name                = var.nat_gateway_name
  location            = var.location
  resource_group_name = var.resource_group_name

  public_ip_id = module.natgw_public_ip.public_ip_id
  subnet_id    = module.vnet.subnet_ids["aks"]

  tags = var.tags
}

############################
# 2. Public IP for Application Gateway
############################
module "public_ip_appgw" {
  source              = "../../terraform-modules/terraform-azure-public-ip"
  name                = "${var.prefix}-appgw-pip"
  location            = var.location
  resource_group_name = var.resource_group_name
  sku                 = "Standard"
  allocation_method   = "Static"
  tags                = var.tags
}

############################
# 3. Shared platform services
############################
module "log_analytics" {
  source              = "../../terraform-modules/terraform-azure-log-analytics"
  name                = var.log_analytics_name
  location            = var.location
  resource_group_name = var.resource_group_name
  retention_in_days   = var.log_retention
  tags                = var.tags
}

module "key_vault" {
  source              = "../../terraform-modules/terraform-azure-key-vault"
  name                = var.key_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tenant_id           = var.tenant_id
  tags                = var.tags
}

module "acr" {
  source              = "../../terraform-modules/terraform-azure-acr"
  name                = var.acr_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

module "disk_encryption_set" {
  source              = "../../terraform-modules/terraform-azure-disk-encryption-set"
  name                = var.des_name
  location            = var.location
  resource_group_name = var.resource_group_name
  key_vault_key_id    = var.key_vault_key_id
  tags                = var.tags
}

module "backup" {
  source              = "../../terraform-modules/terraform-azure-backup"
  name                = var.backup_vault_name
  location            = var.location
  resource_group_name = var.resource_group_name
  tags                = var.tags
}

############################
# 4. Security – NSG for AKS subnet
############################
module "nsg" {
  source              = "../../terraform-modules/terraform-azure-nsg"
  nsg_name            = var.nsg_name
  location            = var.location
  resource_group_name = var.resource_group_name
  subnet_id           = module.vnet.subnet_ids["aks"]
  nsg_security_rules  = var.nsg_security_rules
  tags                = var.tags
}

############################
# 5. Ingress: WAF + App Gateway
############################
module "waf_policy" {
  source                      = "../../terraform-modules/terraform-azure-waf"
  name                        = "${var.prefix}-waf-policy"
  location                    = var.location
  resource_group_name         = var.resource_group_name
  mode                        = "Prevention"
  owasp_version               = "3.2"
  file_upload_limit_in_mb     = 100
  max_request_body_size_in_kb = 128
  tags                        = var.tags
}

module "app_gateway" {
  source               = "../../terraform-modules/terraform-azure-app-gateway"
  name                 = var.app_gateway_name
  location             = var.location
  resource_group_name  = var.resource_group_name
  subnet_id            = module.vnet.subnet_ids[var.app_gateway_subnet_name]
  public_ip_id         = module.public_ip_appgw.public_ip_id
  # HTTPS settings
  https_frontend_port       = 443
  backend_https_port        = 443
  ssl_certificate_secret_id = var.appgw_ssl_cert_secret_id
  ssl_certificate_name      = "appgw-ssl-cert"
  frontend_port        = var.app_gateway_frontend_port
  backend_port         = var.app_gateway_backend_port
  backend_ip_addresses = var.app_gateway_backend_ip_addresses
  sku_name             = var.app_gateway_sku_name
  sku_tier             = var.app_gateway_sku_tier
  capacity             = var.app_gateway_capacity
  firewall_policy_id   = module.waf_policy.waf_policy_id
  tags                 = var.app_gateway_tags
  custom_rules         = var.custom_rules
}

############################
# 6. AKS Cluster with AGIC
############################
module "aks" {
  source = "../../terraform-modules/terraform-azure-aks"

  # ── core settings ───────────────────────────────────────────────
  name                = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  kubernetes_version  = var.kubernetes_version
  node_resource_group = var.node_resource_group
  disable_local_accounts = true
  enable_azure_policy            = true
  auto_rotate_secrets = true

  # ── integrations ────────────────────────────────────────────────
  acr_id                     = module.acr.acr_id
  log_analytics_workspace_id = module.log_analytics.workspace_id

  # ── cluster options ─────────────────────────────────────────────
  private_cluster_enabled         = true
  enable_private_cluster_public_fqdn = false
  api_server_authorized_ip_ranges = var.api_server_authorized_ip_ranges

  # ── AGIC ────────────────────────────────────────────────────────
  enable_ingress_application_gateway = true
  ingress_application_gateway_id     = module.app_gateway.app_gateway_id

  # ── networking (three vars you added) ───────────────────────────
  network_plugin = var.network_plugin
  dns_service_ip = var.dns_service_ip
  service_cidr   = var.service_cidr

  # ── system node pool ────────────────────────────────────────────
  default_node_pool = merge(
    var.default_node_pool,
    {
      vnet_subnet_id              = module.vnet.subnet_ids["aks"]
      enable_auto_scaling         = true
      min_count                   = 2
      max_count                   = 6
      zones                       = ["1", "2", "3"]
      tags                        = var.tags
      temporary_name_for_rotation = "tempnp"
      type                        = "VirtualMachineScaleSets"
    }
  )

  # ── user node pools ─────────────────────────────────────────────
  user_node_pools = {
    for k, v in var.user_node_pools : k => merge(
      v,
      {
        vnet_subnet_id      = module.vnet.subnet_ids["aks"]
        enable_auto_scaling = true
      }
    )
  }

  tags = var.tags
}

############################
# 7. Private DNS
############################
module "private_dns" {
  source               = "../../terraform-modules/terraform-azure-private-dns"
  name                 = var.private_dns_name
  resource_group_name  = var.resource_group_name
  link_name            = var.private_dns_link_name
  virtual_network_id   = module.vnet.vnet_id
  registration_enabled = false
  tags                 = var.tags
}

############################
# 8. Kubernetes Namespaces
############################
resource "kubernetes_namespace" "workspaces" {
  for_each = toset(["bitnobi", "candig", "keycloak", "integrateai", "webapp"])
  metadata { name = each.key }
}
