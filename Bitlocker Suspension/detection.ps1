try {
    $bitlockerStatus = Get-BitLockerVolume -MountPoint "C:" -ErrorAction Stop

    if ($bitlockerStatus.ProtectionStatus -eq "Suspended") {
        Write-Host "Detection: Bitlocker is suspended on C:."
        exit 1
    } else {
        Write-Host "Detection: Bitlocker is not suspended on C: (Status: $($bitlockerStatus.ProtectionStatus))."
        exit 0
    }

} catch {
    Write-Host "Detection Error: Could not get Bitlocker status for C: or an error occurred: $($_.Exception.Message)"
    exit 1
}