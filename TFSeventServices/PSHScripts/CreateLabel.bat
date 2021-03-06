@ECHO OFF
c: 2>&1
cd "C:\Program Files\Informatica PowerCenter 7.1.3\Client" 2>&1

set PASSWORD=%5

pmrep connect -r %3 -n TFSBUILD -X PASSWORD -h %4 -o 5001 2>&1

IF %ERRORLEVEL% NEQ 0 GOTO ConnectionError 

pmrep CreateLabel -a %1 -c "Label created for %2" 2>&1 

IF %ERRORLEVEL% NEQ 0 GOTO LabelError

echo "Label: %1"

:CleanUp
pmrep cleanup 2>&1
GOTO End

:ConnectionError
echo ***Connection ERROR***
GOTO End

:LabelError
echo ***Create Label ERROR***
GOTO CleanUp


:End
echo ***End***