
$RoleTemplates = Get-ChildItem "./" -Filter *.JSON


foreach ($r in $RoleTemplates) {

#Check if role exists
$RoleGroup = Get-AzRoleDefinition -Name (get-content ('./'+$r.name) | convertfrom-json).name 


if ($rolegroup -eq $null) 
{
New-AzRoleDefinition -InputFile ('./'+$r.name) 

}
else
{
$newRoleGroup = $(get-content ('./'+$r.name) | convertfrom-json)

$Compare = Compare-Object $RoleGroup $newRoleGroup -Property Actions,NotActions,AssignableScopes

    if( $compare -eq $null)
        {
            write-host 'No changes to custom definition:' $RoleGroup.name -ForegroundColor Yellow
        }
    else
    {

    Set-AzRoleDefinition -InputFile ('./'+$r.name)
    write-host 'Updating permissions for custom definition: $RoleGroup.name' -ForegroundColor Green
    }
}
}



