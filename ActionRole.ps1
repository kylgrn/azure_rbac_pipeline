

$RoleTemplates = Get-ChildItem -Path D:\a\1\s\*.JSON -Exclude package.json

foreach ($r in $RoleTemplates) {

#Check if role exists
$RoleGroup = Get-AzRoleDefinition -Name (get-content ('D:\a\1\s\'+$r.name) | convertfrom-json).name 


if ($rolegroup -eq $null) 
{
New-AzRoleDefinition -InputFile ('D:\a\1\s\'+$r.name) 

}
else
{
$newRoleGroup = $(get-content ('D:\a\1\s\'+$r.name) | convertfrom-json)

$Compare = Compare-Object $RoleGroup $newRoleGroup -Property Actions,NotActions,AssignableScopes

    if( $compare -eq $null)
        {
            write-host 'No changes to custom definition:' $RoleGroup.name -ForegroundColor Yellow
        }
    else
    {
        write-host 'Updating permissions for custom definition:' $RoleGroup.name -ForegroundColor Green
        Set-AzRoleDefinition -InputFile ('D:\a\1\s\'+$r.name)
    }
}
}


