# Docker eyaml Container
This container allows you to easily get encrypted values for your Puppet infrastructure using hiera-eyaml to consume.

The only thing you need to add is your public key which can be done in one of two ways.  Option 1 is the preferred way usually as then you can allow multiple consumers to easily use the container to encrypt values without having to track down the public key too.

1. Create a new container that contains your public key
To use this method, create a new Dockerfile that looks like the following

```
FROM docker.io/jjulien/eyaml

ADD <location of publickey> /etc/eyaml/public-key.pem
```

2. Mount the public key at runtime
To use this method, when running the container simply provide the option `-v <location of public key>:/etc/eyaml/public-key.pem`

## Getting Encrypted Values
You can run this container as if it were the `eyaml` command itself.  It will automatically use your public key (assuming you included it using one of the two methods mentioned above).

Example Help
```
```

Example String Encryption
```
```

Example File Encryption
```
```

