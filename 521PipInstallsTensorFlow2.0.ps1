$script:logFolder = "C:\BootStrap"
If (Test-Path $logFolder)
{
  $script:logFile = Join-Path -Path $logFolder -ChildPath "TensorFlowInstall.txt"
  pip install --upgrade tensorflow==2.0 | Tee-Object -FilePath $logFile
}
Else
{
  pip install --upgrade tensorflow==2.0
}
