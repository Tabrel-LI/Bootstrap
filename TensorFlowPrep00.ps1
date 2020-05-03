$script:scriptDirectory = Split-Path $MyInvocation.MyCommand.Path

$prep01 = Join-Path -Path $script:scriptDirectory -ChildPath "TensorFlowPrep01.ps1"
<#
$hashArgs = @{}
$hashArgs = @{
  "WebSiteNames" = $arrSplat
  "Action" = $Action
}
#>
If (Test-Path $prep01) {
  $session = New-PSSession
  #$results = Invoke-Command -Session $session -ScriptBlock $block -ArgumentList $hashArgs
  Invoke-Command -Session $session -FilePath $prep01
  Remove-PSSession -Session $session
}

$prep02 = Join-Path -Path $script:scriptDirectory -ChildPath "TensorFlowPrep02.ps1"
If (Test-Path $prep02) {
  $session = New-PSSession
  Invoke-Command -Session $session -FilePath $prep02
  Remove-PSSession -Session $session
}
