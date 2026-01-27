@echo off
setlocal enableextensions enabledelayedexpansion

chcp 65001 >NUL
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

rem Create venv if missing
if not exist ".venv\Scripts\python.exe" (
  echo Creating virtual environment...
  %PY_CMD% -m venv .venv
  if %ERRORLEVEL% neq 0 (
    echo ERROR: Failed to create virtual environment.
    pause
    exit /b 1
  )
)

set "VENV_PY=.venv\Scripts\python.exe"

rem Install build dependencies
echo Installing build dependencies...
"%VENV_PY%" -m pip install --upgrade pip setuptools wheel >NUL 2>&1
"%VENV_PY%" -m pip install flet websockets pyinstaller
set "RC=!ERRORLEVEL!"
if not "!RC!"=="0" (
  echo ERROR: Failed to install dependencies. Exit code !RC!.
  pause
  exit /b !RC!
)

rem Build standalone exe
"%VENV_PY%" build_standalone.py
set "RC=!ERRORLEVEL!"
if not "!RC!"=="0" (
  echo ERROR: Build failed. Exit code !RC!.
  pause
  exit /b !RC!
)

echo Done. Executable is in the dist\ folder.
pause

endlocal
exit /b 0
