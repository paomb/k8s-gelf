#!/bin/sh

kubectl delete -f fluent-bit-service-account.yaml
kubectl delete -f fluent-bit-role.yaml
kubectl delete -f fluent-bit-role-binding.yaml

kubectl delete -f fluent-bit-configmap.yaml

kubectl delete -f fluent-bit-daemon-set.yaml


kubectl delete namespace logging
