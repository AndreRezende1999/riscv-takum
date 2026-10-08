# Convenience launcher; no environment changes or package installation.
$ErrorActionPreference = 'Stop'
$bundledPython = Join-Path $env:USERPROFILE '.cache\codex-runtimes\codex-primary-runtime\dependencies\python\python.exe'
if (Test-Path -LiteralPath $bundledPython) {
    $pythonExecutable = $bundledPython
} else {
    $pythonCommand = Get-Command python -ErrorAction SilentlyContinue
    if (-not $pythonCommand) { throw 'Python 3.10+ não encontrado. Use o executável do seu ambiente.' }
    $pythonExecutable = $pythonCommand.Source
}
$taskArguments = @($args)
Push-Location -LiteralPath $PSScriptRoot
try {
    if ($taskArguments.Count -gt 0 -and $taskArguments[0] -eq 'test') {
        & $pythonExecutable -m unittest discover -s tests -v
    } elseif ($taskArguments.Count -gt 0 -and $taskArguments[0] -eq 'validate') {
        $validationArguments = @($taskArguments | Select-Object -Skip 1)
        & $pythonExecutable tools/run_validation.py @validationArguments
    } else {
        & $pythonExecutable -m takum_rvv @taskArguments
    }
    $taskExitCode = $LASTEXITCODE
} finally {
    Pop-Location
}
exit $taskExitCode
