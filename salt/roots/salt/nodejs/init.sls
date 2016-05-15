include:
  - nvm

node:
  cmd.run:
    - name: . {{ pillar["nvm"]["install_path"] }}/nvm.sh; nvm install 5.11.1; nvm alias defult 5.11.1
    - runas : {{ pillar["system_user"] }}
    - require:
      - sls: nvm
