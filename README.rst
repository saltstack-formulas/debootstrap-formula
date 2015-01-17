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

Create chroots described in pillar data within the ``debootstrap:chroots``
dictionnary. Here's a small pillar data sample::

    debootstrap:
      basedir: /srv/chroots
      implementation: cdebootstrap
      chroots:
        unstable:  # the chroot identifier
          vendor: debian
          dist: sid

Here's the full list of parameters that are supported in such chroot
descriptions:

- ``id``: a chroot identifier, it defaults to the name of the key
  in the ``debootstrap:chroots`` pillar dictionnary.
- ``dist``: the codename of the "distribution" (release) to bootstrap.
  Defaults to the same value as ``id``.
- ``vendor``: the name of the vendor associated to ``dist``. Only required
  when the same codename is used by multiple vendors. Best to be explicit
  when you're not sure.
- ``basedir``: parent directory of where the chroot will be created.
  Defaults to ``debootstrap:basedir`` pillar or ``/srv/chroots`` when the
  former does not exist.
- ``directory``: the directory where the chroot will be created. Defaults
  to ``<basedir>/<id>``.
- ``arch``: the architecture to bootstrap in the chroot. Defaults to the
  current architecture.
- ``components`` (alist): the repository components to enable in APT's
  configuration (aka sources.list). The default value varies for each vendor (and can be
  overriden via pillar data ``debootstrap:vendor:<vendor>:components``).
- ``extra_dists`` (a list): supplementary APT repositories to enable
  in APT's configuration. Defaults to the empty list.
- ``with_source`` (boolean): if True then add "deb-src" lines for
  all repositories enabled in APT's sources.list file.

``debootstrap.prereq``
----------------------

Ensure that the selected debootstrap implementation is installed and that
the base directory hosting the chroots exists. In general, there's no reason
to use this state directly (except possibly when you extend this formula).
The fact that it is separated from ``debootstrap`` is only due to an
implementation detail.

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
        'id': 'my_chroot_identifier',
        'directory': '/srv/chroots/jessie',
        'vendor': 'debian',
        'dist': 'jessie',
    } %}
    {{ debootstrap_state(data, apt_update=False) }}

You can rely on the fact that this will also create a file.managed
state named ``debootstrap_<id>_sources_list`` to update the sources.list
file in the chroot.
