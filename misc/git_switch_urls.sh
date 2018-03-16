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
    echo "switch all git URLs from SSH to HTTPS and vice versa"
    echo ""
    echo "./git_switch_urls.sh"
    echo "  -h --help"
    echo "  -s --ssh : switch all repositories to SSH"
    echo "  -t --https : switch all repositories to HTTPS"
    echo ""
}


function update_git_urls() {
    find ./ -path ./var/lib -prune -o -type f \( -name ".gitmodules" -o -name "config" \)  -exec sed -i $REGEX {} +
}


while [ "$1" != "" ]; do
    PARAM=`echo $1 | awk -F= '{print $1}'`
    VALUE=`echo $1 | awk -F= '{print $2}'`
    case $PARAM in
        -h | --help)
            usage
            exit
            ;;
        -s | --ssh)
            REGEX='s/https:\/\/github.com\//git@github.com:/g'
            update_git_urls
            ;;
        -t | --https)
            REGEX='s/git@github.com:/https:\/\/github.com\//g'
            update_git_urls
            ;;
        *)
            echo "ERROR: unknown parameter \"$PARAM\""
            usage
            exit 1
            ;;
    esac
    shift
done
