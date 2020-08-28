#!/usr/bin/env bash

declare -A array
while IFS="=" read -r key value
do
    if [[ "$key" == "[" || "$key" == "]" ]]; then
        continue
    fi
    key=$(echo $key | tr -d '"')
    value=$(echo $value | tr -d '",')
    array[$key]=$value
done < <(curl -s -H "Private-Token: ${GITLAB_ACCESS_TOKEN}" "https://gitlab.com/api/v4/groups/519/projects?with_shared=false" | jq -r 'map("\(.id)=\(.name)")')

for key in "${!array[@]}"; do
    echo "key: $key   value: ${array[$key]}"
done

