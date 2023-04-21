

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