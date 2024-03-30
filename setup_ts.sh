#!/bin/bash

if [ -e ts ]; then
	exit 1
fi

mkdir ts
cd ts

npm install typescript ts-node --save-dev
npx tsc --init

echo "console.log('hello ts')" > index.ts

npx ts-node index.ts

