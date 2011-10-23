#!/bin/sh

"${FLEX_HOME}"/bin/compc -output build/Accelerate.swc -load-config+=accelerate_lib.config +configname=airmobile -swf-version=13

cd build

cp ../../../obj-c/build/Release-iphoneos/libAIRExtensionC.a .

jar xvf Accelerate.swc 

rm catalog.xml 

"${FLEX_HOME}"/bin/adt -package -target ane ../release/accelerateexample.ane extension.xml -swc Accelerate.swc -platform iPhone-ARM library.swf libAIRExtensionC.a
