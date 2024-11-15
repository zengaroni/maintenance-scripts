# Author - Zen Futral
# Created for use at Xidax

# This script is a simple ping test, it provides a cleaner output meant to be easily read among other system tests


Start-Transcript -OutputDirectory "C:\Windows\PSLogs\PingTest\" -NoClobber

function Ping-GoogleDNS ([int]$sucPing=0, [int]$failPing=0) {
	if (Test-Connection 8.8.8.8 -Count 2 -Quiet) {
		[int]$sucPing += 1
		Clear-Host
		Write-Host "Ping Succesful"
		Write-Host "Failed:", $failPing, " Succesful:", $sucPing

	} else {
		[int]$failPing += 1
		Clear-Host
		Write-Host "Ping Failed"
		Write-Host "Failed:", $failPing, " Succesful:", $sucPing
		Start-Sleep -s 1	# Failing errors out. Makes it unreadable. This just slows things down.
	}

	Ping-GoogleDNS $sucPing $failPing
}


Write-Host "Testing Loop-Back"
if (!(Test-Connection 127.0.0.1 -Count 1 -Quiet)) {	# Check Loop Back
		Clear-Host
		Write-Host "Unable to Ping Host System"
		Write-Host "Script Cannot Continue, Manual Intervention Required"
		ipconfig
		Pause
} else {
	Write-Host "Loop Back Succesful, Proceeding With Test"
	Ping-GoogleDNS
} 
pause