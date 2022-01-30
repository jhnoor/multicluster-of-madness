#!/bin/bash

set -e;

cluster_count=3;

echo "Creating spider-men cluster"
k3d cluster delete spider-men-cluster || true
k3d cluster create --agents $cluster_count --config ${BASH_SOURCE%/*}/../../k3d/k3d.spider-men-cluster.yaml

for (( i=0; i<=$cluster_count-1; i++ ))
do
    kubectl label node k3d-spider-men-cluster-agent-$i universe=spider-men --overwrite
done