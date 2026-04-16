resource "aws_instance" "one" {
tags = {
Name = "IAC-SERVER"
}
ami = "ami-0e12ffc2dd465f6e4"
instance_type "t3.micro" 
count = 1
provisioner "local-exec" {
command = "echo 'Instance id is: ${aws_instance.one[0].id}' >> my-instance.txt"

#Here if we count definitely we need to give count.index as well, so given after labelname []
}
}
