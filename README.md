# ttreeagency/php:latest

Official ttreeagency docker container for PHP application.

This container contain the following software:

- Nginx + PHP CLI/FPM (from Dotdeb respository)
- GIT
- Composer, the PHP package manager, automatically updated on container start

This container is under development, change can happen at any time ...

## Version

Current Version: `1.0.0`

# Contributing

If you find this image useful here's how you can help:

- Send a Pull Request with your awesome new features and bug fixes
- Help new users with [Issues](https://github.com/ttreeagency/docker-php/issues) they may encounter

# Installation

Pull the image from the docker index. This is the recommended method of installation as it is easier to update image. These builds are performed by the **Docker Trusted Build** service.

```bash
docker pull ttreeagency/php:latest
```
Alternately you can build the image locally.

```bash
git clone https://github.com/ttreeagency/docker-php.git
cd docker-php
docker build --tag=$USER/php .
```

# Quick Start

You can manually launch the container.

```bash
docker run --name php -d \
    ttreeagency/php:latest
```

If you build the container manually, you can test it with::

```bash
docker run -i -t -p "8080:80" -P --name php -v $PWD/data:/data ttreeagency/php
```

Point your browser to: ```http://localhost:8080```, you should see the output of phpinfo().

You can start any binary available in the container::

```bash
docker run ttreeagency/php:latest php -v
```

You can available options::

```bash
docker run ttreeagency/php:latest app:help
```

### Available Configuration Parameters

*Please refer the docker run command options for the `--env-file` flag where you can specify all required environment variables in a single file. This will save you from writing a potentially long docker run command. Alternately you can use docker-compose.*

Below is the complete list of available options that can be used to customize your gitlab installation.

- **DEBUG_ENTRYPOINT**: Set this to `true` to enable entrypoint debugging.
- **SSL_CERTIFICATE_PATH**: Location of the ssl certificate. Defaults to `/data/certs/cert.crt`.
- **CA_CERTIFICATES_PATH**: List of SSL certificates to trust. Defaults to `/data/certs/ca.crt`.
- **GITHUB_TOKEN**: Github Oauth token, used by composer.
- **COMPOSER_UPDATE**: Update composer on container start. Defaults to `true`.
