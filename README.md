# DevSecOps OCI

[![Opentofu & Quarkus](https://github.com/tuxtor/devsecops-oci/actions/workflows/full-deployment.yml/badge.svg)](https://github.com/tuxtor/devsecops-oci/actions/workflows/full-deployment.yml)

This repository is a comprehensive showcase of modern DevSecOps, cloud-native architecture, and CI/CD. Designed to demonstrate expertise in building cloud solutions on OCI. It features a fully automated infrastructure-as-code approach using Terraform, with modular definitions for networking, compute, container instances, registry (Docker Hub), DNS (OCI DNS).

The application layer leverages Java 21 and Quarkus, containerized with Docker for portability and rapid deployment.

CI/CD pipelines are implemented with GitHub Actions, ensuring automated testing, static code analysis (SpotBugs for Java, Trivy for IaC and containers), and secure dependency management via Dependabot.

Infrastructure changes are gated to the main branch, while all branches benefit from planning and testing workflows. Pull requests are reviewed with Copilot to enhance code quality and security.

## Architecture

![Architecture Diagram](./docs/architecture-diagram.png)

## Principles and practices
- [12 Factor App: Cloud Native Principles](https://12factor.net/)
- DevSecOps
- Infrastructure as Code (IaC)
- Automated testing
- Static code analysis
- Continuous Integration and Continuous Deployment (CI/CD)

## Tools
- Terraform
- Java 21
- Quarkus
- Eclipse JKube
- OCI
- Docker (used for containerization in Quarkus workloads)
- GitHub Actions
- Static code analysis
    - (Code) [SpotBugs](https://spotbugs.github.io/)
    - (Pipelines) [Trivy](https://trivy.dev/latest/)
- Dependabot for dependency management
- Copilot for PR reviews
