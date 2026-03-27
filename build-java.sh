#!/bin/bash -evx

THIS="${0##*/}"
SRC_DIR="$(pwd)"

if [ -z "$JAVA_HOME" ]; then
    JAVA_HOME=$(dirname $(dirname $(readlink /etc/alternatives/java)))
    export JAVA_HOME
fi


mkdir jnibuild
cd jnibuild
cmake -DCMAKE_BUILD_TYPE=Release -DTD_ENABLE_JNI=ON -DCMAKE_INSTALL_PREFIX:PATH=../example/java/td ..
cmake --build . --target install
cd ../example/java
mkdir build
cd build
cmake -DCMAKE_BUILD_TYPE=Release -DTd_DIR=$SRC_DIR/example/java/td/lib/cmake/Td -DCMAKE_INSTALL_PREFIX:PATH=.. ..
cmake --build . --target install

rm -f *.jar
cd example/java/bin
mv libtdjni.so org/drinkless/tdlib
jar cvf ../../../tdlib.jar * > /dev/null
mv org/drinkless/tdlib/libtdjni.so .
cd - > /dev/null

echo OK
