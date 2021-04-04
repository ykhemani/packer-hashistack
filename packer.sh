#!/bin/bash

# build unencrypted ami
packer build \
  -var-file="yash.pkrvars.hcl" \
  .

# build encrypted ami
#packer build \
#  -var "owner=$(cat var.owner)" \
#  -var "encrypt_boot=true" \
#  -var "aws_kms_key_id=$(cat var.aws_kms_key_id)" \
#  .
