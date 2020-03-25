build {
  sources = [
    "source.amazon-ebs.hashistack"
  ]

  provisioner "shell" {
    inline = [
              "sleep 30",
              "sudo apt-get update",
              "sudo apt-get upgrade -y",
              "sudo apt-get install -y gnupg openssl jq unzip htop"
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
    source      = "files/instantclient-basic-linux.x64-19.6.0.0.0dbru.zip"
    destination = "/tmp/instantclient-basic-linux.x64-19.6.0.0.0dbru.zip"
  }

  provisioner "file" {
    source      = "files/venafi-pki-backend_v0.6.2+743_linux.zip"
    destination = "/tmp/venafi-pki-backend_v0.6.2+743_linux.zip"
  }
  provisioner "shell" {
    inline = [
    "sudo bash /tmp/hashi_install.sh ${var.hashi_download_dir} ${var.bin_dir}     ${var.hashi_base_url} vault                        ${var.vault_version} ent",
    "sudo bash /tmp/hashi_install.sh ${var.hashi_download_dir} ${var.bin_dir}     ${var.hashi_base_url} consul                       ${var.consul_version} ent",
    "sudo bash /tmp/hashi_install.sh ${var.hashi_download_dir} ${var.bin_dir}     ${var.hashi_base_url} nomad                        ${var.nomad_version}",
    "sudo bash /tmp/hashi_install.sh ${var.hashi_download_dir} ${var.bin_dir}     ${var.hashi_base_url} terraform                    ${var.terraform_version}",
    "sudo bash /tmp/hashi_install.sh ${var.hashi_download_dir} ${var.bin_dir}     ${var.hashi_base_url} packer                       ${var.packer_version}",
    "sudo bash /tmp/hashi_install.sh ${var.hashi_download_dir} ${var.plugins_dir} ${var.hashi_base_url} vault-plugin-database-oracle ${var.oracle_plugin_version}",
    "sudo /usr/local/bin/vault -autocomplete-install",
    "sudo setcap cap_ipc_lock=+ep /usr/local/bin/vault",
    "sudo setcap cap_ipc_lock=+ep ${var.plugins_dir}/vault-plugin-database-oracle",
    "sudo useradd --system --home /etc/vault.d --shell /bin/false vault",
    "sudo mkdir /etc/vault.d",
    "sudo touch /etc/vault.d/vault.hcl",
    "sudo chown -R vault:vault /etc/vault.d",
    "sudo chmod 640 /etc/vault.d/vault.hcl",
    "sudo /usr/local/bin/consul -autocomplete-install",
    "sudo useradd --system --home /etc/consul.d --shell /bin/false consul",
    "sudo mkdir /etc/consul.d",
    "sudo touch /etc/consul.d/consul.json",
    "sudo chown -R consul:consul /etc/consul.d",
    "sudo chmod 640 /etc/consul.d/consul.json",
    "sudo mv /tmp/vault.service /etc/systemd/system/vault.service",
    "sudo mv /tmp/consul.service /etc/systemd/system/consul.service",
    "sudo mkdir -p ${var.oracle_download_dir}",
    "sudo mv /tmp/instantclient-basic-linux.x64-19.6.0.0.0dbru.zip ${var.oracle_download_dir}/",
    "sudo unzip -d ${var.oracle_client_dir} ${var.oracle_download_dir}/instantclient-basic-linux.x64-19.6.0.0.0dbru.zip",
    "echo /usr/local/instantclient_19_6 | sudo tee -a /etc/ld.so.conf.d/oracle-instantclient.conf",
    "sudo ldconfig",
    "sudo mv /tmp/venafi-pki-backend_v0.6.2+743_linux.zip ${var.hashi_download_dir}",
    "sudo unzip -d ${var.plugins_dir} ${var.hashi_download_dir}/venafi-pki-backend_v0.6.2+743_linux.zip",
    "sudo setcap cap_ipc_lock=+ep ${var.plugins_dir}/venafi-pki-backend"
    ]
  }

}
