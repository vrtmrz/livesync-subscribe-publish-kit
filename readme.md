# LiveSync Subscribe Publish kit

The Dockerfile and assets for Trying [LiveSync Subscribe Publish](https://github.com/vrtmrz/livesync-subscribe-publish)

## Limitation
- This is an ARM Docker image (in now).
  I will add amd64. (Or, you can send me a PR).

## How to try
```sh
$ git clone https://github.com/vrtmrz/livesync-subscribe-publish-kit
$ cp sample.env .env
$ vi .env
$ ./test.sh
```
Then, your site would be hosted at localhost:8080

## How to host
Depends on your platform. To be written for about some major PaaSs.

## Environment variables

```.env
# Must be changed as your environment.
LSSP_DATABASE=test
LSSP_PASSPHRASE=passphrase
LSSP_PASSWORD=password
LSSP_URL=http://localhost:5984
LSSP_USERNAME=admin
LSSP_OBFUSCATEPASSPHRASE=passphrase

LSSP_HUGO_BASEURL=https://livesync-subscribe-publish.example.net/
LSSP_HUGO_LANGUAGE=en-GB
LSSP_HUGO_TITLE=LiveSync Subscribe Pubslish Test

# You can leave them as default.
LSSP_SUBSCRIBEDIR=blogdir/
LSSP_LOCALDIR=/app/content/sitesrc/
LSSP_SCRIPT_CMD=/app/build.sh
LSSP_SCRIPT_ARGS=""
LSSP_STATDIR=/app/content/sitesrc/
LSSP_CONFIG_PATH=/app/subscriber/config.jsonc
```

Licensed as MIT.