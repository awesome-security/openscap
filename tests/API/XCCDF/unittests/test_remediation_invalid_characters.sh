#!/bin/bash

set -e -o pipefail

name=$(basename $0 .sh)
result=$(mktemp -t ${name}.out.XXXXXX)
stderr=$(mktemp -t ${name}.err.XXXXXX)

$OSCAP xccdf eval --remediate --results $result $srcdir/${name}.xccdf.xml 2> $stderr

echo "Stderr file = $stderr"
echo "Result file = $result"
[ -f $stderr ]; [ ! -s $stderr ]; rm $stderr
[ -f $result ]; [ -s $result ]

$OSCAP xccdf validate-xml $result
rm test_file

rm $result
