# Day 1: Terraform Foundations on Azure
**Date**: 26th February 2026

---

## 📚 Concepts Learned

### 1. Infrastructure as Code (IaC)
- Instead of clicking buttons in the Azure Portal, we write **code** (`.tf` files) that describes what we want.
- Terraform reads this code and builds the infrastructure automatically.
- **Analogy**: The `.tf` files are the **Blueprint**, and Terraform is the **Magic Robot** that reads the blueprint and builds exactly what you described.

### 2. Declarative vs Imperative
- Terraform is **Declarative**: You describe the **end state** ("I want a Resource Group"), not the steps ("Click here, type this, press OK").
- Terraform figures out the steps on its own.

### 3. Providers
- Terraform doesn't know how to talk to Azure by itself. It uses a **Plugin** called a **Provider** (`azurerm`).
- The provider is downloaded during `terraform init` and stored in the `.terraform/` folder.

### 4. State (`terraform.tfstate`)
- Terraform's **Memory**. A JSON file that records every resource it has created, including their Azure IDs.
- Without state, Terraform forgets what it built and tries to rebuild everything, causing conflicts.

### 5. Implicit Dependencies
- When one resource references another (e.g., VNet references `azurerm_resource_group.rg.location`), Terraform automatically knows the **order** to build things.
- No need to manually specify "build RG first, then VNet."

### 6. Variable Hierarchy (Priority: Low → High)
1. `variable.tf` defaults (lowest priority)
2. `terraform.tfvars` file
3. Environment variables (`TF_VAR_<name>`)
4. Command-line flags (`-var="key=value"`) (highest priority)

### 7. Remote State Backend
- Storing `.tfstate` in **Azure Storage** instead of your local machine.
- Benefits: Security, Collaboration, and **State Locking** (prevents two people from modifying infra at the same time).

---

## ⌨️ Commands Learned

| Command | Purpose |
| :--- | :--- |
| `terraform init` | Downloads providers, sets up backend, creates `.terraform.lock.hcl` |
| `terraform plan` | Preview what Terraform **will** do. Does NOT create anything. |
| `terraform apply` | Actually creates/modifies/deletes resources. Asks for `yes` confirmation. |
| `terraform destroy` | Tears down everything Terraform manages (not used today). |

### Azure CLI Commands Used
```bash
# Create a Resource Group for state management
az group create --name terraform-mgmt-rg --location centralindia

# Create a Storage Account for remote state
az storage account create --resource-group terraform-mgmt-rg --name <unique_name> --sku Standard_LRS --encryption-services blob

# Create a blob container inside the storage account
az storage container create --name tfstate --account-name <unique_name>
```

---

## 📂 File Structure Explained

| File | Purpose |
| :--- | :--- |
| `providers.tf` | Declares which cloud (Azure), provider version, and remote backend config |
| `main.tf` | The core blueprint — all resource definitions go here |
| `variable.tf` | Declares input variables with types, descriptions, and defaults |
| `terraform.tfvars` | Assigns actual values to the variables (environment-specific) |
| `outputs.tf` | Declares values to display after `apply` (like resource IDs) |
| `.gitignore` | Excludes `.terraform/`, `.tfstate`, and `.tfvars` from version control |
| `.terraform.lock.hcl` | Locks provider versions for consistency across team members |

---

## 🔥 Interview Questions & Answers

### Q1: What is Terraform and why is it used?
**A**: Terraform is an open-source IaC tool by HashiCorp. It allows you to define cloud infrastructure in declarative configuration files. Benefits include consistency (no manual errors), speed (deploy 100 servers at once), version control (track changes via Git), and reproducibility (same code = same infrastructure every time).

### Q2: What is the difference between `terraform plan` and `terraform apply`?
**A**: `plan` is a dry-run — it shows what Terraform **would** do without making any changes. `apply` actually executes the changes against the cloud provider. `apply` also shows the plan first and asks for confirmation before proceeding.

### Q3: What is the Terraform State file and why is it important?
**A**: The `terraform.tfstate` file is a JSON file that maps your Terraform code to real-world resources. It stores the IDs and properties of every resource Terraform manages. Without it, Terraform loses track of what exists and may try to recreate resources, causing errors or duplicates.

### Q4: Why should you use a Remote Backend for state?
**A**: Three reasons:
1. **Security**: State files can contain sensitive data (passwords, keys). Cloud storage offers encryption.
2. **Collaboration**: Multiple team members can access the same state.
3. **Locking**: Prevents two people from running `apply` simultaneously, which could corrupt the state.

### Q5: What happens if you delete the `terraform.tfstate` file?
**A**: Terraform loses its memory. It will think no resources exist and try to create everything from scratch. Since the resources already exist in Azure, this will cause errors like "Resource Group already exists."

### Q6: What are the `+`, `~`, and `-/+` symbols in `terraform plan`?
**A**:
- `+` = **Create**: A brand new resource will be created.
- `~` = **Update in-place**: An existing resource will be modified without deletion.
- `-/+` = **Destroy and Recreate**: The resource must be deleted and rebuilt (e.g., renaming a Resource Group).

### Q7: What is the "Chicken and Egg" problem with Remote State?
**A**: To store Terraform state in Azure Storage, the Storage Account must already exist. But if you use Terraform to create that Storage Account, where does its state go? The solution is to create the storage foundation manually (via CLI or Portal) first, then configure Terraform to use it.

### Q8: What is an Implicit Dependency in Terraform?
**A**: When one resource references an attribute of another (e.g., `azurerm_resource_group.rg.location`), Terraform automatically understands the dependency order. It will always create the Resource Group before the VNet without you needing to specify it explicitly.

### Q9: What files should be in `.gitignore` for a Terraform project?
**A**: `.terraform/` (large binary plugins), `*.tfstate` and `*.tfstate.backup` (contains sensitive data and should be in remote backend), and `terraform.tfvars` (may contain secrets or environment-specific values). The `.terraform.lock.hcl` file **should** be committed to ensure consistent provider versions.

### Q10: What is the `sensitive` flag in Terraform outputs?
**A**: Adding `sensitive = true` to an output block hides the value from terminal output (shows `<sensitive>` instead). However, it is still stored in plain text in the state file, which is why securing the state file via remote backend with encryption is critical.

---

## 🏗️ Resources Built Today
1. **Resource Group**: `devops-foundation-rg` in Central India
2. **Virtual Network**: `devops-foundation-vnet` with address space `10.0.0.0/16`
3. **Storage Account**: `tfstate2005` for remote state management

## 🕒 Next Session Preview
- Adding **Subnets** to our VNet
- Creating **Network Security Groups** (Firewalls)
- Deploying our first **Virtual Machine**
