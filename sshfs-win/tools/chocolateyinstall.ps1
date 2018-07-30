$ErrorActionPreference = 'Stop';


$packageName= 'sshfs-win'
$toolsDir   = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
#$fileLocation = Join-Path $toolsDir 'NAME_OF_EMBEDDED_INSTALLER_FILE'

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'MSI'
  url           = 'https://github.com/billziss-gh/sshfs-win/releases/download/v2.7.17334/sshfs-win-2.7.17334-x86.msi' # download url, HTTPS preferred
  url64bit      = 'https://github.com/billziss-gh/sshfs-win/releases/download/v2.7.17334/sshfs-win-2.7.17334-x64.msi' # 64bit URL here (HTTPS preferred) or remove - if installer contains both (very rare), use $url
  #file         = $fileLocation

  softwareName  = 'SSHFS-Win*' #part or all of the Display Name as you see it in Programs and Features. It should be enough to be unique

  checksum      = '77A201B1623A34AFF40F7C26D916CA761BDA23C7E54557E6769BD9F9C0062D25'
  checksumType  = 'sha256' #default is md5, can also be sha1, sha256 or sha512
  checksum64    = '246B7CAA8C9B66C44AFF7629DA0A6767D405A5D78B7B81F429A5141C124DA1E1'
  checksumType64= 'sha256'

  silentArgs    = "/qn /norestart /l*v `"$($env:TEMP)\$($packageName).$($env:chocolateyPackageVersion).MsiInstall.log`"" # ALLUSERS=1 DISABLEDESKTOPSHORTCUT=1 ADDDESKTOPICON=0 ADDSTARTMENU=0
  validExitCodes= @(0, 3010, 1641)
}

#https://chocolatey.org/docs/helpers-install-chocolatey-package
Install-ChocolateyPackage @packageArgs
## If you are making your own internal packages (organizations), you can embed the installer or
## put on internal file share and use the following instead (you'll need to add $file to the above)
# https://chocolatey.org/docs/helpers-install-chocolatey-install-package
#Install-ChocolateyInstallPackage @packageArgs
