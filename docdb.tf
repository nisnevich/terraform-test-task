resource "aws_docdb_subnet_group" "service" {
  name       = var.project_name
  subnet_ids = module.vpc.private_subnets
}

resource "aws_docdb_cluster_instance" "service" {
  count              = 1
  identifier         = "${var.project_name}-${count.index}"
  cluster_identifier = "${aws_docdb_cluster.service.id}"
  instance_class     = "${var.docdb_instance_class}"
}

resource "aws_docdb_cluster" "service" {
  skip_final_snapshot     = true
  db_subnet_group_name    = "${aws_docdb_subnet_group.service.name}"
  cluster_identifier      = var.project_name
  engine                  = "docdb"
  master_username         = "tf-${var.project_name}-admin"
  master_password         = var.docdb_password
  db_cluster_parameter_group_name = "${aws_docdb_cluster_parameter_group.service.name}"
  vpc_security_group_ids = [aws_security_group.service.id]
}

resource "aws_docdb_cluster_parameter_group" "service" {
  family = "docdb3.6"
  name = var.project_name

  parameter {
    name  = "tls"
    value = "disabled"
  }
}
