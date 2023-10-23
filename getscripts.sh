#!/bin/bash
#
CURRENT_VERSION=2
BUILDSCRIPTS_BRANCH="master"
GRN="$(tput setaf 2)"    # Green
RED="$(tput setaf 196)"  # Red

function echoRed() {
    printf "${RED}%s${NC}\n" "$1"
}
function echoGreen() {
    printf "${GRN}%s${NC}\n" "$1"
}

main() {
    if [[ -n "$1" ]]; then
        echoBlue "Sourced VERSION: {$CURRENT_VERSION}"
    else
        if [ -d "buildscripts" ]; then
            echoGreen "Updating buildscripts....."
            cd buildscripts || exit
            pwd
            git remote set-url origin https://scm.ised-isde.canada.ca/scm/di/ised-buildscripts.git
            git pull --rebase
            cd ..
        else
            echoGreen "Fetching buildscripts branch [$BUILDSCRIPTS_BRANCH]....."
            if ! git clone -b "$BUILDSCRIPTS_BRANCH" --single-branch https://scm.ised-isde.canada.ca/scm/di/ised-buildscripts.git buildscripts; then
                echoRed "**********************************************************************"
                echoRed "  ERROR: Couldn't get the repository [$BUILDSCRIPTS_BRANCH]"
                echoRed "**********************************************************************"
                exit 1
            fi
        fi
        # Run the update script.
        if [ -f "buildscripts/updatescripts.sh" ]; then
            buildscripts/updatescripts.sh $CURRENT_VERSION &
        fi
        exit
    fi
}

## When we call main() at the end of file, all functions are already defined.
## Explicitly passing "$@" to main is required to make the command line arguments of the script visible in the function.
main "$@"
