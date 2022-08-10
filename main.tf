terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "=4.15"
    }
  }

  required_version = ">= 0.14.5"
}

provider "aws" {
  #profile = "default"
  region  = "us-west-2"
}


resource "aws_vpc" "foo" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "tf-test"
  }
}

resource "aws_subnet" "foo" {
  vpc_id            = aws_vpc.foo.id
  cidr_block        = "10.0.0.0/24"
  availability_zone = "us-west-2a"

  tags = {
    Name = "tf-test"
  }
}

resource "aws_elasticache_subnet_group" "bar" {
  name       = "tf-test-cache-subnet"
  subnet_ids = [aws_subnet.foo.id]
}

resource "aws_route53_record" "www" {
  zone_id = "Z0000799J2Y51JXARECS"
  name    = "www.example.com"
  type    = "A"
  ttl     = 300
  #records = "helloworld"
}

resource "aws_elasticache_parameter_group" "default" {
  name   = "cache-params"
  family = "redis2.8"

  parameter {
    name  = "activerehashing"
    value = "yes"
  }

  parameter {
    name  = "min-slaves-to-write"
    value = "2"
  }
}

resource "aws_elasticache_global_replication_group" "example" {
  global_replication_group_id_suffix = "example"
  primary_replication_group_id       = aws_elasticache_replication_group.primary.id
}

resource "aws_elasticache_replication_group" "primary" {
  replication_group_id          = "example-primary"
  replication_group_description = "primary replication group"

  engine         = "redis"
  engine_version = "5.0.6"
  node_type      = "cache.m5.large"

  number_cache_clusters = 1
}

resource "aws_elasticache_replication_group" "secondary" {
  #provider = aws.other_region

  replication_group_id          = "example-secondary"
  replication_group_description = "secondary replication group"
  global_replication_group_id   = aws_elasticache_global_replication_group.example.global_replication_group_id

  number_cache_clusters = 1
}

# aws_elasticache_global_replication_group
# aws_elasticache_parameter_group
# aws_elasticache_parameter_group
# aws_route53_record
# aws_elasticache_subnet_group

# We are have resources in AWS ap-northeast-1 and ap-east-1