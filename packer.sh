#!/bin/bash

export HCP_CLIENT_ID=$(vault kv get -field HCP_CLIENT_ID kv/hcp/packer)
export HCP_CLIENT_SECRET=$(vault kv get -field HCP_CLIENT_SECRET kv/hcp/packer)

packer init .
packer fmt .

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
