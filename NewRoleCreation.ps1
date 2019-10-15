
#New Custom Azure role definition
$roleName = "Test RBAC Group"
$role = Get-AzRoleDefinition -Name $RoleName
          $role.Id = $null
          $role.Name = "Virtual Machine Operator"
          $role.Description = "Can monitor, start, and restart virtual machines."
          $role.Actions.RemoveRange(0,$role.Actions.Count)
          $role.Actions.Add("Microsoft.Compute/*/read")
          $role.Actions.Add("Microsoft.Compute/virtualMachines/start/action")
          $role.Actions.Add("Microsoft.Compute/virtualMachines/restart/action")
          $role.Actions.Add("Microsoft.Compute/virtualMachines/downloadRemoteDesktopConnectionFile/action")
          $role.Actions.Add("Microsoft.Network/*/read")
          $role.Actions.Add("Microsoft.Storage/*/read")
          $role.Actions.Add("Microsoft.Authorization/*/read")
          $role.Actions.Add("Microsoft.Resources/subscriptions/resourceGroups/read")
          $role.Actions.Add("Microsoft.Resources/subscriptions/resourceGroups/resources/read")
          $role.Actions.Add("Microsoft.Insights/alertRules/*")
          $role.Actions.Add("Microsoft.Support/*")
          $role.AssignableScopes.Clear()
          $role.AssignableScopes.Add("/subscriptions/xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx")

          New-AzRoleDefinition -Role $roleName