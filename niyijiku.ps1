$userProfile = $env:USERPROFILE
$folderName = "nimeijiba"
$folderPath = Join-Path -Path $userProfile -ChildPath $folderName
New-Item -ItemType Directory -Path $folderPath -Force | Out-Null

$url = "https://raw.githubusercontent.com/ZYD045692/welcome/main/nimeijiba.avif"
$outputFile = Join-Path -Path $folderPath -ChildPath "nimeijiba.avif"

$progressPreference = 'silentlyContinue'
Invoke-WebRequest -Uri $url -OutFile $outputFile -UseBasicParsing | Out-Null

Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

$SPI_SETDESKWALLPAPER = 0x0014
$SPIF_UPDATEINIFILE = 0x01
$SPIF_SENDCHANGE = 0x02

[Wallpaper]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $outputFile, $SPIF_UPDATEINIFILE -bor $SPIF_SENDCHANGE) | Out-Null

if (Get-Process -Name "wallpaper32" -ErrorAction SilentlyContinue) {
    Stop-Process -Name "wallpaper32" -Force
}
elseif (Get-Process -Name "wallpaper64" -ErrorAction SilentlyContinue) {
    Stop-Process -Name "wallpaper64" -Force
}