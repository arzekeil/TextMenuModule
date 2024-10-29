function Show-TextMenu {
    param (
        [Parameter(Mandatory=$true)]
        [string[]]$Options
    )

    # Initialize the selection index
    $currentSelection = 0

    # Function to display the menu with the current selection highlighted
    function Show-Menu {
        Clear-Host
        Write-Host "Use the UP and DOWN arrows to navigate, and press ENTER to select."
        for ($i = 0; $i -lt $Options.Length; $i++) {
            if ($i -eq $currentSelection) {
                Write-Host "> $($Options[$i])" -ForegroundColor Cyan
            } else {
                Write-Host "  $($Options[$i])"
            }
        }
    }

    # Display the menu and capture arrow key input
    Show-Menu
    do {
        # Read key press
        $key = $host.UI.RawUI.ReadKey("NoEcho, IncludeKeyDown").VirtualKeyCode
        switch ($key) {
            # Up arrow
            38 {
                # Move selection up
                $currentSelection = if ($currentSelection -gt 0) { $currentSelection - 1 } else { $Options.Length - 1 }
                Show-Menu
            }
            # Down arrow
            40 {
                # Move selection down
                $currentSelection = if ($currentSelection -lt $Options.Length - 1) { $currentSelection + 1 } else { 0 }
                Show-Menu
            }
            # Enter key
            13 {
                # Return the selected option
                return $Options[$currentSelection]
            }
        }
    } while ($true)
}

Export-ModuleMember -Function Show-TextMenu
