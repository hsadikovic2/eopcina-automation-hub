# eOpcina Automation Hub 🚀

Welcome to the **eOpcina Automation Hub**, a centralized repository for the automated lifecycle management of the eOpcina application. This project demonstrates a production-grade **CI/CD pipeline** integrating GitHub Actions with AWS Cloud infrastructure.

## 🌟 Project Overview

The **Automation Hub** serves as the "Engine Room" for the eOpcina ecosystem, ensuring that every code change is built, tested, and deployed with zero manual intervention.

## 🛠️ Technology Stack

* **Core Framework:** .NET 8.0 (ASP.NET Core)
* **Containerization:** Docker (Multi-stage builds)
* **Orchestration:** GitHub Actions (Automated Workflows)
* **Cloud Provider:** AWS EC2 (Elastic Compute Cloud)
* **Registry:** GitHub Container Registry (GHCR)

---

## 🏗️ The CI/CD Architecture

This repository implements an **Immutability Pattern**. We do not patch the server; we replace it with a fresh container on every push.

### 🔄 The Workflow
1. **Commit & Push:** Developer pushes code to `main`.
2. **Build Stage (CI):** GitHub Actions builds the Docker image and tags it with the specific `git-sha`.
3. **Registry Stage:** The verified image is stored in **GHCR**.
4. **Deploy Stage (CD):** GitHub Actions uses **SSH-action** to trigger a remote pull and restart on the **AWS EC2** instance.

---

## 📋 Infrastructure Requirements (GitHub Secrets)

To replicate this automation hub, you must configure the following secrets in your repository:

| Secret Name | Purpose |
| :--- | :--- |
| `EC2_HOST` | The target AWS Public IP |
| `EC2_SSH_KEY` | Private RSA Key (.pem) for server authentication |
| `GITHUB_TOKEN` | (Automated) Used for GHCR authentication |

---

## 🚀 Deployment Commands (Manual Reference)

If you need to trigger the engine manually from the server terminal:

```bash
# Pull the latest image from the Hub
docker pull ghcr.io/hsadikovic2/eopcina:latest

# Restart the application
docker stop eopcina-app || true && docker rm eopcina-app || true
docker run -d --name eopcina-app -p 80:8080 ghcr.io/hsadikovic2/eopcina:latest
