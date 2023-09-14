# LiveSync Subscribe Publish kit

The Dockerfile and assets for Trying [LiveSync Subscribe Publish](https://github.com/vrtmrz/livesync-subscribe-publish)

## How to try
```sh
$ git clone https://github.com/vrtmrz/livesync-subscribe-publish-kit
$ cp sample.env .env
$ vi .env
$ ./test.sh
```
Then, your site would be hosted at localhost:8080

## How to host
### Deploy to fly.io
**Note:** `nrt` is a region in Japan. Please choose a location which the same or near your vault.  
**Note2:** We can try it directly from Google Colab by this [Gist](https://gist.github.com/vrtmrz/f4bba6cdc4216af5cacce3c945b2fb77).
```sh
# 1. Generate a machine
$ fly launch  --auto-confirm --generate-name --detach --no-deploy --region nrt
# 2. Create a volume
$ fly volumes create --region nrt blog --size 1 --yes
# 3. Modify fly.toml (see the following section)
$ vi fly.toml
# 4. Set secret values about your vault on the CouchDB.
$ fly secrets set LSSP_DATABASE=databasename
$ fly secrets set LSSP_PASSPHRASE=passphrase
$ fly secrets set LSSP_PASSWORD=couchdbpassword
$ fly secrets set LSSP_URL=https://your-vault-url.example.com/
$ fly secrets set LSSP_USERNAME=couchdbusername
$ fly secrets set LSSP_OBFUSCATEPASSPHRASE=passsphrase
# 5. deploy
$ fly deploy
```
Then, your blog will begin!

### Things to append to your fly.toml
```toml
[mounts]
  source = "blog"
  destination = "/app/content/"

[build]
  dockerfile = "./Dockerfile"

[env]
  LSSP_SUBSCRIBEDIR = "blogdir/"
  LSSP_LOCALDIR = "/app/content/sitesrc/"
  LSSP_SCRIPT_CMD = "/app/build.sh"
  LSSP_SCRIPT_ARGS = ""
  LSSP_STATDIR = "/app/content/sitesrc/"
  LSSP_CONFIG_PATH = "/app/subscriber/config.jsonc"
  LSSP_PUBLISH_PORT = "8080"
  LSSP_KEYFILE = ""

  # adjust your fly.io url
  LSSP_HUGO_BASEURL = "https://some-your-machine.example.com/"
  LSSP_HUGO_LANGUAGE = "en-GB"
  LSSP_HUGO_TITLE = "LiveSync Subscribe Pubslish Test"

  # API path to update your vault
  LSSP_APIPATH = "/somethingonlyyouknow"
```

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
LSSP_PUBLISH_PORT=8080
LSSP_LOCALDIR=/app/content/sitesrc/
LSSP_SCRIPT_CMD=/app/build.sh
LSSP_SCRIPT_ARGS=""
LSSP_STATDIR=/app/content/sitesrc/
LSSP_CONFIG_PATH=/app/subscriber/config.jsonc
LSSP_KEYFILE=flush.md
LSSP_APIPATH=
```

Note: If you want to use API update mode, you have to set empty to `LSSP_KEYFILE` and any of your favourite paths to `LSSP_APIPATH`.

---

Licensed as MIT.
