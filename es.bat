:: extract_snippet.bat
@echo off
setlocal enabledelayedexpansion

if "%~1"=="" (
    echo Usage: %~nx0 "section title"
    exit /b 1
)

set "section=# %~1"
set "inSection=0"

>snippet.txt (
  for /f "usebackq delims=" %%A in ("master.txt") do (
    set "line=%%A"
    set "trimmed=!line: =!"
    if /i "!trimmed!"=="%section%" (
      if !inSection! == 0 (
        set inSection=1
        rem Skip the header line
        continue
      ) else (
        set inSection=0
        goto :done
      )
    )
    if !inSection! == 1 (
      echo !line!
    )
  )
)
:done
endlocal
