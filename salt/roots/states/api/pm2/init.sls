pm2:
  npm.installed

pm2-upstart:
  cmd.run:
    - name:  pm2 startup centos -u {{pillar['system_user']}} --hp {{pillar['system_user_home']}}
    - require:
      - npm: pm2

pm2-systemctl:
  cmd.run:
    - names:
      - systemctl daemon-reload

pm2-start-service:
  cmd.run:
    - name: systemctl start pm2
    - require_in:
      - cmd: api-create-dump

