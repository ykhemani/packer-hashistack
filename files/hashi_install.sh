#!/bin/bash

################################################################################

hashi_download_dir=$1
install_dir=$2
hashi_base_url=$3
software=$4
version=$5
enterprise=$6
beta=$7

function usage() {
  echo "Usage: $0 <download directory> <install directory> <hashi base url> <software> <version> <ent> <beta>"
  echo " e.g.: $0 /data/src/hashicorp /usr/local/bin https://releases.hashicorp.com vault 1.4.0 ent"
  echo " e.g.: $0 /data/src/hashicorp /usr/local/bin https://releases.hashicorp.com consul 1.7.2 \"\" beta2"
  echo " e.g.: $0 /data/src/hashicorp /usr/local/bin https://releases.hashicorp.com nomad 0.10.2"
  echo " e.g.: $0 /data/src/hashicorp /data/vault/plugins https://releases.hashicorp.com vault-plugin-database-oracle 0.1.6"
}

function show_inputs() {
  echo "hashi_download_dir is ${hashi_download_dir}"
  echo "install_dir is ${install_dir}"
  echo "hashi_base_url is ${hashi_base_url}"
  echo "software is ${software}"
  echo "version is ${version}"
  echo "enterprise is ${enterprise}"
  echo "beta is ${beta}"
}

error=0
if [ "${hashi_download_dir}" == "" ]
then
  error=1
elif [ "${install_dir}" == "" ]
then
  error=1
elif [ "${hashi_base_url}" == "" ]
then
  error=1
elif [ "${software}" == "" ]
then
  error=1
elif [ "${version}" == "" ]
then
  error=1
fi

if [ "${error}" != "0" ]
then
  usage
  echo ""
  show_inputs
  exit ${error}
fi

if [ "${enterprise}" != "" ]
then
  enterprise="+${enterprise}"
fi

if [ "${beta}" != "" ]
then
  beta="-${beta}"
fi

url=${hashi_base_url}/${software}/${version}${enterprise}${beta}/${software}_${version}${enterprise}${beta}_linux_amd64.zip
mkdir -p ${hashi_download_dir} ${install_dir} && \
  cd ${hashi_download_dir} && \
  wget --quiet -O ${software}.zip "${url}" && \
  unzip -q -d ${install_dir} ${software}.zip && \
  cd -
