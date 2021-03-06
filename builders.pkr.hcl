build {
  sources = [
    "source.amazon-ebs.hashistack"
  ]

  provisioner "shell" {
    inline = [
              "sleep 30",
              "sudo apt-get update",
              "sudo apt-get upgrade -y",
              "sudo apt-get install -y gnupg openssl jq unzip htop ldap-utils awscli"
             ]
  }

  provisioner "file" {
    source      = "files/hashi_install.sh"
    destination = "/tmp/hashi_install.sh"
  }

  provisioner "file" {
    source      = "files/vault.service"
    destination = "/tmp/vault.service"
  }

  provisioner "file" {
    source      = "files/consul.service"
    destination = "/tmp/consul.service"
  }

  provisioner "file" {
    source      = "files/nomad.service"
    destination = "/tmp/nomad.service"
  }

  provisioner "file" {
    # via https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html
    #     https://download.oracle.com/otn_software/linux/instantclient/211000/instantclient-basic-linux.x64-21.1.0.0.0.zip
    source      = "files/instantclient-basic-linux.x64-21.1.0.0.0.zip"
    destination = "/tmp/instantclient.zip"
  }

  provisioner "file" {
    # via https://github.com/Venafi/vault-pki-backend-venafi/releases
    #     https://github.com/Venafi/vault-pki-backend-venafi/releases/download/v0.8.3/venafi-pki-backend_v0.8.3_linux.zip
    source      = "files/venafi-pki-backend_v0.8.3_linux.zip"
    destination = "/tmp/venafi-pki-backend.zip"
  }

  provisioner "shell" {
    inline = [
      "sudo bash /tmp/hashi_install.sh ${var.hashi_download_dir} ${var.bin_dir}     ${var.hashi_base_url} vault                        ${var.vault_version} ent",
      "sudo bash /tmp/hashi_install.sh ${var.hashi_download_dir} ${var.bin_dir}     ${var.hashi_base_url} consul                       ${var.consul_version} ent",
      "sudo bash /tmp/hashi_install.sh ${var.hashi_download_dir} ${var.bin_dir}     ${var.hashi_base_url} nomad                        ${var.nomad_version} ent",
      "sudo bash /tmp/hashi_install.sh ${var.hashi_download_dir} ${var.bin_dir}     ${var.hashi_base_url} terraform                    ${var.terraform_version}",
      "sudo bash /tmp/hashi_install.sh ${var.hashi_download_dir} ${var.bin_dir}     ${var.hashi_base_url} packer                       ${var.packer_version}",
      "sudo bash /tmp/hashi_install.sh ${var.hashi_download_dir} ${var.bin_dir}     ${var.hashi_base_url} envconsul                    ${var.envconsul_version}",
      "sudo bash /tmp/hashi_install.sh ${var.hashi_download_dir} ${var.bin_dir}     ${var.hashi_base_url} consul-template              ${var.consul-template_version}",
      "sudo bash /tmp/hashi_install.sh ${var.hashi_download_dir} ${var.plugins_dir} ${var.hashi_base_url} vault-plugin-database-oracle ${var.oracle_plugin_version}",
      "sudo bash /tmp/hashi_install.sh ${var.hashi_download_dir} ${var.bin_dir}     ${var.hashi_base_url} boundary                     ${var.boundary_version}",
      "sudo bash /tmp/hashi_install.sh ${var.hashi_download_dir} ${var.bin_dir}     ${var.hashi_base_url} waypoint                     ${var.waypoint_version}",
   ]
  }

  provisioner "shell" {
    inline = [
      "sudo /usr/local/bin/packer -autocomplete-install"
    ]
  }

  provisioner "shell" {
    inline = [
      "sudo /usr/local/bin/consul -autocomplete-install",
      "sudo useradd --system --home /etc/consul.d --shell /bin/false consul",
      "sudo mkdir -p /etc/consul.d",
      "sudo touch /etc/consul.d/consul.hcl",
      "sudo chown -R consul:consul /etc/consul.d",
      "sudo chmod 640 /etc/consul.d/consul.hcl",
      "sudo mv /tmp/consul.service /etc/systemd/system/consul.service"
    ]
  }

  provisioner "shell" {
    inline = [
      "sudo /usr/local/bin/nomad -autocomplete-install",
      "sudo useradd --system --home /etc/nomad.d --shell /bin/false nomad",
      "sudo mkdir -p /etc/nomad.d",
      "sudo touch /etc/nomad.d/nomad.hcl",
      "sudo chown -R nomad:nomad /etc/nomad.d",
      "sudo chmod 640 /etc/nomad.d/nomad.hcl",
      "sudo mv /tmp/nomad.service /etc/systemd/system/nomad.service"
    ]
  }

  provisioner "shell" {
    inline = [
      "sudo /usr/local/bin/vault -autocomplete-install",
      "sudo setcap cap_ipc_lock=+ep /usr/local/bin/vault",
      "sudo setcap cap_ipc_lock=+ep ${var.plugins_dir}/vault-plugin-database-oracle",
      "sudo useradd --system --home /etc/vault.d --shell /bin/false vault",
      "sudo mkdir /etc/vault.d",
      "sudo touch /etc/vault.d/vault.hcl",
      "sudo chown -R vault:vault /etc/vault.d",
      "sudo chmod 640 /etc/vault.d/vault.hcl",
      "sudo mv /tmp/vault.service /etc/systemd/system/vault.service"
    ]
  }

  provisioner "shell" {
    inline = [
      "sudo mkdir -p ${var.oracle_download_dir}",
      "sudo mv /tmp/instantclient.zip ${var.oracle_download_dir}/",
      "sudo unzip -d ${var.oracle_client_dir} ${var.oracle_download_dir}/instantclient.zip",
      "echo /usr/local/instantclient_21_1 | sudo tee -a /etc/ld.so.conf.d/oracle-instantclient.conf",
      "sudo ldconfig"
    ]
  }

  provisioner "shell" {
    inline = [
      "sudo mv /tmp/venafi-pki-backend.zip ${var.hashi_download_dir}",
      "sudo unzip -d ${var.plugins_dir} ${var.hashi_download_dir}/venafi-pki-backend.zip",
      "sudo setcap cap_ipc_lock=+ep ${var.plugins_dir}/venafi-pki-backend"
    ]
  }
}
