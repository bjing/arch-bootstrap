#!/usr/bin/env bash
PARAMS=$*

if [[ $# < 1 ]]; then
  echo "Running site.yml"
  ansible-playbook site.yml ${PARAMS}
else
  echo "Running ${PARAMS}"
  ansible-playbook ${PARAMS}
fi

