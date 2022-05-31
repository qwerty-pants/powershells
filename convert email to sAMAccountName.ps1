#Get SAM Name, EmailAddress, Title, Department and Company from a list of Email Addresses

Get-Content "C:\Temp\testemail2.csv" |
ForEach-Object { Get-ADUser -Filter {EmailAddress -eq $_} -Properties EmailAddress, SamAccountName, Title, Department, Company } |
Select-Object EmailAddress, SamAccountName, Title, Department, Company |
Export-CSV "C:\Temp\testSAM2.csv" -NoTypeInformation
