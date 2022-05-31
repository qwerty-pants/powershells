Import-Module ActiveDirectory #importing ad module

$UserList = get-content C:\temp\UsersList.txt #defining where the list and path are

Foreach ($Item in $UserList) { #start of foreach statement and declaration of item variable and calling userlist
$user = $null #clearing definition of variable
$Item = $Item.TrimEnd() #triming whitespace at the end
$user = Get-ADUser -Properties samAccountName,Enabled,AccountExpirationDate -filter {samAccountName -eq $Item} 
#defining user variable and storing the result of the query in user variable, filter for only samAccountNames in the userlist
if ($user) #if there is data in the user query append it to the csv
    {
    $user | Select-Object samAccountName,Enabled,AccountExpirationDate | Export-csv C:\temp\CheckedAccounts.csv -append -NoTypeInformation
    #starting from the left we're only selecting the 3 attributes then appending them to a csv then specify noTypeInformation so it removes the type header in the export
    }
else #otherwise
    {
        [PSCustomObject]@{ #mirroring objects(columns) defined for failed queries
            samAccountName = $Item #data that was queried, as defined above
            Enabled = "N\A" #hardcording na because there would be no data to report
            AccountExpirationDate = "N\A"} | Export-csv C:\temp\CheckedAccounts.csv -append -Force -NoTypeInformation #setting na in the list and specify noTypeInformation so it removes the type header in the export
                }
}
