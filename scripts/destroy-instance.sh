#!/usr/bin/env bash

SCRIPT_DIR=$(cd $(dirname $0); pwd -P)
MODULE_DIR=$(cd "${SCRIPT_DIR}/.."; pwd -P)

NAMESPACE="$1"
NAME="$2"

kubectl delete argocds.argoproj.io "${NAME}" -n "${NAMESPACE}" --wait=true

kubectl delete deployment -l "app.kubernetes.io/part-of=argocd" -n "${NAMESPACE}" --wait=true

until kubectl get deployment -l "app.kubernetes.io/part-of=argocd" -n "${NAMESPACE}"; do
  echo "Waiting for deployments to be deleted"
  sleep 30
done