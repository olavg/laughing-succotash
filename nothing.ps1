Add-Type -AssemblyName System.Windows.Forms

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

    # Check if the current time is 5 PM or later
    $currentTime = Get-Date
    if ($currentTime.Hour -ge 17) {
        break  # Exit the loop
    }
} while ($true)
