# NSGs to create
nsgs = {
  aks   = {}
  appgw = {}
  db    = {}
}

# Tags for governance
tags = {
  environment = "production"
  owner       = "platform-engineering"
}

# AKS NSG rules
aks_rules = {
  allow_lb = {
    priority  = 100
    direction = "Inbound"
    access    = "Allow"
    protocol  = "Tcp"
    port      = "*"
    source    = "AzureLoadBalancer"
  }
  allow_appgw_ingress = {
    priority  = 110
    direction = "Inbound"
    access    = "Allow"
    protocol  = "Tcp"
    port      = "443"
    source    = "10.0.128.0/24"   # literal CIDR of AppGW subnet
  }
  allow_out_acr = {
    priority  = 200
    direction = "Outbound"
    access    = "Allow"
    protocol  = "Tcp"
    port      = "*"
    source    = "AzureContainerRegistry"
  }
  allow_out_monitor = {
    priority  = 210
    direction = "Outbound"
    access    = "Allow"
    protocol  = "Tcp"
    port      = "*"
    source    = "AzureMonitor"
  }
}

# App Gateway NSG rules
appgw_rules = {
  allow_internet_https = {
    priority  = 100
    direction = "Inbound"
    access    = "Allow"
    protocol  = "Tcp"
    port      = "443"
    source    = "Internet"
  }
  allow_internet_http = {
    priority  = 110
    direction = "Inbound"
    access    = "Allow"
    protocol  = "Tcp"
    port      = "80"
    source    = "Internet"
  }
  allow_azure_infra = {
    priority  = 120
    direction = "Inbound"
    access    = "Allow"
    protocol  = "Tcp"
    port      = "65200-65535"
    source    = "AzureLoadBalancer"
  }
  allow_to_aks = {
    priority  = 200
    direction = "Outbound"
    access    = "Allow"
    protocol  = "Tcp"
    port      = "443"
    source    = "10.0.0.0/17"   # literal CIDR of AKS subnet
  }
  allow_internet_ephemeral = {
    priority  = 115
    direction = "Inbound"
    access    = "Allow"
    protocol  = "Tcp"
    port      = "65200-65535"
    source    = "Internet"
  }
}

# DB NSG rules
db_rules = {
  allow_appgw = {
    priority  = 100
    direction = "Inbound"
    access    = "Allow"
    protocol  = "Tcp"
    port      = "1433"
    source    = "10.0.128.0/24"   # literal CIDR of AppGW subnet
  }
  allow_aks = {
    priority  = 110
    direction = "Inbound"
    access    = "Allow"
    protocol  = "Tcp"
    port      = "1433"
    source    = "10.0.0.0/17"     # literal CIDR of AKS subnet
  }
  deny_internet_inbound = {
    priority  = 400
    direction = "Inbound"
    access    = "Deny"
    protocol  = "*"
    port      = "*"
    source    = "Internet"
  }
  deny_outbound_internet = {
    priority  = 410
    direction = "Outbound"
    access    = "Deny"
    protocol  = "*"
    port      = "*"
    source    = "*"
  }
}