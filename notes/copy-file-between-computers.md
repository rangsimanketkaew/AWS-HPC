# Downloading and uploading file between local computer and AWS instance

## Let's go!

1. You can use free FTP service such as FileZilla or Bitvise SSH client to download your file from and upload your file to the running AWS instance.

- https://filezilla-project.org/
- https://www.bitvise.com/ssh-client-download

2. You can use a simple `scp` command to this, for example, copying file on local system to AWS instance:

```
scp -i /path/to/key/pair file/to/copy user@ec2-xx-xx-xxx-xxx.compute-1.amazonaws.com:/path/to/file
```

For copying folder, just use flag `-r`, like this:

```
scp -r -i /path/to/key/pair folder/to/copy user@ec2-xx-xx-xxx-xxx.compute-1.amazonaws.com:/path/to/file
```

> Note that a key pair file (.pem) is needed!

## Contact

Rangsiman Ketkaew - rangsiman1993@gmail.com
