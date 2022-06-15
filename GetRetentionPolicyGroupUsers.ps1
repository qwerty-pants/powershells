#get the users for each retention policy and Connect to IPPSSession

$Mailboxes = (Get-RetentionCompliancePolicy -Identity "Retention policy name" -DistributionDetail | Select -ExpandProperty ExchangeLocation)
$(Foreach ($policyLocation in $Mailboxes) {
New-Object PSObject -Property @{
DisplayName = $policyLocation.DisplayName
UPN = $policyLocation.name
}
} ) | select-object -Property DisplayName, UPN | Export-Csv -Path "c:\temp\retention.csv" -NoTypeInformation


#Connect to ExchangeOnline 

import-csv "D:\export\retention\Retention policy name.csv" | Foreach {$SMTPAddress=$_.UPN
Get-MailboxStatistics -identity $SMTPAddress | Select-Object @{Name="SMTPAddress";Expression={$SMTPAddress}},LastUserActionTime,DisplayName} | Export-Csv "D:\Export\retention-1\Retention policy name.csv"
