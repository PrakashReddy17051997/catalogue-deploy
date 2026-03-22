module "catalogue" {
    source = "git::https://github.com/PrakashReddy17051997/roboshop_app.git?ref=main"
    vpc_id = data.aws_ssm_parameter.vpc_id.value
    component_sg_id = data.aws_ssm_parameter.catalogue_sg_id.value
    private_subnet_ids = split(",", data.aws_ssm_parameter.private_subnet_ids.value)
    iam_instance_profile = var.iam_instance_profile
    project_name = var.project_name
    environment = var.environment
    common_tags = var.common_tags
    tags = var.tags
    zone_name = var.zone_name
    app_alb_listener_arn = data.aws_ssm_parameter.app_alb_listener_arn.value
    priority = 20
    instance_username = data.aws_ssm_parameter.ec2_instance_username.value
    instance_password = data.aws_ssm_parameter.ec2_instance_password.value
    app_version = var.app_version
}