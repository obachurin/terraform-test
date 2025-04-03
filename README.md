- Why was this specific VM type chosen?

Just cheap one. It will depends on app requirements which will be hosted in VM

- Were all necessary resources created to ensure the VM is accessible?

Yes. Resource group, vnet, nsg

- Is the Terraform code parameterized to allow reuse across different environments?

Yes. See config folder

- How can it be ensured that the VM is managed exclusively through Terraform?

Tags to set visibility. Lock access to VM for user which is used by CI only wheere terraform is executed

- What modifications are needed to make the code suitable for a team setup?

TF backend. Already added.

- How can the correct order of creating interdependent resources be ensured?

Using depends_on

- How can this code be executed automatically? Which Terraform commands make sense in which scenarios?

It can be run in CI.

terraform init -backend-config="config/dev.tfbackend"

terraform apply -auto-approve -var-file=config/dev.tfvars

- What are the advantages and disadvantages of using Terraform?

Advantages:
1. Infrastructure as Code (IaC)
Terraform allows you to define infrastructure using a declarative configuration language (HCL), enabling repeatable and automated deployments.

2. Multi-Cloud Support
Unlike cloud-specific tools (e.g., AWS CloudFormation), Terraform supports multiple cloud providers like AWS, Azure, GCP, and on-prem solutions.

3. State Management
Terraform maintains the state of infrastructure in a state file, allowing it to track changes and update resources incrementally.

4. Modular and Reusable Code
Terraform supports modules, enabling infrastructure components to be reusable and maintainable.

5. Declarative Approach
You define the desired end state, and Terraform automatically determines and applies the necessary changes.

6. Dependency Graph
Terraform automatically figures out resource dependencies and ensures correct provisioning order.

7. Plan and Apply Workflow
The terraform plan command previews changes before applying them with terraform apply, reducing risks.

8. Version Control and Collaboration
Terraform configurations can be stored in version control systems (e.g., Git), allowing teams to collaborate effectively.

9. Extensibility with Providers
Terraform has a vast ecosystem of providers, allowing users to manage not just cloud infrastructure but also SaaS services, DNS, databases, etc.

Disadvantages:
1. State Management Complexity
Managing the Terraform state file (especially in teams) requires careful handling, and misconfigurations can lead to data loss or infrastructure drift.

2. Learning Curve
Although Terraform uses HCL, understanding its syntax, state management, and best practices requires time and experience.

3. Limited Native Support for Procedural Logic
Terraform follows a declarative approach and lacks built-in loops and conditionals (although workarounds exist).

4. Performance Issues with Large Infrastructures
As Terraform configurations grow, state management and execution times can become slow, impacting efficiency.

5. Rollback Limitations
Unlike some tools (e.g., AWS CloudFormation, ARM, Bicep), Terraform does not natively support automatic rollback on failure, requiring manual interventions.
