# Kubernetes Manifests - Database Service

Deploy the ecommerce database (PostgreSQL with init.sql) to Minikube.

## Apply Order

Apply in this order for each environment (dev, staging, prod):

```bash
kubectl apply -f dev/namespace.yaml
kubectl apply -f dev/secret.yaml
kubectl apply -f dev/configmap.yaml
kubectl apply -f dev/pv-database.yaml
kubectl apply -f dev/deployment.yaml
kubectl apply -f dev/service.yaml
```

Or apply the whole folder: `kubectl apply -f dev/`

## Image Tag

The deployment uses `PLACEHOLDER_IMAGE`. Jenkins updates it via:

```bash
kubectl set image deployment/ecomm-database postgres=YOUR_DOCKERHUB_USER/ecomm-database:TAG -n ecomm-dev
```

## Environments

| Folder   | Namespace     |
|----------|---------------|
| dev/     | ecomm-dev     |
| staging/ | ecomm-staging |
| prod/    | ecomm-prod    |
