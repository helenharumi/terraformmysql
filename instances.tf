resource "aws_instance" "instance_mysql" {
    count = 1
    ami = "ami-00ddb0e5626798373"
    instance_type = "t2.micro"
    subnet_id = element (aws_subnet.public_subnet.*.id,count.index)
    vpc_security_group_ids = [aws_security_group.allow_ssh.id,
                              aws_security_group.allow_outbound.id,
                              aws_security_group.allow_mysql.id]

    tags = {
        Name = "instance_mysql_impacta"
    }

    user_data = templatefile("${path.module}/user_data/install_mysql.tpl", {})
}

output "public_ips" {
    value = join(",", aws_instance.instance_mysql.*.public_ip)
}