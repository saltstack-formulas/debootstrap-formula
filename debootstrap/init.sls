include:
  - debootstrap.pkg

{% from 'debootstrap/state.jinja' import debootstrap_state %}

{% for name, data in salt['pillar.get']('debootstrap:chroots', {}).items() %}
{{ debootstrap_state('debootstrap_' + name, data) }}
{% endfor %}
