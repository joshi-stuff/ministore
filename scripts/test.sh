#!/bin/bash

if [[ -d node ]]
then 
	cd node
	npm install 
	npm run test --workspaces
fi

if [[ -d rust ]]
then 
	cd rust 
	cargo test
fi
