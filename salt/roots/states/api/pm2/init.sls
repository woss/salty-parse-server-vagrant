pm2-install:
  cmd.run:
    - name: npm install -g pm2
    - watch:
      - sls: nodejs
