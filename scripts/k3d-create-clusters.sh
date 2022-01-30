#!/bin/bash
echo $1

case $1 in
  spider-men)
    source ${BASH_SOURCE%/*}/clusters/spider-men.k3d-create-cluster.sh
    ;;

  tva)
    source ${BASH_SOURCE%/*}/clusters/tva.k3d-create-cluster.sh
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







