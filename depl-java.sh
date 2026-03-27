#!/bin/bash -evx
THIS="${0##*/}"


if [ -z "$JAVA_HOME" ]; then
    JAVA_HOME=$(dirname $(dirname $(readlink /etc/alternatives/java)))
    export JAVA_HOME
fi

GROUP=org.drinkless
NAME=tdlib
VERSION=1.8.62.0


[ -z "$1" ] && echo "ERROR: $THIS: No destination directory" >&2 && exit 1
MAVEN_REPO_DIR="$1"

mvn org.apache.maven.plugins:maven-install-plugin:2.3.1:install-file \
    -Dfile=$NAME.jar \
    -DgroupId=$GROUP -DartifactId=$NAME -Dversion=$VERSION \
    -Dpackaging=jar -DcreateChecksum=true -DgeneratePom=true \
    -DlocalRepositoryPath="$MAVEN_REPO_DIR" -B -q
