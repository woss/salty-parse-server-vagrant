ngrok:
  cmd.wait:
    - name: npm install -g ngrok
    - runas : {{ pillar["system_user"] }}
    - watch: 
      - cmd: node
      - sls: nvm
