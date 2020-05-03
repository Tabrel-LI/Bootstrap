$script:logFolder = "C:\BootStrap"
If (Test-Path $logFolder)
{
  $script:logFile = Join-Path -Path $logFolder -ChildPath "TensorFlowInstall.txt"
  pip install --upgrade tensorflow | Tee-Object -FilePath $logFile
}
Else
{
  pip install --upgrade tensorflow
}
