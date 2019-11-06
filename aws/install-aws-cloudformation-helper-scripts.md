# Install AWS CloudFormation Helper Scripts

## Prerequisite

- Linux distribution other than Amazon Linux AMI image
- root or sudo permission

```
sudo yum update -y
sudo yum install -y epel-release
sudo yum install -y https://s3.amazonaws.com/cloudformation-examples/sudo aws-cfn-bootstrap-latest.amzn1.noarch.rpm
sudo ln -s /usr/local/lib/python2.7/site-packages/cfnbootstrap /usr/lib/python2.7/site-packages/cfnbootstrap
ls /opt/aws/bin/
```

## More to read

- https://docs.aws.amazon.com/AWSCloudFormation/latest/UserGuide/cfn-helper-scripts-reference.html

## Contact

Rangsiman Ketkaew - rangsiman1003@gmail.com
