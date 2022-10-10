locals {
    vpc = {
        cidr = "10.0.0.0/16"
        private_subnets = {
            us-east-1a = {
                cidr = "10.0.10.0/24"
            }
            us-east-1b = {
                cidr = "10.0.11.0/24"
            }
        }
        public_subnets = {
            us-east-1a = {
                cidr = "10.0.20.0/24"
            }
            us-east-1b = {
                cidr = "10.0.21.0/24"
            }
        }
    }
}