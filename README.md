# packer-hashistack - HashiCorp Packer image for provisioning HashiStack (Terraform, Vault, Consul, Nomad, Packer)

This [Packer](https://packer.io/) configuration allows you to prepare machine images that contain the following [HashiCorp](https://www.hashicorp.com) tools.
* [Vault](https://vaultproject.io) 1.7.0 Enterprise
* [Consul](https://consul.io) 1.9.4 Enterprise
* [Nomad](https://nomadproject.io) 1.0.4 Enterprise
* [Terraform](https://terraform.io) 0.14.9
* [Packer](https://packer.io) 1.7.1
* [Consul-Template](https://github.com/hashicorp/consul-template) 0.25.2
* [envconsul](https://github.com/hashicorp/envconsul) 0.11.0
* [Boundary](https://boundaryproject.io) 0.1.8
* [Waypoint](https://waypointproject.io) 0.2.4

It also places:
* [Vault Oracle Database Secrets Engine](https://www.vaultproject.io/docs/secrets/databases/oracle/) plugin version 0.2.1.
* [Oracle Instant Client 21.1](https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html).
* [Vault Venafi PKI Secrets Engine](https://github.com/Venafi/vault-pki-backend-venafi) plugin version 0.8.3.

The resulting image provides the foundation for you to run one or some of these tools.

This iteration builds on the [Ubuntu](https://ubuntu.com) 18.04 image from [Canonical](https://canonical.com/). It places systemd scripts for Consul, Nomad and Vault, but does not set them to start automatically on the resulting image. This provides the foundational components for a HashiStack, but does not dictate how you'll use the image.

## Prequisites

### [Packer 1.6.4](https://releases.hashicorp.com/packer/) or later.
This Packer configuration is written in HCL and has been tested on Packer 1.7.0.

### [Oracle Instant Client 19.6](https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html)
Download the Oracle Instant Client [zip file](https://download.oracle.com/otn_software/linux/instantclient/211000/instantclient-basic-linux.x64-21.1.0.0.0.zip). You may be prompted to create or login into an Oracle account and accept the license agreement in order to download the Oracle Client. Once you download it, save it as `files/instantclient-basic-linux.x64-21.1.0.0.0.zip`.

### Environment variables
Set your AWS access credentials (`AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables). These credentials should have the ability to create AMI's.

## Files
[variables.pkr.hcl](variables.pkr.hcl) contains the [variables](https://packer.io/docs/configuration/from-1.5/variables.html) needed for our Packer run. Each has a sane default with the exception of `owner`. You can override the default by passing it via the `-var` command line argument or via a `.pkrvars.hcl` file. Please see the Packer documentation on [Input Variables](https://packer.io/docs/configuration/from-1.5/variables.html) for more information.

[amazon-ebs.pkr.hcl](amazon-ebs.pkr.hcl) contains the code for building an [Amazon Machine Image (AMI)](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html) on AWS. This is the only machine image that this repository currently builds.

[builders.pkr.hcl](builders.pkr.hcl) contains the builds and provisioner definitions. If you wanted to use the Open Source Vault and Consul binaries, or add or remove any resources from the image build, you could do so by modifying this file.

## How to use

Adjust tags in [amazon-ebs.pkr.hcl](amazon-ebs.pkr.hcl) to suit your organization. The tags relate to variables defined in [variables-tags.pkr.hcl](variables-tags.pkr.hcl). You may remove or modify that file if the tags and corresponding variables defined do not apply to your organization.

To create a machine image, run packer from the top level directory of this repository:

```
packer build -var-file 'owner="<packer variables file>"' .
```

For example:

```
packer build -var-file=yash.pkrvars.hcl .
```

---
