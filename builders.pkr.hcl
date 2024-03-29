build {
  hcp_packer_registry {
    bucket_name = var.bucket_name
    description = var.bucket_description

    bucket_labels = {
      "os" = "linux"
    }

    build_labels = {
      "build-time" = timestamp()
    }
  }

  sources = [
    "source.amazon-ebs.hashistack-aws-us-east-1"
  ]

  provisioner "shell" {
    inline = [
      "sleep 30",
      "sudo apt-get update",
      "sudo apt-get upgrade -y",
      "sudo apt-get install -y ca-certificates apt-transport-https curl gnupg openssl lsb-release jq unzip htop ldap-utils awscli",
      "curl -fsSL https://apt.releases.hashicorp.com/gpg | sudo apt-key add -",
      "sudo apt-add-repository \"deb [arch=amd64] https://apt.releases.hashicorp.com $(lsb_release -cs) main\"",
      "curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg",
      "echo \"deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable\" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null",
      "sudo curl -fsSLo /usr/share/keyrings/kubernetes-archive-keyring.gpg https://packages.cloud.google.com/apt/doc/apt-key.gpg",
      "echo \"deb [signed-by=/usr/share/keyrings/kubernetes-archive-keyring.gpg] https://apt.kubernetes.io/ kubernetes-xenial main\" | sudo tee /etc/apt/sources.list.d/kubernetes.list",
      "curl https://baltocdn.com/helm/signing.asc | sudo apt-key add -",
      "echo \"deb https://baltocdn.com/helm/stable/debian/ all main\" | sudo tee /etc/apt/sources.list.d/helm-stable-debian.list",
      "sudo apt-get update",
      "sudo apt-get install -y vault-enterprise",
      "sudo apt-get install -y consul-enterprise",
      "sudo apt-get install -y nomad-enterprise",
      "sudo apt-get install -y terraform",
      "sudo apt-get install -y packer",
      "sudo apt-get install -y consul-template",
      "sudo apt-get install -y boundary",
      "sudo apt-get install -y waypoint",
      "sudo apt-get install -y python3-hvac",
      "sudo apt-get install -y docker-ce docker-ce-cli containerd.io",
      "sudo apt-get install -y kubectl",
      "sudo apt-get install helm",
      "sudo curl -sLo /tmp/minikube_latest_amd64.deb https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb",
      "sudo dpkg -i /tmp/minikube_latest_amd64.deb",
      "sudo usermod -aG docker ubuntu",
      "kubectl completion bash | sudo tee /etc/bash_completion.d/kubectl > /dev/null",
      "echo 'alias k=kubectl' | sudo tee  -a /etc/bash.bashrc > /dev/null",
      "echo 'complete -F __start_kubectl k' | sudo tee  -a /etc/bash.bashrc > /dev/null"
    ]
  }

  provisioner "file" {
    source      = "files/hashi_install.sh"
    destination = "/tmp/hashi_install.sh"
  }

  provisioner "shell" {
    inline = [
      "sudo bash /tmp/hashi_install.sh ${var.hashi_download_dir} ${var.bin_dir} ${var.hashi_base_url} envconsul ${var.envconsul_version}",
    ]
  }

}
