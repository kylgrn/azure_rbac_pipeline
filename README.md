# Azure "RBAC-as-Code" 
This solution uses an Azure DevOps CI/CD pipeline for deploying and managing custom RBAC role definitions in Azure. Creating and updating custom RBAC roles is currently only doable using PowerShell, CLI, or JSON. You can choose to use GitHub, Azure Repos, or one of the other supported repositories. 

This solution monitors a repo that contains custom Azure RBAC roles in JSON format. It will trigger a CI/CD pipeline anytime a new action, NotAction, or AssignableScope is changed.  

**Things to note in this version**

- Removing JSON templates from the repo will *not* result in the custom role being deleted, it must be manually removed
- You **cannot rename the roles**, if you rename a role through the JSON it will create a duplicate role with a new automatically assigned id
- The templates in the "roles" folder are just examples, these can also be named however you would like without requiring changes to ActionRole.ps1

![alt text](https://github.com/kylgrn/azure_rbac_pipeline/blob/master/images/AzureRBACDevOps.png)

**Step 1:** Create an Azure DevOps account if you haven't already. This process can be started by visiting the landing page at: https://dev.azure.com
![alt text](https://github.com/kylgrn/azure_rbac_pipeline/blob/master/images/1-SignUp.png)

**Step 2:** Create a new project, in my example I called it "azure_rbac_pipeline", select whether it's "public" or "private" and create the project.

**Step 4:** Clone this repository and store in the repository of your choice. 

**Step 5:** Create a service connection for DevOps to use in Azure. When granting permissions, you can do so at the resource group, subscription, or management group level. This particular pipeline and solution is managing objects at the Azure AD tenant level, so the scope won't be important here as the changes will be global. https://docs.microsoft.com/en-us/azure/devops/pipelines/library/connect-to-azure?view=azure-devops 
![alt text](https://github.com/kylgrn/azure_rbac_pipeline/blob/master/images/2-Account.png)

Take note of the "Connection Name" you define as you'll need to update the azure-pipelines.yml and define it as the value for "azureSubscription":
![alt text](https://github.com/kylgrn/azure_rbac_pipeline/blob/master/images/3-AccountInfo.png)

**Step 6:** In the Azure portal, you'll need to grant the account created in step 5 the "User Access Administrator" role. This will allow the role to create, update, and delete custom roles in Azure AD. 

Here you can see my account and the "User Access Administrator" role granted to it:
![alt text](https://github.com/kylgrn/azure_rbac_pipeline/blob/master/images/4-Permissions.png)
