# packer-hashistack - HashiCorp Packer image for provisioning HashiStack (Terraform, Vault, Consul, Nomad, Packer)

This [Packer](https://packer.io/) configuration builds on top of the [Ubuntu](https://ubuntu.com) 20.04 image from [Canonical](https://canonical.com/) and includes the following [HashiCorp](https://www.hashicorp.com) software.
* [Vault](https://vaultproject.io) Enterprise
* [Consul](https://consul.io) Enterprise
* [Nomad](https://nomadproject.io) Enterprise
* [Terraform](https://terraform.io)
* [Packer](https://packer.io)
* [Consul-Template](https://github.com/hashicorp/consul-template)
* [envconsul](https://github.com/hashicorp/envconsul)
* [Boundary](https://boundaryproject.io)
* [Waypoint](https://waypointproject.io)

It also includes:
* [Docker Engine CE](https://www.docker.com/)
* [minikube](https://minikube.sigs.k8s.io/docs/)
* [kubectl](https://kubernetes.io/docs/tasks/tools/)
* [Helm](https://helm.sh)

The resulting image provides the foundation for you to run one or some of these tools.

It places systemd scripts for Consul, Nomad and Vault, but does not set them to start automatically on the resulting image. This provides the foundational components for a HashiStack, but does not dictate how you'll use the image.

## Prequisites

### [HashiCorp Packer](https://releases.hashicorp.com/packer/)
This Packer configuration is written in HCL and has been tested on Packer 1.8.0.

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
