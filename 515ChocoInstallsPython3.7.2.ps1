$script:logFolder = "C:\BootStrap"
If (Test-Path $logFolder)
{
  $script:logFile = Join-Path -Path $logFolder -ChildPath "PythonInstall.txt"
  choco install python --version=3.7.2 --force -y | Tee-Object -FilePath $logFile
}
Else
{
  choco install python --version=3.7.2 --force -y
}
