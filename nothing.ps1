Add-Type @"
    using System;
    using System.Runtime.InteropServices;

    public class MouseEvents {
        [DllImport("user32.dll")]
        public static extern void mouse_event(int dwFlags, int dx, int dy, int dwData, int dwExtraInfo);
        [DllImport("user32.dll")]
        public static extern bool GetCursorPos(out POINT lpPoint);

        [StructLayout(LayoutKind.Sequential)]
        public struct POINT {
            public int X;
            public int Y;
        }

        public const int MOUSEEVENTF_MOVE = 0x0001;
    }
"@

do {
    # Get the current cursor position
    $point = New-Object MouseEvents.POINT
    [MouseEvents]::GetCursorPos([ref]$point)
    $xMove = 1  # Default movement to the right

    # If the cursor is too close to the left edge of the screen, move right instead
    if ($point.X -le 0) {
        $xMove = 1
    } else {
        $xMove = -1  # Move left if not close to the edge
    }

    # Move mouse cursor based on $xMove direction
    [MouseEvents]::mouse_event([MouseEvents]::MOUSEEVENTF_MOVE, $xMove, 0, 0, 0)
    Start-Sleep -Milliseconds 100

    # Move mouse cursor back to the original position
    [MouseEvents]::mouse_event([MouseEvents]::MOUSEEVENTF_MOVE, $xMove * -1, 0, 0, 0)

    # Wait for one minute
    Start-Sleep -Seconds 60

    # Check if the current time is 5 PM or later
    $currentTime = Get-Date
    if ($currentTime.Hour -ge 17) {
        break  # Exit the loop
    }
} while ($true)
