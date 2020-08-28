#!/bin/bash
set -euo pipefail

# Using a Heredoc so this is easier to read
# `tr -d '\040\011\012\015'` strips all spaces, horizontal tabs, newlines, and carriage returns from the input
# The numbers are the octal representations of the values in ASCII
cat <<EOF |tr -d '\040\011\012\015' > lambda-payload.json
{
    "User": {
        "FirstName": "$FIRST_NAME",
        "LastName": "$LAST_NAME",
        "Zip": "$ZIP",
        "Email": "$EMAIL",
        "Role": $ROLE,
        "UserKey": "$USER_KEY",
        "BrandRolePrefix": $BRAND_ROLE_PREFIX
    },
    "ActionType": 3
}
EOF

echo "Now invoking ot in ${ENVIRONMENT}"
aws --region us-east-1 lambda invoke \
    --function-name ot \
    --payload <<< - $(cat lambda-payload.json) \
    lambda-response.json

echo "Response from the lambda (if nothing follows this, it means the lambda didn't throw any errors)"
cat lambda-response.json

