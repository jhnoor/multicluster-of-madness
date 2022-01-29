#!/bin/bash

set -e;

cluster_count_spidermen=3;

# spider-men
echo "Creating spider-men cluster"

k3d cluster delete spider-men-cluster || true
k3d cluster create spider-men-cluster --servers $cluster_count_spidermen

for (( i=0; i<=$cluster_count_spidermen-1; i++ ))
do
    kubectl label node k3d-spider-men-cluster-server-$i universe=spider-men --overwrite
done


