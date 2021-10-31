# https://github.com/y-ohgi/introduction-terraform/blob/master/handson/handson/main.tf

terraform {
  required_version = "~> 1.0.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.45.0"
    }
  }
}

variable "aws_access_key" {}
variable "aws_secret_key" {}

# Configure the AWS Provider
# https://dev.classmethod.jp/articles/terraform-getting-started-with-aws/
provider "aws" {
  access_key = var.aws_access_key
  secret_key = var.aws_secret_key
  region     = "ap-northeast-1"
}

# VPC
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/vpc
resource "aws_vpc" "main" {
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "zns-member-site"
  }
}

# Subnet
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/subnet
resource "aws_subnet" "public_1a" {
  vpc_id            = aws_vpc.main.id
  availability_zone = "ap-northeast-1a"
  cidr_block        = "10.0.1.0/24"

  tags = {
    Name = "zns-member-site-pub"
  }
}

resource "aws_subnet" "public_1c" {
  vpc_id            = aws_vpc.main.id
  availability_zone = "ap-northeast-1c"
  cidr_block        = "10.0.2.0/24"

  tags = {
    Name = "zns-member-site-pub"
  }
}

# Internet Gateway
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/internet_gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "zns-member-site-igw"
  }
}

# Route Table
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route_table
resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "zns-member-site-rt"
  }
}

# Route(ルートテーブルのルート)
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route
resource "aws_route" "public" {
  destination_cidr_block = "0.0.0.0/0"
  route_table_id         = aws_route_table.public.id
  gateway_id             = aws_internet_gateway.igw.id
}

# Association(ルートテーブルのサブネット関連づけ)
# https://www.terraform.io/docs/providers/aws/r/route_table_association.html
resource "aws_route_table_association" "public_1a" {
  subnet_id      = aws_subnet.public_1a.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table_association" "public_1c" {
  subnet_id      = aws_subnet.public_1c.id
  route_table_id = aws_route_table.public.id
}

# ALB
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/lb
resource "aws_lb" "main" {
  name               = "zns-member-site-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [module.alb_sg_http.security_group_id]
  subnets            = [aws_subnet.public_1a.id, aws_subnet.public_1c.id]
}

# SecurityGroup
# https://www.terraform.io/docs/providers/aws/r/security_group.html

module "alb_sg_http" {
  source = "./security_group"
  name = "zns-member-site-alb-sg"
  vpc_id = aws_vpc.main.id
  port = 80
  cidr_blocks = ["0.0.0.0/0"]
  description = ""
}

# Listener
# https://www.terraform.io/docs/providers/aws/r/lb_listener.html
resource "aws_lb_listener" "main" {
  port              = "80"
  protocol          = "HTTP"
  load_balancer_arn = aws_lb.main.arn

  # "ok" という固定レスポンスを設定する
  default_action {
    type = "fixed-response"

    fixed_response {
      content_type = "text/plain"
      status_code  = "200"
      message_body = "ok"
    }
  }
}

# SSMパラメーターストア(環境変数)
# 機密情報のパラメーターはTerraformではダミーの値を設定して、あとでaws-cliから更新する
resource "aws_ssm_parameter" "rails_env" {
  name = "rails_env"
  value = "production"
  type = "String"
  description = "RAILS_ENV"
}

resource "aws_ssm_parameter" "tz" {
  name = "tz"
  value = "Japan"
  type = "String"
  description = "TZ"
}

resource "aws_ssm_parameter" "db_name" {
  name = "/db/name"
  value = "zasetsu_norikoe_app_production"
  type = "String"
  description = "DB_NAME"
}

resource "aws_ssm_parameter" "db_user_name" {
  name = "/db/user_name"
  value = "zasetsu_norikoe_app"
  type = "String"
  description = "DB_USERNAME"
}

resource "aws_ssm_parameter" "db_password" {
  name = "/db/password"
  value = "db_pass"
  type = "SecureString"
  description = "DB_PASSWORD"
}

resource "aws_ssm_parameter" "db_host" {
  name = "/db/host"
  value = "db_host"
  type = "SecureString"
  description = "DB_HOST"
}

resource "aws_ssm_parameter" "basic_auth_name" {
  name = "/db/basic_auth_name"
  value = "basic_auth_name"
  type = "SecureString"
  description = "BASIC_AUTH_NAME"
}

resource "aws_ssm_parameter" "basic_auth_password" {
  name = "/db/basic_auth_password"
  value = "basic_auth_password"
  type = "SecureString"
  description = "BASIC_AUTH_PASSWORD"
}

# ECS Cluster(ECSクラスタ)
# https://www.terraform.io/docs/providers/aws/r/ecs_cluster.html
resource "aws_ecs_cluster" "main" {
  name = "zns-member-site"
}

# Task Definition(タスク定義)
# https://www.terraform.io/docs/providers/aws/r/ecs_task_definition.html
# https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/task-cpu-memory-error.html
resource "aws_ecs_task_definition" "main" {
  family = "zns-member-site"

  # Fargateの設定
  cpu                      = "256"
  memory                   = "1024"
  network_mode             = "awsvpc"
  requires_compatibilities = ["FARGATE"]
  container_definitions    = file("./container_definitions.json")
  execution_role_arn       = module.ecs_task_execution_role.iam_role_arn
}

# ALB Target Group
# https://www.terraform.io/docs/providers/aws/r/lb_target_group.html
resource "aws_lb_target_group" "main" {
  name                 = "zns-member-site-alb-tg"
  target_type          = "ip"
  vpc_id               = aws_vpc.main.id
  port                 = 80
  protocol             = "HTTP"
  deregistration_delay = 300

  health_check {
    path                = "/"
    healthy_threshold   = 5
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200,201,302"
    port                = "traffic-port"
    protocol            = "HTTP"
  }

  depends_on = [
    aws_lb.main
  ]
}

# ALB Listener
# https://www.terraform.io/docs/providers/aws/r/lb_listener_rule.html
resource "aws_lb_listener_rule" "main" {
  listener_arn = aws_lb_listener.main.arn
  priority     = 100

  action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.main.arn
  }

  condition {
    path_pattern {
      values = ["/*"]
    }
  }
}

# ECS Service
# https://www.terraform.io/docs/providers/aws/r/ecs_service.html
resource "aws_ecs_service" "main" {
  name            = "zns-member-site-ecs"
  cluster         = aws_ecs_cluster.main.arn
  task_definition = aws_ecs_task_definition.main.arn
  desired_count   = 1
  launch_type     = "FARGATE"
  # https://docs.aws.amazon.com/ja_jp/AmazonECS/latest/developerguide/platform_versions.html#available_pv
  platform_version                  = "1.4.0"
  health_check_grace_period_seconds = 3600

  network_configuration {
    assign_public_ip = true
    security_groups  = [module.ecs_sg_http.security_group_id]

    subnets = [aws_subnet.public_1a.id, aws_subnet.public_1c.id]
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.main.arn
    container_name   = "nginx"
    container_port   = 80
  }

  lifecycle {
    ignore_changes = [task_definition]
  }
}

# SecurityGroup(ECS)
# https://www.terraform.io/docs/providers/aws/r/security_group.html

module "ecs_sg_http" {
  source = "./security_group"
  name = "zns-member-site-ecs-sg"
  vpc_id = aws_vpc.main.id
  port = 80
  cidr_blocks = [aws_vpc.main.cidr_block]
  description = ""
}

# Route53

data "aws_route53_zone" "main" {
  name="zns-member-site.com"
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/route53_zone
resource "aws_route53_record" "main" {
  zone_id = data.aws_route53_zone.main.zone_id
  name    = data.aws_route53_zone.main.name
  type    = "A"

  alias {
    name                   = aws_lb.main.dns_name
    zone_id                = aws_lb.main.zone_id
    evaluate_target_health = true
  }
}

output "domain_name" {
  value = aws_route53_record.main.name
}

# CloudWatch Logs(ログ管理)
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/cloudwatch_log_group
resource "aws_cloudwatch_log_group" "for_ecs" {
  name              = "/ecs/zns-member-site"
  retention_in_days = 7
}

# ECSタスク実行IAMロール

data "aws_iam_policy" "ecs_task_execution_role_policy" {
  arn = "arn:aws:iam::aws:policy/service-role/AmazonECSTaskExecutionRolePolicy"
}

# aws_iam_policyの内容を継承して、必要な権限を追加
data "aws_iam_policy_document" "ecs_task_execution" {
  source_json = data.aws_iam_policy.ecs_task_execution_role_policy.policy

  statement {
    effect    = "Allow"
    actions   = ["ssm:GetParameters", "kms:Decrypt"]
    resources = ["*"]
  }
}

module "ecs_task_execution_role" {
  source     = "./iam_role"
  name       = "ecs_task_execution"
  identifier = "ecs-tasks.amazonaws.com"
  policy     = data.aws_iam_policy_document.ecs_task_execution.json
}

# RDS

# SecurityGroup(RDS)
# https://www.terraform.io/docs/providers/aws/r/security_group.html

module "rds_sg" {
  source = "./security_group"
  name = "zns-member-site-rds-sg"
  vpc_id = aws_vpc.main.id
  port = 3306
  cidr_blocks = ["0.0.0.0/0"]
  description = ""
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_subnet_group
resource "aws_db_subnet_group" "main" {
  name = "zns-member-site-rds-subnet-group"
  subnet_ids = [aws_subnet.public_1a.id,aws_subnet.public_1c.id]

  tags = {
    Name = "zns-member-site-rds-subnet-group"
  }
}

# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/db_instance
resource "aws_db_instance" "main" {
  identifier = "zns-member-site-db"
  engine               = "mysql"
  engine_version       = "5.7"
  instance_class       = "db.t3.micro"
  allocated_storage   = 20
  storage_type        = "gp2"
  name = "zasetsu_norikoe_app_production"
  username            = "zasetsu_norikoe_app"
  password            = "password" # 構築後すぐマスターパスワードを変更すること
  port                = 3306
  # skip_final_snapshot = true

  vpc_security_group_ids = [module.rds_sg.security_group_id]
  db_subnet_group_name = aws_db_subnet_group.main.name
}

# ***************
# Rails deploy
# ***************

# App ECRリポジトリ
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_repository
resource "aws_ecr_repository" "app" {
  name = "zns-member-site-ecr-app"

  image_scanning_configuration {
    scan_on_push = true
  }
}

# App ECRライフサイクルポリシー
# https://docs.aws.amazon.com/ja_jp/AmazonECR/latest/userguide/LifecyclePolicies.html
# https://registry.terraform.io/providers/hashicorp/aws/latest/docs/resources/ecr_lifecycle_policy
resource "aws_ecr_lifecycle_policy" "app" {
  repository = aws_ecr_repository.app.name

  policy = <<EOF
  {
    "rules": [
      {
        "rulePriority": 1,
        "description": "Keep last 10 release tagged images",
        "selection": {
          "tagStatus": "tagged",
          "tagPrefixList": ["release"],
          "countType": "imageCountMoreThan",
          "countNumber": 10
        },
        "action": {
          "type": "expire"
        }
      }
    ]
  }
  EOF
}

# Nginx ECR
resource "aws_ecr_repository" "nginx" {
  name = "zns-member-site-ecr-nginx"

  image_scanning_configuration {
    scan_on_push = true
  }
}
