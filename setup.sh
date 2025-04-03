#!/bin/bash

echo "Which mode? (local/server/client/runner)"
read MODE

if [ "$MODE" != "local" ] && [ "$MODE" != "server" ] && [ "$MODE" != "client" ] && [ "$MODE" != "runner" ] ; then
	echo "Valid mode was not specified, defaulting to 'local'"
	MODE='local'
fi

if [ -f "$HOME/.bash_profile" ] ; then
	echo "\nexport TORERO_APPLICATION_MODE=$MODE" >> "$HOME/.bash_profile"
fi

if [ -f "$HOME/.zshrc" ] ; then
	if ! [ -e "$HOME/.zshenv" ] ; then
		touch "$HOME/.zshenv"
	fi
	echo "\nexport TORERO_APPLICATION_MODE=$MODE" >> "$HOME/.zshenv"
fi