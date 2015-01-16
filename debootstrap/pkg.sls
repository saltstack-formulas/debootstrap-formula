{% from 'debootstrap/state.jinja' import debootstrap_impl %}

{{ debootstrap_impl }}:
  pkg.installed
