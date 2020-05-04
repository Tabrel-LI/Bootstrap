$script:logFolder = "C:\BootStrap"
New-Item $logFolder -ItemType Directory -Force

# Install Chocolatey.
If (Test-Path $logFolder)
{
  $script:logFile = Join-Path -Path $logFolder -ChildPath "ChocoInstall.txt"
  Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1')) | Tee-Object -FilePath $logFile
}
Else
{
  Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
}

# Choco installs Posh-Git.
If (Test-Path $logFolder)
{
  $script:logFile = Join-Path -Path $logFolder -ChildPath "PoshgitInstall.txt"
  choco upgrade poshgit -y | Tee-Object -FilePath $logFile
}
Else
{
  choco upgrade poshgit -y
}

# Choco installs Python 3.7.2.
If (Test-Path $logFolder)
{
  $script:logFile = Join-Path -Path $logFolder -ChildPath "PythonInstall.txt"
  choco install python --version=3.7.2 --force -y | Tee-Object -FilePath $logFile
}
Else
{
  choco install python --version=3.7.2 --force -y
}

# pip is needed to install Tensorflow, but pip won't run in same session
# that Python was installed in and we can't create another local session on VM.
# Pull pip scripts from GitHub and run those in VM.  Maybe set a run-once to
# do it for us.

# Try reloading env var from Registry, although this doesn't completely load all.
refreshenv

# Pull from GitHub.
Try
{
  $script:gitFolder = "C:\Repos"
  New-Item $gitFolder -ItemType Directory -Force
  Set-Location -Path $gitFolder
  git clone https://github.com/Tabrel-LI/Bootstrap.git
  git clone https://github.com/Tabrel-LI/TensorFlow.git
}
Catch
{
  $script:logFile = Join-Path -Path $logFolder -ChildPath "errors.txt"
  $message = "ERROR - " + $MyInvocation.MyCommand.Name
  Write-Warning $message | Tee-Object -FilePath $logFile
  Write-Error "Exception Type: $($_.Exception.GetType().FullName)" | Tee-Object -FilePath $logFile
  Write-Error "Exception Message: $($_.Exception.Message)" | Tee-Object -FilePath $logFile
  $i = $_.InvocationInfo
  $infoMessage = "Line: " + $i.ScriptLineNumber.ToString() + " OffSet:" + $i.OffsetInLine.ToString() + " " + $i.Line
  Write-Warning $infoMessage | Tee-Object -FilePath $logFile
}