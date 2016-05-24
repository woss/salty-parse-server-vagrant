mongodb-repo:
    pkgrepo.managed:
        - humanname: MongoDB Repository
        - gpgcheck: 0
        - baseurl: http://repo.mongodb.org/yum/redhat/$releasever/mongodb-org/3.0/x86_64/

mongodb-org:
    pkg.installed

/etc/mongod.conf:
    file.managed:
        - source: salt://mongodb/mongod.conf
        - template: jinja
        - requires:
            - pkg: mongodb-org
        - watch_in:
            - service: mongod

/var/lib/mongo/:
    file.directory:
        - user: mongod
        - group: mongod
        - mode: 750
        - makedirs: True
        - recurse:
            - user
            - group

mongod:
    service.running:
        - enable: True
        - require:
            - pkg: mongodb-org
            - file: /etc/mongod.conf
