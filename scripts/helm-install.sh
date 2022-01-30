#!/bin/bash
set -e;

bash ${BASH_SOURCE%/*}/../.secrets/create-secret.sh || true

case $1 in
  spider-men)
    # TODO maybe we should delete and then install (just encountered issue with creating templating and it failing until i deleted the chart and installed it...)
    helm upgrade --install spider-men ${BASH_SOURCE%/*}/../Charts/spider-men
    ;;

  tva)
    helm upgrade --install tva ${BASH_SOURCE%/*}/../Charts/tva
    ;;

  *)
    echo -n "
        Command should be followed by cluster name
        Must be one of the following:
            - spider-man
            - tva
    "
    ;;
esac