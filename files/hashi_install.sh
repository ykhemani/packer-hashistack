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
  echo "Download and install Hashi Tools."
  echo ""
  echo "Usage: $0 <download directory> <install directory> <hashi base url> <software> <version> <ent> <beta>"
  echo " e.g.: $0 /data/src/hashicorp /usr/local/bin https://releases.hashicorp.com vault 1.4.0 ent"
  echo " e.g.: $0 /data/src/hashicorp /usr/local/bin https://releases.hashicorp.com consul latest \"\" beta2"
  echo " e.g.: $0 /data/src/hashicorp /usr/local/bin https://releases.hashicorp.com nomad"
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
fi

if [ "${error}" != "0" ]
then
  usage
  echo ""
  show_inputs
  exit ${error}
fi

if [ "${version}" == "" ] || [ "${version}" == "latest" ]
then
  echo "getting latest ${software} version ${enterprise} ${beta}"
  url=$(curl -sL ${hashi_base_url}/${software}/index.json | jq -r '.versions[].builds[].url' | egrep "${software}_[0-9]\.[0-9]{1,2}\.[0-9]{1,2}[\+]?${enterprise}${beta}_linux.*amd64" | sort -V | tail -1)
else
  if [ "${enterprise}" != "" ]
  then
    enterprise="+${enterprise}"
  fi

  if [ "${beta}" != "" ]
  then
    beta="-${beta}"
  fi
  url=${hashi_base_url}/${software}/${version}${enterprise}${beta}/${software}_${version}${enterprise}${beta}_linux_amd64.zip
fi

echo "Download URL is $url"

mkdir -p ${hashi_download_dir}/${software} ${install_dir} && \
  cd ${hashi_download_dir}/${software} && \
  wget --quiet -O ${software}.zip "${url}" && \
  unzip -q ${software}.zip && \
  mv ${software} ${install_dir} && \
  cd -
