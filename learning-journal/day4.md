# Day 4: Professional Environment Management & State Recovery 🌍

**Date**: 2nd March 2026

---

## 📚 Concepts Learned

### 1. Folder-Based Environment Separation
- **The Modern Standard**: Instead of managing everything in one folder, we split our project into `envs/dev` and `envs/prod`.
- **Isolation**: Each environment has its own `main.tf`, `variables.tf`, and `providers.tf`. 
- **Safety**: Running `terraform destroy` in Dev is physically impossible to touch Prod because they are in different directories and use different state files.

### 2. State Isolation (Multi-Key Backend)
- We used a single Azure Storage Account but gave each environment a unique **State Key**:
  - `dev.tfstate`
  - `prod.tfstate`
- This ensures that the "Memory" of Dev and Prod never mixes.

### 3. Terraform Import (The "Life Saver")
- **Scenario**: When your state file is lost or you want to manage existing resources.
- **Action**: Use `terraform import <address> <id>` to tell Terraform to "adopt" an existing cloud resource.
- **Skill**: This is an essential production-grade skill for migrating or fixing broken state files.

### 4. Code Parity vs. Data Divergence
- **Parity**: Dev and Prod use the **exact same module code** (`modules/network`).
- **Divergence**: They use **different inputs** (Project Name, IP ranges) via their own `terraform.tfvars`.

---

## ⌨️ Commands Learned

| Command | Purpose |
| :--- | :--- |
| `terraform init -reconfigure` | Forces Terraform to ignore local state and connect freshly to the backend. |
| `terraform init -migrate-state`| Automatically move state from one backend key/location to another. |
| `terraform import` | Connects a piece of code to a resource that already exists in the cloud. |
| `terraform state list` | Shows a list of all resources currently "known" by the state file. |

---

## 🔥 Interview Questions & Answers

### Q1: Why use Folders instead of Workspaces for Dev/Prod?
**A**: Folders are more explicit and safer. You can see the configuration diff between environments easily, and you prevent the accidental "Wrong Workspace" error where you apply Dev changes to Prod.

### Q2: What's the difference between `moved` blocks and `terraform import`?
**A**: `moved` blocks are used when the state file is healthy and you just want to rename things within the code. `terraform import` is used when there is **no record** in the state file at all.

### Q3: Why is a shared module beneficial for multi-environment setups?
**A**: It ensures "Environment Parity." If a network configuration works in Dev, you are 100% sure it will work the same in Prod because they share the exact same logic brick.

---

## 🏗️ Accomplishments Today
- Restructured project into `envs/dev` and `envs/prod`.
- **Recovered from a state loss** using manual `terraform import` (Great debugging practice!).
- Verified Dev state with `Plan: 0 to add`.
- Deployed a **fully isolated Production environment** in under 5 minutes using the network module.

## 🕒 Next Session Preview: Phase 5
- **Azure Container Apps**: Transitioning from Networking to Compute.
- **Nginx Deployment**: Deploying our first web server into our new subnets.
- **Serverless Compute**: Learning why Container Apps are perfect for rapid DevOps.
