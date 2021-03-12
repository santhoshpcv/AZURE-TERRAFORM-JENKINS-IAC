variable "resource_group" {
    type = string
    default = "pani_rg"
}

variable "virtualnetwork_name" {
    type = string
    default = "santhoshvnet"
}

variable "nsgs"{

    type = list
    default = ["prd_nsg","test_nsg","dev_nsg"]


}