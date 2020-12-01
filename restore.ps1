#Written by: Kenneth B Shinn Jr. Student Number: #001222768

#Clears powershell command line
Clear-Host

#Try Statement begins here
Try 
    {

    #Creates a PowerShell Session to a AD Domain Controller called dc01.ucertify.com if required you can uncomment it out
    #$ADSession = New-PSSession -ComputerName dc01.ucertify.com -ErrorAction Stop
    #Imports Active Directory Modules from AD Domain Controller for the purpose of this session. If you need it you can uncomment it as well. 
    #Import-Module -PSsession $ADSession -Name ActiveDirectory -ErrorAction Stop
    #Creates Finance OU off the root in the uCertify.com Domain
    New-ADOrganizationalUnit -Name "finance" -Path "DC=uCertify,DC=com"
    #Imports users from provided CSV file and turns it into the ADUsers Variable
    $ADUsers = Import-CSV -path .\financePersonnel.csv -ErrorAction Stop

    #Begin creating Variables data being imported into AD
    foreach ($User in $ADUsers)
    {
    #This is the list of Variables from Spreadsheet a required for the Task
    $Username = $User.samAccount
    $Firstname = $User.First_Name
    $Lastname = $User.Last_Name
    $Displayname = $Firstname + " " + $Lastname
    $PostalCode = $User.PostalCode
    $OfficePhone = $User.OfficePhone
    $MobilePhone = $User.MobilePhone
    $OU = "OU=finance,DC=uCertify,DC=com"


    #Creates AD User based on information imported above. Each Variable is translated into a user attribute  in AD. 
    New-ADUser -Name "$Displayname" -DisplayName "$Displayname" -UserPrincipalName "$Username" -samAccountName "$Username" -GivenName "$Firstname" -Surname "$Lastname" -Path "$OU" -PostalCode "$PostalCode" -OfficePhone "$OfficePhone" -MobilePhone "$MobilePhone"

    }


    #Creates a PowerShell Session to an SQL Server called SQL01.ucertify.com. You can uncomment this if you need it
    #$SQLSession = New-PSSession -ComputerName UCERTIFY3
    #Imports SQL Server Modules from SQL Server for this session. You can uncomment this if you need it. 
    #Import-Module -PSsession $SQLSession -Name SQLServer


    #This will install the SQLServer Module from the PowerShell Gallery
    Install-Module -Name SQLServer -Confirm:$false -Force -AllowClobber

    #This Command Creates a new Database in the SQL Server Instance
    Invoke-Sqlcmd -Query "CREATE DATABASE ClientDB" -ServerInstance .\UCERTIFY3
    #This will import the NewClientData.csv, specify the headers, and then pipe the results into Write-SQLTableData which will create a new Table with the data from the import in the Database we just created. 
    Import-CSV -path .\NewClientData.csv | Write-SqlTableData -ServerInstance ".\UCERTIFY3" -DatabaseName "ClientDB" -TableName "Client_A_Contacts" -SchemaName "dbo" -Force

}
 Catch [System.OutOfMemoryException]
 {
    $ErrorMessage = System.OutOfMemoryException
 }