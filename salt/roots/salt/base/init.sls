include:
  - base.sanity

{{ pillar["system_user_home"] }}/.bashrc:
    file.managed:
        - source: salt://base/bashrc
        - user: {{ pillar["system_user"] }}
        - group: {{ pillar["system_user"] }}
        - mode: 700
