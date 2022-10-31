
$global:gitAvailableBranches = @()

function Get-AvailableBranches {
    try {

        (git branch -a 2>$null) |
        ForEach-Object { $_.Trim('*', ' ').Replace('remotes/', '') } |
        Where-Object { !$_.Contains('origin/HEAD') }
    }
    catch {
        @()
    }
}

function Get-CurrentBranch {
    try {
        $Branch = (git rev-parse --abbrev-ref HEAD)
        return $Branch
    }
    catch {
        return ""
    }
}

function Get-RepoDirtyFlag {
    try {
        $dirty = (git diff --quiet --ignore-submodules HEAD)
        return $dirty -ne 0
    }
    catch {
        return false
    }
}

function UpdateAvailableBranches($branches) {
    $global:gitAvailableBranches = $branches
}

function RefreshAvailableBranches {
    $branches = Get-AvailableBranches
    UpdateAvailableBranches $branches
}


function InitializeArgumentCompleter {
    Register-ArgumentCompleter -Native -CommandName git -ScriptBlock {
        param($wordToComplete, $commandAst, $cursorPosition)

        $command = [string]$commandAst
        $isCheckout = $command.Contains("git checkout") -Or $command.Contains("git switch")

        #[System.Diagnostics.Debug]::WriteLine("TestWrite $command Checkout = $isCheckout")

        # Note: startout like this, could narrow this by looking at what the actual command is
        $items = $global:gitAvailableBranches

        # Write-Host "Running completer for" $wordToComplete $items.Length
        $branch_matches = @()
        $branch_matches += $items |
        Where-Object { $_ -like "$wordToComplete*" } |
        Sort-Object

        $fuzzyMatches = @()
        $fuzzyMatches += $items |
        Where-Object { $_ -like "*$wordToComplete*" } |
        Sort-Object

        $m = $branch_matches + $fuzzyMatches | Select-Object -Unique

        if ($isCheckout) {
            # Filter out all 'origin/' - since during a checkout we most likely want a local branch
            $m = $m | ForEach-Object { $_.Replace("origin/", "") }
            $m = $m | Select-Object -Unique
        }

        # Write-Host "Matches  Length: " $m.Length

        # Write-Host "Got matches: " $m
        $m | ForEach-Object {
            # Write-Host "Returning " $_
            [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
        }
    }
}
