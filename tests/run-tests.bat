@echo off
set platform=%1
set configuration=%2
set ERROR_RESULT=0

set FILTER_BAT=%~dp0test_result_filter_tell_AppVeyor.bat

pushd %~dp0
set BUILDDIR=build\%platform%
set BINARY_DIR=%BUILDDIR%\bin\%configuration%

pushd %BINARY_DIR%
for /r %%i in (tests*.exe) do (
	@echo %%i --gtest_list_tests
	%%i --gtest_list_tests || set ERROR_RESULT=1

	@echo %%i | "%FILTER_BAT%"
	%%i | "%FILTER_BAT%" || set ERROR_RESULT=1
)
popd
popd

if "%ERROR_RESULT%" == "1" (
	@echo ERROR
	exit /b 1
)
