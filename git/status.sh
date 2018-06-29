#!/bin/bash

echo '------ Main Project -------'
git status  -s -b
echo '------ Sub Modules --------'
git submodule foreach --recursive 'git status -s -b'