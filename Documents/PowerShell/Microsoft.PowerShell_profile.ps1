# http://serverfault.com/questions/95431
# function Test-Administrator {
#     $user = [Security.Principal.WindowsIdentity]::GetCurrent();
#     (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
# }
#

# Load GitUtils
$gitUtilsPath = $PSScriptRoot + '\GitUtils.ps1'
.$gitUtilsPath

function prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    RefreshAvailableBranches
    InitializeArgumentCompleter

    $arrowChar = [char]0xE0B0
    $branchChar = [char]0xE725
    $exclamChar = [char]0xF12A
    $timeFg = [ConsoleColor]::Black
    $timeBg = [ConsoleColor]::DarkBlue

    $timeBracketFg = [ConsoleColor]::Black

    $locationFg = [ConsoleColor]::DarkBlue
    $locationBg = [ConsoleColor]::DarkGray

    $branchFg = [ConsoleColor]::Black
    $branchBg = [ConsoleColor]::Green

    # Take a look at https://github.com/PoshCode/Pansies and see if we should redo the colors


    if ($null -ne $s) {
        # color for PSSessions
        Write-Host " (`$s: " -NoNewline -ForegroundColor DarkGray
        Write-Host "$($s.Name)" -NoNewline -ForegroundColor Yellow
        Write-Host ") " -NoNewline -ForegroundColor DarkGray
    }

    # Write-Host $arrowChar -BackgroundColor $timeBg -ForegroundColor Black -NoNewline
    Write-Host ($arrowChar + " ") -NoNewline -ForegroundColor $timeBracketFg -BackgroundColor $timeBg
    Write-Host (Get-Date -Format "HH:mm:ss") -NoNewline -ForegroundColor $timeFg -BackgroundColor $timeBg
    Write-Host " " -NoNewline -ForegroundColor $timeBracketFg -BackgroundColor $timeBg
    Write-Host $arrowChar -BackgroundColor $locationBg -NoNewline -ForegroundColor $timeBg
    Write-Host -NoNewline " " -BackgroundColor $locationBg
    Write-Host $($(Get-Location)) -NoNewline -ForegroundColor $locationFg -BackgroundColor $locationBg
    Write-Host " " -NoNewline -BackgroundColor $locationBg

    $currentBranch = Get-CurrentBranch
    if (![string]::IsNullOrEmpty($currentBranch)) {
        Write-Host $arrowChar -BackgroundColor $branchBg -ForegroundColor $locationBg -NoNewline
        Write-Host " " -NoNewline -BackgroundColor $branchBg
        Write-Host $branchChar -NoNewline -BackgroundColor $branchBg -ForegroundColor $branchFg
        Write-Host " " -NoNewline -BackgroundColor $branchBg
        Write-Host $currentBranch -BackgroundColor $branchBg -ForegroundColor $branchFg -NoNewline
        Write-Host " " -NoNewline -BackgroundColor $branchBg
        Write-Host $arrowChar -ForegroundColor $branchBg -NoNewline

        # Not used, too slow on windows for large repos
        # $repoDirty = Get-RepoDirtyFlag
        # if ($repoDirty) {
        #     Write-Host "dirty"
        # }

        $cherry = (git cherry -v)
        if ($cherry.Length -ne 0) {
            Write-Host " $exclamChar" -NoNewline -ForegroundColor Yellow
        }
    }
    else {
        Write-Host $arrowChar -ForegroundColor $locationBg -NoNewline
    }

    $currentCommand = ""
    $history = (Get-History)
    if ($history.Length -gt 0) {
        $currentCommand = $history[-1].commandLine
    }

    # See if we can find something acceptable speedwise for git-status in: https://gist.github.com/sindresorhus/3898739

    # test if branch has changed - if so, update available branches
    if (![string]::Equals($cb, $currentBranch) -or $currentCommand.Contains('checkout') -or $currentCommand.Contains('fetch')) {
        # Write-Host " BC " -NoNewline
        RefreshAvailableBranches
    }

    Set-Variable -Name "cb" -Scope global -Value $currentBranch

    $global:LASTEXITCODE = $realLASTEXITCODE

    if ($realLASTEXITCODE -ne 0 -and $null -ne $realLASTEXITCODE) {
        $message = $exclamChar + " $realLASTEXITCODE " + $exclamChar
        $startposx = $Host.UI.RawUI.windowsize.width - $message.length
        $startposy = $Host.UI.RawUI.CursorPosition.Y
        $Host.UI.RawUI.CursorPosition = New-Object System.Management.Automation.Host.Coordinates $startposx, $startposy
        $oldColor = $Host.UI.RawUI.ForegroundColor
        $Host.UI.RawUI.ForegroundColor = "DarkRed"
        $Host.UI.Write($message)
        $Host.UI.RawUI.ForegroundColor = $oldColor
    }

    Write-Host ""

    if ($profile_title -eq "") {
        $Host.UI.RawUI.WindowTitle = (Get-Item .).Name
    }

    $devenv = (Get-Command devenv)
    if ($devenv) {
        # VS icon
        return ([char]0xE70C) + " "
    } else {
        return ([char]0xEAD3) + " "
    }

    # return "> "
}

#Import-Module z
Import-Module -Name Terminal-Icons
Set-PSReadLineOption -PredictionSource None

Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
})

function Set-Title {
    param([string]$t)
    $Host.UI.RawUI.WindowTitle = $t
    Set-Variable -Name "profile_title" -Scope global -Value $t
}

#Set-PSReadLineKeyHandler -Key Tab -Function Complete

# Chocolatey profile
# $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
# if (Test-Path($ChocolateyProfile)) {
#     Import-Module "$ChocolateyProfile"
# }
