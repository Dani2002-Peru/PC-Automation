$fecha = Get-Date -Format "yyyy-MM-dd_HH-mm"
$archivoLog = "C:\Repos\MisProyectos\PC-Automation\Bitacoras_Medicas\Reporte_Salud_$fecha.txt"

Start-Transcript -Path $archivoLog -Append

Write-Host "==========================================================" -ForegroundColor Magenta
Write-Host "   CHEQUEO MEDICO Y OPTIMIZACION DE PC - FECHA: $fecha" -ForegroundColor Magenta
Write-Host "==========================================================`n" -ForegroundColor Magenta

Write-Host "=== 1. DIAGNOSTICO FISICO DE DISCOS Y MEMORIA RAM ===" -ForegroundColor Cyan
Get-PhysicalDisk | Select-Object FriendlyName, MediaType, OperationalStatus, HealthStatus, @{Name="Tamaño(GB)";Expression={[math]::round($_.Size/1GB,2)}} | Format-Table -AutoSize
$os = Get-CimInstance Win32_OperatingSystem
$ramLibre = [math]::round($os.FreePhysicalMemory / 1MB, 2)
$ramTotal = [math]::round($os.TotalVisibleMemorySize / 1MB, 2)
Write-Host "-> Memoria RAM Disponible: $ramLibre GB libres de $ramTotal GB totales.`n" -ForegroundColor Green

Write-Host "=== 2. CAJA NEGRA: ULTIMOS 5 ERRORES CRITICOS DE WINDOWS ===" -ForegroundColor Cyan
Get-WinEvent -FilterHashtable @{LogName='System'; Level=1,2} -MaxEvents 5 -ErrorAction SilentlyContinue | Select-Object TimeCreated, ProviderName, Message | Format-Table -Wrap

Write-Host "=== 3. REPARACION PROFUNDA DE ARCHIVOS DE WINDOWS (SFC) ===" -ForegroundColor Cyan
Write-Host "Verificando integridad del sistema operativo (toma ~30 segundos)..." -ForegroundColor Yellow
sfc /scannow

Write-Host "`n=== 4. LIMPIANDO BASURA TEMPORAL Y CACHES ===" -ForegroundColor Cyan
Remove-Item -Path "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
Write-Host "-> Basura eliminada.`n" -ForegroundColor Green

Write-Host "=== 5. ENCENDIENDO MONITORES DE HARDWARE (TEMPERATURAS) ===" -ForegroundColor Cyan
$rutasWinget = "$env:LOCALAPPDATA\Microsoft\WinGet\Packages", "$env:ProgramFiles", "${env:ProgramFiles(x86)}"
foreach ($app in @("LibreHardwareMonitor", "FanControl")) {
    if (-not (Get-Process $app -ErrorAction SilentlyContinue)) {
        $exe = Get-ChildItem -Path $rutasWinget -Filter "$app.exe" -Recurse -ErrorAction SilentlyContinue | Select-Object -First 1
        if ($exe) { Start-Process $exe.FullName }
    }
}
Write-Host "-> Monitores activos.`n" -ForegroundColor Green

Write-Host "=== 6. SINCRONIZANDO REPOSITORIOS DE GITHUB (GIT PULL) ===" -ForegroundColor Cyan
Get-ChildItem -Path "C:\Repos\Externos" -Directory | ForEach-Object {
    Write-Host "Actualizando repo: $($_.Name)..." -ForegroundColor Yellow
    git -C $_.FullName pull
}

Write-Host "`n=== 7. ACTUALIZANDO PROGRAMAS RESTANTES (WINGET) ===" -ForegroundColor Cyan
winget upgrade --all --accept-package-agreements --accept-source-agreements --silent

Write-Host "`n=== ¡CHEQUEO Y MANTENIMIENTO COMPLETADO AL 100%! ===" -ForegroundColor Green
Write-Host "Reporte guardado en: $archivoLog" -ForegroundColor Cyan

Stop-Transcript
