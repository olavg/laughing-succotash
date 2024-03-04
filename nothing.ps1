Add-Type @"
    using System;
    using System.Runtime.InteropServices;

    public class MouseEvents {
        [DllImport("user32.dll")]
        public static extern void mouse_event(int dwFlags, int dx, int dy, int dwData, int dwExtraInfo);

        public const int MOUSEEVENTF_MOVE = 0x0001;
    }
"@

do {
    # Move mouse cursor one pixel to the left
    [MouseEvents]::mouse_event([MouseEvents]::MOUSEEVENTF_MOVE, -1, 0, 0, 0)
    Start-Sleep -Milliseconds 100
    # Move mouse cursor one pixel to the right
    [MouseEvents]::mouse_event([MouseEvents]::MOUSEEVENTF_MOVE, 1, 0, 0, 0)
    # Wait for one minute
    Start-Sleep -Seconds 60
} while ($true)
