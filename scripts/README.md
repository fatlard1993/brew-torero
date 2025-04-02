# Torero Homebrew Management Scripts

The script(s) that live here are intended to be run via torero and describe the automated management of this repo.

## Setup

1. `torero create repository homebrew-torero --url git@github.com:fatlard1993/homebrew-torero.git`
2. `torero create service python-script homebrew-update --repository ./homebrew-torero --working-dir scripts --filename update.py`

## Run

> Update
`torero run service python-script homebrew-update --set arg=<version> --set arg=<gitUser> --set arg=<gitToken>`