@echo off

goto checkArgs

:usage
echo Convert svg graphic file to windows icon.
echo Usage: svgtoico SVG-file ICO-file
echo  SVG-file - path to input .svg file.
echo  ICO-file - path to output .ico file. File will be overwritten if exists.
echo             If path specified without file name there will be icon.ico
goto end


:: Check arguments
:checkArgs
:: first argument must be a valid SVG
if "%1"=="" goto usage
if not exist "%1" (
    echo Error SVG-file %1 doesn't exist.
    goto usage
)

:: second argument must be a path to ICO
if "%2"=="" goto usage

:: there must be two arguments
if not "%3"=="" goto usage

:: Create temporary directory for PNG files generated from SVG
:makeTempDir
set svgtoicoTempDir=%tmp%\svgtoico-%RANDOM%
if exist "%svgtoicoTempDir%" goto :makeTempDir
mkdir "%svgtoicoTempDir%"

:: Detect chocolatey shim
set svgtoicoShimArgs=
inkscape.exe --shimgen-noop > nul
if %ERRORLEVEL% equ -1 (
    set svgtoicoShimArgs=--shimgen-waitforexit
)

:: Generate PNG files from SVG (sizes: 16x16, 24x24, 32x32, 48x48, 64x64, 256x256)
inkscape.exe -w 16 -h 16 -o "%svgtoicoTempDir%\16.png" "%1" %svgtoicoShimArgs%
inkscape.exe -w 24 -h 24 -o "%svgtoicoTempDir%\24.png" "%1" %svgtoicoShimArgs%
inkscape.exe -w 32 -h 32 -o "%svgtoicoTempDir%\32.png" "%1" %svgtoicoShimArgs%
inkscape.exe -w 48 -h 48 -o "%svgtoicoTempDir%\48.png" "%1" %svgtoicoShimArgs%
inkscape.exe -w 64 -h 64 -o "%svgtoicoTempDir%\64.png" "%1" %svgtoicoShimArgs%
inkscape.exe -w 256 -h 256 -o "%svgtoicoTempDir%\256.png" "%1" %svgtoicoShimArgs%

:: Create ICO file from set of PNGs
py -m iconify -win "%svgtoicoTempDir%" "%svgtoicoTempDir%\icon"

:: Copy ICO to specified path
copy "%svgtoicoTempDir%\icon.ico" "%2"

:: Remove temporary files and directory
:clean
del "%svgtoicoTempDir%\icon.ico"
del "%svgtoicoTempDir%\16.png"
del "%svgtoicoTempDir%\24.png"
del "%svgtoicoTempDir%\32.png"
del "%svgtoicoTempDir%\48.png"
del "%svgtoicoTempDir%\64.png"
del "%svgtoicoTempDir%\256.png"
rmdir "%svgtoicoTempDir%"

:end
