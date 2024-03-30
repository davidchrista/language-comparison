#!/bin/bash

if [ -e go ]; then
	exit 1
fi

mkdir go
cd go

go mod init github.com/davidchrista/language-comparison/go

echo -e "package main\n\nimport \"fmt\"\n\nfunc main() {\n  fmt.Println(\"hello go\")\n}\n" > main.go

go run .

