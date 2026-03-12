locals {
  name           = "${var.project_name}-${var.environment}"
  current_time = formatdate("DD-MM-YYYY-hh-mm-ss", timestamp())
}