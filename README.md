# Fargete with Terraform

This is an experimenrtal repository and every commit may introduce breaking changes

## Sources

- Cloudformation created by eksctl
- [https://docs.aws.amazon.com/eks/latest/userguide/fargate-logging.html]

## How to use it?

```bash
terraform init
terraform apply
kubectl apply -f templates/fluentbit-config.yaml
kubectl apply -f templates/logger-server.yaml
kubectl -n demo expose deploy logger-server
kubectl -n demo port-forward svc/logger-server 8080:80
curl localhost:8080
```
