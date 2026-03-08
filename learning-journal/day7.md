# Day 7: Advanced HCL & Engineering Logic 🏗️

**Date**: 4th March 2026

---

## 📚 Concepts Learned

### 1. Looping with `for_each`
- **Durable Identity**: Unlike `count`, `for_each` uses keys (like "web-subnet") instead of index numbers. 
- **Production Strength**: If you delete one item in a map, Terraform doesn't touch the others. This prevents accidental resource recreation.

### 2. State Migration (`moved` blocks)
- Learned how to "rename" a resource in the state file without actually destroying the physical resource in Azure. 
- **Zero-Downtime Refactoring**: Essential for shifting from single resources to loops while live.

### 3. Dynamic Blocks
- Used to keep code **DRY** (Don't Repeat Yourself).
- Perfect for resources with repeating nested blocks, like **NSG Security Rules** or **Service Endpoints**.
- Allows the module to remain "static" while the configuration is passed in as a list of objects.

### 4. Lifecycle Rules (The Safety Gear)
- **`prevent_destroy`**: Blocks `terraform destroy` from wiping critical resources (like Resource Groups).
- **`ignore_changes`**: Useful when Azure modifies settings (like automatic tagging) that you don't want Terraform to fight over.
- **`create_before_destroy`**: Useful for updating resources that don't support in-place updates without causing downtime.

---

## ⌨️ Commands Learned

| Command | Purpose |
| :--- | :--- |
| `terraform validate` | Checks syntax without needing a cloud connection. Highly recommended as a "smoke test." |
| `terraform state list` | View the new addresses (e.g., `module.network.azurerm_subnet.web["web-subnet"]`). |

---

## 🔥 Interview Questions & Answers

### Q1: Why is `for_each` generally better than `count` for subnets?
**A**: Because `count` is index-based. If you have 3 subnets `[0, 1, 2]` and you delete `[1]`, Terraform will rename `[2]` to `[1]`, which often triggers a "Destroy and Recreate" of the third subnet. `for_each` avoids this by giving every resource a permanent name.

### Q2: How do you handle a resource that was created manually but now needs to be managed by Terraform?
**A**: You use `terraform import`. (We practiced this in Phase 4 when recovering our state).

---

## 🏗️ Accomplishments Today
- Refactored the network module to support **multiple subnets** via `for_each`.
- Implemented **State Migration** using `moved` blocks.
- Cleaned up the NSG module using **Dynamic Blocks**.
- Installed **Infrastructure Seatbelts** using `prevent_destroy`.
- Successfully verified that Terraform refuses to destroy protected resources!

## 🕒 Next Session Preview: Phase 8
- **AKS (Azure Kubernetes Service)**: We take the leap to K8s! 
- **The "1-Hour Spike"**: We'll spin up a cluster, explore how Terraform talks to K8s, and then destroy it to save your student credits.
