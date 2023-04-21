resource "aws_eks_cluster" "sumologic-demo" {
  name     = "sumologic-demo"
  role_arn = aws_iam_role.sumologic-demo.arn

  enabled_cluster_log_types = [
    "api",
    "audit",
    "authenticator",
    "controllerManager",
    "scheduler"
  ]

  vpc_config {
    endpoint_private_access = false
    endpoint_public_access  = true
    subnet_ids = concat([for v in aws_subnet.private : v.id], [for v in aws_subnet.public : v.id])
    security_group_ids = [aws_security_group.sumologic-demo-control-plane.id]
  }

  version = "1.24"
}

data "template_file" "kubeconfig" {
  template = file("${path.module}/kubeconfig.tpl")

  vars = {
    kubeconfig_name           = "eks_${aws_eks_cluster.sumologic-demo.name}"
    clustername               = aws_eks_cluster.sumologic-demo.name
    endpoint                  = aws_eks_cluster.sumologic-demo.endpoint
    cluster_auth_base64       = aws_eks_cluster.sumologic-demo.certificate_authority[0].data
  }
}

resource "local_file" "kubeconfig" {
  content  = data.template_file.kubeconfig.rendered
  filename = pathexpand("~/.kube/config")
}

resource "aws_eks_fargate_profile" "demo" {
  cluster_name           = aws_eks_cluster.sumologic-demo.name
  fargate_profile_name   = "demo"
  pod_execution_role_arn = aws_iam_role.sumologic-demo-fargate.arn
  subnet_ids             = [for v in aws_subnet.private : v.id]

  selector {
    namespace = "demo"
  }
}
