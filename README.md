# Salty Parse Server with Vagrant

Ready to use [Parse Server](https://github.com/ParsePlatform/parse-server) vagrant box.

## Details:

* CentOS 7.1, `bento/centos-7.1`
* MongoDB
* Latest Parse Server
* nodejs `5.11.1`
* [PM2](https://github.com/Unitech/pm2)

## Structure:

```shell
$ tree -a -I 'node_modules|.vagrant|logs|.git|.idea|.DS_Store'
.
├── .editorconfig
├── .gitignore
├── LICENSE.md
├── README.md
├── Vagrantfile
├── packer
│   ├── centos-7.2-x86_64.json
│   ├── floppy
│   │   └── dummy_metadata.json
│   ├── http
│   │   └── centos-7.2
│   │       └── ks.cfg
│   ├── packer_cache
│   └── scripts
│       ├── centos
│       │   ├── cleanup.sh
│       │   └── networking.sh
│       └── common
│           ├── metadata.sh
│           ├── minimize.sh
│           ├── shutdown.sh
│           ├── sshd.sh
│           ├── sudoers.sh
│           ├── vagrant.sh
│           └── vmtools.sh
├── salt
│   ├── minion.yml
│   └── roots
│       ├── pillar
│       │   ├── api.sls
│       │   ├── nodejs.sls
│       │   ├── system.sls
│       │   └── top.sls
│       └── states
│           ├── api
│           │   ├── env
│           │   ├── init.sls
│           │   └── pm2
│           │       ├── dump.pm2
│           │       └── init.sls
│           ├── base
│           │   ├── bashrc
│           │   ├── init.sls
│           │   └── sanity.sls
│           ├── git
│           │   └── init.sls
│           ├── mongodb
│           │   ├── init.sls
│           │   └── mongod.conf
│           ├── nginx
│           │   ├── api-server
│           │   ├── init.sls
│           │   └── nginx.conf
│           ├── ngrok
│           │   └── init.sls
│           ├── nodejs
│           │   └── init.sls
│           ├── ntp
│           │   └── init.sls
│           └── top.sls
└── server
    ├── .env
    ├── .nvmrc
    ├── lockdown.json
    ├── package.json
    ├── process.json
    └── server.js
```

## Before running

This build comes with keys for Parse Server. Defaults can be found in `api.sls` file under `./salt/roots/pillar` directory.
Defaults are:

```
api:
  home: /srv/api # if you change this, make sure you have also changed the mapping in Vagrantfile
  app_key: "ashdgvon12682762n13921879"
  master_key: "89d22c0f261be72a88c3a7e100412f36"
  file_key: "89d22c0f261be72a88c3a7e100412f36ashdgvon12682762n13921879"
  host: "127.0.0.1"
  port: 7070
  protocol: "http"
  mongodb_host: "localhost"
  mongodb_port: 27017
  mongodb_db: "parse"
```

Change values here then provision in order to regenerate `.env` file in `server` directory.

`.env`  is managed by salt, which means it will be overwritten on next provision.
DO NOT CHANGE IT, change `/salt/roots/pillar/api.sls`



## Running

```
git clone https://github.com/7Signals/salty-parse-server-vagrant.git
cd salty-parse-server-vagrant
vagrant up
```
Parse server will be available on `http://192.168.77.10` or `http://127.0.0.1` inside the machine.

## Examples

This will work out-of-the-box only for default setup, if you have changed the keys make sure you change it here as well.

Inside the box:

```shell

# Create a recod

curl -X POST \
-H "X-Parse-Application-Id: ashdgvon12682762n13921879" \
-H "Content-Type: application/json" \
-d '{"instrument": "guitar","playerName":"Peter","why":"coz me so kul"}' \
http://localhost/classes/songs

curl -X GET \
  -H "X-Parse-Application-Id: ashdgvon12682762n13921879" \
  http://localhost/classes/songs
```

Outside the box:

```shell

# Create a recod

curl -X POST \
-H "X-Parse-Application-Id: ashdgvon12682762n13921879" \
-H "Content-Type: application/json" \
-d '{"instrument": "guitar","playerName":"Peter","why":"coz me so kul"}' \
http://192.168.77.10/classes/songs

# Get records

curl -X GET \
  -H "X-Parse-Application-Id: ashdgvon12682762n13921879" \
  http://192.168.77.10/classes/songs

```

## Salt-y commands - for dev only

```
# sync it
salt-call saltutil.sync_all

# test it
salt-call state.apply test=True

# apply it ( OR this can be ran right away :) )
salt-call state.highstate --retcode-passthrough  --log-level=info --force-color

# apply only one state
salt-call state.apply nginx

```

Maybe implement this https://github.com/saltstack-formulas/nginx-formula

## Packer related commands

**NOTE** Not working yet!!!

Run from root of the project

```
packer validate packer/centos-7.2-x86_64.json
packer build packer/centos-7.2-x86_64.json

```

## Issues

If server is not available on specified IP, either reload the box `vagrant reload` or restart nginx:

```
$ vagrant ssh
$ sudo systemctl restart nginx
```

# License

Short version: MIT + New BSD.

Long version: Read the LICENSE.md -file.
