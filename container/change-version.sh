#!/bin/sh  


FROM_VERSION=$1
TO_VERSION=$2

if [ "x$FROM_VERSION" = "x" ]; then
    echo "No from version is set"
    exit 1
fi

if [ "x$TO_VERSION" = "x" ]; then
    echo "No to version is set"
    exit 1
fi


find . -type f -name "pom.xml" -print0 | xargs -0 -t sed -i "" -e "s/$FROM_VERSION/$TO_VERSION/g"
