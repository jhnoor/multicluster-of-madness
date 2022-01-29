#!/bin/bash

bash ${BASH_SOURCE%/*}/../.secrets/create-secret.sh
helm upgrade --install spider-men ${BASH_SOURCE%/*}/../Charts/spider-men