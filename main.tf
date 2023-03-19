resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags       = merge(var.tags, { Name = "${var.env}-vpc" })

}

#Public subnets
resource "aws_subnet" "public_subnet" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.tags,
    { Name = "${var.env}-${each.value["name"]}" }
  )

  for_each          = var.public_subnets
  cidr_block        = each.value["cidr_block"]
  availability_zone = each.value["availability_zone"]
}

# public route table
resource "aws_route_table" "public-route-table" {
  vpc_id = aws_vpc.main.id

  for_each = var.public_subnets
  tags = merge(
    var.tags,
    { Name = "${var.env}-${each.value["name"]}" }
  )

}
#Private subnets

resource "aws_subnet" "private_subnet" {
  vpc_id = aws_vpc.main.id
  tags = merge(
    var.tags,
    { Name = "${var.env}-${each.value["name"]}" }
  )

  for_each          = var.private_subnets
  cidr_block        = each.value["cidr_block"]
  availability_zone = each.value["availability_zone"]
}


# private route table
resource "aws_route_table" "private-route-table" {
  vpc_id = aws_vpc.main.id

  for_each = var.private_subnets
  tags = merge(
    var.tags,
    { Name = "${var.env}-${each.value["name"]}" }
  )

}






