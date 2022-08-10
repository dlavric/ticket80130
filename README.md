# ticket80130

This repository has been created to test the AWS v3 VS v4 performance

## Instructions

### Prerequisites

- [X] [Terraform](https://www.terraform.io/downloads)

## How to Use this Repo

- Clone this repository:
```shell
git clone git@github.com:dlavric/ticket80130.git
```

- Go to the directory where the repo is stored and make sure the `main.tf` file is there too:
```shell
cd ticket80130
```

- Export the AWS credentials 
```shell
export AWS_ACCESS_KEY_ID=...
export AWS_SECRET_ACCESS_KEY=...
export AWS_SESSION_TOKEN=...   
```

- Run `terraform init`, to download any external dependency
```shell
terraform init
```

- Run `terraform plan` to and check how much time it takes to complete on v3 VS v4 of the AWS provider
```shell
terraform plan
```

