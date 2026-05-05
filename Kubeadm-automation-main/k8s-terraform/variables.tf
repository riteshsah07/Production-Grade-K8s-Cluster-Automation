variable "key_name" {
  description = "EC2 key pair name"
  default     = "kubpair2"
  # 🔴 CHANGE: must be an existing EC2 key pair name
}

variable "instance_type" {
  default = "t3.medium"
  # ✅ OK for Kubernetes lab
}

variable "worker_count" {
  default = 1
  # 🔴 CHANGE if you want more or fewer worker nodes
}
