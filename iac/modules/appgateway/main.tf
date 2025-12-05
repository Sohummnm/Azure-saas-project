
resource "azurerm_application_gateway" "appgw-prod-aks" {
  name = var.appgw_name
  resource_group_name = data.terraform_remote_state.resource_group.outputs.rg_name
  location = data.terraform_remote_state.resource_group.outputs.rg_location
  
  sku {
    name = var.sku_name
    tier = var.sku_tier
    capacity = var.sku_capacity
    }

    gateway_ip_configuration {
        name = "appgw-ipcfg"
        subnet_id = data.terraform_remote_state.vnet.outputs.subnet_ids["appgw"]
    }

    frontend_ip_configuration {
        name = "appgw-feip"
        public_ip_address_id = data.terraform_remote_state.pip.outputs.public_ip_id
    }

  frontend_port {
    name = "http-port"
    port = 80
  }

  frontend_port {
    name = "https-port"
    port = 443
  }

  backend_address_pool {
    name = "aks-backend-pool"
  }

  backend_http_settings {
    name = "https-settings"
    cookie_based_affinity = "Disabled"
    port = 80
    protocol = "Http"
    request_timeout = 30
  }

  http_listener {
    name = "http-listener"
    frontend_ip_configuration_name = "appgw-feip"
    frontend_port_name = "http-port"
    protocol = "Http"
  }

  request_routing_rule {
    name = "rule-http-basic"
    rule_type = "Basic"
    http_listener_name = "http_listener"
    backend_address_pool_name = "aks-backend-pool"
    backend_http_settings_name = "http-settings"
  }

  tags = var.tags
}