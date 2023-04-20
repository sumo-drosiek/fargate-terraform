# // "VPC": {
# //     "Type": "AWS::EC2::VPC",
# //     "Properties": {
# //       "CidrBlock": "192.168.0.0/16",
# //       "EnableDnsHostnames": true,
# //       "EnableDnsSupport": true,
# //       "Tags": [
# //         {
# //           "Key": "Name",
# //           "Value": {
# //             "Fn::Sub": "${AWS::StackName}/VPC"
# //           }
# //         }
# //       ]
# //     }
# //   }

resource "aws_vpc" "sumologic-demo" {
  cidr_block = "192.168.0.0/16"
  enable_dns_hostnames = true
  enable_dns_support = true

  tags = {
    "Name": "sumologic-demo/VPC",
  }
}

# "SubnetPrivateUSEAST2A": {
#   "Type": "AWS::EC2::Subnet",
#   "Properties": {
#     "AvailabilityZone": "us-east-2a",
#     "CidrBlock": "192.168.128.0/19",
#     "Tags": [
#       {
#         "Key": "kubernetes.io/role/internal-elb",
#         "Value": "1"
#       },
#       {
#         "Key": "Name",
#         "Value": {
#           "Fn::Sub": "${AWS::StackName}/SubnetPrivateUSEAST2A"
#         }
#       }
#     ],
#     "VpcId": {
#       "Ref": "VPC"
#     }
#   }
# },

resource "aws_subnet" "private-a" {
  vpc_id     = aws_vpc.sumologic-demo.id
  cidr_block = "192.168.128.0/19"
  availability_zone = "us-east-2a"

  tags = {
    "Name": "sumologic-demo/SubnetPrivateUSEAST2A",
    "kubernetes.io/role/internal-elb": "1",
  }
}

# "SubnetPrivateUSEAST2B": {
#   "Type": "AWS::EC2::Subnet",
#   "Properties": {
#     "AvailabilityZone": "us-east-2b",
#     "CidrBlock": "192.168.96.0/19",
#     "Tags": [
#       {
#         "Key": "kubernetes.io/role/internal-elb",
#         "Value": "1"
#       },
#       {
#         "Key": "Name",
#         "Value": {
#           "Fn::Sub": "${AWS::StackName}/SubnetPrivateUSEAST2B"
#         }
#       }
#     ],
#     "VpcId": {
#       "Ref": "VPC"
#     }
#   }
# },

resource "aws_subnet" "private-b" {
  vpc_id     = aws_vpc.sumologic-demo.id
  cidr_block = "192.168.96.0/19"
  availability_zone = "us-east-2b"

  tags = {
    "Name": "sumologic-demo/SubnetPrivateUSEAST2B",
    "kubernetes.io/role/internal-elb": "1",
  }
}

# "SubnetPrivateUSEAST2C": {
#   "Type": "AWS::EC2::Subnet",
#   "Properties": {
#     "AvailabilityZone": "us-east-2c",
#     "CidrBlock": "192.168.160.0/19",
#     "Tags": [
#       {
#         "Key": "kubernetes.io/role/internal-elb",
#         "Value": "1"
#       },
#       {
#         "Key": "Name",
#         "Value": {
#           "Fn::Sub": "${AWS::StackName}/SubnetPrivateUSEAST2C"
#         }
#       }
#     ],
#     "VpcId": {
#       "Ref": "VPC"
#     }
#   }
# },

resource "aws_subnet" "private-c" {
  vpc_id     = aws_vpc.sumologic-demo.id
  cidr_block = "192.168.160.0/19"
  availability_zone = "us-east-2c"

  tags = {
    "Name": "sumologic-demo/SubnetPrivateUSEAST2C",
    "kubernetes.io/role/internal-elb": "1",
  }
}

# "SubnetPublicUSEAST2A": {
#   "Type": "AWS::EC2::Subnet",
#   "Properties": {
#     "AvailabilityZone": "us-east-2a",
#     "CidrBlock": "192.168.32.0/19",
#     "MapPublicIpOnLaunch": true,
#     "Tags": [
#       {
#         "Key": "kubernetes.io/role/elb",
#         "Value": "1"
#       },
#       {
#         "Key": "Name",
#         "Value": {
#           "Fn::Sub": "${AWS::StackName}/SubnetPublicUSEAST2A"
#         }
#       }
#     ],
#     "VpcId": {
#       "Ref": "VPC"
#     }
#   }
# },

resource "aws_subnet" "public-a" {
  vpc_id     = aws_vpc.sumologic-demo.id
  cidr_block = "192.168.32.0/19"
  availability_zone = "us-east-2a"
  map_public_ip_on_launch = true

  tags = {
    "Name": "sumologic-demo/SubnetPublicUSEAST2A",
    "kubernetes.io/role/elb": "1",
  }
}

# "SubnetPublicUSEAST2B": {
#   "Type": "AWS::EC2::Subnet",
#   "Properties": {
#     "AvailabilityZone": "us-east-2b",
#     "CidrBlock": "192.168.0.0/19",
#     "MapPublicIpOnLaunch": true,
#     "Tags": [
#       {
#         "Key": "kubernetes.io/role/elb",
#         "Value": "1"
#       },
#       {
#         "Key": "Name",
#         "Value": {
#           "Fn::Sub": "${AWS::StackName}/SubnetPublicUSEAST2B"
#         }
#       }
#     ],
#     "VpcId": {
#       "Ref": "VPC"
#     }
#   }
# },

resource "aws_subnet" "public-b" {
  vpc_id     = aws_vpc.sumologic-demo.id
  cidr_block = "192.168.0.0/19"
  availability_zone = "us-east-2b"
  map_public_ip_on_launch = true

  tags = {
    "Name": "sumologic-demo/SubnetPublicUSEAST2B",
    "kubernetes.io/role/elb": "1",
  }
}

# "SubnetPublicUSEAST2C": {
#   "Type": "AWS::EC2::Subnet",
#   "Properties": {
#     "AvailabilityZone": "us-east-2c",
#     "CidrBlock": "192.168.64.0/19",
#     "MapPublicIpOnLaunch": true,
#     "Tags": [
#       {
#         "Key": "kubernetes.io/role/elb",
#         "Value": "1"
#       },
#       {
#         "Key": "Name",
#         "Value": {
#           "Fn::Sub": "${AWS::StackName}/SubnetPublicUSEAST2C"
#         }
#       }
#     ],
#     "VpcId": {
#       "Ref": "VPC"
#     }
#   }
# },

resource "aws_subnet" "public-c" {
  vpc_id     = aws_vpc.sumologic-demo.id
  cidr_block = "192.168.64.0/19"
  availability_zone = "us-east-2c"
  map_public_ip_on_launch = true

  tags = {
    "Name": "sumologic-demo/SubnetPublicUSEAST2C",
    "kubernetes.io/role/elb": "1",
  }
}

# "InternetGateway": {
#   "Type": "AWS::EC2::InternetGateway",
#   "Properties": {
#     "Tags": [
#       {
#         "Key": "Name",
#         "Value": {
#           "Fn::Sub": "${AWS::StackName}/InternetGateway"
#         }
#       }
#     ]
#   }
# },

resource "aws_internet_gateway" "sumologic-demo" {
  vpc_id = aws_vpc.sumologic-demo.id

  tags = {
    Name = "sumologic-demo/InternetGateway"
  }
}

# "ControlPlaneSecurityGroup": {
#     "Type": "AWS::EC2::SecurityGroup",
#     "Properties": {
#     "GroupDescription": "Communication between the control plane and worker nodegroups",
#     "Tags": [
#         {
#         "Key": "Name",
#         "Value": {
#             "Fn::Sub": "${AWS::StackName}/ControlPlaneSecurityGroup"
#         }
#         }
#     ],
#     "VpcId": {
#         "Ref": "VPC"
#     }
#     }
# },

resource "aws_security_group" "sumologic-demo-control-plane" {
  name        = "sumologic-demo/ControlPlaneSecurityGroup"
  description = "Communication between the control plane and worker nodegroups"
  vpc_id      = aws_vpc.sumologic-demo.id

  tags = {
    Name = "sumologic-demo/ControlPlaneSecurityGroup"
  }
}

# "ClusterSharedNodeSecurityGroup": {
#     "Type": "AWS::EC2::SecurityGroup",
#     "Properties": {
#     "GroupDescription": "Communication between all nodes in the cluster",
#     "Tags": [
#         {
#         "Key": "Name",
#         "Value": {
#             "Fn::Sub": "${AWS::StackName}/ClusterSharedNodeSecurityGroup"
#         }
#         }
#     ],
#     "VpcId": {
#         "Ref": "VPC"
#     }
#     }
# },

resource "aws_security_group" "sumologic-demo-cluster-shared" {
  name        = "sumologic-demo/ClusterSharedNodeSecurityGroup"
  description = "Communication between all nodes in the cluster"
  vpc_id      = aws_vpc.sumologic-demo.id

  tags = {
    Name = "sumologic-demo/ClusterSharedNodeSecurityGroup"
  }
}


# "NATIP": {
#     "Type": "AWS::EC2::EIP",
#     "Properties": {
#     "Domain": "vpc",
#     "Tags": [
#         {
#         "Key": "Name",
#         "Value": {
#             "Fn::Sub": "${AWS::StackName}/NATIP"
#         }
#         }
#     ]
#     }
# },

resource "aws_eip" "sumologic-demo" {
  vpc      = true

  tags = {
    "Name": "sumologic-demo/NATIP"
  }
}

# "NATGateway": {
#     "Type": "AWS::EC2::NatGateway",
#     "Properties": {
#     "AllocationId": {
#         "Fn::GetAtt": [
#         "NATIP",
#         "AllocationId"
#         ]
#     },
#     "SubnetId": {
#         "Ref": "SubnetPublicUSEAST2B"
#     },
#     "Tags": [
#         {
#         "Key": "Name",
#         "Value": {
#             "Fn::Sub": "${AWS::StackName}/NATGateway"
#         }
#         }
#     ]
#     }
# },

resource "aws_nat_gateway" "sumologic-demo" {
  allocation_id = aws_eip.sumologic-demo.id
  subnet_id     = aws_subnet.public-b.id

  tags = {
    Name = "sumologic-demo/NATGateway"
  }
}

# "PrivateRouteTableUSEAST2A": {
#     "Type": "AWS::EC2::RouteTable",
#     "Properties": {
#     "Tags": [
#         {
#         "Key": "Name",
#         "Value": {
#             "Fn::Sub": "${AWS::StackName}/PrivateRouteTableUSEAST2A"
#         }
#         }
#     ],
#     "VpcId": {
#         "Ref": "VPC"
#     }
#     }
# },

resource "aws_route_table" "private-a" {
  vpc_id = aws_vpc.sumologic-demo.id

  tags = {
    Name = "sumologic-demo/PrivateRouteTableUSEAST2A"
  }
}

# "PrivateRouteTableUSEAST2B": {
#   "Type": "AWS::EC2::RouteTable",
#   "Properties": {
#     "Tags": [
#       {
#         "Key": "Name",
#         "Value": {
#           "Fn::Sub": "${AWS::StackName}/PrivateRouteTableUSEAST2B"
#         }
#       }
#     ],
#     "VpcId": {
#       "Ref": "VPC"
#     }
#   }
# },

resource "aws_route_table" "private-b" {
  vpc_id = aws_vpc.sumologic-demo.id

  tags = {
    Name = "sumologic-demo/PrivateRouteTableUSEAST2B"
  }
}

# "PrivateRouteTableUSEAST2C": {
#   "Type": "AWS::EC2::RouteTable",
#   "Properties": {
#     "Tags": [
#       {
#         "Key": "Name",
#         "Value": {
#           "Fn::Sub": "${AWS::StackName}/PrivateRouteTableUSEAST2C"
#         }
#       }
#     ],
#     "VpcId": {
#       "Ref": "VPC"
#     }
#   }
# },

resource "aws_route_table" "private-c" {
  vpc_id = aws_vpc.sumologic-demo.id

  tags = {
    Name = "sumologic-demo/PrivateRouteTableUSEAST2C"
  }
}

# "PublicRouteTable": {
#     "Type": "AWS::EC2::RouteTable",
#     "Properties": {
#     "Tags": [
#         {
#         "Key": "Name",
#         "Value": {
#             "Fn::Sub": "${AWS::StackName}/PublicRouteTable"
#         }
#         }
#     ],
#     "VpcId": {
#         "Ref": "VPC"
#     }
#     }
# },

resource "aws_route_table" "sumologic-demo" {
  vpc_id = aws_vpc.sumologic-demo.id

  tags = {
    Name = "sumologic-demo/PublicRouteTable"
  }
}

# "NATPrivateSubnetRouteUSEAST2A": {
#   "Type": "AWS::EC2::Route",
#   "Properties": {
#     "DestinationCidrBlock": "0.0.0.0/0",
#     "NatGatewayId": {
#       "Ref": "NATGateway"
#     },
#     "RouteTableId": {
#       "Ref": "PrivateRouteTableUSEAST2A"
#     }
#   }
# },

resource "aws_route" "private-a" {
  route_table_id            = aws_route_table.private-a.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = aws_nat_gateway.sumologic-demo.id
}

# "NATPrivateSubnetRouteUSEAST2B": {
#   "Type": "AWS::EC2::Route",
#   "Properties": {
#     "DestinationCidrBlock": "0.0.0.0/0",
#     "NatGatewayId": {
#       "Ref": "NATGateway"
#     },
#     "RouteTableId": {
#       "Ref": "PrivateRouteTableUSEAST2B"
#     }
#   }
# },

resource "aws_route" "private-b" {
  route_table_id            = aws_route_table.private-b.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = aws_nat_gateway.sumologic-demo.id
}

# "NATPrivateSubnetRouteUSEAST2C": {
#   "Type": "AWS::EC2::Route",
#   "Properties": {
#     "DestinationCidrBlock": "0.0.0.0/0",
#     "NatGatewayId": {
#       "Ref": "NATGateway"
#     },
#     "RouteTableId": {
#       "Ref": "PrivateRouteTableUSEAST2C"
#     }
#   }
# },

resource "aws_route" "private-c" {
  route_table_id            = aws_route_table.private-c.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = aws_nat_gateway.sumologic-demo.id
}

# "PublicSubnetRoute": {
#   "Type": "AWS::EC2::Route",
#   "Properties": {
#     "DestinationCidrBlock": "0.0.0.0/0",
#     "GatewayId": {
#       "Ref": "InternetGateway"
#     },
#     "RouteTableId": {
#       "Ref": "PublicRouteTable"
#     }
#   },
#   "DependsOn": [
#     "VPCGatewayAttachment"
#   ]
# },

resource "aws_route" "public-c" {
  route_table_id            = aws_route_table.sumologic-demo.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.sumologic-demo.id
}

# "RouteTableAssociationPrivateUSEAST2A": {
#   "Type": "AWS::EC2::SubnetRouteTableAssociation",
#   "Properties": {
#     "RouteTableId": {
#       "Ref": "PrivateRouteTableUSEAST2A"
#     },
#     "SubnetId": {
#       "Ref": "SubnetPrivateUSEAST2A"
#     }
#   }
# },

resource "aws_route_table_association" "private-a" {
  subnet_id      = aws_subnet.private-a.id
  route_table_id = aws_route_table.private-a.id
}

# "RouteTableAssociationPrivateUSEAST2B": {
#   "Type": "AWS::EC2::SubnetRouteTableAssociation",
#   "Properties": {
#     "RouteTableId": {
#       "Ref": "PrivateRouteTableUSEAST2B"
#     },
#     "SubnetId": {
#       "Ref": "SubnetPrivateUSEAST2B"
#     }
#   }
# },

resource "aws_route_table_association" "private-b" {
  subnet_id      = aws_subnet.private-b.id
  route_table_id = aws_route_table.private-b.id
}

# "RouteTableAssociationPrivateUSEAST2C": {
#   "Type": "AWS::EC2::SubnetRouteTableAssociation",
#   "Properties": {
#     "RouteTableId": {
#       "Ref": "PrivateRouteTableUSEAST2C"
#     },
#     "SubnetId": {
#       "Ref": "SubnetPrivateUSEAST2C"
#     }
#   }
# },

resource "aws_route_table_association" "private-c" {
  subnet_id      = aws_subnet.private-c.id
  route_table_id = aws_route_table.private-c.id
}

# "RouteTableAssociationPublicUSEAST2A": {
#   "Type": "AWS::EC2::SubnetRouteTableAssociation",
#   "Properties": {
#     "RouteTableId": {
#       "Ref": "PublicRouteTable"
#     },
#     "SubnetId": {
#       "Ref": "SubnetPublicUSEAST2A"
#     }
#   }
# },

resource "aws_route_table_association" "public-a" {
  subnet_id      = aws_subnet.public-a.id
  route_table_id = aws_route_table.sumologic-demo.id
}

# "RouteTableAssociationPublicUSEAST2B": {
#   "Type": "AWS::EC2::SubnetRouteTableAssociation",
#   "Properties": {
#     "RouteTableId": {
#       "Ref": "PublicRouteTable"
#     },
#     "SubnetId": {
#       "Ref": "SubnetPublicUSEAST2B"
#     }
#   }
# },

resource "aws_route_table_association" "public-b" {
  subnet_id      = aws_subnet.public-b.id
  route_table_id = aws_route_table.sumologic-demo.id
}

# "RouteTableAssociationPublicUSEAST2C": {
#   "Type": "AWS::EC2::SubnetRouteTableAssociation",
#   "Properties": {
#     "RouteTableId": {
#       "Ref": "PublicRouteTable"
#     },
#     "SubnetId": {
#       "Ref": "SubnetPublicUSEAST2C"
#     }
#   }
# },

resource "aws_route_table_association" "public-c" {
  subnet_id      = aws_subnet.public-c.id
  route_table_id = aws_route_table.sumologic-demo.id
}

# "ServiceRole": {
#   "Type": "AWS::IAM::Role",
#   "Properties": {
#     "AssumeRolePolicyDocument": {
#       "Statement": [
#         {
#           "Action": [
#             "sts:AssumeRole"
#           ],
#           "Effect": "Allow",
#           "Principal": {
#             "Service": [
#               {
#                 "Fn::FindInMap": [
#                   "ServicePrincipalPartitionMap",
#                   {
#                     "Ref": "AWS::Partition"
#                   },
#                   "EKS"
#                 ]
#               }
#             ]
#           }
#         }
#       ],
#       "Version": "2012-10-17"
#     },
#     "ManagedPolicyArns": [
#       {
#         "Fn::Sub": "arn:${AWS::Partition}:iam::aws:policy/AmazonEKSClusterPolicy"
#       },
#       {
#         "Fn::Sub": "arn:${AWS::Partition}:iam::aws:policy/AmazonEKSVPCResourceController"
#       }
#     ],
#     "Tags": [
#       {
#         "Key": "Name",
#         "Value": {
#           "Fn::Sub": "${AWS::StackName}/ServiceRole"
#         }
#       }
#     ]
#   }
# },

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

  tags = {
    "Name": "sumologic-demo/ServiceRole"
  }

  managed_policy_arns = [
    "arn:aws:iam::aws:policy/AmazonEKSClusterPolicy",
    "arn:aws:iam::aws:policy/AmazonEKSVPCResourceController",
    aws_iam_policy.sumologic-demo-cloudwatch.arn,
    aws_iam_policy.sumologic-demo-elb.arn,
    ]
}

# "FargatePodExecutionRole": {
#   "Type": "AWS::IAM::Role",
#   "Properties": {
#     "AssumeRolePolicyDocument": {
#       "Statement": [
#         {
#           "Action": [
#             "sts:AssumeRole"
#           ],
#           "Effect": "Allow",
#           "Principal": {
#             "Service": [
#               {
#                 "Fn::FindInMap": [
#                   "ServicePrincipalPartitionMap",
#                   {
#                     "Ref": "AWS::Partition"
#                   },
#                   "EKSFargatePods"
#                 ]
#               }
#             ]
#           }
#         }
#       ],
#       "Version": "2012-10-17"
#     },
#     "ManagedPolicyArns": [
#       {
#         "Fn::Sub": "arn:${AWS::Partition}:iam::aws:policy/AmazonEKSFargatePodExecutionRolePolicy"
#       }
#     ],
#     "Tags": [
#       {
#         "Key": "Name",
#         "Value": {
#           "Fn::Sub": "${AWS::StackName}/FargatePodExecutionRole"
#         }
#       }
#     ]
#   }
# },


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

  tags = {
    "Name": "sumologic-demo/FargatePodExecutionRole"
  }

  managed_policy_arns = [
    aws_iam_policy.cloudwatch.arn,
    ]
}

# "PolicyELBPermissions": {
#   "Type": "AWS::IAM::Policy",
#   "Properties": {
#     "PolicyDocument": {
#       "Statement": [
#         {
#           "Action": [
#             "ec2:DescribeAccountAttributes",
#             "ec2:DescribeAddresses",
#             "ec2:DescribeInternetGateways"
#           ],
#           "Effect": "Allow",
#           "Resource": "*"
#         }
#       ],
#       "Version": "2012-10-17"
#     },
#     "PolicyName": {
#       "Fn::Sub": "${AWS::StackName}-PolicyELBPermissions"
#     },
#     "Roles": [
#       {
#         "Ref": "ServiceRole"
#       }
#     ]
#   }
# },

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

# "PolicyCloudWatchMetrics": {
#   "Type": "AWS::IAM::Policy",
#   "Properties": {
#     "PolicyDocument": {
#       "Statement": [
#         {
#           "Action": [
#             "cloudwatch:PutMetricData"
#           ],
#           "Effect": "Allow",
#           "Resource": "*"
#         }
#       ],
#       "Version": "2012-10-17"
#     },
#     "PolicyName": {
#       "Fn::Sub": "${AWS::StackName}-PolicyCloudWatchMetrics"
#     },
#     "Roles": [
#       {
#         "Ref": "ServiceRole"
#       }
#     ]
#   }
# },

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


# "VPCGatewayAttachment": {
#   "Type": "AWS::EC2::VPCGatewayAttachment",
#   "Properties": {
#     "InternetGatewayId": {
#       "Ref": "InternetGateway"
#     },
#     "VpcId": {
#       "Ref": "VPC"
#     }
#   }
# }

# resource "aws_internet_gateway_attachment" "sumologic-demo" {
#   internet_gateway_id = aws_internet_gateway.sumologic-demo.id
#   vpc_id              = aws_vpc.sumologic-demo.id
# }

# "IngressNodeToDefaultClusterSG": {
#   "Type": "AWS::EC2::SecurityGroupIngress",
#   "Properties": {
#     "Description": "Allow unmanaged nodes to communicate with control plane (all ports)",
#     "FromPort": 0,
#     "GroupId": {
#       "Fn::GetAtt": [
#         "ControlPlane",
#         "ClusterSecurityGroupId"
#       ]
#     },
#     "IpProtocol": "-1",
#     "SourceSecurityGroupId": {
#       "Ref": "ClusterSharedNodeSecurityGroup"
#     },
#     "ToPort": 65535
#   }
# }

# resource "aws_vpc_security_group_ingress_rule" "sumologic-demo-node-to-cluster-1" {
#   referenced_security_group_id = aws_security_group.sumologic-demo-cluster-shared.id
#   security_group_id = aws_security_group.sumologic-demo-cluster-shared.id
  
#   from_port   = 0
#   ip_protocol = "-1"
#   to_port     = 65535
# }

resource "aws_vpc_security_group_ingress_rule" "sumologic-demo-node-to-cluster" {
  referenced_security_group_id = aws_security_group.sumologic-demo-control-plane.id
  security_group_id = aws_security_group.sumologic-demo-cluster-shared.id
  
  # from_port   = 0
  ip_protocol = "-1"
  # to_port     = 65535
}


# "IngressInterNodeGroupSG": {
#   "Type": "AWS::EC2::SecurityGroupIngress",
#   "Properties": {
#     "Description": "Allow nodes to communicate with each other (all ports)",
#     "FromPort": 0,
#     "GroupId": {
#       "Ref": "ClusterSharedNodeSecurityGroup"
#     },
#     "IpProtocol": "-1",
#     "SourceSecurityGroupId": {
#       "Ref": "ClusterSharedNodeSecurityGroup"
#     },
#     "ToPort": 65535
#   }
# }

resource "aws_vpc_security_group_ingress_rule" "sumologic-demo-inter-node-group" {
  referenced_security_group_id = aws_security_group.sumologic-demo-cluster-shared.id
  security_group_id = aws_security_group.sumologic-demo-cluster-shared.id

  # from_port   = 0
  ip_protocol = "-1"
  # to_port     = 65535
}


# "IngressDefaultClusterToNodeSG": {
#   "Type": "AWS::EC2::SecurityGroupIngress",
#   "Properties": {
#     "Description": "Allow managed and unmanaged nodes to communicate with each other (all ports)",
#     "FromPort": 0,
#     "GroupId": {
#       "Ref": "ClusterSharedNodeSecurityGroup"
#     },
#     "IpProtocol": "-1",
#     "SourceSecurityGroupId": {
#       "Fn::GetAtt": [
#         "ControlPlane",
#         "ClusterSecurityGroupId"
#       ]
#     },
#     "ToPort": 65535
#   }
# }

# resource "aws_vpc_security_group_ingress_rule" "sumologic-demo-default-cluster-to-node-1" {
#   referenced_security_group_id = aws_security_group.sumologic-demo-cluster-shared.id
#   security_group_id = aws_security_group.sumologic-demo-cluster-shared.id

#   from_port   = 0
#   ip_protocol = "-1"
#   to_port     = 65535
# }

resource "aws_vpc_security_group_ingress_rule" "sumologic-demo-default-cluster-to-node" {
  referenced_security_group_id = aws_security_group.sumologic-demo-cluster-shared.id
  security_group_id = aws_security_group.sumologic-demo-control-plane.id

  # from_port   = 0
  ip_protocol = "-1"
  # to_port     = 65535
}

# "ControlPlane": {
#   "Type": "AWS::EKS::Cluster",
#   "Properties": {
#     "KubernetesNetworkConfig": {},
#     "Logging": {
#       "ClusterLogging": {
#         "EnabledTypes": [
#           {
#             "Type": "api"
#           },
#           {
#             "Type": "audit"
#           },
#           {
#             "Type": "authenticator"
#           },
#           {
#             "Type": "controllerManager"
#           },
#           {
#             "Type": "scheduler"
#           }
#         ]
#       }
#     },
#     "Name": "sumologic-demo",
#     "ResourcesVpcConfig": {
#       "EndpointPrivateAccess": false,
#       "EndpointPublicAccess": true,
#       "SecurityGroupIds": [
#         {
#           "Ref": "ControlPlaneSecurityGroup"
#         }
#       ],
#       "SubnetIds": [
#         {
#           "Ref": "SubnetPublicUSEAST2B"
#         },
#         {
#           "Ref": "SubnetPublicUSEAST2A"
#         },
#         {
#           "Ref": "SubnetPublicUSEAST2C"
#         },
#         {
#           "Ref": "SubnetPrivateUSEAST2C"
#         },
#         {
#           "Ref": "SubnetPrivateUSEAST2B"
#         },
#         {
#           "Ref": "SubnetPrivateUSEAST2A"
#         }
#       ]
#     },
#     "RoleArn": {
#       "Fn::GetAtt": [
#         "ServiceRole",
#         "Arn"
#       ]
#     },
#     "Tags": [
#       {
#         "Key": "Name",
#         "Value": {
#           "Fn::Sub": "${AWS::StackName}/ControlPlane"
#         }
#       }
#     ],
#     "Version": "1.24"
#   }
# }

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
