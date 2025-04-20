@echo off
setlocal

:: Get video URL
set /p "url=Enter YouTube video URL or Playlist URL: "

:: Ask for resolution
echo Choose resolution (leave blank for best quality):
echo 1. 1080p
echo 2. 720p
echo 3. 480p
echo 4. 360p
set /p "choice=Enter choice (1-4): "

:: Set resolution based on user choice
if "%choice%"=="1" set "res=1080"
if "%choice%"=="2" set "res=720"
if "%choice%"=="3" set "res=480"
if "%choice%"=="4" set "res=360"

:: Default to best quality if no choice is entered
if "%res%"=="" set "res=best"

:: Ask for FPS
echo Choose FPS (leave blank for highest available):
echo 1. 60 FPS
echo 2. 30 FPS
set /p "fpsChoice=Enter choice (1-2): "

:: Set FPS based on user choice
if "%fpsChoice%"=="1" set "fps=60"
if "%fpsChoice%"=="2" set "fps=30"

:: Default to highest FPS if no choice is entered
if "%fps%"=="" set "fps=best"

:: Ask for output folder
set /p "outFolder=Enter output folder (default is D:\yt_downloads): "
if "%outFolder%"=="" set "outFolder=D:\yt_downloads\random_stuff"

:: Ensure the output folder exists
if not exist "%outFolder%" (
    echo Error: The specified folder does not exist!
    pause
    exit /b
)

:: Check if the URL contains "list=" (indicating it's a playlist)
echo %url% | findstr /I "list=" >nul
if not errorlevel 1 (
    set "isPlaylist=true"
) else (
    set "isPlaylist=false"
)

:: Determine format based on resolution
if "%res%"=="best" (
    set "format=bestvideo+bestaudio/best"
) else (
    set "format=bestvideo[height=%res%]+bestaudio/best"
)

:: Download videos
if "%isPlaylist%"=="true" (
    yt-dlp -f "%format%" --merge-output-format mp4 -o "%outFolder%\%%(playlist_title)s\%%(title)s.%%(ext)s" "%url%"
) else (
    yt-dlp -f "%format%" --merge-output-format mp4 -o "%outFolder%\%%(title)s.%%(ext)s" "%url%"
)

echo Download complete! Files saved to: "%outFolder%"
pause