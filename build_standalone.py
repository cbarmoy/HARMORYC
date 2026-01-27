import os
import subprocess
import sys
from pathlib import Path


APP_NAME = "HARMORYC_Questionnaire"
ENTRYPOINT = "app.py"
EXTRA_FILES = [
    "assets",
    "sessions",
    "experiment_data.json",
    "questions_config.json",
]


def _add_data_arg(path: str) -> str:
    src = Path(path)
    if not src.exists():
        return ""
    # Windows separator for PyInstaller add-data is ";"
    return f"{src}{os.pathsep}{src.name}"


def _run_pyinstaller(onefile: bool) -> int:
    cmd = [
        sys.executable,
        "-m",
        "PyInstaller",
        "--noconsole",
        "--clean",
        "--name",
        APP_NAME,
    ]
    cmd.append("--onefile" if onefile else "--onedir")

    for p in EXTRA_FILES:
        arg = _add_data_arg(p)
        if arg:
            cmd.extend(["--add-data", arg])

    cmd.append(ENTRYPOINT)
    print("Running:", " ".join(cmd))
    return subprocess.call(cmd)


def main() -> int:
    print("Building standalone executable...")
    rc = _run_pyinstaller(onefile=True)
    if rc == 0:
        print("OK: onefile build complete. See dist/ folder.")
        return 0

    print("Onefile build failed. Falling back to onedir...")
    rc = _run_pyinstaller(onefile=False)
    if rc == 0:
        print("OK: onedir build complete. See dist/ folder.")
        return 0

    print(f"ERROR: build failed with code {rc}")
    return rc


if __name__ == "__main__":
    raise SystemExit(main())
