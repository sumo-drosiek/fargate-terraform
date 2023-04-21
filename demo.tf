resource "aws_vpc" "sumologic-demo" {
  cidr_block = "192.168.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

}

resource "aws_subnet" "private-a" {
  vpc_id     = aws_vpc.sumologic-demo.id
  cidr_block = "192.168.128.0/19"
  availability_zone = "us-east-2a"

  tags = {
    "kubernetes.io/role/internal-elb": "1",
  }
}

resource "aws_subnet" "private-b" {
  vpc_id     = aws_vpc.sumologic-demo.id
  cidr_block = "192.168.96.0/19"
  availability_zone = "us-east-2b"

  tags = {
    "kubernetes.io/role/internal-elb": "1",
  }
}

resource "aws_subnet" "private-c" {
  vpc_id     = aws_vpc.sumologic-demo.id
  cidr_block = "192.168.160.0/19"
  availability_zone = "us-east-2c"

  tags = {
    "kubernetes.io/role/internal-elb": "1",
  }
}

resource "aws_subnet" "public-a" {
  vpc_id     = aws_vpc.sumologic-demo.id
  cidr_block = "192.168.32.0/19"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    "kubernetes.io/role/elb": "1",
  }
}

resource "aws_subnet" "public-b" {
  vpc_id     = aws_vpc.sumologic-demo.id
  cidr_block = "192.168.0.0/19"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = true

  tags = {
    "kubernetes.io/role/elb": "1",
  }
}

resource "aws_subnet" "public-c" {
  vpc_id     = aws_vpc.sumologic-demo.id
  cidr_block = "192.168.64.0/19"
  availability_zone = "us-east-2c"
  map_public_ip_on_launch = true

  tags = {
    "kubernetes.io/role/elb": "1",
  }
}

resource "aws_internet_gateway" "sumologic-demo" {
  vpc_id = aws_vpc.sumologic-demo.id
}

resource "aws_security_group" "sumologic-demo-control-plane" {
  name        = "sumologic-demo/ControlPlaneSecurityGroup"
  description = "Communication between the control plane and worker nodegroups"
  vpc_id      = aws_vpc.sumologic-demo.id
}

resource "aws_security_group" "sumologic-demo-cluster-shared" {
  name        = "sumologic-demo/ClusterSharedNodeSecurityGroup"
  description = "Communication between all nodes in the cluster"
  vpc_id      = aws_vpc.sumologic-demo.id
}

resource "aws_eip" "sumologic-demo" {
  vpc      = true
}

resource "aws_nat_gateway" "sumologic-demo" {
  allocation_id = aws_eip.sumologic-demo.id
  subnet_id     = aws_subnet.public-b.id
}

resource "aws_route_table" "private-a" {
  vpc_id = aws_vpc.sumologic-demo.id
}

resource "aws_route_table" "private-b" {
  vpc_id = aws_vpc.sumologic-demo.id
}

resource "aws_route_table" "private-c" {
  vpc_id = aws_vpc.sumologic-demo.id
}

resource "aws_route_table" "sumologic-demo" {
  vpc_id = aws_vpc.sumologic-demo.id
}

resource "aws_route" "private-a" {
  route_table_id            = aws_route_table.private-a.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = aws_nat_gateway.sumologic-demo.id
}

resource "aws_route" "private-b" {
  route_table_id            = aws_route_table.private-b.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = aws_nat_gateway.sumologic-demo.id
}

resource "aws_route" "private-c" {
  route_table_id            = aws_route_table.private-c.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = aws_nat_gateway.sumologic-demo.id
}

resource "aws_route" "public-c" {
  route_table_id            = aws_route_table.sumologic-demo.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.sumologic-demo.id
}

resource "aws_route_table_association" "private-a" {
  subnet_id      = aws_subnet.private-a.id
  route_table_id = aws_route_table.private-a.id
}

resource "aws_route_table_association" "private-b" {
  subnet_id      = aws_subnet.private-b.id
  route_table_id = aws_route_table.private-b.id
}

resource "aws_route_table_association" "private-c" {
  subnet_id      = aws_subnet.private-c.id
  route_table_id = aws_route_table.private-c.id
}

resource "aws_route_table_association" "public-a" {
  subnet_id      = aws_subnet.public-a.id
  route_table_id = aws_route_table.sumologic-demo.id
}

resource "aws_route_table_association" "public-b" {
  subnet_id      = aws_subnet.public-b.id
  route_table_id = aws_route_table.sumologic-demo.id
}

resource "aws_route_table_association" "public-c" {
  subnet_id      = aws_subnet.public-c.id
  route_table_id = aws_route_table.sumologic-demo.id
}

resource "aws_iam_role" "sumologic-demo" {
  name = "sumologic-demo"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks.amazonaws.com"
        }
      },
    ]
  })

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController",
    aws_iam_policy.sumologic-demo-cloudwatch.arn,
    aws_iam_policy.sumologic-demo-elb.arn,
    ]
}

resource "aws_iam_role" "sumologic-demo-fargate" {
  name = "sumologic-demo-fargate"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  assume_role_policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = "sts:AssumeRole"
        Effect = "Allow"
        Principal = {
          Service = "eks-fargate-pods.amazonaws.com"
        }
      },
    ]
  })

  managed_policy_arns = [
    aws_iam_policy.cloudwatch.arn,
    ]
}

resource "aws_iam_policy" "sumologic-demo-elb" {
  name        = "sumologic-demo-PolicyELBPermissions"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "ec2:DescribeAccountAttributes",
          "ec2:DescribeAddresses",
          "ec2:DescribeInternetGateways"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "sumologic-demo-elb" {
  role       = aws_iam_role.sumologic-demo.name
  policy_arn = aws_iam_policy.sumologic-demo-elb.arn
}

resource "aws_iam_policy" "sumologic-demo-cloudwatch" {
  name        = "sumologic-demo-PolicyCloudWatchMetrics"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
          "cloudwatch:PutMetricData"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ],
  })
}

resource "aws_iam_role_policy_attachment" "sumologic-demo-cloudwatch" {
  role       = aws_iam_role.sumologic-demo.name
  policy_arn = aws_iam_policy.sumologic-demo-cloudwatch.arn
}

resource "aws_vpc_security_group_ingress_rule" "sumologic-demo-node-to-cluster" {
  referenced_security_group_id = aws_security_group.sumologic-demo-control-plane.id
  security_group_id = aws_security_group.sumologic-demo-cluster-shared.id
  
  ip_protocol = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "sumologic-demo-inter-node-group" {
  referenced_security_group_id = aws_security_group.sumologic-demo-cluster-shared.id
  security_group_id = aws_security_group.sumologic-demo-cluster-shared.id

  ip_protocol = "-1"
}

resource "aws_vpc_security_group_ingress_rule" "sumologic-demo-default-cluster-to-node" {
  referenced_security_group_id = aws_security_group.sumologic-demo-cluster-shared.id
  security_group_id = aws_security_group.sumologic-demo-control-plane.id

  ip_protocol = "-1"
}

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
    subnet_ids = [
      aws_subnet.private-a.id,
      aws_subnet.private-b.id,
      aws_subnet.private-c.id,
      aws_subnet.public-a.id,
      aws_subnet.public-b.id,
      aws_subnet.public-c.id
      ]
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
  subnet_ids             = [
    aws_subnet.private-a.id,
    aws_subnet.private-b.id,
    aws_subnet.private-c.id,
    ]

  selector {
    namespace = "demo"
  }
}

resource "aws_iam_policy" "cloudwatch" {
  name        = "sumologic-demo-cloudwatch"

  # Terraform's "jsonencode" function converts a
  # Terraform expression result to valid JSON syntax.
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [
      {
        Action = [
			"logs:CreateLogStream",
			"logs:CreateLogGroup",
			"logs:DescribeLogStreams",
			"logs:PutLogEvents"
        ]
        Effect   = "Allow"
        Resource = "*"
      },
    ]
  })
}

resource "aws_iam_role_policy_attachment" "sumologic-demo-fargate-cloudwatch" {
  role       = aws_iam_role.sumologic-demo-fargate.name
  policy_arn = aws_iam_policy.cloudwatch.arn
}
