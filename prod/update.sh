#!/bin/bash

# The script detect the right main project branch, then update the submodule function of branch-[mainProjectBranch]
# For example, if you define these variables in .gitmodules :
# - branch-dev
# - branch-master
# If you are on dev branch in main project, the script will update submodule functions of branch-dev you've defined
# In main project, if you are in another branch than master or dev, it will take by default dev branch
# If you don't define any branches for you submodule, the script will update from master

cd "$(dirname "$0")"/../../

function usage() {
    echo "update the Mezzo instance and all submodules with various options"
    echo ""
    echo "./update.sh"
    echo "  -h --help"
    echo "  -hr --hard-reset : hard reset the main project and submodules before update"
    echo ""
}

while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -h | --help)
            usage
            exit
            ;;
        -hr | --hard-reset)
            git reset --hard
            git submodule foreach --recursive 'git reset --hard'
        ;;
    esac
    shift
done

# Update main project
git pull

# Get the current branch
curr_branch=$(git symbolic-ref --short HEAD)
echo $curr_branch
if [ $curr_branch != "master" ] && [ $curr_branch != "dev" ];
then
    curr_branch="dev"
fi

# checkout new submodule
git submodule update --init

# Synchronizes submodules' remote URL configuration setting to the value specified in .gitmodules
git submodule sync

# Checkout all submodules on right branches specified in .gitmodules, by default the branch is master
git submodule foreach --recursive 'git checkout $(git config -f $toplevel/.gitmodules submodule.$name.branch-'$curr_branch' || echo master)'

# Pull all submodules on right branches specified in .gitmodules, by default the branch is master
git submodule foreach --recursive 'git pull origin $(git config -f $toplevel/.gitmodules submodule.$name.branch-'$curr_branch' || echo master)'
