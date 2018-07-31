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
  checksum      = '77A201B1623A34AFF40F7C26D916CA761BDA23C7E54557E6769BD9F9C0062D25'
  checksumType  = 'sha256'
  checksum64    = '246B7CAA8C9B66C44AFF7629DA0A6767D405A5D78B7B81F429A5141C124DA1E1'
  checksumType64= 'sha256'

  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`" ALLUSERS=1"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs