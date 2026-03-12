variable "common_tags" {
  default = {
    Project     = "Roboshop"
    Environment = "dev"
    Terraform   = "true"
  }

}

variable "tags" {
  default = {
    Component = "catalogue"
  }
  
}

variable "project_name" {
  default = "roboshop"

}
variable "environment" {
  default = "dev"

}
variable "zone_name" {
  type    = string
  default = "learndevopswithprakash.online"

}

variable "app_version" {
  
}