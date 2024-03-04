Add-Type -AssemblyName System.Windows.Forms

# Capture the script start time
$scriptStartTime = Get-Date

# Determine whether the script started before or after 5 PM
$endTime = if ($scriptStartTime.Hour -ge 17) {
    $scriptStartTime.AddHours(2) # Set end time to 2 hours after start time if started after 5 PM
} else {
    (Get-Date).Date.AddHours(17) # Set end time to today's 5 PM if started before 5 PM
}

do {
    # Get the current cursor position
    $X = [System.Windows.Forms.Cursor]::Position.X
    $Y = [System.Windows.Forms.Cursor]::Position.Y

    # Determine movement direction based on screen boundary
    if ($X -le 1) {
        $newX = $X + 1  # Move right if too close to the left edge
    } else {
        $newX = $X - 1  # Otherwise, move left
    }

    # Apply the calculated movement
    [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($newX, $Y)

    # Wait a bit before moving back to give the appearance of movement
    Start-Sleep -Milliseconds 100

    # Move cursor back to original position
    [System.Windows.Forms.Cursor]::Position = New-Object System.Drawing.Point($X, $Y)

    # Wait for one minute
    Start-Sleep -Seconds 60

    # Check the current time
    $currentTime = Get-Date
} while ($currentTime -lt $endTime) # Continue looping until the current time is less than the end time

Write-Output "Script has ended based on the time condition."
