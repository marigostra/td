#!/bin/bash -e
THIS="${0##*/}"


if [ -z "$JAVA_HOME" ]; then
    echo Settings JAVA_HOME
    export JAVA_HOME=$(dirname $(dirname $(readlink /etc/alternatives/java)))
fi
echo "JAVA_HOME is $JAVA_HOME"

GROUP=org.drinkless
NAME=tdlib
VERSION=1.8.62.0


[ -z "$1" ] && echo "ERROR: $THIS: No destination directory" >&2 && exit 1
MAVEN_REPO_DIR="$1"

rm -f *.jar
cd example/java/bin
mv libtdjni.so org/drinkless/tdlib
jar cvf ../../../tdlib.jar * > /dev/null
mv org/drinkless/tdlib/libtdjni.so .
cd - > /dev/null
mvn org.apache.maven.plugins:maven-install-plugin:2.3.1:install-file \
    -Dfile=$NAME.jar \
    -DgroupId=$GROUP -DartifactId=$NAME -Dversion=$VERSION \
    -Dpackaging=jar -DcreateChecksum=true -DgeneratePom=true \
    -DlocalRepositoryPath="$MAVEN_REPO_DIR" -B -q
