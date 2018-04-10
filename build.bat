@ECHO OFF
 
:: Environment 
IF "%1" == "" GOTO ALERT 	
:: Maven action
IF "%2" == "" GOTO ALERT 	
:: Version first digit
IF "%3" == "" GOTO ALERT 	
:: Version second digit
IF "%4" == "" GOTO ALERT 	
:: Version third digit
IF "%5" == "" GOTO ALERT 	
:: Version fourth digit
IF "%6" == "" GOTO SET_VERSION_1
:: Version fivth digit
IF "%7" == "" GOTO SET_VERSION_2

SET IVER=%3.%4.%5.%6.%7
SET DVER=%3_%4_%5_%6_%7
GOTO CHECK_ENV

:SET_VERSION_1
SET IVER=%3.%4.%5
SET DVER=%3_%4_%5
GOTO CHECK_ENV

:SET_VERSION_2
SET IVER=%3.%4.%5.%6
SET DVER=%3_%4_%5_%6
GOTO CHECK_ENV

:CHECK_ENV
ECHO Input version : %IVER%
ECHO Application version : %DVER%

SET ENV_VAR=%1
SET MVN_VAR=%2

IF "%1" == "dev" GOTO DEV
IF "%1" == "dev.uat" GOTO DEVUAT
IF "%1" == "sit" GOTO SIT
IF "%1" == "dmo" GOTO DMO
IF "%1" == "lpt" GOTO LPT
IF "%1" == "uat" GOTO UAT
IF "%1" == "ppm" GOTO PPM
IF "%1" == "fps" GOTO FPS
IF "%1" == "fps.dc1" GOTO FPSDC1
IF "%1" == "fps.dc2" GOTO FPSDC2
IF "%1" == "prd" GOTO PRD
IF "%1" == "prd.dc3" GOTO PRDDC3
IF "%1" == "prd.dc5" GOTO PRDDC5
IF "%1" == "loc" GOTO LOC
 
:LOC
SET VERSION=%IVER%-LOC
GOTO MAIN
 
:DEV
SET VERSION=%IVER%-DEV
GOTO MAIN

:DEVUAT
SET VERSION=%IVER%-DEV-UAT
GOTO MAIN

:SIT
SET VERSION=%IVER%-SIT
GOTO MAIN

:LPT
SET VERSION=%IVER%-LPT
GOTO MAIN

:UAT
SET VERSION=%IVER%-UAT
GOTO MAIN

:PPM
SET VERSION=%IVER%-PPM
GOTO MAIN

:FPS
SET VERSION=%IVER%-FPS
GOTO MAIN

:FPSDC1
SET VERSION=dc1-%IVER%-FPS
GOTO MAIN

:FPSDC2
SET VERSION=dc2-%IVER%-FPS
GOTO MAIN

:PRD
SET VERSION=%IVER%
GOTO MAIN

:PRDDC3
SET VERSION=dc3-%IVER%
GOTO MAIN

:PRDDC5
SET VERSION=dc5-%IVER%
GOTO MAIN

 
:MAIN
:: Replace Version
ECHO ===============================================================================================================
ECHO mvn versions:set -DnewVersion=%VERSION%
CALL mvn versions:set -DnewVersion=%VERSION%
IF NOT "%ERRORLEVEL%" == "0" EXIT /B

:: Remove pom.xml backup
ECHO ===============================================================================================================
ECHO mvn versions:commit
CALL mvn versions:commit
IF NOT "%ERRORLEVEL%" == "0" EXIT /B

:: Purge project dependencies to make sure redownload release
::ECHO ===============================================================================================================
::ECHO mvn dependency:purge-local-repository -Dverbose=true -DreResolve=false -DresolutionFuzziness=version
::CALL mvn dependency:purge-local-repository -Dverbose=true -DreResolve=false -DresolutionFuzziness=version
::IF NOT "%ERRORLEVEL%" == "0" EXIT /B

:: Install or Deploy or Deploy site
ECHO ===============================================================================================================
ECHO mvn clean %MVN_VAR% -Denv=%ENV_VAR% -Ddisplay.version=%DVER%
CALL mvn clean %MVN_VAR% -Denv=%ENV_VAR% -Ddisplay.version=%DVER%
IF NOT "%ERRORLEVEL%" == "0" EXIT /B

:: Revert to default value
ECHO ===============================================================================================================
ECHO mvn versions:set -DnewVersion=%IVER%-DEV
CALL mvn versions:set -DnewVersion=%IVER%-DEV
IF NOT "%ERRORLEVEL%" == "0" EXIT /B

:: Remove pom.xml backup
ECHO ===============================================================================================================
ECHO mvn versions:commit
CALL mvn versions:commit
IF NOT "%ERRORLEVEL%" == "0" EXIT /B


GOTO END

:ALERT
ECHO ================================================================ 
ECHO   At least one argument is missing or incorrect
ECHO   Usage build.bat {env} {install,deploy,site-deploy} {version - major, regular, minor, patch(optional), internal use(optional)} 
ECHO      e.g. build.bat sit install 3 0 0 
ECHO           build.bat sit install 3 0 0 1 1
ECHO ================================================================ 

 
:END

