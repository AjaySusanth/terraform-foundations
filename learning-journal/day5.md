# Day 5: Computing with Container Apps 🏎️

**Date**: 3rd March 2026

---

## 📚 Concepts Learned

### 1. Azure Container Apps (ACA)
- **Serverless Containers**: No need to manage Kubernetes nodes or VMs. ACA handles the scaling and infrastructure for you.
- **Microservices Ready**: Designed to host multiple containers that can communicate with each other easily.

### 2. The 3-Layer Infrastructure Stack
Today we learned that a professional app isn't just a "container." It needs:
1.  **Logging (Log Analytics)**: The "Diary" that records every error and print statement.
2.  **Environment (ACA Environment)**: The "Secure Perimeter" that hosts your apps and handles networking.
3.  **App (Container App)**: The "Actual Code" running inside the environment.

### 3. Ingress & FQDN
- **External Ingress**: Telling Azure to create a Load Balancer so people on the internet can reach your app.
- **FQDN (Fully Qualified Domain Name)**: The unique URL Terraform "discovers" from Azure after the deployment is finished.

### 4. Quotas & Limits
- Observed that some Azure regions (especially on Student accounts) have a limit of **1 Container App Environment per region**.
- Learned how to troubleshoot **409 Conflict** errors by cleaning up old resources or shifting regions.

---

## ⌨️ Commands Learned

| Command | Purpose |
| :--- | :--- |
| `terraform state show module.app.azurerm_container_app.web` | View every single detail of your live container app in the terminal. |
| `az containerapp list` | Use the Azure CLI to verify your apps outside of Terraform. |

---

## 🔥 Interview Questions & Answers

### Q1: What is the benefit of using an "Environment" in ACA?
**A**: It provides a shared set of logging, networking, and scaling rules for multiple apps. This is more efficient than managing these settings for every single container separately.

### Q2: Why did we put Log Analytics in its own resource?
**A**: Separating Logs from the App allows you to persist your data even if you destroy and rebuild the app. It's a "Stateful" resource vs. the "Stateless" container.

---

## 🏗️ Accomplishments Today
- Created a reusable `modules/app` module.
- Provisioned a **Log Analytics Workspace** for telemetry.
- Built a **Managed Container Environment**.
- Successfully deployed a **Public-facing Web Server** and accessed it via the browser.

## 🕒 Next Session Preview: Phase 6
- **Security & Identity**: We'll give our app a "Digital ID" (Managed Identity) so it can talk to other Azure services securely.
- **Key Vault**: Protecting secrets like API keys and passwords.
