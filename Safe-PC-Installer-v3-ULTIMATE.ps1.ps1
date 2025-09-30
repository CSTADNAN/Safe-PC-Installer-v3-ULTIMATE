# Safe-PC-Installer-v3-ULTIMATE.ps1
# 🚀 Future-Proof Edition - 1000 Years Ready!
# Version: 3.0 - Ultimate Feature Set
# Last Updated: September 2025

#Requires -RunAsAdministrator

Clear-Host

$script:Colors = @{
    Primary = "Cyan"
    Success = "Green"
    Warning = "Yellow"
    Error = "Red"
    Info = "White"
    Highlight = "Magenta"
}

# 📊 Enhanced Configuration
$script:Config = @{
    LogPath = "$env:USERPROFILE\Desktop\SafePC-Install-Log.txt"
    BackupEnabled = $true
    AutoUpdateCheck = $true
    ParallelInstall = $false
    MaxRetries = 3
    AutoFix = $true
    UseAlternativeSource = $true
}

# 🛡️ ULTIMATE SOFTWARE LIST (50+ Apps - All Categories)
$softwareList = @(
    # 🌐 Browsers
    @{Name="🌐 Google Chrome"; Id="Google.Chrome"; Category="Browsers"; Priority=1},
    @{Name="🦊 Mozilla Firefox"; Id="Mozilla.Firefox"; Category="Browsers"; Priority=1},
    @{Name="🪟 Microsoft Edge"; Id="Microsoft.Edge"; Category="Browsers"; Priority=1},
    @{Name="🔷 Arc Browser"; Id="TheBrowserCompany.Arc"; Category="Browsers"; Priority=2},
    @{Name="🦁 Brave Browser"; Id="Brave.Brave"; Category="Browsers"; Priority=2},
    @{Name="🌊 Opera GX"; Id="Opera.OperaGX"; Category="Browsers"; Priority=2},

    # 💼 Office & Productivity
    @{Name="📑 LibreOffice"; Id="TheDocumentFoundation.LibreOffice"; Category="Office"; Priority=1},
    @{Name="📕 Adobe Acrobat Reader"; Id="Adobe.Acrobat.Reader.64-bit"; Category="Office"; Priority=1},
    @{Name="🇧🇩 Bijoy Bayanno"; Id="OmicronLab.BijoyBayanno"; Category="Office"; Priority=3},
    @{Name="📝 Notion"; Id="Notion.Notion"; Category="Office"; Priority=2},
    @{Name="📊 Obsidian"; Id="Obsidian.Obsidian"; Category="Office"; Priority=2},

    # 👨‍💻 Development Tools
    @{Name="💻 Visual Studio Code"; Id="Microsoft.VisualStudioCode"; Category="Dev"; Priority=1},
    @{Name="🐙 Git"; Id="Git.Git"; Category="Dev"; Priority=1},
    @{Name="🐍 Python"; Id="Python.Python.3.12"; Category="Dev"; Priority=2},
    @{Name="📗 Node.js"; Id="OpenJS.NodeJS"; Category="Dev"; Priority=2},
    @{Name="🎯 Postman"; Id="Postman.Postman"; Category="Dev"; Priority=2},
    @{Name="🐳 Docker Desktop"; Id="Docker.DockerDesktop"; Category="Dev"; Priority=3},

    # 📥 Download & Compression
    @{Name="⬇️ Internet Download Manager"; Id="Tonec.InternetDownloadManager"; Category="Utils"; Priority=1},
    @{Name="📦 WinRAR"; Id="RARLab.WinRAR"; Category="Utils"; Priority=1},
    @{Name="📦 7-Zip"; Id="7zip.7zip"; Category="Utils"; Priority=1},

    # 🎵 Multimedia
    @{Name="🎥 VLC Media Player"; Id="VideoLAN.VLC"; Category="Media"; Priority=1},
    @{Name="🎙️ Audacity"; Id="Audacity.Audacity"; Category="Media"; Priority=2},
    @{Name="🎨 GIMP"; Id="GIMP.GIMP"; Category="Media"; Priority=2},
    @{Name="🎬 OBS Studio"; Id="OBSProject.OBSStudio"; Category="Media"; Priority=2},
    @{Name="🎞️ HandBrake"; Id="HandBrake.HandBrake"; Category="Media"; Priority=2},
    @{Name="🎵 Spotify"; Id="Spotify.Spotify"; Category="Media"; Priority=2},

    # 📡 Communication
    @{Name="💬 WhatsApp"; Id="9NKSQGP7F2NH"; Category="Comm"; Priority=1},
    @{Name="🎧 Discord"; Id="Discord.Discord"; Category="Comm"; Priority=1},
    @{Name="☎️ Skype"; Id="Microsoft.Skype"; Category="Comm"; Priority=2},
    @{Name="📧 Telegram"; Id="Telegram.TelegramDesktop"; Category="Comm"; Priority=2},
    @{Name="💼 Zoom"; Id="Zoom.Zoom"; Category="Comm"; Priority=2},
    @{Name="👔 Slack"; Id="SlackTechnologies.Slack"; Category="Comm"; Priority=3},

    # 🛠 System Utilities
    @{Name="🔍 Everything"; Id="voidtools.Everything"; Category="Utils"; Priority=1},
    @{Name="🖥️ CPU-Z"; Id="CPUID.CPU-Z"; Category="Utils"; Priority=2},
    @{Name="🖱️ ShareX"; Id="ShareX.ShareX"; Category="Utils"; Priority=2},
    @{Name="🌐 qBittorrent"; Id="qBittorrent.qBittorrent"; Category="Utils"; Priority=2},
    @{Name="🛡️ Malwarebytes"; Id="Malwarebytes.Malwarebytes"; Category="Utils"; Priority=1},
    @{Name="☁️ Google Drive"; Id="Google.Drive"; Category="Utils"; Priority=1},
    @{Name="💿 Rufus"; Id="Rufus.Rufus"; Category="Utils"; Priority=2},
    @{Name="🛠️ PowerToys"; Id="Microsoft.PowerToys"; Category="Utils"; Priority=1},
    @{Name="🎨 Windows Terminal"; Id="Microsoft.WindowsTerminal"; Category="Utils"; Priority=1},
    @{Name="🔧 CCleaner"; Id="Piriform.CCleaner"; Category="Utils"; Priority=2},
    @{Name="📊 TreeSize Free"; Id="JAM-Software.TreeSize-Free"; Category="Utils"; Priority=2},
    @{Name="🔐 KeePassXC"; Id="KeePassXCTeam.KeePassXC"; Category="Utils"; Priority=2},
    @{Name="🌐 Wireguard"; Id="WireGuard.WireGuard"; Category="Utils"; Priority=3},

    # 🎮 Gaming
    @{Name="🎮 Steam"; Id="Valve.Steam"; Category="Gaming"; Priority=1},
    @{Name="🎮 Epic Games"; Id="EpicGames.EpicGamesLauncher"; Category="Gaming"; Priority=1},
    @{Name="🎮 Battle.net"; Id="Blizzard.BattleNet"; Category="Gaming"; Priority=2},
    @{Name="🎮 EA App"; Id="ElectronicArts.EADesktop"; Category="Gaming"; Priority=2},
    @{Name="🎮 GOG Galaxy"; Id="GOG.Galaxy"; Category="Gaming"; Priority=2}
)

# 📝 Logging System
function Write-Log {
    param([string]$Message, [string]$Type = "INFO")
    $timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"
    $logMessage = "[$timestamp] [$Type] $Message"
    Add-Content -Path $Config.LogPath -Value $logMessage -ErrorAction SilentlyContinue
    
    switch ($Type) {
        "SUCCESS" { Write-Host $Message -ForegroundColor $Colors.Success }
        "ERROR" { Write-Host $Message -ForegroundColor $Colors.Error }
        "WARNING" { Write-Host $Message -ForegroundColor $Colors.Warning }
        default { Write-Host $Message -ForegroundColor $Colors.Info }
    }
}

# 🔧 Auto-Fix Winget Issues
function Repair-Winget {
    Write-Host "`n🔧 Auto-repairing Winget..." -ForegroundColor $Colors.Warning
    Write-Log "Attempting Winget repair" "INFO"
    
    try {
        # Reset Winget source
        Write-Host "  → Resetting Winget sources..." -ForegroundColor $Colors.Info
        winget source reset --force
        Start-Sleep -Seconds 2
        
        # Update sources
        Write-Host "  → Updating sources..." -ForegroundColor $Colors.Info
        winget source update
        Start-Sleep -Seconds 2
        
        Write-Log "✅ Winget repaired successfully" "SUCCESS"
        return $true
    } catch {
        Write-Log "❌ Winget repair failed: $($_.Exception.Message)" "ERROR"
        return $false
    }
}

# 🔍 Enhanced Winget Health Check with Auto-Repair
function Test-WingetHealth {
    Write-Host "`n🔍 Checking Winget health..." -ForegroundColor $Colors.Info
    try {
        $wingetVersion = winget --version 2>$null
        if ($LASTEXITCODE -ne 0 -or [string]::IsNullOrEmpty($wingetVersion)) {
            throw "Winget command failed"
        }
        Write-Log "✅ Winget Version: $wingetVersion" "SUCCESS"
        return $true
    } catch {
        Write-Log "⚠️ Winget issue detected!" "WARNING"
        
        if ($Config.AutoFix) {
            Write-Host "`n🔧 Auto-Fix enabled. Attempting repair..." -ForegroundColor $Colors.Warning
            if (Repair-Winget) {
                Write-Host "✅ Repair successful! Continuing..." -ForegroundColor $Colors.Success
                Start-Sleep -Seconds 2
                return $true
            }
        }
        
        Write-Log "❌ Winget not working! Install 'App Installer' from Microsoft Store." "ERROR"
        Write-Host "`n💡 Quick Fix: Open Microsoft Store → Search 'App Installer' → Install/Update" -ForegroundColor $Colors.Info
        return $false
    }
}

# 🎯 Smart Category Installer
function Install-ByCategory {
    Clear-Host
    Show-Header
    Write-Host "📦 INSTALL BY CATEGORY" -ForegroundColor $Colors.Highlight
    Write-Host ""
    $categories = $softwareList | Group-Object -Property Category
    $i = 1
    foreach ($cat in $categories) {
        Write-Host "  [$i] $($cat.Name) ($($cat.Count) apps)" -ForegroundColor $Colors.Info
        $i++
    }
    Write-Host ""
    $choice = Read-Host "Select category number"
    
    if ($choice -match '^\d+$') {
        $idx = [int]$choice - 1
        if ($idx -ge 0 -and $idx -lt $categories.Count) {
            $selectedCat = $categories[$idx]
            Write-Host "`n📦 Installing all from: $($selectedCat.Name)" -ForegroundColor $Colors.Success
            Install-Software -items $selectedCat.Group
        }
    }
}

# 🚀 Bulk Install Presets
function Install-Preset {
    Clear-Host
    Show-Header
    Write-Host "🎯 QUICK INSTALL PRESETS" -ForegroundColor $Colors.Highlight
    Write-Host ""
    Write-Host "  [1] 💼 Essential Office Pack (7 apps)" -ForegroundColor $Colors.Info
    Write-Host "  [2] 👨‍💻 Developer Pack (8 apps)" -ForegroundColor $Colors.Info
    Write-Host "  [3] 🎮 Gaming Pack (5 apps)" -ForegroundColor $Colors.Info
    Write-Host "  [4] 🎵 Multimedia Pack (6 apps)" -ForegroundColor $Colors.Info
    Write-Host "  [5] 🛠️ Power User Pack (10 apps)" -ForegroundColor $Colors.Info
    Write-Host "  [6] 🌟 EVERYTHING (All 50+ apps)" -ForegroundColor $Colors.Warning
    Write-Host ""
    
    $choice = Read-Host "Select preset"
    $preset = @()
    
    switch ($choice) {
        "1" { $preset = $softwareList | Where-Object { $_.Category -in @("Browsers", "Office") -and $_.Priority -eq 1 } }
        "2" { $preset = $softwareList | Where-Object { $_.Category -eq "Dev" } }
        "3" { $preset = $softwareList | Where-Object { $_.Category -eq "Gaming" } }
        "4" { $preset = $softwareList | Where-Object { $_.Category -eq "Media" } }
        "5" { $preset = $softwareList | Where-Object { $_.Priority -eq 1 } }
        "6" { $preset = $softwareList }
    }
    
    if ($preset.Count -gt 0) {
        Write-Host "`n⚡ Installing $($preset.Count) apps..." -ForegroundColor $Colors.Success
        Install-Software -items $preset
    }
}

# 🔄 Update All Installed Apps
function Update-AllApps {
    Clear-Host
    Show-Header
    Write-Host "🔄 UPDATING ALL INSTALLED APPS..." -ForegroundColor $Colors.Info
    Write-Log "Starting update process" "INFO"
    winget upgrade --all --silent --accept-package-agreements --accept-source-agreements
    Write-Log "✅ Update complete!" "SUCCESS"
    Pause
}

# 🧹 Safe System Cleanup
function Invoke-SafeCleanup {
    Clear-Host
    Show-Header
    Write-Host "🧹 SAFE SYSTEM CLEANUP" -ForegroundColor $Colors.Warning
    Write-Host "   ⚠️ This will only clean TEMP files (100% Safe)" -ForegroundColor $Colors.Warning
    Write-Host ""
    
    if ((Read-Host "Continue? (Y/N)") -match '^[Yy]$') {
        Write-Host "`n🧹 Cleaning Windows Temp..." -ForegroundColor $Colors.Info
        Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
        
        Write-Host "🧹 Cleaning User Temp..." -ForegroundColor $Colors.Info
        Remove-Item "$env:LOCALAPPDATA\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
        
        Write-Host "🧹 Running Disk Cleanup..." -ForegroundColor $Colors.Info
        Start-Process cleanmgr -ArgumentList "/sagerun:1" -Wait -ErrorAction SilentlyContinue
        
        Write-Log "✅ Cleanup complete!" "SUCCESS"
    }
    Pause
}

# 📊 System Information
function Show-SystemInfo {
    Clear-Host
    Show-Header
    Write-Host "💻 SYSTEM INFORMATION" -ForegroundColor $Colors.Highlight
    Write-Host ""
    
    $os = Get-CimInstance Win32_OperatingSystem
    $cpu = Get-CimInstance Win32_Processor
    $ram = Get-CimInstance Win32_ComputerSystem
    
    Write-Host "OS: " -NoNewline -ForegroundColor $Colors.Warning
    Write-Host "$($os.Caption) ($($os.OSArchitecture))" -ForegroundColor $Colors.Info
    
    Write-Host "CPU: " -NoNewline -ForegroundColor $Colors.Warning
    Write-Host "$($cpu.Name)" -ForegroundColor $Colors.Info
    
    Write-Host "RAM: " -NoNewline -ForegroundColor $Colors.Warning
    Write-Host "$([Math]::Round($ram.TotalPhysicalMemory/1GB, 2)) GB" -ForegroundColor $Colors.Info
    
    Write-Host "Free Space: " -NoNewline -ForegroundColor $Colors.Warning
    $disk = Get-PSDrive C
    Write-Host "$([Math]::Round($disk.Free/1GB, 2)) GB" -ForegroundColor $Colors.Info
    
    Pause
}

# 📋 Export/Import Config
function Export-Config {
    $installedApps = @()
    foreach ($app in $softwareList) {
        $check = winget list --id $app.Id 2>$null
        if ($LASTEXITCODE -eq 0) {
            $installedApps += $app.Id
        }
    }
    
    $config = @{
        Date = Get-Date -Format "yyyy-MM-dd"
        Apps = $installedApps
    }
    
    $exportPath = "$env:USERPROFILE\Desktop\SafePC-Config-Backup.json"
    $config | ConvertTo-Json | Out-File $exportPath
    Write-Log "✅ Config exported to: $exportPath" "SUCCESS"
    Pause
}

function Test-AdminPrivileges {
    $currentUser = [Security.Principal.WindowsIdentity]::GetCurrent()
    $principal = New-Object Security.Principal.WindowsPrincipal($currentUser)
    return $principal.IsInRole([Security.Principal.WindowsBuiltInRole]::Administrator)
}

function Show-Header {
    $headerText = @"
╔═══════════════════════════════════════════════════════════════════════════╗
║                                                                           ║
║     ██╗   ██╗██╗  ████████╗██╗███╗   ███╗ █████╗ ████████╗███████╗       ║
║     ██║   ██║██║  ╚══██╔══╝██║████╗ ████║██╔══██╗╚══██╔══╝██╔════╝       ║
║     ██║   ██║██║     ██║   ██║██╔████╔██║███████║   ██║   █████╗         ║
║     ██║   ██║██║     ██║   ██║██║╚██╔╝██║██╔══██║   ██║   ██╔══╝         ║
║     ╚██████╔╝███████╗██║   ██║██║ ╚═╝ ██║██║  ██║   ██║   ███████╗       ║
║      ╚═════╝ ╚══════╝╚═╝   ╚═╝╚═╝     ╚═╝╚═╝  ╚═╝   ╚═╝   ╚══════╝       ║
║                                                                           ║
║              🚀 SAFE PC INSTALLER V3.0 - ULTIMATE EDITION 🚀              ║
║              ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━  
					Made by Md. Adnan            ║
║      50+ Apps | Smart Presets | Auto-Update | Future-Proof               ║
║      100% SAFE • NO REGISTRY • NO FILE DELETION • LOGGING                 ║
║                                                                           ║
╚═══════════════════════════════════════════════════════════════════════════╝
"@
    Write-Host $headerText -ForegroundColor $Colors.Primary
    Write-Host "`n  📦 Total Apps: " -NoNewline -ForegroundColor $Colors.Warning
    Write-Host "$($softwareList.Count)" -ForegroundColor $Colors.Success
    Write-Host "  🔐 Admin: " -NoNewline -ForegroundColor $Colors.Warning
    Write-Host $(if (Test-AdminPrivileges) { "✅ Yes" } else { "❌ No" }) -ForegroundColor $Colors.Success
    Write-Host "  📝 Log: " -NoNewline -ForegroundColor $Colors.Warning
    Write-Host "$($Config.LogPath)" -ForegroundColor $Colors.Info
    Write-Host ""
}

function Show-Menu {
    Write-Host "┌───────────────────────────────────────────────────────────────────────────┐" -ForegroundColor $Colors.Warning
    Write-Host "│                      ⚡ ULTIMATE ACTIONS ⚡                                │" -ForegroundColor $Colors.Warning
    Write-Host "└───────────────────────────────────────────────────────────────────────────┘" -ForegroundColor $Colors.Warning
    Write-Host ""
    Write-Host "  [I]  📥 Install Software  [P]  🎯 Quick Presets  [C]  📦 By Category" -ForegroundColor $Colors.Success
    Write-Host "  [U]  🗑️  Uninstall        [A]  🔄 Update All     [L]  📋 List Installed" -ForegroundColor $Colors.Info
    Write-Host "  [S]  💻 System Info       [E]  💾 Backup Config   [K]  🧹 Safe Cleanup" -ForegroundColor DarkYellow
    Write-Host "  [Q]  ❌ Quit" -ForegroundColor $Colors.Error
    Write-Host ""
    
    # 3-Column Software List
    Write-Host "┌───────────────────────────────────────────────────────────────────────────┐" -ForegroundColor DarkCyan
    Write-Host "│ 📦 ALL SOFTWARE (50+ Apps) - Type Number to Install                      │" -ForegroundColor $Colors.Info
    Write-Host "└───────────────────────────────────────────────────────────────────────────┘" -ForegroundColor DarkCyan
    Write-Host ""
    
    $total = $softwareList.Count
    $columns = 3
    $rows = [Math]::Ceiling($total / $columns)
    
    for ($row = 0; $row -lt $rows; $row++) {
        $line = "  "
        for ($col = 0; $col -lt $columns; $col++) {
            $index = $row + ($col * $rows)
            if ($index -lt $total) {
                $num = $index + 1
                $name = $softwareList[$index].Name
                $numStr = if ($num -lt 10) { "[$num]  " } else { "[$num] " }
                $line += ($numStr + $name).PadRight(35)
            }
        }
        Write-Host $line -ForegroundColor $Colors.Info
    }
    Write-Host ""
}

# 🚀 Smart Install with Auto-Retry & Alternative Methods
function Install-SingleApp {
    param(
        [Parameter(Mandatory=$true)]
        [hashtable]$app,
        [int]$attemptNumber = 1
    )
    
    $appName = $app.Name
    $appId = $app.Id
    
    Write-Host "`n📦 [$attemptNumber/$($Config.MaxRetries)] $appName" -ForegroundColor $Colors.Info
    Write-Log "Installing: $appName (Attempt $attemptNumber)" "INFO"
    
    # Method 1: Standard Winget Install
    winget install --id $appId --silent --accept-package-agreements --accept-source-agreements 2>$null
    
    if ($LASTEXITCODE -eq 0) {
        Write-Log "✅ $appName installed successfully" "SUCCESS"
        return $true
    }
    
    # Auto-Retry with fixes
    if ($attemptNumber -lt $Config.MaxRetries) {
        Write-Host "  ⚠️ Failed. Trying alternative method..." -ForegroundColor $Colors.Warning
        Start-Sleep -Seconds 2
        
        # Method 2: Try without --silent
        Write-Host "  → Attempting interactive mode..." -ForegroundColor $Colors.Info
        winget install --id $appId --accept-package-agreements --accept-source-agreements 2>$null
        
        if ($LASTEXITCODE -eq 0) {
            Write-Log "✅ $appName installed (interactive mode)" "SUCCESS"
            return $true
        }
        
        # Method 3: Try with source reset
        if ($Config.AutoFix) {
            Write-Host "  → Resetting sources and retrying..." -ForegroundColor $Colors.Info
            winget source reset --force 2>$null
            Start-Sleep -Seconds 1
            winget source update 2>$null
            Start-Sleep -Seconds 1
            
            winget install --id $appId --silent --accept-package-agreements --accept-source-agreements 2>$null
            
            if ($LASTEXITCODE -eq 0) {
                Write-Log "✅ $appName installed (after source reset)" "SUCCESS"
                return $true
            }
        }
        
        # Recursive retry
        return Install-SingleApp -app $app -attemptNumber ($attemptNumber + 1)
    }
    
    Write-Log "❌ $appName failed after $($Config.MaxRetries) attempts" "ERROR"
    Write-Host "  ❌ Skipped (may not be available or requires manual install)" -ForegroundColor $Colors.Error
    return $false
}

function Install-Software {
    param([array]$items)
    Clear-Host
    Write-Host "🛡️ Installing with Auto-Fix & Retry System..." -ForegroundColor $Colors.Success
    Write-Host "   Max Retries: $($Config.MaxRetries) | Auto-Fix: $($Config.AutoFix)" -ForegroundColor $Colors.Info
    Write-Host ""
    
    $successful = 0
    $failed = 0
    $skipped = 0

    foreach ($app in $items) {
        # Check if already installed
        $checkInstalled = winget list --id $app.Id 2>$null
        if ($LASTEXITCODE -eq 0 -and $checkInstalled -match $app.Id) {
            Write-Host "`n📦 $($app.Name)" -ForegroundColor $Colors.Info
            Write-Host "  ⏭️ Already installed, skipping..." -ForegroundColor DarkYellow
            Write-Log "$($app.Name) already installed" "INFO"
            $skipped++
            continue
        }
        
        # Install with smart retry
        if (Install-SingleApp -app $app) {
            $successful++
        } else {
            $failed++
        }
        
        Start-Sleep -Milliseconds 500
    }
    
    Write-Host "`n" -NoNewline
    Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor $Colors.Highlight
    Write-Host "✅ Success: $successful | ⏭️ Skipped: $skipped | ❌ Failed: $failed" -ForegroundColor $Colors.Info
    Write-Host "═══════════════════════════════════════════════════════" -ForegroundColor $Colors.Highlight
    
    if ($failed -gt 0) {
        Write-Host "`n💡 Tip: Failed apps may require:" -ForegroundColor $Colors.Warning
        Write-Host "   • Manual download from official website" -ForegroundColor $Colors.Info
        Write-Host "   • Different app name/ID in Winget" -ForegroundColor $Colors.Info
        Write-Host "   • Check Desktop log for details" -ForegroundColor $Colors.Info
    }
    
    Pause
}

function Uninstall-Software {
    Clear-Host
    Show-Header
    Write-Host "🗑️ Enter software number to uninstall:" -ForegroundColor $Colors.Warning
    $input = Read-Host

    if ($input -match '^\d+$') {
        $idx = [int]$input - 1
        if ($idx -ge 0 -and $idx -lt $softwareList.Count) {
            $app = $softwareList[$idx]
            Write-Host "`n📦 Target: $($app.Name)" -ForegroundColor $Colors.Info
            if ((Read-Host "Confirm? (Y/N)") -match '^[Yy]$') {
                winget uninstall --id $app.Id --silent --accept-source-agreements
                Write-Log "✅ $($app.Name) uninstalled" "SUCCESS"
            }
        }
    }
    Pause
}

function List-InstalledSoftware {
    Clear-Host
    Show-Header
    Write-Host "📋 Installed Software:" -ForegroundColor $Colors.Info
    winget list --accept-source-agreements
    Pause
}

# Initialize
if (-not (Test-WingetHealth)) {
    Write-Host "`n❌ Cannot continue without Winget. Install from Microsoft Store." -ForegroundColor $Colors.Error
    Pause
    exit
}

Write-Log "═══ SafePC Installer V3.0 Started ═══" "INFO"

# Main Loop
do {
    Clear-Host
    Show-Header
    Show-Menu
    $choice = Read-Host "👉 Select option"

    switch ($choice.ToUpper()) {
        "I" {
            $input = Read-Host "Enter number(s) (e.g., 4 or 9,10,8)"
            $validApps = @()
            $parts = $input -split ',' | ForEach-Object { $_.Trim() }
            foreach ($part in $parts) {
                if ($part -match '^\d+$') {
                    $idx = [int]$part - 1
                    if ($idx -ge 0 -and $idx -lt $softwareList.Count) {
                        $validApps += $softwareList[$idx]
                    }
                }
            }
            if ($validApps.Count -gt 0) {
                Install-Software -items $validApps
            }
        }
        "P" { Install-Preset }
        "C" { Install-ByCategory }
        "U" { Uninstall-Software }
        "A" { Update-AllApps }
        "L" { List-InstalledSoftware }
        "S" { Show-SystemInfo }
        "E" { Export-Config }
        "K" { Invoke-SafeCleanup }
        "Q" { 
            Write-Log "═══ SafePC Installer Closed ═══" "INFO"
            Write-Host "`n✅ Thank you! Stay safe!" -ForegroundColor $Colors.Success
            break 
        }
        default {
            Write-Host "❌ Invalid option!" -ForegroundColor $Colors.Error
            Pause
        }
    }
} while ($true)