#!/bin/bash
set -e;

bash ${BASH_SOURCE%/*}/../.secrets/create-secret.sh || true
helm upgrade --install spider-men ${BASH_SOURCE%/*}/../Charts/spider-men