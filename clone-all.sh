#!/usr/bin/env bash
set -euo pipefail

command -v jq || (echo "ERROR: jq not installed"; exit 1)
command -v curl || (echo "ERROR: curl not installed"; exit 1)
command -v git || (echo "ERROR: git not installed"; exit 1)

AUTHORIZATION='--header Private-Token:'${GRANULAR_GITLAB_ACCESS_TOKEN}
HOST='gitlab.com'
BASE_URL="https://$HOST/api/v4"

declare -A ORGS
ORGS[org]=519

function findNextPage() {
    next=$(curl -sf --head ${AUTHORIZATION} $1 | grep 'X-Next-Page' | tr -d '\r' | awk '{print $2}')
    if [[ -n "$next" ]]; then
        return $next
    else
        return 0
    fi
}

function getProjects() {
    url="${BASE_URL}/groups/$2/projects?with_shared=false&per_page=100"
    set +u
    if [ -n "$3" ]; then
        url="$url&page=$3"
    fi
    set -u
    for project in `curl -sf ${AUTHORIZATION} $url | jq -r '.[].id'`; do
        projectName=$(curl -sf ${AUTHORIZATION} "${BASE_URL}/projects/$project" | jq -r '.name')
        if [[ ! -d "$projectName" ]]; then
            #clonePath=$(curl -sf ${AUTHORIZATION} "${BASE_URL}/projects/$project" | jq -r '.ssh_url_to_repo')
            #git clone $clonePath $projectName
            echo "$1/$projectName"
        fi
    done
    set +e
    findNextPage $url
    nextPage=$?
    set -e
    if [[ $nextPage -ne 0 ]]; then
        getProjects $1 $2 $nextPage
    fi
}

for ORG in "${!ORGS[@]}"; do
    if [ ! -d "$ORG" ]; then
        mkdir $ORG
    fi
    cd $ORG
    getProjects $ORG ${ORGS[$ORG]}
    cd ..
done

