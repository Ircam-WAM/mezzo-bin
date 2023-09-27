#!/bin/bash

# This script merges all submodule dev branches defined as branch-dev in every .gitmodules files into the related master branches defined in branch-master.
# If there is no definition branches for you submodule, the script will merge the dev branch

cd "$(dirname "$0")"/../../

git submodule foreach --recursive 'echo $name; git merge $(git config -f $toplevel/.gitmodules submodule.$name.branch-develop)'

git commit -a -m "update submodules"

git merge develop
