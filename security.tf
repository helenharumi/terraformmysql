resource "aws_security_group" "allow_ssh" {
    vpc_id =  aws_vpc.main.id
    name = "allow_ssh"
    
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "allow_outbound" {
    vpc_id = aws_vpc.main.id
    name = "allow_outbound"

    egress {
        from_port  = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}

resource "aws_security_group" "allow_mysql" {
    vpc_id =  aws_vpc.main.id
    name = "allow_mysql"
    
    ingress {
        from_port = 3306
        to_port = 3306
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
}