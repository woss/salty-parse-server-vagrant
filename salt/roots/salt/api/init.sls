{{ pillar["api"]["home"] }}/.env:
    file.managed:
        - source: salt://api/env
        - user: {{ pillar["system_user"] }}
        - group: {{ pillar["system_user"] }}
        - mode: 700
        - template: jinja

api:
  cmd.wait:
    - name: npm start
    - cwd: /srv/api
    - runas : {{ pillar["system_user"] }}
    - watch:
      - cmd: node
