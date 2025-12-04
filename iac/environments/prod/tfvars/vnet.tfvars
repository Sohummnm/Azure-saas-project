vnet_name = "prod-vnet"
address_space = ["10.0.0.0/16"]

subnets = {
    aks = "10.0.1.0/16"
    app = "10.0.2.0/24"
    db = "10.0.3.0/24"
}
tags = {
    environment = "production"
    owner = "platform-engineering"
}