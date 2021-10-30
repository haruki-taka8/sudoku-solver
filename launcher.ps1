
# Check main executable
if (!(Test-Path '.\sudoku.exe')) {
    Write-Error 'sudoku.exe cannot be found.'
    Exit 1
}

# Check configuration file
if (!(Test-Path '.\defaults.ini')) {
    Write-Warning 'Configuration file not found; creating a default file'
    (
        'interactive=FALSE',
        'verbose=TRUE',
        'theme=Switch',
        'input=Space',
        'inputFile=stdin',
        '',
        '; Option values are case and space-sensitive',
        '',
        '; interactive',
        '; --------------------------------------------------------------',
        '; DEFAULT FALSE  -  ACCEPTS TRUE/FALSE',
        '; Pause after each iteration with cell modified',
        '',
        '; verbose',
        '; --------------------------------------------------------------',
        '; DEFAULT TRUE   -  ACCEPTS TRUE/FALSE',
        '; Whether or not output each step to Sudoku_Steps_xxxxxxxxx.txt',
        '',
        '; theme',
        '; --------------------------------------------------------------',
        '; DEFAULT Switch  -  ACCEPTS Plain OR Switch OR E257',
        '',
        '; input',
        '; --------------------------------------------------------------',
        '; DEFAULT Space   -  ACCEPTS Space OR Continuous',
        '; Space       Delimit each number with space, 0 for empty cells, single or multi-line allowed',
        '; Continuous  No delimiter between characters, use space or 0 or . for empty cells, single line only',
        '',
        '; inputFile',
        '; --------------------------------------------------------------',
        '; DEFAULT stdin   -  ACCEPTS stdin OR a valid file name',
        '; The program will read the sudoku board from the inputFile file',
        ''
    ) | Out-File '.\defaults.ini' -Encoding ASCII

}

Write-Host
Write-Host 'Starting sudoku'
& .\sudoku.exe