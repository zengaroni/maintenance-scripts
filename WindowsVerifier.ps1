﻿# Author - Zen Futral
# Created for use at Xidax

# This script automates frequent windows verification techniques


# Requires -RunAsAdministrator

Start-Transcript -OutputDirectory "C:\Windows\PSLogs\WinVer\" -NoClobber
Clear-Host

Write-Host "This script will fix windows store and windows apps, restart explorer.exe, run SFC & DISM, Run cleanmgr, then disable hybernation."
Write-Host "Make sure all work is saved, and that your recylce bin does not contain important documents"
$myInput = Read-Host "If you would like to proceed, enter 'Y'"

if ($myInput.ToLower() -eq "y") {
	Clear-Host
	Write-Host "Reseting Windows Store"
	wsreset.exe
	Start-Sleep -Seconds 3
	Get-Process -name winstore.app | Stop-Process
	
	Write-Host "Registering AppXManifests"
	Get-AppXPackage -AllUsers | ForEach-Object {Add-AppxPackage -DisableDevelopmentMode -Register "$($_.InstallLocation)\AppXManifest.xml"}
	Clear-Host

	Write-Host "Restarting Explorer.exe"
	Get-Process -name *explorer* | Stop-Process
	Start-Sleep -Seconds 3
	Clear-Host
	
	Write-Host "Disabling Hybernation"
	powercfg /hibernate off
	Clear-Host

	Write-Host "Performing SFC & DISM Scans"
	sfc /scannow
	Dism.exe /Online /Cleanup-Image /RestoreHealth
	Dism.exe /Online /Cleanup-Image /StartComponentCleanup
	sfc /scannow

 	Write-host "Performing Final Cleanup"
  	start /b cmd.exe "/c cleanmgr /verlowdisk"
   	chkdsk /b /f /r

	shutdown /r
}

