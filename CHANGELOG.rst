debootstrap formula
===================

0.2.0 (2017-06-08)

- Make compatible with cdebootstrap 0.7.x from Debian 9 Stretch.
- Support passing script parameter with debootstrap.
- Use debootstrap by default instead of cdebootstrap (which is not as well
  maintained).

0.1.2 (2015-01-17)

- Make most parameters optional ("dist" defaults to the chroot identifier,
  "vendor" is identified from the "dist" when possible, "directory"
  is built on top of a new "basedir" setting).

0.0.1 (2015-01-16)

- Initial version
