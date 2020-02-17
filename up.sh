#!/bin/bash/
cd terraform_flask/
terraform apply -auto-approve
cd  ../terraform_gitlab/
terraform apply -auto-approve
cd ../terraform_jenkins/
terraform apply -auto-approve
cd ../terraform_sentry/
terraform apply -auto-approve
cd ../terraform_ansible/
terraform apply -auto-approve
