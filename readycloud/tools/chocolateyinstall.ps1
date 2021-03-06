﻿$ErrorActionPreference = 'Stop'
$packageName = 'readycloud' 
$toolsDir    = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$url         = 'http://readycloud.netgear.com/client/install/ReadyCloudSetup.exe'
$checksum    = '49B573C525538F9653A25673982EA2040FA79041FE8C10D9E025B5508D84ADDD'

$ahkExe = 'AutoHotKey'
$ahkFile = Join-Path $toolsDir "ReadyCLOUDinstall.ahk"
$ahkProc = Start-Process -FilePath $ahkExe `
                         -ArgumentList $ahkFile `
                         -PassThru

$ahkId = $ahkProc.Id
Write-Debug "$ahkExe start time:`t$($ahkProc.StartTime.ToShortTimeString())"
Write-Debug "Process ID:`t$ahkId"

$packageArgs = @{
  packageName   = $packageName
  unzipLocation = $toolsDir
  fileType      = 'EXE' 
  url           = $url
  checksum      = $checksum
  checksumType  = 'sha256'  
  silentArgs    = ''
  softwareName  = 'ReadyCLOUD' 
  }
Install-ChocolateyPackage @packageArgs
