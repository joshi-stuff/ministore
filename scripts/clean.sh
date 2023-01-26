#!/bin/bash

if [[ -d node ]]
then 
	cd node
	npm install 
	npm run clean --workspaces
fi

if [[ -d rust ]]
then 
	cd rust 
	cargo clean
fi
