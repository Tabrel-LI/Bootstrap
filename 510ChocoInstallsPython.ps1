$script:logFolder = "C:\BootStrap"
If (Test-Path $logFolder)
{
  $script:logFile = Join-Path -Path $logFolder -ChildPath "PythonInstall.txt"
  choco upgrade python -y | Tee-Object -FilePath $logFile
}
Else
{
  choco upgrade python -y
}
