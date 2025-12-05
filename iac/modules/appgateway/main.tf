
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
        name = "appgwIpCfg"
        subnet_id = data.terraform_remote_state.vnet.outputs.subnet_ids["appgw"]
    }

    frontend_ip_configuration {
        name = "appgwFeIp"
        public_ip_address_id = data.terraform_remote_state.pip.outputs.public_ip_id
    }

  frontend_port {
    name = "httpPort"
    port = 80
  }

  frontend_port {
    name = "httpsPort"
    port = 443
  }

  backend_address_pool {
    name = "aksBackendPool"
    ip_addresses = var.backend_ips
  }

  backend_http_settings {
    name = "httpSettings"
    cookie_based_affinity = "Disabled"
    port = 80
    protocol = "Http"
    request_timeout = 30
  }

  http_listener {
    name = "httpListener"
    frontend_ip_configuration_name = "appgwFeIp"
    frontend_port_name = "httpPort"
    protocol = "Http"
  }

  request_routing_rule {
    name = "ruleHttpBasic"
    rule_type = "Basic"
    http_listener_name = "httpListener"
    backend_address_pool_name = "aksBackendPool"
    backend_http_settings_name = "httpSettings"
    priority = 100
  }

  tags = var.tags
}

