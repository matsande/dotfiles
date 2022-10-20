# http://serverfault.com/questions/95431
# function Test-Administrator {
#     $user = [Security.Principal.WindowsIdentity]::GetCurrent();
#     (New-Object Security.Principal.WindowsPrincipal $user).IsInRole([Security.Principal.WindowsBuiltinRole]::Administrator)
# }

# Load GitUtils
$gitUtilsPath = $PSScriptRoot + '\GitUtils.ps1'
.$gitUtilsPath

RefreshAvailableBranches
InitializeArgumentCompleter

function prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    $arrowChar = [char]0xE0B0
    $branchChar = [char]0xE725
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
    } else {
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

    Write-Host ""

    return "> "
}

Import-Module z
Import-Module -Name Terminal-Icons

# Chocolatey profile
# $ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
# if (Test-Path($ChocolateyProfile)) {
#     Import-Module "$ChocolateyProfile"
# }