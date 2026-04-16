resource "aws_key_pair" "mykp" {
key_name = "sumanth-kp"
public_key = file("/root/.ssh/id_rsa.pub")   #create a new key-pair with command: ssh-keygen and copy the public_kp here
}

resource "aws_instance" "one" {
tags = {
Name = "IAC-SERVER"
}
ami = "ami-0e12ffc2dd465f6e4"
instance_type="t3.micro"
count = 1
key_name = aws_key_pair.mykp.key_name   #Attaching KEY-PAIR to the instance
provisioner "remote-exec" {
connection {
  type = "ssh" 
  user = "ec2-user" 
  private_key = file("/root/.ssh/id_rsa")    #Connecting public_key with private key for connection
  host = self.public_ip                      # with local-terraform server we are connecting with key-pair with SSH connection
  }
  source = "my-instance.txt"
  destination = "my-instance.txt"
}
}

#NOTE: While applying the changes for this infra it will have default SG so connection won't happen by default, 
#for this add all-traffic and SSH to the default-SG IN-BOUND RULES and save it. It will work properly.
