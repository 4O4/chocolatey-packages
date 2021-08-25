$ErrorActionPreference = 'Stop';


$packageName= 'sshfs'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  file           = Get-Item $toolsDir\*-x86.msi
  file64         = Get-Item $toolsDir\*-x64.msi
  softwareName  = 'SSHFS-Win*'

  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`" ALLUSERS=1"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyInstallPackage @packageArgs
