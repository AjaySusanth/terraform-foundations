# Day 2: Terraform Depth, Structure & Modules
**Date**: 28th February 2026

---

## 📚 Concepts Learned

### 1. Azure Networking Deep Dive
- **VNet (Hotel Building)**: The overarching private network boundary.
- **Subnet (Hotel Floors)**: Segments inside the VNet to organize resources and security.
- **NSG (Security Guard)**: A firewall that controls traffic into/out of a subnet using **Security Rules**.
- **NSG Association**: The "Link" that attaches a specific guard to a specific floor.

### 2. Implicit vs Explicit Dependencies
- **Implicit**: When you reference `.id` or `.name` of another resource. Terraform builds the dependency graph automatically. (e.g., Subnet needs VNet's name).
- **Explicit**: Using `depends_on = [resource.name]`. Used only when there is no code-level link but one resource MUST exist before another.

### 3. Data Sources (Read-Only)
- Used to **read** information from Azure that Terraform didn't create.
- Example: `data "azurerm_subscription" "current" {}` to get the subscription name dynamically.

### 4. Locals (Internal Logic)
- Used for **internal calculations** and keeping code **DRY** (Don't Repeat Yourself).
- Unlike variables, they cannot be changed by the user at runtime. Ideal for building complex tags or standardized names.

### 5. Terraform Modules (The "Lego" Phase)
- **Isolation**: Modules are "Black Boxes." They can't see root variables unless you "plug them in" via module variables.
- **Portability**: You can write a "Network Module" once and use it for Dev, Staging, and Prod.

### 6. State Migration (`moved` blocks)
- A professional way to rename or move resources into modules **without destroying them** in Azure.
- Prevents downtime and "Delete/Recreate" operations when refactoring code.

---

## ⌨️ Commands Learned

| Command | Purpose |
| :--- | :--- |
| `terraform graph` | (Conceptual) Generates a visual map of all resource dependencies. |
| `terraform init` | Must be run again whenever a **new module** is added to the project. |
| `terraform plan` | Shows the diff. For refactoring, we look for **"moved"** instead of "created/destroyed." |

---

## 🔥 Interview Questions & Answers

### Q1: Why use `azurerm_virtual_network.vnet.name` instead of `var.vnet_name` in a subnet?
**A**: Using the resource property creates an **Implicit Dependency**. It ensures Terraform finishes building the VNet and confirms its name from the Azure API before it ever tries to create the Subnet.

### Q2: What is the difference between a Variable and a Local?
**A**: A **Variable** is an input from the user (like an ingredient). A **Local** is internal logic or prep-work (like a recipe). Locals can contain logic and string interpolation; variables cannot.

### Q3: What happens if you move a resource into a module without a `moved` block?
**A**: Terraform will think the old resource was deleted and a new one was added. It will try to **Destroy** your live infrastructure and **Recreate** it, causing downtime and data loss.

### Q4: Can one NSG be assigned to multiple subnets?
**A**: **Yes**. This is a best practice for maintaining consistent security rules across identical environments (e.g., all Web subnets having the same firewall rules).

### Q5: What is the benefit of a "Black Box" module design?
**A**: It prevents side effects. You can change the internal code of the module, and as long as the "Plugs" (Inputs/Outputs) stay the same, the rest of the infrastructure won't break.

---

## 🏗️ Refactoring Accomplished Today
- Created `modules/network/` folder structure.
- Moved VNet, Subnet, and NSG into the module.
- Cleaned up `main.tf` to call the module instead of individual resources.
- Verified **"0 to add, 0 to change, 0 to destroy"** with a `moved` block plan.

## 🕒 Next Session Preview: Phase 4
- **Environment Separation**: Setting up real `dev` and `prod` folders.
- **State Per Environment**: Keeping Dev failures from touching Prod data.
- **Variable Files**: Using different `.tfvars` for different environments.
