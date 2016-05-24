nginx:
#    user.present:
#        - fullname: nginx
#        - shell: /bin/false
#        - home: /var/www
#        # There's a known bug in Salt, that will cause this to fail unless
#        # we manually create the folder (it should be created automatically)
#        # See https://github.com/saltstack/salt/issues/18843
#        - require:
#            - file: /var/www
#        - groups:
#            - nginx
  pkg:
    - installed
  service.running:
    - enable: True
    - require:
        - pkg: nginx
    - watch:
        - file: /etc/nginx/nginx.conf

# Temporary fix to work around the bug mentioned above
#/var/www:
#    file.directory:
#        - user: nginx
#        - group: nginx
#        - mode: 755
#        - makedirs: True
#        - require:
#            - pkg: nginx

{% for dir in '/etc/nginx/sites-enabled/', '/etc/nginx/sites-available/', '/var/lib/nginx', '/var/lib/nginx/tmp/',
 '/etc/nginx/include.d/', %}
{{ dir }}:
  file.directory:
    - user: nginx
    - group: nginx
    - mode: 755
    - makedirs: True
{% endfor %}

{% for path in '/etc/nginx/conf.d/', '/etc/nginx/sites-enabled/default' %}
{{ path }}:
   file.absent
{% endfor %}

/etc/nginx/nginx.conf:
 file.managed:
    - source: salt://nginx/nginx.conf
    - require:
      - pkg: nginx

/etc/nginx/sites-available/{{ pillar['api']['hostname'] }}.conf:
  file.managed:
    - source: salt://nginx/api-server
    - template: jinja

api-symlink:
  file.symlink:
    - target: /etc/nginx/sites-available/{{ pillar['api']['hostname'] }}.conf
    - name: /etc/nginx/sites-enabled/{{ pillar['api']['hostname'] }}.conf
