#!/bin/bash

set -euo pipefail

if [[ $# -ne 3 ]]; then
  echo "Usage: $0 <email> <first-name> <last-name>"
  exit 1
fi

EMAIL="$1"
FIRST_NAME="$2"
LAST_NAME="$3"

OU="/Employees"

GROUP="fte@oluopeodu.com"

if gam info user "$EMAIL" >/dev/null 2>&1; then
  echo "User already exists: $EMAIL"
  exit 0
fi

echo "Creating Google Workspace user: $EMAIL"

gam create user "$EMAIL" \
  firstname "$FIRST_NAME" \
  lastname "$LAST_NAME"
  
echo "Moving user to $OU"

gam update org "$OU" move user "$EMAIL"

echo "Adding user to $GROUP"

gam user "$EMAIL" add group "$GROUP"
