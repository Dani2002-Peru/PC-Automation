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
