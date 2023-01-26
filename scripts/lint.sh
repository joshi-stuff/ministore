#!/bin/bash

if [[ -d node ]]
then 
	cd node
	npm install 
	npm run lint --workspaces
fi

if [[ -d rust ]]
then 
	cd rust 
	cargo check
fi
