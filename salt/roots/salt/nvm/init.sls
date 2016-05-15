nvm:
  git.latest:
    - name: {{ pillar["nvm"]["git_location"] }}
    - target: {{ pillar["nvm"]["install_path"]}}
    - branch: {{ pillar["nvm"]["git_branch"] }}
    - user: {{ pillar["system_user"] }}
