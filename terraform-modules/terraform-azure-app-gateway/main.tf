resource "azurerm_application_gateway" "this" {
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

  # ── HTTPS Frontend Port ────────────────────────────────────
  frontend_port {
    name = "https-port"
    port = var.https_frontend_port      # e.g. 443
  }

  # ── SSL Certificate from Key Vault ───────────────────────
  ssl_certificate {
    name                = var.ssl_certificate_name   # e.g. "appgw-ssl-cert"
    key_vault_secret_id = var.ssl_certificate_secret_id
  }

  frontend_ip_configuration {
    name                 = "frontend-ip"
    public_ip_address_id = var.public_ip_id
  }

  backend_address_pool {
    name        = "backend-pool"
    ip_addresses = var.backend_ip_addresses
  }

  # ── HTTPS Backend Settings ────────────────────────────────
  backend_http_settings {
    name                                = "https-settings"
    protocol                            = "Https"
    port                                = var.backend_https_port          # e.g. 443
    cookie_based_affinity               = "Disabled"
    request_timeout                     = 20
    pick_host_name_from_backend_address = false
    trusted_root_certificate_names      = [var.ssl_certificate_name]
  }

  # ── HTTPS Listener ─────────────────────────────────────────
  http_listener {
    name                           = "https-listener"
    frontend_ip_configuration_name = "frontend-ip"
    frontend_port_name             = "https-port"
    protocol                       = "Https"
    ssl_certificate_name           = var.ssl_certificate_name
  }

  request_routing_rule {
    name                       = "rule1"
    rule_type                  = "Basic"
    http_listener_name         = "https-listener"
    backend_address_pool_name  = "backend-pool"
    backend_http_settings_name = "https-settings"
    priority                   = 100
  }

  # ── Enforce a strong TLS policy ────────────────────────────
  ssl_policy {
    policy_type = "Predefined"
    policy_name = "AppGwSslPolicy20170401S"   # TLS1.2+ defaults
  }

  waf_configuration {
    enabled          = true
    firewall_mode    = "Prevention"
    rule_set_type    = "OWASP"
    rule_set_version = "3.2"
  }

  firewall_policy_id = var.firewall_policy_id

  tags = var.tags
}
