#!/bin/bash
kubectl get events --all-namespaces  --sort-by='.metadata.creationTimestamp'