nodejs-repo:
  cmd.run:
    - name: curl --silent --location https://rpm.nodesource.com/setup_{{ pillar['nodejs']['version'] }}.x | bash -

nodejs:
  pkg.installed:
    - wait:
      - cmd: nodejs-repo

