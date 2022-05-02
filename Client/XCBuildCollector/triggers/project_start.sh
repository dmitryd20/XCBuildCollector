#!/bin/sh

if ! pip3 list --disable-pip-version-check | grep -F requests ; then
  pip3 install requests
fi

cd ~/.XCBuildCollector
python3 ./scripts/project_start.py