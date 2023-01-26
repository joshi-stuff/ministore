#!/bin/bash

if [[ -d node ]]
then 
	cd node
	npm install 
	npm run format --workspaces
fi

if [[ -d rust ]]
then 
	cd rust 
	cargo fmt
fi
