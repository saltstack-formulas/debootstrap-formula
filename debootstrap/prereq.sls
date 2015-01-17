{% from 'debootstrap/state.jinja' import debootstrap_impl %}

# Ensure we have the package
debootstrap_package:
  pkg.installed:
    - name: {{ debootstrap_impl }}

# And the base directory hosting the chroots
debootstrap_basedir:
  file.directory:
    - name: {{ salt['pillar.get']('debootstrap:basedir', '/srv/chroots') }}
    - user: root
    - group: root
    - mode: 755
    - makedirs: True
