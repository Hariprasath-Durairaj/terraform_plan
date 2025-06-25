# DHDP QA Environment – Terraform Infrastructure

This directory contains the Terraform configuration for provisioning the **Quality-Assurance (QA)** environment of the **DHDP** platform in Microsoft Azure.

---

## 📁 Directory Layout

```

environments/QA/
├── backend.tf            # Remote-state backend
├── main.tf               # Root module for QA
├── variables.tf          # Environment inputs
├── terraform.tfvars      # QA-specific values
├── outputs.tf            # Exposed IDs / URIs
└── versions.tf           # Terraform & provider pinning

````

> **Note** The repo’s reusable building blocks live under `terraform-modules/`.

---

## 🔧 Infrastructure Deployed

| Layer | Details |
|-------|---------|
| **Compute / Orchestration** | Azure Kubernetes Service (**AKS**) with:<br>• Dedicated node pools: *bitnobi* | *keycloak* | *candig* | *integrateai* | *webapp*<br>• AAD-integrated RBAC, logging to Log Analytics, autoscaler enabled |
| **Network** | Single VNet (<kbd>10.30.0.0/16</kbd>)<br>• Subnets: `aks`, `appgw`, `bastion`, etc.<br>• NAT Gateway for static egress<br>• NSG rules per subnet |
| **Ingress** | **Application Gateway v2** with WAF (OWASP 3.2, Prevention) driven by **AGIC**; no in-cluster NGINX |
| **Security / Secrets** | Key Vault (CMK-ready) + Disk Encryption Set |
| **Governance** | Enterprise Tag Policy module enforcing 7 mandatory tags |
| **Backup** | Recovery Services Vault (file & VM backups) |
| **DNS** | Private DNS Zone linked to VNet |
| **Connectivity (optional)** | Bastion host and VNet Peering to hub VNet |

---

## 🧱 Modules Called by `main.tf`

| Module | Folder |
|--------|--------|
| AKS                       | `terraform-modules/terraform-azure-aks` |
| Virtual Network           | `terraform-modules/terraform-azure-vnet` |
| Application Gateway + WAF | `terraform-modules/terraform-azure-app-gateway`<br>`terraform-modules/terraform-azure-waf` |
| NAT Gateway               | `terraform-modules/terraform-azure-nat-gateway` |
| Private DNS               | `terraform-modules/terraform-azure-private-dns` |
| Key Vault + DES           | `terraform-modules/terraform-azure-key-vault`<br>`terraform-modules/terraform-azure-disk-encryption-set` |
| Tag Policy (enterprise)   | `terraform-modules/terraform-azure-tag-policy` |
| Backup Vault, NSG, etc.   | Other modules in `terraform-modules/` |

---

## ⚙️ Workflow

```bash
# 1) Initialise (remote-state & provider plugins)
cd environments/QA
terraform init

# 2) Review planned infrastructure
terraform plan -var-file=terraform.tfvars

# 3) Apply to Azure
terraform apply -var-file=terraform.tfvars
````

---

## 🏷️ Standard Tags (auto-enforced)

| Key          | Example           |
| ------------ | ----------------- |
| environment  | `QA`              |
| businessUnit | `corp`            |
| application  | `dhdp`            |
| owner        | `example@corp.com`|
| managedBy    | `hello@dhdp-tfri` |
| createdBy    | `Terraform`       |
| criticality  | `Standard`        |

The **tag-policy** module appends any missing tag with these defaults and blocks drift in production scopes.

---

## 🔐 Security Highlights

* AKS control-plane private or IP-allow-listed
* WAF in Prevention mode on App Gateway
* NAT Gateway provides fixed egress IPs, SNAT-scaling
* All secrets pulled from Key Vault; no plain-text in tfvars

---

## ✅ Prerequisites

* **Terraform ≥ 1.3** (lock file committed)
* **AzureRM provider ≥ 3.0**
* Azure CLI authenticated to the target subscription
* State-storage account and container referenced in `backend.tf`
