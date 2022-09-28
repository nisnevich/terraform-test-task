resource "aws_codepipeline" "cinema_microservice_pipeline" {
  name     = "cinema_microservice_pipeline"
  role_arn = data.aws_iam_role.pipeline_role.arn
  tags     = {
    Environment = var.env
  }

  stage {
    name = "Source"

    action {
      category = "Source"
      configuration = {
        "Branch"               = var.github_repository_branch
        "Owner"                = var.github_repository_owner
        "PollForSourceChanges" = "false"
        "Repo"                 = var.github_repository_name
      }
      input_artifacts = []
      name            = "Source"
      output_artifacts = [
        "SourceArtifact",
      ]
      owner     = "ThirdParty"
      provider  = "GitHub"
      run_order = 1
      version   = "1"
    }
  }
  stage {
    name = "Build"

    action {
      category = "Build"
      configuration = {
        "EnvironmentVariables" = jsonencode(
          [
            {
              name  = "ENV"
              type  = "PLAINTEXT"
              value = var.env
            },
            {
              name  = "AWS_DEFAULT_REGION"
              type  = "PLAINTEXT"
              value = var.aws_region
            },
            {
              name  = "AWS_ACCOUNT_ID"
              type  = "PLAINTEXT"
              value = var.aws_account_id
            },
            {
              name  = "IMAGE_REPO_NAME"
              type  = "PLAINTEXT"
              value = "web-app"
            },
          ]
        )
        "ProjectName" = "cinema-microservice-web-build"
      }
      input_artifacts = [
        "SourceArtifact",
      ]
      name = "Build"
      output_artifacts = [
        "BuildArtifact",
      ]
      owner     = "AWS"
      provider  = "CodeBuild"
      run_order = 1
      version   = "1"
    }
  }
#   stage {
#     name = "Deploy"
#
#     action {
#       category = "Deploy"
#       configuration = {
#         "BucketName" = var.static_web_bucket_name
#         "Extract"    = "true"
#       }
#       input_artifacts = [
#         "BuildArtifact",
#       ]
#       name             = "Deploy"
#       output_artifacts = []
#       owner            = "AWS"
#       provider         = "S3"
#       run_order        = 1
#       version          = "1"
#     }
#   }
}
