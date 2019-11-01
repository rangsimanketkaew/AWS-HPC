# Install and Configure AWS Client

## Prerequisites

1. Virutalenv

## Let's go

1. Open Linux terminal and run the following scripts:

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

2. A created `config` file is available at `$HOME/.aws/`

## Contact

Rangsiman Ketkaew - rangsiman1993@gmail.com
