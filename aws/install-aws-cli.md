# Install and Configure AWS Client

## Prerequisites

1. Virtualenv (optional)

## Install AWS CLI

1. Activate to a virtual environment (skipp this step if you do not use virtualenv)

2. Open Linux terminal and run the following command:

```
(pcluster-virtenv) [duff]$ pip install --upgrade awscli
```

## Configure AWS CLI

1. Run the following scripts to set configure settings and create `config` file. 

```
(pcluster-virtenv) [duff]$ pip install --upgrade awscli
(pcluster-virtenv) [duff@]$ aws configure
AWS Access Key ID []: <aws_access_key>
AWS Secret Access Key []: <aws_secret_access_key>
Default region name []: us-east-1
Default output format []: json
(pcluster-virtenv) [duff]$ aws s3 mb s3://duff-parallelcluster
make_bucket: duff-parallelcluster 
```

2. Created `config` file will be available at `$HOME/.aws/`

```
ls $HOME/.aws/config
```

## Contact

Rangsiman Ketkaew - rangsiman1993@gmail.com
