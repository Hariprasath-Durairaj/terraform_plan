########################################
#  A) HTTP-only Application Gateway    #
########################################
resource "azurerm_application_gateway" "http" {
  count               = var.key_vault_secret_id == null ? 1 : 0
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = var.capacity
  }

  gateway_ip_configuration {
    name      = "gateway-ip-config"
    subnet_id = var.subnet_id
  }

  # ── FRONTEND PORT (80) ──
  frontend_port {
    name = "http-port"
    port = var.frontend_port          # default 80
  }

  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = var.public_ip_id
  }

  backend_address_pool {
    name        = "backend-pool"
    ip_addresses = var.backend_ip_addresses
  }

  # ── BACKEND HTTP SETTINGS ──
  backend_http_settings {
    name     = "http-settings"
    protocol = "Http"
    port     = var.backend_port       # default 8080
    cookie_based_affinity = "Disabled"
    request_timeout        = 20
  }

  # ── HTTP LISTENER ──
  http_listener {
    name                           = "http-listener"
    frontend_ip_configuration_name = "frontend-ip"
    frontend_port_name             = "http-port"
    protocol                       = "Http"
  }

  request_routing_rule {
    name                       = "http-rule"
    rule_type                  = "Basic"
    http_listener_name         = "http-listener"
    backend_address_pool_name  = "backend-pool"
    backend_http_settings_name = "http-settings"
    priority                   = 100
  }

  waf_configuration {
    enabled          = true
    firewall_mode    = "Prevention"
    rule_set_type    = "OWASP"
    rule_set_version = "3.2"
  }

  firewall_policy_id = var.firewall_policy_id
  tags               = var.tags
}

####################################################
#  B) HTTPS-enabled Application Gateway            #
####################################################
resource "azurerm_application_gateway" "https" {
  count               = var.key_vault_secret_id != null ? 1 : 0
  name                = var.name
  location            = var.location
  resource_group_name = var.resource_group_name

  sku {
    name     = var.sku_name
    tier     = var.sku_tier
    capacity = var.capacity
  }

  gateway_ip_configuration {
    name      = "gateway-ip-config"
    subnet_id = var.subnet_id
  }

  # ── HTTPS FRONTEND PORT (443) ──
  frontend_port {
    name = "https-port"
    port = var.https_frontend_port    # default 443
  }

  # ── SSL CERTIFICATE ──
  ssl_certificate {
    name                = var.ssl_certificate_name
    key_vault_secret_id = var.key_vault_secret_id
  }

  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = var.public_ip_id
  }

  backend_address_pool {
    name        = "backend-pool"
    ip_addresses = var.backend_ip_addresses
  }

  # ── BACKEND HTTPS SETTINGS ──
  backend_http_settings {
    name     = "https-settings"
    protocol = "Https"
    port     = var.backend_https_port   # default 443
    cookie_based_affinity = "Disabled"
    request_timeout        = 20
    trusted_root_certificate_names = [var.ssl_certificate_name]
  }

  # ── HTTPS LISTENER ──
  http_listener {
    name                           = "https-listener"
    frontend_ip_configuration_name = "frontend-ip"
    frontend_port_name             = "https-port"
    protocol                       = "Https"
    ssl_certificate_name           = var.ssl_certificate_name
  }

  request_routing_rule {
    name                       = "https-rule"
    rule_type                  = "Basic"
    http_listener_name         = "https-listener"
    backend_address_pool_name  = "backend-pool"
    backend_http_settings_name = "https-settings"
    priority                   = 100
  }

  # Optional strong TLS policy
  ssl_policy {
    policy_type = "Predefined"
    policy_name = "AppGwSslPolicy20170401S"
  }

  waf_configuration {
    enabled          = true
    firewall_mode    = "Prevention"
    rule_set_type    = "OWASP"
    rule_set_version = "3.2"
  }

  firewall_policy_id = var.firewall_policy_id
  tags               = var.tags
}
