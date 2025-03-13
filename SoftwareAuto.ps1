$host.UI.RawUI.WindowTitle = "Byte Fix Up - Software Installer"

Write-Host "`n====================================="
Write-Host "     Byte Fix Up - Auto Installer"
Write-Host "=====================================`n"

Write-Host "[>] Downloading chrome.zip..." -NoNewline
$stopwatch = [System.Diagnostics.Stopwatch]::StartNew()
$client = New-Object System.Net.WebClient
$file = "chrome.zip"
$url = "https://drive.google.com/uc?export=download&id=1IGTDCEFe9BiBKCJwxWDdeBiXG3OqG3AO"

try {
    $client.DownloadFile($url, $file)
    $stopwatch.Stop()
    Write-Host " [OK] Done! [$($stopwatch.Elapsed.TotalSeconds.ToString("0.00")) sec]"
} catch {
    Write-Host " [X] Download Failed!"
    Read-Host "`nPress Enter to exit"
    exit
}

Write-Host "`n[~] Extracting files..."
try {
    Expand-Archive -Force -Path $file -DestinationPath "Extracted"
    Write-Host "[OK] Extraction Complete!"
} catch {
    Write-Host "[X] Extraction Failed!"
    Read-Host "`nPress Enter to exit"
    exit
}

$installer = ".\Extracted\ChromeSetup.exe"
Write-Host "`n[>>] Launching Installer: ChromeSetup.exe..."

$process = Start-Process $installer -Wait -PassThru

if ($process.ExitCode -eq 0) {
    Write-Host "[OK] Installation Completed Successfully!"
} else {
    Write-Host "[X] Installation Failed or was Cancelled! (Exit Code: $($process.ExitCode))"
}

Write-Host "`n[!] Press Enter to exit"
Read-Host
