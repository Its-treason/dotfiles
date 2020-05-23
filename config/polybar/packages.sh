#!/bin/sh

STRING="";

PACKAGES=$(($(apt list --installed 2> /dev/null | wc -l) - 1))
STRING="${T3}${T0} $PACKAGES"

UPDATE=$(($(apt list --upgradable 2> /dev/null | wc -l) - 1))
if [ $UPDATE -ne 9 ]; then
  STRING="$STRING ${T3}${T0} $UPDATE"
fi

echo $STRING
