# Author - Zen Futral
# Created for use at Xidax

# This script runs RoboCopy, it's nothing special. It just creates a department standard that everyone used.


# Requires -RunAsAdministrator
Start-Transcript -OutputDirectory "C:\Windows\PSLogs\RoboCopy\" -NoClobber

$source = Read-Host "Source Directory"
$dest = Read-Host "Destination Directory"

$date = Get-Date
$date = $date -replace "/", "-"
$date = $date -replace ":", "-"
$date = $date -replace " ", "_"
$logFileName = $dest + "\LOG_" + $date + ".txt"

robocopy $source $dest /copyall /e /pf /v /fp /bytes /eta /tee /log:"$logFileName"
pause