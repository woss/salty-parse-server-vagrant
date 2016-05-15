nvm:
  git.latest:
    - name: {{ pillar["nvm"]["git_location"] }}
    - rev: {{ pillar["nvm"]["git_branch"] }}
    - target: {{ pillar["nvm"]["install_path"]}}
    - branch: {{ pillar["nvm"]["git_branch"] }}
    - user: {{ pillar["system_user"] }}
