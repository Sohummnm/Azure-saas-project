appgw_name = "appgw-demo"
sku_name   = "Standard_v2"
sku_tier   = "Standard_v2"
sku_capacity = 1
backend_ips = ["10.1.0.10"]
agic_identity_name = "agic-identity"


tags = {
  environment = "demo"
  owner       = "platform-team"
}