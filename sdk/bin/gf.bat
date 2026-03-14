@echo off

REM --- Determine script directory (sdk/bin) ---
set SCRIPT_DIR=%~dp0

REM --- SDK root = one folder above sdk/bin ---
set SDK_ROOT=%SCRIPT_DIR%\..

REM --- Normalize slashes ---
set SDK_ROOT=%SDK_ROOT:\=/%

REM --- Prepend toolchain paths ---
set PATH=%SDK_ROOT%/../tools/bin/lua/windows/x86_64;%PATH%
set PATH=%SDK_ROOT%/../tools/bin/gfortran/windows/x86_64;%PATH%
set PATH=%SDK_ROOT%/../tools/bin/nasm/windows/x86_64;%PATH%

REM --- Run unified CLI ---
lua "%SDK_ROOT%/../sdk/scripts/gf.lua" %*
