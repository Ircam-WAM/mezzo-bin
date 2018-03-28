#!/bin/bash

# The script detect the right main project branch, then update the submodule function of branch-[mainProjectBranch]
# For example, if you define these variables in .gitmodules :
# - branch-dev
# - branch-master
# If you are on dev branch in main project, the script will update submodule functions of branch-dev you've defined
# In main project, if you are in another branch than master or dev, it will take by default dev branch
# If you don't define any branches for you submodule, the script will update from master

cd "$(dirname "$0")"/../../

git status
git submodule foreach --recursive 'git status'
