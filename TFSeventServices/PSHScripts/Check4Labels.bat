@ECHO OFF
c: 2>&1
cd "C:\Program Files\Informatica PowerCenter 7.1.3\Client" 2>&1

set PASSWORD=%5

pmrep connect -r %3 -n TFSBuild -X PASSWORD -h %4 -o 5001 2>&1

IF %ERRORLEVEL% NEQ 0 GOTO ConnectionError 

pmrep listobjects -o Label | findstr %1 > %2 2>&1

IF %ERRORLEVEL% NEQ 0 GOTO NoLabelError

:CleanUp
pmrep cleanup 2>&1
GOTO End

:ConnectionError
echo ***Connection ERROR***
GOTO End

:NoLabelError
echo ***No Label ERROR***
GOTO CleanUp


:End
echo ***End***