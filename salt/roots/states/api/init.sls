include:
  - nodejs
  - api.pm2


{{ pillar["api"]["home"] }}/.env:
    file.managed:
        - source: salt://api/env
        - user: {{ pillar["system_user"] }}
        - group: {{ pillar["system_user"] }}
        - mode: 700
        - template: jinja

api-upstart:
  cmd.wait:
    - names:
      - su -c "env PATH=$PATH:{{pillar["system_user_home"]}}/.nvm/versions/node/v5.11.1/bin pm2 startup centos -u {{pillar["system_user"]}} --hp {{pillar["system_user_home"]}}"
      - su -c "chmod +x /etc/init.d/pm2-init.sh && update-rc.d pm2-init.sh defaults"
    - watch:
      - cmd: pm2-install

{{ pillar["system_user_home"]}}/.pm2/dump.pm2:
    file.managed:
        - source: salt://pm2/dump.pm2
        - user: {{ pillar["system_user"] }}
        - group: {{ pillar["system_user"] }}
        - mode: 700

