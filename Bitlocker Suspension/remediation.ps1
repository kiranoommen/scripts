Start-Sleep -Seconds 5

try {
    $bitlockerStatus = Get-BitLockerVolume -MountPoint "C:" -ErrorAction Stop

    if ($bitlockerStatus.ProtectionStatus -eq "Suspended") {
        Write-Host "Remediation: Attempting to resume Bitlocker on C:..."
        Resume-BitLocker -MountPoint "C:" -Force -ErrorAction Stop
        Write-Host "Remediation: Resume-BitLocker command issued for C:."
        exit 0
    } elseif ($bitlockerStatus.ProtectionStatus -eq "On") {
         Write-Host "Remediation: Bitlocker is already On on C:. No action needed."
         exit 0
    } else {
         Write-Host "Remediation: Bitlocker status on C: is '$($bitlockerStatus.ProtectionStatus)'. Cannot resume from this state."
         exit 0
    }

} catch {
    Write-Host "Remediation Error: Could not resume Bitlocker on C: or an error occurred: $($_.Exception.Message)"
    exit 1
}