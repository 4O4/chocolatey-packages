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
  checksum      = '9643DAF27EB7E384DADC9E64A4299C8D92E6C91E07913E9425F5B19AAD3B2DED'
  checksumType  = 'sha256'
  checksum64    = '1657E397F8DCE1C2D2E3220007F9C9F882631882B9BEC4608F7835E87DCD096C'
  checksumType64= 'sha256'

  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`" ALLUSERS=1"
  validExitCodes= @(0, 3010, 1641)
}

Install-ChocolateyPackage @packageArgs
