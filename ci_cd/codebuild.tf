module "codebuild_iam_role" {
  source = "dod-iac/codebuild-iam-role/aws"

  name       = "app-cinema-microservice-codebuild-iam-role-${var.env}"
  subnet_ids = ["*"]
  vpc_ids    = ["*"]
  tags       = {
    Application = "cinema-microservice-"
    Environment = var.env
    Automation  = "Terraform"
  }
}

data "template_file" "buildspec" {
  template = file("${path.module}/buildspec.yml")
  vars = {
    env          = var.env
  }
}

resource "aws_codebuild_project" "static_web_build" {
  badge_enabled  = false
  build_timeout  = 60
  name           = "static-web-build"
  queued_timeout = 480
  service_role   = module.codebuild_iam_role.arn
  tags = {
    Environment = var.env
  }

  artifacts {
    encryption_disabled    = false
    name                   = "static-web-build-${var.env}"
    override_artifact_name = false
    packaging              = "NONE"
    type                   = "CODEPIPELINE"
  }

  environment {
    compute_type                = "BUILD_GENERAL1_SMALL"
    image                       = "aws/codebuild/amazonlinux2-x86_64-standard:2.0"
    image_pull_credentials_type = "CODEBUILD"
    privileged_mode             = false
    type                        = "LINUX_CONTAINER"
  }

  logs_config {
    cloudwatch_logs {
      status = "ENABLED"
    }

    s3_logs {
      encryption_disabled = false
      status              = "DISABLED"
    }
  }

  source {
    buildspec           = data.template_file.buildspec.rendered
    git_clone_depth     = 0
    insecure_ssl        = false
    report_build_status = false
    type                = "CODEPIPELINE"
  }
}
