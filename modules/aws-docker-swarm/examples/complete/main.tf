provider "aws" {
  region = "${var.aws_region}"
}

data "aws_vpc" "default" {
  default = true
}

data "aws_subnet_ids" "all" {
  vpc_id = "${data.aws_vpc.default.id}"
}

module "aws-docker-swarm" {
  source = "../../"
  vpc_id = "${var.vpc_id}"
  ec2_subnet_id = "${var.subnet_1}"
  ec2_master_name = "swarm_master"
  ec2_worker_name = "swarm_worker"
  master_count = "1"
  worker_count= "2"
  ec2_instance_type = "m5.large"
  ec2_key_name = "damedash-dev"
  security_group_ids = ["sg-cdb1ff84", "sg-0cb7f945"]
}

output "MASTERS" {
  value = "${module.aws-docker-swarm.MASTERS}"
}
output "WORKERS" {
  value = "${module.aws-docker-swarm.WORKERS}"
}
