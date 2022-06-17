# github-deploy-runner

Simplistic github action runner to perform deployments in k8s via github actions.

## Setup

Currently requires manually adding an action runner in the settings page of a repository.
Note the token presented in the commands and then do:

```
docker run --rm untoldwind/github-deploy-runner:2 /cluster_conf.sh --work /tmp --labels dev-deploy --name dev-deploy --url <repo-url> --token <token>
```

Output is a k8s secret that should be used to execute the runner in the k8s cluster itself.

