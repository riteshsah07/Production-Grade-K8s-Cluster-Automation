#!/bin/bash
set -e

# Note: common.sh content will be prepended by Terraform

# -------- INIT ONLY IF NOT EXISTS --------
if [ ! -f /etc/kubernetes/admin.conf ]; then
  # Initialize Kubernetes Master
  # Using --ignore-preflight-errors=NumCPU to allow running on smaller instances if needed
  kubeadm init --pod-network-cidr=10.244.0.0/16 --ignore-preflight-errors=NumCPU
else
  echo "Kubernetes already initialized"
fi

# kubeconfig setup for ubuntu user
USER_HOME="/home/ubuntu"
mkdir -p $USER_HOME/.kube
cp -f /etc/kubernetes/admin.conf $USER_HOME/.kube/config
chown ubuntu:ubuntu $USER_HOME/.kube/config

# Persist kubeconfig in .bashrc
grep -qxF 'export KUBECONFIG=$HOME/.kube/config' $USER_HOME/.bashrc || \
echo 'export KUBECONFIG=$HOME/.kube/config' >> $USER_HOME/.bashrc

export KUBECONFIG=$USER_HOME/.kube/config

# -------- CNI SAFE INSTALL (Flannel) --------
# Wait for API server to be ready
echo "Waiting for API server to be ready..."
until kubectl get nodes >/dev/null 2>&1; do
  sleep 5
done

if ! kubectl get daemonset kube-flannel-ds -n kube-system >/dev/null 2>&1; then
  echo "Installing Flannel CNI..."
  kubectl apply -f https://raw.githubusercontent.com/coreos/flannel/master/Documentation/kube-flannel.yml
else
  echo "Flannel already installed"
fi

# Allow scheduling on master (optional, good for small labs)
kubectl taint nodes --all node-role.kubernetes.io/control-plane- || true

# Generate Join command
kubeadm token create --print-join-command > /home/ubuntu/join.sh
chmod +x /home/ubuntu/join.sh
echo "Join command saved to /home/ubuntu/join.sh"
