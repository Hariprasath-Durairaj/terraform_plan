=======
# Terraform Azure Infrastructure for DHDP

This repository provides modular, reusable, and scalable Terraform code to deploy and manage Azure infrastructure for the **DHDP** across multiple environments (DEV, QA, PROD). It includes AKS provisioning, VNet design, private DNS, peering, WAF policies, and tagging standards.

---

## 🔧 Core Features

- 🚀 Modular Terraform setup using `terraform_modules/`
- 🔁 Environment-specific configurations under `env/`
- 🔒 Secure deployments with private DNS and WAF integration
- 🛡️ Tag policies enforcement
- 🧱 Supports infrastructure across AKS, VMs, WAF, NSGs, VPN
- ✅ Integrated with Azure DevOps Pipelines (recommended)

---

## 📁 Folder Structure

```bash
terraform/
├── env/
│   ├── QA/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   ├── outputs.tf
│   │   ├── terraform.tfvars
│   │   └── backend.tf
│   └── DEV/
│       └── ...
├── terraform_modules/
│   ├── terraform-azure-aks/
│   ├── terraform-azure-vnet/
│   ├── terraform-azure-private-dns/
│   ├── terraform-azure-public-ip/
│   ├── terraform-azure-vnet-peering/
│   ├── terraform-azure-tag-policy/
│   ├── terraform-azure-waf/
│   └── ...
└── README.md
````

---

## ⚙️ Infrastructure Components

### Modules (`terraform_modules/`)

Each module is self-contained with `main.tf`, `variables.tf`, and `outputs.tf`:

* **AKS Module**: Deploys Azure Kubernetes Service with node pools, RBAC, and Log Analytics integration.
* **VNet Module**: Defines VNet, subnets, and NSG attachments.
* **Private DNS Module**: Creates DNS zones and links them to VNets.
* **VNet Peering Module**: Enables private traffic between networks.
* **WAF Module**: Configures Application Gateway WAF with OWASP rules and custom rules.
* **Public IP Module**: Allocates and manages static/dynamic public IPs.
* **Tag Policy Module**: Enforces mandatory resource tagging using Azure Policy.

### Environments (`env/QA`, `env/DEV`)

Each environment folder:

* Uses backend config for remote state.
* Specifies its own inputs via `terraform.tfvars`.
* Calls necessary modules for that stage (e.g., AKS, VNet, WAF).

---

## 🔄 Workflow

1. **Clone Repository**:

   ```bash
   git clone git@github.com:Hariprasath-Durairaj/terraform.git
   cd terraform/env/QA
   ```

2. **Initialize Terraform**:

   ```bash
   terraform init
   ```

3. **Preview Infrastructure Changes**:

   ```bash
   terraform plan -var-file=terraform.tfvars
   ```

4. **Apply Changes**:

   ```bash
   terraform apply -var-file=terraform.tfvars
   ```

---

## 🚀 CI/CD Integration (Azure DevOps)

Recommended pipeline stages:

1. **Terraform Init**
2. **Terraform Validate + Plan**
3. **Manual Approval**
4. **Terraform Apply**
5. **Post-deploy validations or Ansible Playbooks (optional)**

Use secure Service Connections and remote state storage (e.g., Azure Blob).

---

## ✅ Best Practices Followed

* Logical separation of concerns via modules
* Reusability and DRY code structure
* Secure-by-design: private networking, WAF, RBAC
* Tagging enforcement and environment separation
* Modular and CI-friendly

---

## 📌 Requirements

* Terraform >= 1.3.x
* Azure CLI authenticated
* Azure DevOps (if using CI/CD)
* Proper permissions to manage Azure resources

---

## 👥 Contributing

Fork the repo, create a feature branch, and submit a PR.

>>>>>>> 37b7d865c3b3d9ab5624fe73138c56e77653e8e8
