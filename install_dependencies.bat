@echo off
setlocal enableextensions enabledelayedexpansion

chcp 65001 >NUL

rem Ensure we run from this script's directory
cd /d "%~dp0"

rem Find Python
where py >NUL 2>&1
if %ERRORLEVEL%==0 (
  set "PY_CMD=py -3"
) else (
  where python >NUL 2>&1
  if %ERRORLEVEL%==0 (
    set "PY_CMD=python"
  ) else (
    echo ERROR: Python 3 is not installed.
    echo Please install from https://www.python.org/downloads/windows/
    pause
    exit /b 1
  )
)

rem Check Python version (>= 3.9)
%PY_CMD% -c "import sys; v=sys.version_info; sys.exit(0 if (v.major==3 and v.minor>=9) else 1)"
if %ERRORLEVEL% neq 0 (
  echo ERROR: Python 3.9+ is required.
  %PY_CMD% -c "import sys; print('Detected:', sys.version)"
  pause
  exit /b 1
)

rem Install dependencies globally (no virtual environment, to avoid pip issues on Python 3.14)
echo Installing required packages...
%PY_CMD% -m pip install --upgrade pip setuptools wheel
%PY_CMD% -m pip install -r requirements.txt
set "RC=!ERRORLEVEL!"
if not "!RC!"=="0" (
  echo ERROR: Failed to install dependencies. Exit code !RC!.
  pause
  exit /b !RC!
)

rem Ensure folders
if not exist "assets" mkdir "assets"
if not exist "sessions" mkdir "sessions"

echo Done. You can now run run_app.bat
pause

endlocal
exit /b 0
