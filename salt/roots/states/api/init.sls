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

api-start:
  cmd.run:
    - cwd: {{ pillar['api']['home']}}
    - name: npm start
    - user: {{ pillar['system_user']}}
    - wait:
      - npm: pm2

api-create-dump:
  cmd.run:
    - name: pm2 save
    - user: {{ pillar['system_user']}}
