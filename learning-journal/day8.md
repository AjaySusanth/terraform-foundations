# Day 8: AKS Speed Run ☸️

**Date**: 6th March 2026

---

## 📚 Concepts Learned

### 1. AKS Architecture
- **Control Plane**: Managed by Azure (free tier). Handles scheduling, API server, etcd.
- **Node Pool**: The actual VMs that run your containers (pods). We used 1 node with `Standard_B2pls_v2`.
- **System-Assigned Identity**: AKS needs its own identity to manage Azure resources like Load Balancers and Disks.

### 2. Kubernetes Networking (Azure CNI)
- **`network_plugin = "azure"`**: Each pod gets a real IP from your VNet subnet (vs. `kubenet` which uses NAT).
- **`service_cidr`**: A separate IP range (172.16.0.0/16) for internal K8s services like DNS, separate from the VNet range.
- **`dns_service_ip`**: Must live inside the `service_cidr`. Convention is to use `.10`.

### 3. Real-World Debugging (3 Errors Conquered!)
| Error | Root Cause | Fix |
|:---|:---|:---|
| `K8sVersionNotSupported` | K8s 1.29/1.30 moved to LTS-only (Premium required) | Used `az aks get-versions` to find `1.34` |
| `VM size not allowed` | `Standard_B2s` (v1) retired in `centralindia` | Switched to `Standard_B2pls_v2` |
| `ServiceCidrOverlapExistingSubnetsCidr` | Default service CIDR conflicted with VNet | Explicitly set `service_cidr = "172.16.0.0/16"` |

---

## ⌨️ Commands Learned

| Command | Purpose |
|:---|:---|
| `az aks get-versions --location centralindia` | Check available K8s versions in your region |
| `az aks get-credentials --resource-group <rg> --name <cluster>` | Download cluster credentials to local machine |
| `kubectl get nodes` | Verify cluster nodes are running |
| `kubectl get pods --all-namespaces` | See all running pods including system services |
| `terraform destroy -target=module.aks` | Surgically destroy only the AKS cluster |

---

## 🔥 Interview Questions & Answers

### Q1: What is the difference between Azure CNI and Kubenet?
**A**: Azure CNI gives each pod a real IP address from your VNet subnet, enabling direct communication with other Azure services. Kubenet uses NAT and a bridge network, which is simpler but has limitations with VNet integration.

### Q2: Why can't the AKS service CIDR overlap with your VNet?
**A**: The `service_cidr` is used for internal Kubernetes cluster services (like CoreDNS). If it overlaps with the VNet, routing conflicts occur — traffic meant for a K8s service could accidentally go to your subnet, and vice versa.

---

## 🏗️ Accomplishments Today
- Built a reusable `modules/aks` Terraform module.
- Debugged **3 consecutive Azure deployment errors** like a senior engineer.
- Successfully deployed a **Kubernetes cluster** to Azure.
- Explored the cluster using `kubectl`.
- **Destroyed the cluster** responsibly to protect student credits. 💰

## 🕒 Next Session Preview: Phase 9
- **CI/CD for Terraform**: GitHub Actions pipeline that runs `terraform plan` on Pull Requests and `terraform apply` on merge to main.
- **Azure OIDC Login**: No secrets stored in GitHub — passwordless authentication!
