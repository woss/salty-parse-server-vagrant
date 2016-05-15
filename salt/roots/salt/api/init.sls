api:
  cmd.wait:
    - name: npm start
    - cwd: /srv/api
    - runas : {{ pillar["system_user"] }}
    - watch:
      - cmd: node
