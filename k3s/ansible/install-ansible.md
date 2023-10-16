# 1. Install Ansible


### Check Python is installed or not
### Require Python >= 3.9 for control node Ansible
```bash
python --version
sudo apt update
sudo apt install software-properties-common -y 
sudo apt install Python3.10 
python3.10 --version
```

### Install Ansible command

```bash
sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository --yes --update ppa:ansible/ansible
sudo apt install ansible
```

# 2. Add hosts: Setting up the Inventory Files
```bash
sudo vi /etc/ansible/hosts

[node]
node1 ansible_host=10.148.0.6
node2 ansible_host=10.148.0.7

[all:vars]
ansible_python_interpreter=/usr/bin/python3

ansible-inventory --list -y
```

# 3. Set up SSH connections so Ansible can connect to the managed nodes.
## a. Add your public SSH key to the authorized_keys file on each remote system.
### From control node
```bash
ssh-keygen
cat ~/.ssh/id_rsa.pub
```
### On managed hosts
```bash
mkdir -p ~/.ssh
vi ~/.ssh/authorized_keys

ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDJVszOaSZAAhzlT27bMpb9lBiQU8O2d81SHzNHNuJQIULvfiRzUpGzw3E656K9Zw1Z2vmBkautyET+iPM6xIsca1aYcLFN6t/W3S95LoT+Z16msPuhvS99ithZOKNL9p157wbitis6Yh/XL5llhUloxDRAAH66sGIKFLxcFuHtIrhXxjBXiAVAL2epVLQHlclsAoRp5RyLRa/n26UeRTWQ3nSyNzT6r2UhjT9BVfcmzMDC/uVSoIhshEwbWUZtk1619asGEkwBECDEs/IQbpQCKGD4CS3wFWEehWdgQD425aqyKFqrWx1y8dNa7vySNOvdIbqfKCSanqXYqmuc7v2op0QPwfsu1lDKmWSXR9Nq1WdODO/sSzvXLFh/W8E/ZGIN/FCiB25UUFzioCw8VK/54TFZFdLEHSjcPUVVzjASEyfVgYk1J9TqyYq1fj9r7/+j445SFJnl5GK7oZzCYpicfeyHXP8AQA+fpDyTtrhNVN4Aj8kNx+xgvHtkO7w6Qq8= txhanh@control-plane
```
## b. Test the SSH connections, for example:
```bash
# Try to test SSH connections
ssh txhanh@10.148.0.6
ssh txhanh@10.148.0.7

# Ping to managed hosts
ansible all -m ping
# Check disk usage on managed hosts
ansible all -a "df -h" -u txhanh
```