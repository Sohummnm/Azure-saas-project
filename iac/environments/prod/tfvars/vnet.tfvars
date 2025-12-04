vnet_name = "prod-vnet"
address_space = ["10.0.0.0/16"]

subnets = {
    aks = "10.0.0.0/17"
    appgw = "10.0.128.0/24"
    db = "10.0.129.0/24"
}
tags = {
    environment = "production"
    owner = "platform-engineering"
}