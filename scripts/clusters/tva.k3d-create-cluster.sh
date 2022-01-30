#!/bin/bash

set -e;

cluster_count=2;

echo "Creating tva cluster"
k3d cluster delete tva-cluster || true
k3d cluster create --agents $cluster_count --config ${BASH_SOURCE%/*}/../../k3d/k3d.tva-cluster.yaml

kubectl label node k3d-tva-cluster-agent-0 universe=tva-blue --overwrite
kubectl label node k3d-tva-cluster-agent-1 universe=tva-green --overwrite
