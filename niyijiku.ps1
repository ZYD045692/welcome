# Create target folder in user directory
$userProfile = $env:USERPROFILE
$folderName = "nimeijiba"
$folderPath = Join-Path -Path $userProfile -ChildPath $folderName
New-Item -ItemType Directory -Path $folderPath -Force | Out-Null

# Define download URL
$url = "https://raw.githubusercontent.com/ZYD045692/ClickFix/main/nimeijiba.avif"
$outputFile = Join-Path -Path $folderPath -ChildPath "nimeijiba.avif"

# Download file silently
$progressPreference = 'silentlyContinue'
Invoke-WebRequest -Uri $url -OutFile $outputFile -UseBasicParsing | Out-Null

# Import SystemParametersInfo function from user32.dll
Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;
public class Wallpaper {
    [DllImport("user32.dll", CharSet = CharSet.Auto)]
    public static extern int SystemParametersInfo(int uAction, int uParam, string lpvParam, int fuWinIni);
}
"@

# Windows API constants for wallpaper setting
$SPI_SETDESKWALLPAPER = 0x0014
$SPIF_UPDATEINIFILE = 0x01
$SPIF_SENDCHANGE = 0x02

# Apply desktop wallpaper
[Wallpaper]::SystemParametersInfo($SPI_SETDESKWALLPAPER, 0, $outputFile, $SPIF_UPDATEINIFILE -bor $SPIF_SENDCHANGE) | Out-Null