# Azure "RBAC-as-Code" 
This solution uses an Azure DevOps CI/CD pipeline for deploying and managing custom RBAC role definitions in Azure. Creating and updating custom RBAC roles is currently only doable using PowerShell, CLI, or JSON. You can choose to use GitHub, Azure Repos, or one of the other supported repositories. 

![alt text](https://github.com/kylgrn/azure_rbac_pipeline/blob/master/images/AzureRBACDevOps.png)

**Step 1:** Create an Azure DevOps account if you haven't already. This process can be started by visiting the landing page at: https://dev.azure.com
![alt text](https://github.com/kylgrn/azure_rbac_pipeline/blob/master/images/1-SignUp.png)

**Step 2:** Create a new project, in my example I called it "azure_rbac_pipeline", select whether it's "public" or "private" and create the project.

**Step 4:** Clone this repository and store in the repository of your choice. 

**Step 5:** 