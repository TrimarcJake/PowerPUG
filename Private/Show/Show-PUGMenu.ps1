using namespace Terminal.Gui
function Show-PUGMenu {
    #requires -Modules Microsoft.PowerShell.ConsoleGuiTools
    $Module = (Get-Module Microsoft.PowerShell.ConsoleGuiTools -List).ModuleBase
    Add-Type -Path (Join-Path $Module Terminal.Gui.dll)

    # Initialize the window
    [Application]::Init()

    # Create the window to use
    $Window = [Window]::New()
    $Window.Title = 'Label Window'

    # Do Stuff
    [Application]::Top.Add($Window)
    [Application]::Run()

    # Shut it down
    [Application]::Shutdown()
}