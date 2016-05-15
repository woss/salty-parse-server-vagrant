install pm2:
  cmd.wait:
    - name: npm install -g pm2
    - runas : {{ pillar["system_user"] }}
    - watch:
      - cmd: node
      - sls: nvm

startup install:
  cmd.wait:
    - names:
      - su -c "env PATH=$PATH:{{pillar["system_user_home"]}}/.nvm/versions/node/v5.11.1/bin pm2 startup centos -u {{pillar["system_user"]}} --hp {{pillar["system_user_home"]}}"
      - su -c "chmod +x /etc/init.d/pm2-init.sh && update-rc.d pm2-init.sh defaults"
    - watch:
      - cmd: install pm2

{{ pillar["system_user_home"]}}/.pm2/dump.pm2:
    file.managed:
        - source: salt://pm2/dump.pm2
        - user: {{ pillar["system_user"] }}
        - group: {{ pillar["system_user"] }}
        - mode: 700
