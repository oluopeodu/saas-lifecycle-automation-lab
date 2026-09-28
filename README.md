# SaaS Lifecycle Automation Lab

![Frappe HR](https://img.shields.io/badge/HRIS-Frappe_HR-0089FF?style=for-the-badge)
![n8n](https://img.shields.io/badge/Workflow-n8n-EA4B71?style=for-the-badge)
![Okta](https://img.shields.io/badge/IAM-Okta-007DC1?style=for-the-badge)
![Terraform](https://img.shields.io/badge/IaC-Terraform-844FBA?style=for-the-badge)
![Docker](https://img.shields.io/badge/Containers-Docker-2496ED?style=for-the-badge)

A hands-on Systems Engineering project demonstrating how to automate employee identity and SaaS access lifecycle management using HR-driven workflows.

## Overview

This project simulates an enterprise IT environment where employee lifecycle events originate in an HR system and drive identity management and SaaS provisioning.

The lab integrates Frappe HR, n8n, Okta, and Google Workspace to explore how IT teams can automate employee onboarding, identity updates, and access management while maintaining consistent identity data across systems.

The project is designed to demonstrate practical skills in:

- Identity and Access Management (IAM)
- Joiner-Mover-Leaver (JML) lifecycle automation
- HRIS-to-identity-provider integration
- Workflow orchestration and API integration
- Infrastructure as Code (IaC)
- SaaS administration and access governance


## Architecture

The lab follows an HR-driven identity lifecycle architecture:


```mermaid
flowchart TD
    A["Frappe HR<br/>HRIS"] -->|"Employee data via REST API"| B["n8n<br/>Workflow orchestration"]
    B -->|"Okta API"| C["Okta<br/>Identity Provider"]
    C -->|"Provisioning / Group Push"| D["Google Workspace<br/>SaaS applications"]

    style A fill:#e1f5fe,stroke:#0288d1,color:#01579b
    style B fill:#fce4ec,stroke:#c2185b,color:#880e4f
    style C fill:#e8eaf6,stroke:#3949ab,color:#1a237e
    style D fill:#e8f5e9,stroke:#388e3c,color:#1b5e20
```


## Implemented Features

### HRIS-to-Okta Synchronization

- Retrieve employee records from Frappe HR using its REST API.
- Orchestrate HR data processing with n8n.
- Compare HRIS employee records with existing Okta users.
- Use the Frappe HR Employee ID as the identity matching attribute in Okta (`employeeNumber`).
- Create Okta user accounts for eligible employees.

### Identity Lifecycle Management

- Explore Joiner-Mover-Leaver (JML) lifecycle automation.
- Classify employee records based on HR and Okta data.
- Support user activation and profile updates through Okta workflows.

### Infrastructure and SaaS Administration

- Run the lab components locally using Docker Compose.
- Manage selected Cloudflare DNS resources with Terraform.
- Automate Google Workspace user creation using GAM7.

## Implementation Status

| Area | Status |
|---|---|
| Frappe HR REST API integration with n8n | Implemented |
| HRIS-to-Okta user comparison | Implemented |
| Okta user creation | Implemented |
| Okta Workflows for identity lifecycle operations | In progress |
| Google Workspace provisioning and group automation | In progress |
| Terraform infrastructure automation | Partially implemented |

## Testing and Validation

The lab is being developed incrementally, with a focus on validating identity lifecycle behavior across HRIS and identity systems.

Current work includes testing employee data retrieval, identity matching, and Okta account operations.

Further validation is planned for complete Joiner-Mover-Leaver scenarios, rehire handling, and downstream SaaS provisioning.


## Prerequisites

The following tools and accounts are used to build and operate the lab:

- Docker Desktop and Docker Compose
- Git and GitHub
- n8n
- Frappe HR
- Okta Integrator Free Plan
- Google Workspace
- GAM7 (Google Apps Manager)
- Terraform
- A Cloudflare account for DNS automation

Some integrations require API credentials and service account configuration. Keep credentials in local environment variables or secret-management systems and never commit them to Git.



## Identity Matching and Lifecycle Logic

### Identity Matching

The lab uses the Frappe HR Employee ID as the primary identity matching attribute.

| Frappe HR | Okta |
|---|---|
| Employee ID (`name`) | `profile.employeeNumber` |
| First name | First name |
| Last name | Last name |
| Company email | Email and login |

Using the HR-generated Employee ID as the matching key helps maintain a consistent identity reference across systems, independently of changes to an employee's email address.

### Lifecycle Classification

The n8n workflow compares employee records retrieved from Frappe HR with existing Okta users.

The comparison supports the identification of employee records that require further processing, including:

- New employees who may need an Okta account.
- Existing employees whose HR data may require updates.
- Employee records that already have a corresponding Okta identity.

The workflow uses HR and Okta data to determine the appropriate processing path.

Further lifecycle scenarios, including complete leaver processing and rehire handling, remain subject to additional implementation and validation.


## n8n Workflow

n8n acts as the orchestration layer between Frappe HR and Okta. It retrieves employee records, compares them with existing Okta identities, and routes eligible records for processing.

### Workflow Stages

| Stage | Description |
|---|---|
| 1. Retrieve HR Data | Fetch employee records from Frappe HR through its REST API. |
| 2. Split Employee Records | Process the retrieved employee records as individual workflow items. |
| 3. Authenticate with Okta | Obtain an Okta API access token using a client assertion. |
| 4. Retrieve Okta Users | Fetch existing Okta users for identity comparison. |
| 5. Compare Identities | Match HR records with Okta users using the Frappe HR Employee ID and Okta `profile.employeeNumber`. |
| 6. Evaluate Employee Status | Check employee status and route eligible records for further processing. |
| 7. Create Okta User | Send eligible new employee records to the Okta user creation operation. |

### Workflow Design

The workflow separates HR data retrieval, identity comparison, and Okta account operations into distinct stages.

This design makes it easier to inspect individual steps, troubleshoot API responses, and extend the automation as additional lifecycle scenarios are implemented.

The current implementation focuses on HRIS-to-Okta synchronization and eligible user creation. Complete leaver processing and rehire handling require further implementation and validation.