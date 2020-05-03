$script:logFolder = "C:\BootStrap"
If (Test-Path $logFolder)
{
  $script:logFile = Join-Path -Path $logFolder -ChildPath "matplotlibInstall.txt"
  pip install --upgrade matplotlib | Tee-Object -FilePath $logFile
}
Else
{
  pip install --upgrade matplotlib
}
