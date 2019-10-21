# Setup CentOS 7 on AWS EC2

## Pre-built CentOS 7 image by CentOS team

This is the Official CentOS 7 x86_64 HVM image that has been built with a minimal profile, suitable for use in HVM instance types only. The image contains just enough packages to run within AWS, bring up an SSH Server and allow users to login. Please note that this is the default CentOS-7 image that we recommend everyone uses. It contains packages that are updated at points in time to include critical security updates.

Website: https://aws.amazon.com/marketplace/pp/B00O7WM7QW/ref=mkt_ste_catgtm_osslp

## Launching instance (compute node)

1. Register AWS account and sign-in to AWS dashboard
2. Go to EC2 dashboard using navigation pane (https://console.aws.amazon.com/ec2)
3. In Create Instance, click **Launch Instance**
4. Choose Amazon Machine Image (AMI), aka operating system, you want to use
5. Click **Review and Launch** then click **Launch** for initiating virtual compute node

Note that you are able to change setting of a running compute node anytime.

## Setting up

1. Change root password: `sudo passwd root`
2. Update packages: `sudo yum update`
3. Install development tools: `sudo yum groupinstall "Development Tools"`
4. Install Python 2 and Python 3: `sudo yum install python-devel python3-devel"
5. Install `wget` and `locate`: `sudo yum install wget mlocate`
