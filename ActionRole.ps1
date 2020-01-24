
<#
Script by Kyle Green
kylgrn@gmail.com

Purpose:
This script is called as part of an Azure DevOps pipeline build. The script relies on JSON templates structured for custom Azure role definitions, used for custom RBAC groups. 
When a JSON file is uploaded to the repository or an existing one is updated, the build will run and perform the following:
1) Check to see if the role already exists in Azure
2) If not, create new role
3) If one exists, check to see if any of the permissions (allowed or denied) have been updated
4) Update existing role
#>


#Inventory JSON files
$RoleTemplates = Get-ChildItem -Path D:\a\1\s\roles\*.JSON -Exclude package.json

foreach ($r in $RoleTemplates) {

#Check if role exists
$RoleGroup = Get-AzRoleDefinition -Name (get-content ('D:\a\1\s\roles\'+$r.name) | convertfrom-json).name 

#If no role exists, create new one
if ($rolegroup -eq $null) 
{
New-AzRoleDefinition -InputFile ('D:\a\1\s\roles\'+$r.name) 

}
#If role already exists, check to see if permissions changed
else
{
$newRoleGroup = $(get-content ('D:\a\1\s\roles\'+$r.name) | convertfrom-json)

$Compare = Compare-Object $RoleGroup $newRoleGroup -Property Actions,NotActions,AssignableScopes

    if( $compare -eq $null)
        {
            write-host 'No changes to custom definition:' $RoleGroup.name -ForegroundColor Yellow
        }
    else
    {
        write-host 'Updating permissions for custom definition:' $RoleGroup.name -ForegroundColor Green
       
        #Validate that the ID assigned by Azure is updated in the JSON template 
        $role = get-content -Path ('D:\a\1\s\roles\'+$r.name) | convertfrom-json 
        $azrole = Get-AzRoleDefinition -Name $role.name
        $role.id = $azrole.id
        $role | ConvertTo-Json | Set-Content -Path ('D:\a\1\s\roles\'+$r.name)
        Set-AzRoleDefinition -InputFile ('D:\a\1\s\roles\'+$r.name)
    }
}
}