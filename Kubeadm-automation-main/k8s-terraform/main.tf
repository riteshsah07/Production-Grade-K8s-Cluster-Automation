# -----------------------------
# SECURITY GROUP
# -----------------------------
resource "aws_security_group" "k8s_sg" {
  name        = "k8s-cluster-sg"
  description = "Kubernetes cluster security group"

  # 🔴 LAB ONLY: Allows ALL TCP ports from anywhere
  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    description = "All TCP inbound (LAB ONLY)"
  }

  # SSH access
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    # 🔴 OPTIONAL: restrict to your IP for safety
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "k8s-sg"
  }
}

# -----------------------------
# MASTER NODE
# -----------------------------
resource "aws_instance" "master" {
  ami           = "ami-087d1c9a513324697"
  # 🔴 CHANGE: Ubuntu 22.04 AMI for YOUR REGION

  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.k8s_sg.id]

  # Combine common setup and master-specific setup
  user_data = join("\n", [
    file("${path.module}/scripts/common.sh"),
    file("${path.module}/scripts/control-plane.sh")
  ])

  tags = {
    Name = "k8s-master"
  }
}

# -----------------------------
# WORKER NODES
# -----------------------------
resource "aws_instance" "workers" {
  count         = var.worker_count
  ami           = "ami-087d1c9a513324697"
  # 🔴 SAME AMI as master (Ubuntu 22.04)

  instance_type = var.instance_type
  key_name      = var.key_name

  vpc_security_group_ids = [aws_security_group.k8s_sg.id]

  # Combine common setup and worker-specific setup
  user_data = join("\n", [
    file("${path.module}/scripts/common.sh"),
    file("${path.module}/scripts/worker.sh")
  ])

  tags = {
    Name = "k8s-worker-${count.index}"
  }
}