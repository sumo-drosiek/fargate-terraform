resource "aws_vpc" "sumologic-demo" {
  cidr_block           = var.aws_cidr_block
  enable_dns_hostnames = true
  enable_dns_support   = true

}

resource "aws_internet_gateway" "sumologic-demo" {
  vpc_id = aws_vpc.sumologic-demo.id
}

resource "aws_subnet" "private" {
  for_each = var.aws_availability_zones

  vpc_id            = aws_vpc.sumologic-demo.id
  cidr_block        = each.value[1]
  availability_zone = each.key

  tags = {
    "kubernetes.io/role/internal-elb": "1",
  }
}

resource "aws_subnet" "public" {
  for_each = var.aws_availability_zones

  vpc_id     = aws_vpc.sumologic-demo.id
  cidr_block = each.value[0]
  availability_zone = each.key

  tags = {
    "kubernetes.io/role/elb": "1",
  }
}

resource "aws_eip" "sumologic-demo" {
  vpc      = true
}

resource "aws_nat_gateway" "sumologic-demo" {
  allocation_id = aws_eip.sumologic-demo.id
  subnet_id     = aws_subnet.public["us-east-2a"].id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.sumologic-demo.id
}

resource "aws_route_table" "sumologic-demo" {
  vpc_id = aws_vpc.sumologic-demo.id
}

resource "aws_route" "private" {
  route_table_id            = aws_route_table.private.id
  destination_cidr_block    = "0.0.0.0/0"
  nat_gateway_id            = aws_nat_gateway.sumologic-demo.id
}

resource "aws_route" "public-c" {
  route_table_id            = aws_route_table.sumologic-demo.id
  destination_cidr_block    = "0.0.0.0/0"
  gateway_id                = aws_internet_gateway.sumologic-demo.id
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = aws_subnet.public[each.key].id
  route_table_id = aws_route_table.sumologic-demo.id
}
