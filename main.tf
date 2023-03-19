resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = merge(var.tags, { Name = "${var.env}-vpc" }) 
 
}

#Public subnets
resource "aws_subnet" "public_subnet" {
  vpc_id            = aws_vpc.main.id
  tags = merge(
    var.tags,
    { Name = "${var.env}-${each.value["name"]}" }
  )
 
  for_each          = var.public_subnets
  cidr_block        = each.value["cidr_block"]
  availability_zone = each.value["availability_zone"]
  
#Private subnets

resource "aws_subnet" "private_subnet" {
  vpc_id            = aws_vpc.main.id
  tags = merge(
    var.tags,
    { Name = "${var.env}-${each.value["name"]}" }
  )
 
  for_each          = var.private_subnets
  cidr_block        = each.value["cidr_block"]
  availability_zone = each.value["availability_zone"]
  


}







