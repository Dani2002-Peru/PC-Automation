# Bitácora de Automatización y Diagnóstico de PC (Dani2002-Peru)

## 1. Estructura de Directorios
* `C:\Repos\Externos`: Repositorios clonados para pruebas, optimización y estudio.
* `C:\Repos\MisProyectos\PC-Automation`: Script propio de mantenimiento, auditoría de salud y actualización automatizada.
* `C:\Repos\MisProyectos\PC-Automation\Bitacoras_Medicas`: Historial automático con fecha y hora de cada chequeo médico ejecutado en la PC.

## 2. Qué ejecuta el Script Maestro (`Mantenimiento-PC.ps1`)
1. **Generación de Reporte (`Start-Transcript`)**: Guarda toda la evidencia del diagnóstico en un `.txt` fechado.
2. **Chequeo de Hardware**: Evalúa la salud física (S.M.A.R.T.) de los discos y mide la saturación de RAM.
3. **Auditoría de Errores (`Get-WinEvent`)**: Extrae los últimos 5 errores críticos del sistema para detectar qué programa o driver causa lentitud.
4. **Auto-reparación (`sfc /scannow`)**: Repara archivos dañados de Windows automáticamente.
5. **Limpieza y Actualización Segura**: Borra archivos temporales, actualiza repositorios con `git pull` y actualiza programas con `winget` (excluyendo Visual Studio, MySQL y MongoDB mediante `winget pin` para evitar bloqueos).

## 4. Resultados de Prueba de Estrés (25/10/2026) - Diagnóstico Térmico
* **BIOS y RAM**: Sano. BIOS P10.43 actualizada. 32GB RAM corriendo a 3200 MHz reales (XMP activo). Pila CMOS a 3.28V.
* **Almacenamiento (SSD Crucial P2 500GB)**: Sano (85% de vida útil).
* **CPU (Ryzen 5 3600)**: Sano. 75°C-76°C al 100% de estrés individual. Sube a 83°C únicamente cuando absorbe el calor residual de la GPU en prueba combinada.
* **GPU (RTX 3060 Ti)**: **REQUIERE MANTENIMIENTO FÍSICO (Cambio de Pasta Térmica)**. Bajo estrés en FurMark (1080p, 5 min) alcanza 83°C en núcleo y **104°C en HotSpot** (Delta de 21°C).
* **Acción Correctiva**: Realizar cambio de pasta térmica de alta conductividad en la RTX 3060 Ti y limpieza de flujo de aire del gabinete. Descartado formateo de Windows.
