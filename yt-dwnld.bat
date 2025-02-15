@echo off
set /p "url=Enter YouTube video URL or Playlist URL: "
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
if not defined res set "res=best"

:: Ask for output folder
set /p "outFolder=Enter output folder (default is D:\YT Downloads): "
if "%outFolder%"=="" set "outFolder=D:\YT Downloads"

:: Check if the folder exists
if not exist "%outFolder%" (
    echo Error: The specified folder does not exist!
    pause
    exit /b
)

:: Check if the URL contains "list=" (indicating it's a playlist)
echo "%url%" | findstr /I "list=" >nul
if %errorlevel%==0 (
    set "isPlaylist=true"
) else (
    set "isPlaylist=false"
)

:: Download entire playlist if it's a playlist
if "%isPlaylist%"=="true" (
    if "%res%"=="best" (
        yt-dlp -f "bestvideo+bestaudio/best" -o "%outFolder%\%%(playlist_title)s\%%(title)s.%%(ext)s" "%url%"
    ) else (
        yt-dlp -f "bestvideo[height<=%res%]+bestaudio/best" -o "%outFolder%\%%(playlist_title)s\%%(title)s.%%(ext)s" "%url%"
    )
) else (
    if "%res%"=="best" (
        yt-dlp -f "bestvideo+bestaudio/best" -o "%outFolder%\%%(title)s.%%(ext)s" "%url%"
    ) else (
        yt-dlp -f "bestvideo[height<=%res%]+bestaudio/best" -o "%outFolder%\%%(title)s.%%(ext)s" "%url%"
    )
)

echo Download complete! Files saved to: %outFolder%
pause
