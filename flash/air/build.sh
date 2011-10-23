#!/bin/sh

if [ $# -lt 3 ]; then
    echo "Usage: $0 <{path.to}.mobileprovision> <{path.to}.developer_identity.p12> <password>"
    exit 1
fi


"${FLEX_HOME}"/bin/mxmlc +configname=airmobile -output build/AccelerateExample.swf src/AccelerateExample.mxml -load-config+=accelerate_app.config -swf-version=13

cp src/AccelerateExample-app.xml build/AccelerateExample-app.xml

mkdir -p build
cd build

"${FLEX_HOME}"/bin/adt -package -target ipa-test-interpreter -provisioning-profile $1 -storetype pkcs12 -keystore $2 -storepass $3 ../release/AccelerateExample.ipa AccelerateExample-app.xml AccelerateExample.swf -extdir ../ext/
