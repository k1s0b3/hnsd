#!/bin/bash

cd $(dirname "$0")

if test -z "$LIBTOOLIZE" && test "$(uname)" = "Darwin"; then
  LIBTOOLIZE=glibtoolize
fi

ACLOCAL=${ACLOCAL:-aclocal}
AUTOCONF=${AUTOCONF:-autoconf}
AUTOMAKE=${AUTOMAKE:-automake}
LIBTOOLIZE=${LIBTOOLIZE:-libtoolize}

set -ex

pushd c-ares
if ! test -f configure; then
  ./buildconf
fi
popd

"$LIBTOOLIZE" --copy
"$ACLOCAL" -I m4
"$AUTOCONF"
"$AUTOMAKE" --add-missing --copy