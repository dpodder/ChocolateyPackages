$packageName = 'flagfox-firefox'
$url         = 'https://addons.cdn.mozilla.net/user-media/addons/5791/flagfox-5.1.18-fx+sm.xpi'
$checksum    = 'AE3D10F1CE119E700C624C373B9C6BAEA8FA7381006905E6795032D91A430094'
$extensionID = "{1018e4d6-728f-4b20-ad56-37578a4de76b}"

if(test-path 'hklm:\SOFTWARE\Mozilla\Firefox\TaskBarIDs'){
	$installDir = Get-Item -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Mozilla\Firefox\TaskBarIDs | Select-Object -ExpandProperty Property
}
if(test-path 'hklm:\SOFTWARE\Wow6432Node\Mozilla\Firefox\TaskBarIDs'){
	$installDir = Get-Item -Path Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Wow6432Node\Mozilla\Firefox\TaskBarIDs | Select-Object -ExpandProperty Property
}

$browserFolder = Join-Path $installDir "browser"
$extensionsFolder = Join-Path $browserFolder "extensions"
$extFolder = Join-Path $extensionsFolder "$extensionID"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $extFolder
  fileType      = 'ZIP' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256' 
}

if (!(Test-Path $extFolder)) {
	New-Item -Force -ItemType directory -Path $extFolder 
	Install-ChocolateyZipPackage @packageArgs
}
else {
	Write-Host "$packageName already exists"
}
