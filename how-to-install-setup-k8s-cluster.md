Installing a container runtime 

>> Docker Engine
# ++++++++++++++++++++++++++
# Step 1: Install Docker Engine
- Pick Ubuntu
- Install using the Apt repository
# 1. Set up Docker's Apt repository.
# Add Docker's official GPG key:
sudo apt-get update
sudo apt-get install ca-certificates curl gnupg
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg

# Add the repository to Apt sources:
echo \
  "deb [arch="$(dpkg --print-architecture)" signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  "$(. /etc/os-release && echo "$VERSION_CODENAME")" stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt-get update

# 2. Install the Docker packages.
sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# 3. Verify that the Docker Engine installation is successful by running the hello-world image.

sudo docker run hello-world


# ++++++++++++++++++++++++++
# Step 2: Install cri-dockerd

# Install git-all
sudo apt-get install git-all
sudo apt-get install wget

# Clone Mirantis cri-dockerd
git clone https://github.com/Mirantis/cri-dockerd.git

# Download Go
https://go.dev/doc/install

# Pick version: go1.21.1

wget https://go.dev/dl/go1.21.1.linux-amd64.tar.gz

# then extract the archive just downloaded into /usr/local
sudo tar -C /usr/local -xzf go1.21.1.linux-amd64.tar.gz

# Export to ~/.profile
cp ~/.profile ~/.profile.bak
echo 'export PATH=$PATH:/usr/local/go/bin' >> ~/.profile

source ~/.profile

# Verify that you've installed Go

go version

# Download cri-dockerd for ubuntu-focal 20.04

wget https://github.com/Mirantis/cri-dockerd/releases/download/v0.3.4/cri-dockerd_0.3.4.3-0.ubuntu-focal_amd64.deb

# Unpack .deb

sudo dpkg -i cri-dockerd_0.3.4.3-0.ubuntu-focal_amd64.deb

sudo systemctl daemon-reload
sudo systemctl enable --now cri-docker.socket

# Initializing your control-plane node
sudo kubeadm init --pod-network-cidr=192.166.0.0/16 --cri-socket=unix:///var/run/cri-dockerd.sock

Your Kubernetes control-plane has initialized successfully!

To start using your cluster, you need to run the following as a regular user:

  mkdir -p $HOME/.kube
  sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
  sudo chown $(id -u):$(id -g) $HOME/.kube/config


# ===================================================
# Joining new nodes as workers
# ===================================================

1. Install a runtime if needed
2. Run command: kubeadm join

sudo kubeadm join 10.148.0.2:6443 --token jondct.uv3bl44v6s3af4a7 \
        --discovery-token-ca-cert-hash sha256:d50f82527c970755ebb027b417c9626d9af26b26a596f72a902cdaa83d2dadef \
        --cri-socket=unix:///var/run/cri-dockerd.sock