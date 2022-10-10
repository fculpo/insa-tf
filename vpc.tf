resource "aws_vpc" "this" {
  cidr_block = local.vpc.cidr
}

resource "aws_subnet" "private" {
  for_each = local.vpc.private_subnets

  vpc_id = aws_vpc.this.id
  availability_zone = each.key
  cidr_block = each.value.cidr
  map_public_ip_on_launch = false 

  tags = {
    "Name" = "sub-priv-${each.key}"
  }
}

resource "aws_subnet" "public" {
  for_each = local.vpc.public_subnets

  vpc_id = aws_vpc.this.id
  availability_zone = each.key
  cidr_block = each.value.cidr
  map_public_ip_on_launch = true

   tags = {
    "Name" = "sub-pub-${each.key}"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.this.id
  tags = {
    "Name" = "rtb-private"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route  {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    "Name" = "rtb-public"
  }
}

resource "aws_route_table_association" "private" {
  for_each = aws_subnet.private

  subnet_id      = each.value.id
  route_table_id = aws_route_table.private.id
}

resource "aws_route_table_association" "public" {
  for_each = aws_subnet.public

  subnet_id      = each.value.id
  route_table_id = aws_route_table.public.id
}