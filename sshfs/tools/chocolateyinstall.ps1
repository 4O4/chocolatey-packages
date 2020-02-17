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
  checksum      = 'C8A6E5924F169C00E0AC55C859C5B52CFDA44F3459C426C5EC5861A914D42A5D'
  checksumType  = 'sha256'
  checksum64    = 'B3468016C3DDFC3F3B82F259674A1A9F3A5FAEF56AB4BD9620C58B97608F4FDC'
  checksumType64= 'sha256'

  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`" ALLUSERS=1"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs