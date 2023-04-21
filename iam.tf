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

resource "aws_iam_role_policy_attachment" "sumologic-demo-eks-cluster" {
  role       = aws_iam_role.sumologic-demo.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy"
}

resource "aws_iam_role_policy_attachment" "sumologic-demo-vpc-controller" {
  role       = aws_iam_role.sumologic-demo.name
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController"
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
