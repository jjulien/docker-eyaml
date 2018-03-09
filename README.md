# Docker eyaml Container
This container allows you to easily get encrypted values for your Puppet infrastructure using hiera-eyaml.

The only thing you need to do is add your public key, which can be done in one of two ways.  

1. [Create a new container that contains your public key](#option-1---create-a-new-container-that-contains-your-public-key)
2. [Mount the public key at runtime](#option-2---mount-the-public-key-at-runtime)t 

### Option 1 - Create a new container that contains your public key
To use this method, create a new Dockerfile that looks like the following

```
FROM docker.io/jjulien/eyaml

ADD <location of publickey> /etc/eyaml/public-key.pem
```

### Option 2 - Mount the public key at runtime
To use this method, when running the container simply provide the option `-v <location of public key>:/etc/eyaml/public-key.pem`

## Getting Encrypted Values
You can run this container as if it were the `eyaml` command itself.  It will automatically use your public key (assuming you included it using one of the two methods mentioned above).  The below examples assume you used the first method of storing the public key inside a new container.

Example Help
```
$ docker run docker.io/jjulien/example-eyaml encrypt --help
eyaml encrypt: encrypt some data

Usage: eyaml encrypt [options]

Options:
  -n, --encrypt-method=<s>    Override default encryption and decryption method
                              (default is PKCS7) (default: pkcs7)
  --version                   Show version information
  -v, --verbose               Be more verbose
  -t, --trace                 Enable trace debug
  -q, --quiet                 Be less verbose
  -h, --help                  Information on how to use this command
  -p, --password              Source input is a password entered on the
                              terminal
  -s, --string=<s>            Source input is a string provided as an argument
  -f, --file=<s>              Source input is a regular file
  --stdin                     Source input is taken from stdin
  -e, --eyaml=<s>             Source input is an eyaml file
  -o, --output=<s>            Output format of final result (examples, block,
                              string) (default: examples)
  -l, --label=<s>             Apply a label to the encrypted result
  --pkcs7-private-key=<s>     Path to private key (default:
                              ./keys/private_key.pkcs7.pem)
  --pkcs7-public-key=<s>      Path to public key (default:
                              ./keys/public_key.pkcs7.pem)
  --pkcs7-subject=<s>         Subject to use for certificate when creating keys
                              (default: /)

```

Example String Encryption
```
$ docker run docker.io/jjulien/example-eyaml encrypt -s "hi"
string: ENC[PKCS7,MIIBeQYJKoZIhvcNAQcDoIIBajCCAWYCAQAxggEhMIIBHQIBADAFMAACAQEwDQYJKoZIhvcNAQEBBQAEggEAjqVqCcs1XYx6hcKOWJG8duebShmkoWyi6lGs0V1+DPxEqp1ySGC52fN83dV+JFGSrg3V23SmKQOBXNeBIDOMaO/vmKXqtHiln1b/ffaQBW52IRGRmMNMXfWtqa5RbUTLqnJsi9DZaTWoqXUZCPhvGN7GICVZW16cnR9nnPFNZyuBgxh9h8sDN0RUCwItzOqIBRVqtU+6Qal/Q/NJC4QcoOUe46dsPpcG6JHgN09q/3T+9bNjbcaDt6Q6kyHD1Vy8F3RWav2kGHVe+Zydv1/OXr7Xm3tNY2bkd+ZHTtetcFV3lMJK6q8jZdPFpGaNHZxnem8/oPOcKebh5iaYbnU7gTA8BgkqhkiG9w0BBwEwHQYJYIZIAWUDBAEqBBDZxc1VthYkwAX4781vtnNCgBBBcP4haBxOV9UZqduSmsdr]

OR

block: >
    ENC[PKCS7,MIIBeQYJKoZIhvcNAQcDoIIBajCCAWYCAQAxggEhMIIBHQIBADAFMAACAQEw
    DQYJKoZIhvcNAQEBBQAEggEAjqVqCcs1XYx6hcKOWJG8duebShmkoWyi6lGs
    0V1+DPxEqp1ySGC52fN83dV+JFGSrg3V23SmKQOBXNeBIDOMaO/vmKXqtHil
    n1b/ffaQBW52IRGRmMNMXfWtqa5RbUTLqnJsi9DZaTWoqXUZCPhvGN7GICVZ
    W16cnR9nnPFNZyuBgxh9h8sDN0RUCwItzOqIBRVqtU+6Qal/Q/NJC4QcoOUe
    46dsPpcG6JHgN09q/3T+9bNjbcaDt6Q6kyHD1Vy8F3RWav2kGHVe+Zydv1/O
    Xr7Xm3tNY2bkd+ZHTtetcFV3lMJK6q8jZdPFpGaNHZxnem8/oPOcKebh5iaY
    bnU7gTA8BgkqhkiG9w0BBwEwHQYJYIZIAWUDBAEqBBDZxc1VthYkwAX4781v
    tnNCgBBBcP4haBxOV9UZqduSmsdr]
```

Example File Encryption
```
$ docker run -v $(pwd)/myfile:/myfile docker.io/jjulien/example-eyaml encrypt -f /myfile
string: ENC[PKCS7,MIIBeQYJKoZIhvcNAQcDoIIBajCCAWYCAQAxggEhMIIBHQIBADAFMAACAQEwDQYJKoZIhvcNAQEBBQAEggEAaMmr2+Xf74e/xvXmq9cV9ZrHFVkFsjbz2tlU7d4U6Mn8UT9e4SQOVCunasCXsk1M9TwIBJoZjWYiZ1wF9+UkT2cj8St+sY5KYbWWXNdvALHxNeGqHQKlCGV/OWrrP2f/Z5fP2Xcnr+sWZtKPmqfTwB9YCF3CsCEWsfbeeARAKBRKVpBK4vozIBVKGWjIgLE7sfpjEjDqFVIf7k+Rq9yWlon3nyD1wIrnJYqHC+CJSlEjHvNavOP19XsE/prcCC/vWPjEXfpB4wr7POLzXtJ2gVOmm3cjaP9Tg4u/cbzIDUaYBdPwo1nYRbEM8aXi/Fk3ps5RQF2M5CUXjziE2byGuzA8BgkqhkiG9w0BBwEwHQYJYIZIAWUDBAEqBBDKwM08f1LWbCNfXIYeAD5IgBDo9cBSsIFMWL8hCfq7h37+]

OR

block: >
    ENC[PKCS7,MIIBeQYJKoZIhvcNAQcDoIIBajCCAWYCAQAxggEhMIIBHQIBADAFMAACAQEw
    DQYJKoZIhvcNAQEBBQAEggEAaMmr2+Xf74e/xvXmq9cV9ZrHFVkFsjbz2tlU
    7d4U6Mn8UT9e4SQOVCunasCXsk1M9TwIBJoZjWYiZ1wF9+UkT2cj8St+sY5K
    YbWWXNdvALHxNeGqHQKlCGV/OWrrP2f/Z5fP2Xcnr+sWZtKPmqfTwB9YCF3C
    sCEWsfbeeARAKBRKVpBK4vozIBVKGWjIgLE7sfpjEjDqFVIf7k+Rq9yWlon3
    nyD1wIrnJYqHC+CJSlEjHvNavOP19XsE/prcCC/vWPjEXfpB4wr7POLzXtJ2
    gVOmm3cjaP9Tg4u/cbzIDUaYBdPwo1nYRbEM8aXi/Fk3ps5RQF2M5CUXjziE
    2byGuzA8BgkqhkiG9w0BBwEwHQYJYIZIAWUDBAEqBBDKwM08f1LWbCNfXIYe
    AD5IgBDo9cBSsIFMWL8hCfq7h37+]
```

