#!/bin/bash

if [ -e dart ]; then
	exit 1
fi

dart create -t console dart
cd dart
sed -i "s/Hello world:/hello/;s/!//" bin/dart.dart
sed -i "s/calculate/name/" bin/dart.dart lib/dart.dart
sed -i "s/int/String/;s/6 \* 7/'dart'/" lib/dart.dart
dart run

