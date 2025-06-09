# DHDP Terraform CI/CD Pipelines

This directory contains Azure DevOps pipeline definitions used for deploying the DHDP infrastructure across environments like **DEV**, **QA**, and **PROD**.

It uses modular YAML templates for Terraform workflows (`init`, `validate`, `plan`, `apply`, `destroy`, `output`) and separates concerns for better reusability and automation.

---

## 📁 Structure

```

pipeline/
├── azure-pipelines-QA.yml                # Main pipeline for QA environment
├── azure-pipelines-DEV.yml               # Main pipeline for DEV environment
├── azure-pipelines-PROD.yml              # Main pipeline for PROD environment
└── templates/
├── init-stage.yml
├── validate-stage.yml
├── plan-stage.yml
├── apply-stage.yml
├── destroy-stage.yml
└── output-stage.yml

````

---

## 🧩 Pipeline Stage Templates

Each stage template is reusable and supports:

| Template             | Purpose                          |
|----------------------|----------------------------------|
| `init-stage.yml`     | Initializes backend state        |
| `validate-stage.yml` | Lints and validates Terraform    |
| `plan-stage.yml`     | Previews infrastructure changes  |
| `apply-stage.yml`    | Applies planned changes          |
| `destroy-stage.yml`  | Tears down infrastructure        |
| `output-stage.yml`   | Displays Terraform outputs       |

---

## 🚀 Main Pipeline Files

You’ll find individual pipelines for each environment:

### `azure-pipelines-QA.yml`
Runs a full Terraform workflow using templates and environment-specific variables for the QA setup.

Example stages:
```yaml
stages:
  - template: templates/init-stage.yml
  - template: templates/validate-stage.yml
  - template: templates/plan-stage.yml
  - template: templates/apply-stage.yml
  - template: templates/output-stage.yml
````

---

## ⚙️ Parameters (via `variables:`)

Each pipeline file sets required parameters like:

```yaml
variables:
  workingDirectory: 'env/QA'
  serviceConnection: 'dhdp-infra-sp'
  backendResourceGroup: 'dhdp-lab-resource-group'
  backendStorageAccount: 'dhdplabsa'
  backendContainerName: 'tfstate'
  backendKey: 'qa.terraform.tfstate'
```

---

## ✅ Best Practices Followed

* Modularized pipeline templates
* OIDC authentication with ARM environment variables
* Remote backend initialization with reuse of pipeline variables
* Version-pinned Terraform (`1.5.7`)
* Environment-specific YAML pipelines
* Manual `trigger: none` to prevent unintended CI runs

---

## 🔒 Security Notes

* Service connections must use managed identity or scoped SPs
* Remote state backend (`backend.tf`) must exist before running pipelines
* Add manual approval gates in Azure DevOps if needed for `apply` or `destroy`

---

## 📄 License

MIT License. See root-level `LICENSE` file.
