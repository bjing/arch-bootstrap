#!/bin/bash
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <username> <repo>"
  exit 1
fi

if [ -d "/home/$1/.git" ]; then
  echo "Repository already exists. Not creating."
  exit 0
else
  echo "Creating git repository and fetching it."
  cd /home/$1 && \
  git init && \
  git remote add origin $2 && \
  GIT_SSH_COMMAND="ssh -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no" git fetch && \
  git checkout -t origin/master
fi

