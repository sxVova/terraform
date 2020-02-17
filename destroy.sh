#!/bin/bash/
cd terraform_flask/
terraform destroy -auto-approve
cd  ../terraform_gitlab/
terraform destroy -auto-approve
cd ../terraform_jenkins/
terraform destroy -auto-approve
cd ../terraform_sentry/
terraform destroy -auto-approve
cd ../terraform_ansible/
terraform destroy -auto-approve
