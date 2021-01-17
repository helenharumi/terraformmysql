resource "aws_vpc" "main" {
    cidr_block = "192.168.0.0/16"

    tags = {
        Name = "impacta"
    }
}

resource "aws_subnet" "private_subnet" {
    count = 1
    vpc_id = aws_vpc.main.id
    cidr_block = cidrsubnet(aws_vpc.main.cidr_block,8,count.index+10)

    availability_zone = var.availability_zones[count.index]

    tags = {
        Name = "private_subnet_impacta_${count.index}"
    }
}

resource "aws_subnet" "public_subnet" {
    count = 1
    vpc_id = aws_vpc.main.id
    cidr_block = cidrsubnet(aws_vpc.main.cidr_block,8,count.index+20)

    availability_zone = var.availability_zones[count.index]
    map_public_ip_on_launch = true

    tags = {
        Name = "public_subnet_impacta_${count.index}"
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.main.id

    tags = {
        Name = "igw_impacta"
    }
}

resource "aws_route_table" "route" {
    vpc_id = aws_vpc.main.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.igw.id
    }

    tags = {
        Name = "route_impacta"
    }
}

resource "aws_route_table_association" "route_association" {
    count = 1
    route_table_id = aws_route_table.route.id
    subnet_id = element (aws_subnet.public_subnet.*.id,count.index)
}