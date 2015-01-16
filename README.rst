===========
debootstrap
===========

This formula makes it easy to create chroots of various Debian-based
distributions with debootstrap/cdebootstrap.

.. note::

    See the full `Salt Formulas installation and usage instructions
    <http://docs.saltstack.com/en/latest/topics/development/conventions/formulas.html>`_.

Available states
================

.. contents::
    :local:

``debootstrap``
---------------

Create chroots described in pillar data below ``debootstrap:chroots``.
Here is a short overview of the pillar structure::

    debootstrap:
      chroots:
        unstable:                     # a chroot identifier
          # Required parameters
          directory: /srv/chroots/unstable  # the target directory
          vendor: debian              # the name of the vendor
          dist: sid                   # codename of the release to bootstrap
          # Optional parameters
          arch: amd64                 # architecture to bootstrap
                                      # (defaults to current arch)
          components:                 # list of components to enable
            - main
          extra_dists:                # supplementary APT repositories to 
            - experimental            # enable
          with_source: True           # include source repositories too
        another-chroot:
          ...

``Configuration``
=================
See the pillar.example file to have an idea of everything that can
be customized in this formula.

``Extending``
=============
You can build your own debootstrap-based formula by importing the
``debootstrap_state`` macro from ``debootstrap/state.jinja``::

    include:
      - debootstrap.pkg

    {% from 'debootstrap/state.jinja' import debootstrap_state %}

    {% set data = {
        'directory': '/srv/chroots/jessie',
        'vendor': 'debian',
        'dist': 'jessie',
    } %}
    {{ debootstrap_state('my_state_name', data, apt_update=False) }}

You can rely on the fact that this will also create a file.managed
state suffixed with "_sources_list" to update the sources.list file in the
chroot.
