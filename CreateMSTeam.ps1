$group = New-Team -MailNickname "TeamName" -displayname "DisplayName" -Visibility "private"
Add-TeamUser -GroupId $group.GroupId -User "user.name@email.com"
#create a team and add a user
