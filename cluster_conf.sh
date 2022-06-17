#!/bin/bash

/runner/config.sh $@

_CREDENTIALS=$(cat /runner/.credentials | base64 -w 0)
_CREDENTIALS_RSA=$(cat /runner/.credentials_rsaparams | base64 -w 0)
_ENV=$(cat /runner/.env | base64 -w 0)
_PATH=$(cat /runner/.path | base64 -w 0)
_RUNNER=$(cat /runner/.runner | base64 -w 0)

cat <<END
---
apiVersion: v1
kind: Secret
metadata:
  name: deploy-runner-credentials
type: Opaque
data:
    .credentials: $_CREDENTIALS
    .credentials_rsaparams: $_CREDENTIALS_RSA
    .path: $_PATH
    .env: $_ENV 
    .runner: $_RUNNER
END
