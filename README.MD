# **Huawei Cloud CAE Auto Upgrade Action**

![GitHub Marketplace](https://img.shields.io/badge/Marketplace-auto--upgrade--CAE--component-blue)

This GitHub Action automatically triggers a **Component Upgrade** in **Huawei Cloud Cloud Application Engine (CAE)** whenever a new **Docker image** is pushed. It leverages the **Huawei Cloud CLI (`hcloud`)** for all operations.

---

## **Features**

* ✅ Automatically upgrades CAE components when a new image is pushed
* ✅ Authenticates using **Access Key (AK) and Secret Key (SK)**
* ✅ Dynamically retrieves **Environment, Application, and Component IDs**
* ✅ Parses and uses **image URL and tag** for upgrade
* ✅ Supports multiple **Huawei Cloud regions**

---



## **Usage**

### **1. Create Workflow (`.github/workflows/auto-upgrade.yml`)**

```yaml
name: Auto Upgrade CAE Component

on:
  push:
    tags:
      - '*'

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - name: Checkout Repository
        uses: actions/checkout@v3

      - name: Auto Upgrade Component in CAE
        uses: lemrex/Triggers-CAE-upgrade-on-image-push@v1.0.0
        with:
          project_id: ${{ secrets.HUAWEI_PROJECT_ID }}
          enterprise_project_id: "0"
          environment_name: "prod"
          app_name: "my-app"
          component_name: "web"
          version: "1.0.0"
          accessKey: ${{ secrets.ACCESSKEY }}
          secretKey: ${{ secrets.SECRETKEY }}
          region: "af-south-1"
          swr_org: "ralf"
          swr_repo: "date"
          image_tag: 
```

---

## **Inputs**

| Name                    | Description                              | Required |
| ----------------------- | ---------------------------------------- | -------- |
| `project_id`            | Huawei Cloud Project ID                  | ✅ Yes    |
| `environment_name`      | Name of the environment                  | ✅ Yes    |
| `app_name`              | Name of the application                  | ✅ Yes    |
| `component_name`        | Name of the component                    | ✅ Yes    |
| `version`               | Image tag (usually from `git tag`)       | ✅ Yes    |
| `accessKey`             | Huawei Cloud Access Key (AK)             | ✅ Yes    |
| `secretKey`             | Huawei Cloud Secret Key (SK)             | ✅ Yes    |
| `region`                | Huawei Cloud region (e.g., `af-south-1`) | ✅ Yes    |
| `enterprise_project_id` | Enterprise Project ID (`0` is default)   | ❌ No     |
| `swr_org`               | SWR organization (namespace)             | ✅ Yes    |
| `swr_repo`              | SWR image repository name                | ✅ Yes    |

---

## **Security Practices**

✅ **Use GitHub Secrets** for sensitive credentials
✅ **Wipes CLI credentials after execution** using `hcloud configure clear`
✅ **Deletes temporary files and clears shell history** to avoid leakage

---

## **Prerequisites**

* Huawei Cloud account with AK/SK credentials
* A CAE environment, app, and component already created
* Project ID and Enterprise Project ID
* SWR image repository already populated (via CI/CD or manual push)

---

## **Common Issues & Troubleshooting**

🔹 **Invalid Image URL**
Make sure the image URL follows this pattern:

```
swr.${region}.myhuaweicloud.com/{swr_org}/{swr_repo}:{tag}
```

🔹 **Authentication Failure**
Ensure AK/SK are correct and assigned to an IAM user with CAE permissions.

🔹 **Not Found Errors**
Double-check that environment, application, and component names match what is defined in CAE.

---

## **Reference Docs**

* [CAE Product Overview](https://support.huaweicloud.com/intl/en-us/productdesc-cae/cae_01_0001.html)
* [Huawei Cloud CLI (`hcloud`)](https://support.huaweicloud.com/intl/en-us/productdesc-hcli/hcli_01.html)
* [Enterprise Project Management](https://support.huaweicloud.com/intl/en-us/usermanual-em/pm_topic_0003.html)

---

## **License**

Licensed under the **MIT License**.

