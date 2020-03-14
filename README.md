# packer-hashistack -HashiCorp Packer image for provisioning HashiStack (Terraform, Vault, Consul, Nomad, Packer)

This [Packer](https://packer.io/) configuration allows you to prepare machine images that contain the following [HashiCorp](https://www.hashicorp.com) tools.
* [Vault](https://vaultproject.io) 1.3.3 Enterprise
* [Consul](https://consul.io) 1.7.1 Enterprise
* [Nomad](https://nomadproject.io) 0.10.4
* [Terraform](https://terraform.io) 0.12.23
* [Packer](https://packer.io) 1.5.4

It also places:
* [Vault Oracle Database Secrets Engine](https://www.vaultproject.io/docs/secrets/databases/oracle/) plugin version 0.1.6.
* [Oracle Instant Client 19.6](https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html).

The resulting image provides the foundation for you to run one or some of these tools.

This iteration builds on the [Ubuntu](https://ubuntu.com) 18.04 image from [Canonical](https://canonical.com/). It places systemd scripts for Consul and Vault, but does not set either to start automatically on the resulting image. This provides the foundational components for a HashiStack, but does not dictate how you'll use the image.

## Prequisites

### [Packer 1.5.4](https://releases.hashicorp.com/packer/) or later.
This Packer configuration is written in HCL and has been tested on Packer 1.5.4.

### [Oracle Instant Client 19.6](https://www.oracle.com/database/technologies/instant-client/linux-x86-64-downloads.html)
Download the Oracle Instant Client [zip file](https://download.oracle.com/otn_software/linux/instantclient/19600/instantclient-basic-linux.x64-19.6.0.0.0dbru.zip). You may be prompted to create or login into an Oracle account and accept the license agreement in order to download the Oracle Client. Once you download it, save it as `files/instantclient-basic-linux.x64-19.6.0.0.0dbru.zip`.

### Environment variables
Set the `AWS_ACCESS_KEY_ID` and `AWS_SECRET_ACCESS_KEY` environment variables. These credentials should have the ability to create AMI's.

## Files
[variables.pkr.hcl](../blob/master/variables.pkr.hcl) contains the [variables](https://packer.io/docs/configuration/from-1.5/variables.html) needed for our Packer run. Each has a sane default with the exception of `owner`. You can override the default by passing it via the `-var` command line argument or via a `.pkrvars.hcl` file. Please see the Packer documentation on [Input Variables](https://packer.io/docs/configuration/from-1.5/variables.html) for more information.

[amazon-ebs.pkr.hcl](../blob/master/amazon-ebs.pkr.hcl) contains the code for building an [Amazon Machine Image (AMI)](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html) on AWS. This is the only machine image that this repository currently builds.

[builders.pkr.hcl](../blob/master/builders.pkr.hcl) contains the builds and provisioner definitions. If you wanted to use the Open Source Vault and Consul binaries, or add or remove any resources from the image build, you could do so by modifying this file.

## How to use

To create a machine image, run packer from the top level directory of this repository:

```
packer build -var 'owner="<owner>"' .
```

For example:

```
packer build -var 'owner="ykhemani"' .
```

---
