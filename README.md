# Production-Grade Kubernetes Cluster Automation using Terraform & Kubeadm
Overview

This project demonstrates the end-to-end automation of a Kubernetes cluster on AWS using Infrastructure as Code and bootstrap scripting. It provisions cloud infrastructure using Terraform and configures a fully functional Kubernetes cluster using kubeadm.

The goal is to create a repeatable, scalable, and production-aligned setup without relying on managed Kubernetes services like EKS.

Architecture

The system provisions and configures the following components:

AWS EC2 instances for:
Kubernetes Control Plane (Master Node)
Worker Nodes
VPC and networking configuration
Security Groups for controlled access
SSH key-based authentication
Kubernetes cluster initialized using kubeadm
Container runtime using containerd
Pod networking via Flannel CNI
Workflow
Terraform provisions AWS infrastructure (EC2, Security Groups, Networking)
EC2 instances are initialized using user data scripts
Master node initializes Kubernetes using kubeadm
Worker nodes are configured with required dependencies
Join token is generated on master node
Worker nodes join the cluster using the token
Flannel CNI is deployed for pod networking
Cluster becomes ready for workload deployment
Tech Stack
Terraform (Infrastructure as Code)
AWS EC2, VPC, Security Groups
Kubernetes (kubeadm)
containerd (Container Runtime)
Flannel (CNI Plugin)
Bash scripting (bootstrap automation)
Features
Fully automated infrastructure provisioning
Kubernetes cluster bootstrapped without managed services
Idempotent setup scripts using Terraform user_data
Dynamic worker node join using kubeadm token
Secure SSH access using key pairs
Scalable architecture for adding more worker nodes
Production-aligned setup using containerd and CNI networking
Prerequisites

Before running this project, ensure you have:

AWS Account with sufficient permissions
Terraform installed (>= 1.x)
AWS CLI configured (aws configure)
SSH key pair created in AWS
Basic understanding of Kubernetes and Terraform
Project Structure
k8s-terraform/
│── main.tf
│── variables.tf
│── outputs.tf
│── provider.tf
│── terraform.tfvars
│── scripts/
│   ├── master.sh
│   ├── worker.sh
Setup Instructions
1. Clone Repository
git clone https://github.com/your-username/Production-Grade-K8s-Cluster-Automation.git
cd Production-Grade-K8s-Cluster-Automation/k8s-terraform
2. Initialize Terraform
terraform init
3. Validate Configuration
terraform validate
terraform plan
4. Deploy Infrastructure
terraform apply -auto-approve

After successful deployment, Terraform will output:

Master Public IP
Worker Node Public IP(s)
5. SSH into Master Node
ssh -i "path/to/your-key.pem" ubuntu@<master_public_ip>
6. Verify Cluster
kubectl get nodes
kubectl get pods -A
7. Join Worker Nodes

On master:

cat /home/ubuntu/join.sh

On worker node:

sudo <paste-join-command>
Troubleshooting
AMI Not Found Error

Ensure the AMI ID matches your selected AWS region.

SSH Connection Timeout
Verify Security Group allows inbound port 22
Check instance public IP
Ensure instance is in running state
Permission Denied (SSH)
Verify correct key pair is used
Ensure proper permissions on .pem file
Node Not Ready
Check if CNI plugin is installed
Verify container runtime is running
Security Considerations
Restrict SSH access to trusted IP ranges
Avoid using 0.0.0.0/0 in production
Rotate key pairs periodically
Use IAM roles instead of hardcoded credentials
Future Enhancements
Integrate Cluster Autoscaler
Add Horizontal Pod Autoscaler (HPA)
Use Helm for application deployment
Add CI/CD pipeline using Jenkins or GitHub Actions
Integrate monitoring (Prometheus + Grafana)
Replace Flannel with production-grade CNI (Calico/Cilium)
Key Learnings
Infrastructure provisioning using Terraform
Kubernetes cluster lifecycle using kubeadm
Debugging real-world issues (AMI mismatch, security groups, SSH)
Writing idempotent automation scripts
Understanding cluster networking and node communication
Conclusion

This project reflects a real-world DevOps workflow where infrastructure and application orchestration are tightly integrated. It demonstrates the ability to build scalable, automated systems aligned with production practices.

Author

Ritesh Sah
Open to opportunities in Cloud Engineering, DevOps, and Kubernetes-based roles

<img width="1600" height="852" alt="WhatsApp Image 2026-05-06 at 1 14 08 AM" src="https://github.com/user-attachments/assets/27a9fdef-f5ed-495d-8662-286fece212df" />

<img width="1600" height="854" alt="WhatsApp Image 2026-05-06 at 1 14 08 AM" src="https://github.com/user-attachments/assets/5102c5d4-8e91-42bc-82ed-c1c291771b73" />
<img width="1600" height="855" alt="WhatsApp Image 2026-05-06 at 1 14 09 AM (1)" src="https://github.com/user-attachments/assets/b846757a-96ce-4bc2-9d6f-777fac272df4" />
<img width="1600" height="842" alt="WhatsApp Image 2026-05-06 at 1 14 09 AM (2)" src="https://github.com/user-attachments/assets/92964a43-17bd-4b13-912a-bc3fc3d60680" />
<img width="1600" height="845" alt="WhatsApp Image 2026-05-06 at 1 14 10 AM (1)" src="https://github.com/user-attachments/assets/77563d72-4f20-4d11-b2c2-ad37b3216de1" />
<img width="1600" height="847" alt="WhatsApp Image 2026-05-06 at 1 14 10 AM (2)" src="https://github.com/user-attachments/assets/02364866-3d65-4a6e-8340-cd7c4c9fa68f" />
<img width="1600" height="849" alt="WhatsApp Image 2026-05-06 at 1 14 10 AM" src="https://github.com/user-attachments/assets/410d880a-540d-4453-a8f1-28c038132855" />
<img width="1600" height="852" alt="WhatsApp Image 2026-05-06 at 1 14 11 AM" src="https://github.com/user-attachments/assets/bf38baaf-7b2a-4329-8b03-d8d4de4f18c3" />

<img width="1536" height="1024" alt="ChatGPT Image May 6, 2026, 01_15_22 AM" src="https://github.com/user-attachments/assets/e9caa62e-803a-4b8d-8676-a01e2163d082" />
<img width="1600" height="855" alt="WhatsApp Image 2026-05-06 at 1 14 11 AM (1)" src="https://github.com/user-attachments/assets/fab633c3-b170-4f01-93f4-6e3945aa7fe0" />
<img width="1600" height="855" alt="WhatsApp Image 2026-05-06 at 1 14 11 AM (2)" src="https://github.com/user-attachments/assets/5eaca1d9-858d-45f2-900e-e1077cface9c" />
