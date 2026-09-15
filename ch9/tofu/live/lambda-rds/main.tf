provider "aws" {
  region = "eu-central-1"
}

module "rds_postgres" {
    source = "brikis98/devops/book//modules/rds-postgres"
    version = "1.0.1"

    name = "bank"

    postgres_version = "16.15"
    instance_class = "db.t4g.micro"
    allocated_storage = 20
    username = var.username
    password = var.password
}

module "app" {
    source = "brikis98/devops/book//modules/lambda"
    version = "1.0.1"

    name = "lambda-rds-app"

    src_dir = "${path.module}/src"
    handler = "app.handler"
    runtime = "nodejs22.x"
    memory_size = 128
    timeout = 5

    environment_variables = {
        NODE_ENV = "production"
        DB_NAME = module.rds_postgres.db_name
        DB_HOST = module.rds_postgres.hostname
        DB_PORT = module.rds_postgres.port
        DB_USERNAME = var.username
        DB_PASSWORD = var.password
    }

    create_url = true
}
