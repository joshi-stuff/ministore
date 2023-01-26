#!/bin/bash

if [[ -d node ]]
then 
	cd node
	npm install 
	if [[ "$MODE" == "release" ]]
	then
		NODE_ENV="production" npm run build --workspaces
	else
		NODE_ENV="development" npm run build --workspaces
	fi
fi

if [[ -d rust ]]
then 
	cd rust 
	if [[ "$MODE" == "release" ]]
	then
		cargo build --release
	else
		cargo build
	fi
fi
