nodejs-deps:
  pkg.installed:
    - names:
      - openssl-devel

/opt/nodejs-v{{ pillar['nodejs']['version'] }}:
  file.directory:
   - makedirs: True

nodejs-download:
  file.managed:
    - name: /opt/nodejs-v{{ pillar['nodejs']['version'] }}/node-v{{ pillar['nodejs']['version'] }}.tar.gz
    - source: https://nodejs.org/dist/v{{ pillar['nodejs']['version'] }}/node-v{{ pillar['nodejs']['version'] }}-linux-x64.tar.gz
    - source_hash: sha256={{ pillar['nodejs']['checksum'] }}
    - require:
      - pkg: nodejs-deps

nodejs-unpack:
  cmd.run:
    - cwd: /opt/nodejs-v{{ pillar['nodejs']['version'] }}
    - names:
      - tar -zxf node-v{{ pillar['nodejs']['version'] }}.tar.gz -C {{ pillar['nodejs']['install_path']}}
    - unless: test -e {{ pillar['nodejs']['install_path']}}/node-v{{ pillar['nodejs']['version'] }}-linux-x64

nodejs-link:
  file.symlink:
    - target: {{ pillar['nodejs']['install_path']}}/node-v{{ pillar['nodejs']['version'] }}-linux-x64/bin/node
    - name: {{ pillar['nodejs']['symlink_path']}}
    - force: True # If it exists we overwrite it, making sure that it is there
    - watch:
      - cmd: nodejs-unpack

npm-link:
  file.symlink:
    - target: {{ pillar['nodejs']['install_path']}}/node-v{{ pillar['nodejs']['version'] }}-linux-x64/lib/node_modules/npm/bin/npm-cli.js
    - name: {{ pillar['nodejs']['symlink_path']}}
    - force: True # If it exists we overwrite it, making sure that it is there
    - watch:
      - cmd: nodejs-unpack

