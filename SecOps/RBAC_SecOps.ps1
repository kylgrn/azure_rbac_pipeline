
#New Custom Azure role definition
$RoleName = 'Custom Security Operations Group'
$RoleDef = Get-AzRoleDefinition $RoleName 

<#
#####
###########This is the section where you define the permissions this custom role is granted###########
#####
#>
$perms = 'Microsoft.Storage/*/read','Microsoft.Network/*/read','Microsoft.Compute/*/read'
$perms += 'Microsoft.Compute/virtualMachines/start/action','Microsoft.Compute/virtualMachines/restart/action'
$perms += 'Microsoft.Authorization/*/read'
$perms += 'Microsoft.ResourceHealth/availabilityStatuses/read'
$perms += 'Microsoft.Resources/subscriptions/resourceGroups/read'
$perms += 'Microsoft.Insights/alertRules/*','Microsoft.Support/*'
$perms += 'Microsoft.Web/*/read'
$perms += 'Microsoft.Web/*/write'
<#
#####
######################################################################################################
#####
#>

#These are the actions explicitly not allowed by the custom role
$notperms = '*/delete'
$subs = '/subscriptions/8ee2aaf4-8329-4aa2-afa2-21cda345f7d4','/subscriptions/a70ba5e6-f570-4c74-ba83-aa1f6c9f010a'

if ($RoleDef -eq $null)
{
Write-host "Existing role not found"
$role = [Microsoft.Azure.Commands.Resources.Models.Authorization.PSRoleDefinition]::new()
$role.Name = $RoleName
$role.Description = 'Custom App Dev Role'
$role.IsCustom = $true
$role.Actions = $perms
$role.AssignableScopes = $subs
$role.NotActions = $notperms
New-AzRoleDefinition -Role $role
Write-host "Creating new Azure Role Definition"
}
else 
{
    write-host "Existing role found, updating permissions"
    $ExistingRole = Get-AzRoleDefinition $RoleName
    $Setrole = [Microsoft.Azure.Commands.Resources.Models.Authorization.PSRoleDefinition]::new()
    $Setrole.Name = $ExistingRole.Name
    $Setrole.id += $ExistingRole.id
    $Setrole.Description = $ExistingRole.Description
    $Setrole.IsCustom = $ExistingRole.IsCustom
    $Setrole.Actions = $perms
    $Setrole.NotActions = $notperms
    $Setrole.AssignableScopes = $subs
 Set-AzRoleDefinition -Role $Setrole -Verbose
}