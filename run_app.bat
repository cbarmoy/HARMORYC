@echo off
setlocal enableextensions enabledelayedexpansion

chcp 65001 >NUL

rem Ensure we run from this script's directory
cd /d "%~dp0"

rem Check Python
where py >NUL 2>&1
if %ERRORLEVEL%==0 (
  set "PY_CMD=py -3"
) else (
  where python >NUL 2>&1
  if %ERRORLEVEL%==0 (
    set "PY_CMD=python"
  ) else (
    echo ERROR: Python 3 not found. Please install from https://www.python.org/downloads/windows/
    pause
    exit /b 1
  )
)

rem Verify dependencies globally; if missing, run install_dependencies.bat
%PY_CMD% -c "import sys, importlib.util as u; mods=['flet','websockets']; sys.exit(0 if all(u.find_spec(m) for m in mods) else 1)"
if %ERRORLEVEL% neq 0 (
  echo Installing required packages...
  call "%~dp0install_dependencies.bat"
)

rem Ensure folders
if not exist "assets" mkdir "assets"
if not exist "sessions" mkdir "sessions"

rem Start app (console window will be visible)
%PY_CMD% app.py

endlocal
exit
