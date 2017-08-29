@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
shutdown /A 2>NUL 1>&2
FOR /F %%A IN ('wmic.exe OS GET localdatetime ^| findstr ^[0-9]') DO (SET t0=%%A)
SET Y0=%t0:~0,4%
SET M0=%t0:~4,2%
SET D0=%t0:~6,2%
SET H0=%t0:~8,2%
SET X0=%t0:~10,2%
SET C0=%t0:~12,2%
TITLE Miner-autorun(%Y0%.%M0%.%D0%_%H0%:%X0%:%C0%)
SET Version=1.0.3.6
:hardstart
CLS
COLOR 06
ECHO ==================================================================
ECHO +----------------------------------------------------------------+
ECHO +          AutoRun for EWBF 0.3.4.b Miner - by Acrefawn          +
ECHO +                acrefawn@gmail.com [v. %Version%]                 +
ECHO +                    Donation deposit adress:                    +
ECHO +            ZEC: t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv            +
ECHO +----------------------------------------------------------------+
ECHO ==================================================================
IF "%PROCESSOR_ARCHITECTURE%" == "x86" (
	IF NOT DEFINED PROCESSOR_ARCHITEW6432 (
		ECHO Your OS Architecture is %PROCESSOR_ARCHITECTURE%. Only x64 required.
		PAUSE
		EXIT
	)
)
REM Basic constant
SET FirstRun=0
SET MinerPath=%~dp0
SET ErrorsAmount=5
SET ErrorsCounter=0
SET ConfigErrorsList=/C:"Cannot connect to the pool" /C:"No properly configured pool"
SET InternetErrorsList=/C:"Lost connection" /C:"Cannot resolve hostname" /C:"Stratum subscribe timeout"
SET MinerErrorsList=/C:"Thread exited" /C:" 0 Sol/s" /C:"Total speed: 0 Sol/s" /C:"benchmark error" /C:"Api bind error" /C:"CUDA error"
SET CriticalErrorsList=/C:"ERROR: Cannot initialize NVML. Temperature monitor will not work"
SET OtherErrorsList=/C:"ERROR:"
SET ErrorEcho=+ Unknown error.                                                 +
:checkconfig
IF EXIST config.bat (
	FOR /F "tokens=5 delims= " %%B IN ('findstr /C:"REM Configuration file v." config.bat') DO (
		IF "%%B" == "%Version%" (
			CALL config.bat
			ECHO Config.bat loaded.
			GOTO prestart
		) ELSE (
			ECHO Your config.bat is out of date.
			CHOICE /C yn /T 15 /D y /M "Delete outdated and create an updated (default) config.bat"
			IF ERRORLEVEL ==2 EXIT
			MOVE /Y config.bat config_backup_%%B.bat 2>NUL 1>&2 && ECHO Created backup of your v. %%B config.bat.
		)
	)
)
ECHO @ECHO off > config.bat
ECHO REM Configuration file v. %Version% >> config.bat
ECHO REM =================================================== [OverClock] >> config.bat
ECHO REM Enable GPU OverClock control monitor (0 - false, 1 - true GIGABYTE, 2 - true MSI, 3 - true ASUS, 4 - true EVGA) >> config.bat
ECHO REM Autorun and run-check of GPU OverClock programs >> config.bat
ECHO SET EnableGPUOverClockControl=0 >> config.bat
ECHO REM Allow restart OverClock programs when miner restarting (1 - true, 0 - false) >> config.bat
ECHO REM Please, do not use this option if it is not needed >> config.bat
ECHO SET AllowRestartGPUOverClock=0 >> config.bat
ECHO REM =================================================== [GPU] >> config.bat
ECHO REM Set how many GPU devices are enabled >> config.bat
ECHO SET GPUDevicesAmount=0 >> config.bat
ECHO REM Set total average hashrate of this Rig (you can use average hashrate value from your pool) >> config.bat
ECHO SET AverageHashrate=0 >> config.bat
ECHO REM =================================================== [Miner] >> config.bat
ECHO REM Name miner process (in English, without special symbols and spaces) >> config.bat
ECHO SET MinerProcessProgram=miner.exe>> config.bat
ECHO REM Name miner.log file (in English, without special symbols and spaces) >> config.bat
ECHO SET MinerProcessLog=miner.log>> config.bat
ECHO REM Use .bat or .exe file to start mining? (1 - .exe, 2 - .bat) >> config.bat
ECHO SET UseBatOrExe=2 >> config.bat
ECHO REM Name miner start .bat file (in English, without special symbols and spaces) >> config.bat
ECHO SET MinerProcessBat=miner.bat>> config.bat
ECHO REM Set %MinerProcessBat% command here to autocreate this file if it is missing >> config.bat
ECHO SET MinerProcessBatText=miner --server eu1-zcash.flypool.org --port 3333 --user t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv.imaginary --pass x --log 2 --fee 2 --templimit 80 --eexit 3 --pec>> config.bat
ECHO REM =================================================== [Timers] >> config.bat
ECHO REM Restart miner every hour (1 - true every One hour, 2 - true every Two hours, 0 - false) >> config.bat
ECHO SET AutoRestartMinerEveryHour=0 >> config.bat
ECHO REM Restart computer every hour (1 - true every One hour, 2 - true every Two hours, 0 - false) >> config.bat
ECHO SET AutoRestartComputerEveryHour=0 >> config.bat
ECHO REM Restart miner every day at 12:00 (1 - true, 0 - false) >> config.bat
ECHO SET AutoRestartMinerAtMidday=1 >> config.bat
ECHO REM Restart computer every day at 12:00 (1 - true, 0 - false) >> config.bat
ECHO SET AutoRestartComputerAtMidday=0 >> config.bat
ECHO REM Restart miner every day at 00:00 (1 - true, 0 - false) >> config.bat
ECHO SET AutoRestartMinerAtMidnight=1 >> config.bat
ECHO REM Restart computer every day at 00:00 (1 - true, 0 - false) >> config.bat
ECHO SET AutoRestartComputerAtMidnight=0 >> config.bat
ECHO REM =================================================== [Other] >> config.bat
ECHO REM Enable double window check (1 - true, 0 - false ) >> config.bat
ECHO SET EnableDoubleWindowCheck=1 >> config.bat
ECHO REM Skip "Begin mining" confirmation (1 - true, 0 - false) >> config.bat
ECHO SET SkipBeginMining=0 >> config.bat
ECHO REM Allow %~n0.bat to restart this computer (1 - true, 0 - false) >> config.bat
ECHO SET AllowRestartComputer=1 >> config.bat
ECHO REM Enable checking of internet connection (1 - true, 0 - false) >> config.bat
ECHO REM Disable this function only if you have problems or errors with it (bad internet connection, problems with provider, etc...) >> config.bat
ECHO SET EnableInternetErrorsList=1 >> config.bat
ECHO REM Enable additional environments. Please, do not use this option if it is not needed, or you don't understand what does it mean (1 - true, 0 - false) >> config.bat
ECHO REM GPU_FORCE_64BIT_PTR 0, GPU_MAX_HEAP_SIZE 100, GPU_USE_SYNC_OBJECTS 1, GPU_MAX_ALLOC_PERCENT 100, GPU_SINGLE_ALLOC_PERCENT 100 >> config.bat
ECHO SET EnableGPUEnvironments=0 >> config.bat
ECHO REM =================================================== [Telegram notifications] >> config.bat
ECHO REM Enable Telegram notifications, don't forget to add @ZcashMinerAutorunBot in Telegram (1 - true, 2 - false) >> config.bat
ECHO SET EnableTelegramNotifications=0 >> config.bat
ECHO REM Path to "curl" library + curl.exe file (in English, without special symbols and spaces) >> config.bat
ECHO SET CurlPath=curl-7.55.1-win64-mingw\bin\curl.exe>> config.bat
ECHO REM Name your Rig (in English, without special symbols) >> config.bat
ECHO SET RigName=Zcash Farm>> config.bat
ECHO REM Enter here your chat_id, from Telegram @get_id_bot >> config.bat
ECHO SET ChatId=000000000 >> config.bat
ECHO REM =================================================== [Additional program] >> config.bat
ECHO REM If you need to start another additional program, miner, etc... and check if this program is working, you can use this feature (1 - true, 0 - false) >> config.bat
ECHO SET EnableAUAutorun=0 >> config.bat
ECHO REM Process Name additional program (Press CTRL+ALT+DEL and type Name process) >> config.bat
ECHO SET AUProcessName=minergate.exe>> config.bat
ECHO REM Path + launcher file of additional program (in English, without special symbols and spaces) >> config.bat
ECHO SET AUProcessPath=C:\Program Files\MinerGate\minergate.exe>> config.bat
ECHO Default config.bat created. Please check it and restart %~n0.bat.
GOTO checkconfig
:restart
COLOR 0C
IF %AllowRestartComputer% EQU 1 (
	CHOICE /C yn /T 60 /D y /M "Restart your computer"
	IF ERRORLEVEL ==2 GOTO hardstart
) ELSE (
	CHOICE /C yn /T 60 /D n /M "Restart your computer"
	IF ERRORLEVEL ==2 GOTO hardstart
)
tskill /A /V %GPUOverClockTaskName% 2>NUL 1>&2 && ECHO Process %GPUOverClockProcess% was successfuly killed.
IF %EnableGPUOverClockControl% EQU 1 (
	tskill /A /V %GPUOverClockProcessJunk% 2>NUL 1>&2 && ECHO Process %GPUOverClockProcessJunk%.exe was successfuly killed.
)
taskkill /F /IM "%MinerProcessProgram%" 2>NUL 1>&2 && ECHO Process %MinerProcessProgram% was successfuly killed.
IF %EnableAUAutorun% EQU 1 (
	taskkill /F /IM "%AUProcessName%" 2>NUL 1>&2 && ECHO Process %AUProcessName% was successfuly killed.
)
ECHO [%Y1%.%M1%.%D1%][%H1%:%X1%:%C1%] Computer restarting. >> %~n0.log
IF %EnableTelegramNotifications% EQU 1 (
	IF EXIST "%CurlPath%" (
		IF %ChatId% NEQ "000000000" "%CurlPath%" "https://api.telegram.org/bot438597926:AAGGY2wHtvLriYdlvgOuptjw8FJYj6rimac/sendMessage?chat_id=%ChatId%&text=%RigName%: Computer restarting..." 2>NUL 1>&2
	)
)
shutdown /T 60 /R /F
ECHO To cancel restarting, close this window and start autorun.bat manually.
timeout /T 50 /nobreak >NUL
EXIT
:prestart
SET GPUDevicesAmount=%GPUDevicesAmount: =%
SET AverageHashrate=%AverageHashrate: =%
SET ChatId=%ChatId: =%
IF %EnableDoubleWindowCheck% EQU 1 (
	tasklist /V /FI "WINDOWTITLE ne Miner-autorun(%Y0%.%M0%.%D0%_%H0%:%X0%:%C0%)" | find /I /N "Miner-autorun" >NUL && GOTO :doublewindow
	GOTO preprestart
	:doublewindow
	ECHO Warning. This is second CMD window of this program. Check it, please. 
	ECHO Or try to turn off EnableDoubleWindowCheck option in config.bat.
	CHOICE /C yn /T 10 /D y /M "Exit"
	IF ERRORLEVEL ==2 (
		SET EnableDoubleWindowCheck=0
		GOTO preprestart
	)
	EXIT
)
:preprestart
IF %EnableGPUEnvironments% EQU 1 (
	SETX GPU_FORCE_64BIT_PTR 0 2>NUL 1>&2 && ECHO GPU_FORCE_64BIT_PTR 0
	SETX GPU_MAX_HEAP_SIZE 100 2>NUL 1>&2 && ECHO GPU_MAX_HEAP_SIZE 100
	SETX GPU_USE_SYNC_OBJECTS 1 2>NUL 1>&2 && ECHO GPU_USE_SYNC_OBJECTS 1
	SETX GPU_MAX_ALLOC_PERCENT 100 2>NUL 1>&2 && ECHO GPU_MAX_ALLOC_PERCENT 100
	SETX GPU_SINGLE_ALLOC_PERCENT 100 2>NUL 1>&2 && ECHO GPU_SINGLE_ALLOC_100
) ELSE (
	REG DELETE HKCU\Environment /F /V GPU_FORCE_64BIT_PTR 2>NUL 1>&2 && ECHO GPU_FORCE_64BIT_PTR successfuly removed from environments.
	REG DELETE HKCU\Environment /F /V GPU_MAX_HEAP_SIZE 2>NUL 1>&2 && ECHO GPU_MAX_HEAP_SIZE successfuly removed from environments.
	REG DELETE HKCU\Environment /F /V GPU_USE_SYNC_OBJECTS 2>NUL 1>&2 && ECHO GPU_USE_SYNC_OBJECTS successfuly removed from environments.
	REG DELETE HKCU\Environment /F /V GPU_MAX_ALLOC_PERCENT 2>NUL 1>&2 && ECHO GPU_MAX_ALLOC_PERCENT successfuly removed from environments.
	REG DELETE HKCU\Environment /F /V GPU_SINGLE_ALLOC_PERCENT 2>NUL 1>&2 && ECHO GPU_SINGLE_ALLOC_PERCENT successfuly removed from environments.
)
IF %SkipBeginMining% EQU 0 (
	CHOICE /C yn /T 30 /D y /M "Begin mining"
	IF ERRORLEVEL ==2 EXIT
	GOTO start
) ELSE (
	timeout /T 5 /nobreak >NUL
	GOTO start
)
:ctimer
COLOR 06
IF %EnableTelegramNotifications% EQU 1 (
	IF EXIST "%CurlPath%" (
		IF %ChatId% NEQ "000000000" "%CurlPath%" "https://api.telegram.org/bot438597926:AAGGY2wHtvLriYdlvgOuptjw8FJYj6rimac/sendMessage?chat_id=%ChatId%&text=%RigName%: Scheduled computer restart, please wait" 2>NUL 1>&2
	)
)
ECHO [%Y2%.%M2%.%D2%][%H2%:%X2%:%C2%] Warning. Scheduled computer restart, please wait. Miner works %t3% >> %~n0.log
ECHO ==================================================================
ECHO +----------------------------------------------------------------+
ECHO + Now %Y2%.%M2%.%D2% %H2%:%X2%                                           +
ECHO + Miner was started at %Y1%.%M1%.%D1% %H1%:%X1%                          +
ECHO + Miner works %t3%                                           +
ECHO + Warning. Scheduled computer restart, please wait...            +
ECHO +----------------------------------------------------------------+
ECHO ==================================================================
GOTO restart
:mtimer
COLOR 06
IF %EnableTelegramNotifications% EQU 1 (
	IF EXIST "%CurlPath%" (
		IF %ChatId% NEQ "000000000" "%CurlPath%" "https://api.telegram.org/bot438597926:AAGGY2wHtvLriYdlvgOuptjw8FJYj6rimac/sendMessage?chat_id=%ChatId%&text=%RigName%: Scheduled miner restart, please wait" 2>NUL 1>&2
	)
)
ECHO [%Y2%.%M2%.%D2%][%H2%:%X2%:%C2%] Warning. Scheduled miner restart, please wait. Miner works %t3% >> %~n0.log
ECHO ==================================================================
ECHO +----------------------------------------------------------------+
ECHO + Now %Y2%.%M2%.%D2% %H2%:%X2%                                           +
ECHO + Miner was started at %Y1%.%M1%.%D1% %H1%:%X1%                          +
ECHO + Miner works %t3%                                           +
ECHO + Warning. Scheduled miner restart, please wait...               +
ECHO +----------------------------------------------------------------+
ECHO ==================================================================
timeout /T 60 /nobreak >NUL
GOTO hardstart
:error
COLOR 0C
IF %EnableTelegramNotifications% EQU 1 (
	IF EXIST "%CurlPath%" (
		IF %ChatId% NEQ "000000000" "%CurlPath%" "https://api.telegram.org/bot438597926:AAGGY2wHtvLriYdlvgOuptjw8FJYj6rimac/sendMessage?chat_id=%ChatId%&text=%RigName%: Miner restarting..." 2>NUL 1>&2
	)
)
ECHO ==================================================================
ECHO +----------------------------------------------------------------+
ECHO + Now %Y2%.%M2%.%D2% %H2%:%X2%                                           +
ECHO + Miner was started at %Y1%.%M1%.%D1% %H1%:%X1%                          +
ECHO + Miner works %t3%                                           +
ECHO %ErrorEcho%
ECHO + Miner restarting...                                            +
ECHO +----------------------------------------------------------------+
ECHO ==================================================================
SET /A ErrorsCounter+=1
:start
COLOR 06
FOR /F %%C IN ('wmic.exe OS GET localdatetime ^| findstr ^[0-9]') DO (SET t1=%%C)
SET Y1=%t1:~0,4%
SET M1=%t1:~4,2%
SET D1=%t1:~6,2%
SET H1=%t1:~8,2%
SET X1=%t1:~10,2%
SET C1=%t1:~12,2%
SET /A s1=H1*60*60*100+X1*60*100+C1*100
IF %AllowRestartComputer% EQU 0 (
	IF %AutoRestartComputerEveryHour% NEQ 0 ECHO Computer restart is denied. Check and reconfigure AutoRestartComputerEveryHour in your config.bat.
	IF %AutoRestartComputerAtMidday% NEQ 0 ECHO Computer restart is denied. Check and reconfigure AutoRestartComputerAtMidday in your config.bat.
	IF %AutoRestartComputerAtMidnight% NEQ 0 ECHO Computer restart is denied. Check and reconfigure AutoRestartComputerAtMidnight in your config.bat.
	SET AutoRestartComputerEveryHour=0
	SET AutoRestartComputerAtMidday=0
	SET AutoRestartComputerAtMidnight=0
)
IF %EnableGPUOverClockControl% GEQ 0 (
	IF %EnableGPUOverClockControl% EQU 0 (
		ECHO OverClock control monitor is disabled.
	) ELSE (
		IF %AverageHashrate% EQU 0 (
			ECHO Error. Average hashrate = 0. Configure it, please.
			ECHO GPUOverClockControl will be disabled...
			SET EnableGPUOverClockControl=0
		)
	)
	IF %EnableGPUOverClockControl% GTR 4 (
		ECHO Warning. Wrong parameter of EnableGPUOverClockControl, only [0-4] are required. Configure it, please.
		SET EnableGPUOverClockControl=0
	)
	IF %EnableGPUOverClockControl% EQU 1 (
	SET GPUOverClockTaskName=Xtreme
	SET GPUOverClockProcess=Xtreme.exe
	SET GPUOverClockProcessJunk=loading
	SET GPUOverClockPath="C:\Program Files (x86)\GIGABYTE\XTREME GAMING ENGINE\Launcher.exe"
		IF NOT EXIST "C:\Program Files (x86)\GIGABYTE\XTREME GAMING ENGINE" (
			ECHO Warning. Wrong path to Gigabyte Xtreme OC, use default install path. Check it, please.
			ECHO GPUOverClockControl will be disabled...
			SET EnableGPUOverClockControl=0
		)
	)
	IF %EnableGPUOverClockControl% EQU 2 (
	SET GPUOverClockTaskName=MSIAfterburner
	SET GPUOverClockProcess=MSIAfterburner.exe
	SET GPUOverClockPath="C:\Program Files (x86)\MSI Afterburner\MSIAfterburner.exe"
		IF NOT EXIST "C:\Program Files (x86)\MSI Afterburner" (
			ECHO Warning. Wrong path to MSI Afterburner OC, use default install path. Check it, please.
			ECHO GPUOverClockControl will be disabled...
			SET EnableGPUOverClockControl=0
		)
	)
	IF %EnableGPUOverClockControl% EQU 3 (
	SET GPUOverClockTaskName=GPUTweakII
	SET GPUOverClockProcess=GPUTweakII.exe
	SET GPUOverClockPath="C:\Program Files (x86)\ASUS\GPU TweakII\GPUTweakII.exe"
		IF NOT EXIST "C:\Program Files (x86)\ASUS\GPU TweakII" (
			ECHO Warning. Wrong path to ASUS GPU TweakII OC, use default install path. Check it, please.
			ECHO GPUOverClockControl will be disabled...
			SET EnableGPUOverClockControl=0
		)
	)
	IF %EnableGPUOverClockControl% EQU 4 (
	SET GPUOverClockTaskName=PrecisionX_x64
	SET GPUOverClockProcess=PrecisionX_x64.exe
	SET GPUOverClockPath="C:\Program Files (x86)\EVGA\Precision XOC\PrecisionX_x64.exe"
		IF NOT EXIST "C:\Program Files (x86)\EVGA\Precision XOC\" (
			ECHO Warning. Wrong path to EVGA Precision X OC, use default install path. Check it, please.
			ECHO GPUOverClockControl will be disabled...
			SET EnableGPUOverClockControl=0
		)
	)
) ELSE (
	ECHO Warning. Wrong parameter of EnableGPUOverClockControl, only [0-4] are required. Configure it, please.
	SET EnableGPUOverClockControl=0
)
IF NOT EXIST "%MinerProcessProgram%" (
	ECHO Error. %MinerPath%miner.exe is missing. Check it, please.
	PAUSE
	EXIT
)
IF NOT EXIST "cudart32_80.dll" (
	ECHO Error. %MinerPath%cudart32_80.dll is missing. Check it, please.
	PAUSE
	EXIT
)
IF NOT EXIST "cudart64_80.dll" (
	ECHO Error. %MinerPath%cudart64_80.dll is missing. Check it, please.
	PAUSE
	EXIT
)
IF EXIST "Logs" (
	ECHO Folder Logs exist.
) ELSE (
	MD Logs && ECHO Folder Logs created.
)
IF %EnableAUAutorun% EQU 1 (
	tasklist /FI "IMAGENAME eq %AUProcessName%" 2>NUL | find /I /N "%AUProcessName%" >NUL
	IF ERRORLEVEL ==1 (
		START /MIN "%AUProcessName%" "%AUProcessPath%" && ECHO %AUProcessName% is started at %H1%:%X1%:%C1% %Y1%.%M1%.%D1%.
		ECHO [%Y1%.%M1%.%D1%][%H1%:%X1%:%C1%] %AUProcessName% is started. >> %~n0.log
		timeout /T 5 /nobreak >NUL
	)
)
IF %EnableGPUOverClockControl% GEQ 1 (
	IF %AllowRestartGPUOverClock% EQU 1 (
		IF %FirstRun% EQU 1 (
			tskill /A /V %GPUOverClockTaskName% 2>NUL 1>&2 && ECHO Process %GPUOverClockProcess% was successfuly killed.
			IF %EnableGPUOverClockControl% EQU 1 (
				tskill /A /V %GPUOverClockProcessJunk% 2>NUL 1>&2 && ECHO Process %GPUOverClockProcessJunk%.exe was successfuly killed.
			)
			timeout /T 5 /nobreak >NUL
		)
	)
	tasklist /FI "IMAGENAME eq %GPUOverClockProcess%" 2>NUL | find /I /N "%GPUOverClockProcess%" >NUL
	IF ERRORLEVEL ==1 (
		START /MIN "" %GPUOverClockPath% && ECHO %GPUOverClockProcess% is started at %H1%:%X1%:%C1% %Y1%.%M1%.%D1%.
		ECHO [%Y1%.%M1%.%D1%][%H1%:%X1%:%C1%] %GPUOverClockProcess% is started. >> %~n0.log
		IF %EnableTelegramNotifications% EQU 1 (
			IF EXIST "%CurlPath%" (
				IF %ChatId% NEQ "000000000" "%CurlPath%" "https://api.telegram.org/bot438597926:AAGGY2wHtvLriYdlvgOuptjw8FJYj6rimac/sendMessage?chat_id=%ChatId%&text=%RigName%: %GPUOverClockProcess% is started." 2>NUL 1>&2
			)
		)
		timeout /T 5 /nobreak >NUL
	)
)
taskkill /F /IM "%MinerProcessProgram%" 2>NUL 1>&2 && ECHO Process %MinerProcessProgram% was successfuly killed.
timeout /T 5 /nobreak >NUL
taskkill /F /FI "IMAGENAME eq cmd.exe" /FI "WINDOWTITLE eq %MinerProcessBat%*" 2>NUL 1>&2
timeout /T 5 /nobreak >NUL
IF EXIST %MinerProcessLog% MOVE /Y %MinerProcessLog% Logs\miner_%Y1%.%M1%.%D1%_%H1%.%X1%.%C1%.log 2>NUL 1>&2
IF ERRORLEVEL ==1 (
	ECHO Error. Can't rename, move or open %MinerProcessLog%. Check it, please.
	CHOICE /C yn /T 10 /D y /M "Try to delete %MinerProcessLog%"
	IF ERRORLEVEL ==2 (
		ECHO [%Y1%.%M1%.%D1%][%H1%:%X1%:%C1%] Error. Can't rename, move or open %MinerProcessLog%. Check it, please. >> %~n0.log
	) ELSE (
		DEL /Q /F %MinerProcessLog% 2>NUL 1>&2 && ECHO %MinerProcessLog% deleted successfuly. Continue...
	)
) ELSE (
	ECHO %MinerProcessLog% renamed and moved to Logs folder.
)
timeout /T 5 /nobreak >NUL
IF %UseBatOrExe% EQU 1 (
	IF NOT EXIST "miner.cfg" (
		FOR /F "tokens=3,5,7,9 delims= " %%W IN ("%MinerProcessBatText%") DO (
			ECHO # Common parameters > miner.cfg
			ECHO # All the parameters here are similar to the command line arguments >> miner.cfg
			ECHO. >> miner.cfg
			ECHO [common] >> miner.cfg
			ECHO cuda_devices 0 1 2 3 4 5 6 7 >> miner.cfg
			ECHO intensity    64 64 64 64 64 64 64 64 >> miner.cfg
			ECHO templimit    80 >> miner.cfg
			ECHO pec          1 >> miner.cfg
			ECHO boff         0 >> miner.cfg
			ECHO eexit        3 >> miner.cfg
			ECHO tempunits    c >> miner.cfg
			ECHO log          2 >> miner.cfg
			ECHO logfile      miner.log >> miner.cfg
			ECHO api          127.0.0.1:42000 >> miner.cfg
			ECHO. >> miner.cfg
			ECHO # The miner start work from this server >> miner.cfg
			ECHO # When the server is fail, the miner will try to reconnect 3 times >> miner.cfg >> miner.cfg
			ECHO # After three unsuccessful attempts, the miner will switch to the next server >> miner.cfg
			ECHO # You can add up to 8 servers >> miner.cfg
			ECHO. >> miner.cfg
			ECHO # main server >> miner.cfg
			ECHO [server] >> miner.cfg
			ECHO server %%W >> miner.cfg
			ECHO port   %%X >> miner.cfg
			ECHO user   %%Y >> miner.cfg
			ECHO pass   %%Z >> miner.cfg
			ECHO. >> miner.cfg
			ECHO # additional server 1 >> miner.cfg
			ECHO [server] >> miner.cfg
			ECHO server eu1-zcash.flypool.org >> miner.cfg
			ECHO port   3333 >> miner.cfg
			ECHO user   t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv.imaginary >> miner.cfg
			ECHO pass   x >> miner.cfg
			ECHO miner.cfg created... Check it, please.
		)
	)
	IF NOT EXIST %MinerProcessProgram% (
		ECHO %MinerProcessProgram% is missing, mining is impossible.
		PAUSE
		EXIT
	)
	START /MIN %MinerProcessProgram% && ECHO Miner is started at %H1%:%X1%:%C1% %Y1%.%M1%.%D1%.
	ECHO [%Y1%.%M1%.%D1%][%H1%:%X1%:%C1%] Miner is started. Autorun v. %Version%. >> %~n0.log
	IF %EnableTelegramNotifications% EQU 1 (
		IF EXIST "%CurlPath%" (
			IF %ChatId% NEQ "000000000" "%CurlPath%" "https://api.telegram.org/bot438597926:AAGGY2wHtvLriYdlvgOuptjw8FJYj6rimac/sendMessage?chat_id=%ChatId%&text=%RigName%: Miner is started." 2>NUL 1>&2
		)
	)
) ELSE (
	IF NOT EXIST %MinerProcessBat% (
		ECHO TITLE %MinerProcessBat% > %MinerProcessBat%
		ECHO %MinerProcessBatText% >> %MinerProcessBat%
		ECHO EXIT >> %MinerProcessBat%
		ECHO %MinerProcessBat% created... Check it, please.
		GOTO start
	)
	START /MIN "%MinerProcessBat%" %MinerProcessBat% && ECHO Miner is started at %H1%:%X1%:%C1% %Y1%.%M1%.%D1%.
	ECHO [%Y1%.%M1%.%D1%][%H1%:%X1%:%C1%] Miner is started. Autorun v. %Version%. >> %~n0.log
	IF %EnableTelegramNotifications% EQU 1 (
		IF EXIST "%CurlPath%" (
			IF %ChatId% NEQ "000000000" "%CurlPath%" "https://api.telegram.org/bot438597926:AAGGY2wHtvLriYdlvgOuptjw8FJYj6rimac/sendMessage?chat_id=%ChatId%&text=%RigName%: Miner is started." 2>NUL 1>&2
		)
	)
)
timeout /T 5 /nobreak >NUL
IF NOT EXIST %MinerProcessLog% (
	ECHO Error. %MinerProcessLog% is missing. Check it, please.
	IF %UseBatOrExe% EQU 2 (
		ECHO Check "--log 2" and "--eexit 3" options in your %MinerProcessBat% file.
		ECHO Example:
		ECHO miner --server eu1-zcash.flypool.org --port 3333 --user t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv.imaginary --pass x --log 2 --eexit 3
		CHOICE /C yn /T 30 /D y /M "Create default %MinerProcessBat%"
		IF ERRORLEVEL ==2 (
			ECHO [%Y1%.%M1%.%D1%][%H1%:%X1%:%C1%] Error. %MinerProcessLog% is missing. Check it, please. >> %~n0.log
			ECHO [%Y1%.%M1%.%D1%][%H1%:%X1%:%C1%] Check "--log 2" and "--eexit 3" options in your %MinerProcessBat% file. >> %~n0.log
		) ELSE (
			ECHO TITLE %MinerProcessBat% > %MinerProcessBat%
			ECHO %MinerProcessBatText% >> %MinerProcessBat%
			ECHO EXIT >> %MinerProcessBat%
			ECHO %MinerProcessBat% created... Check it, please.
			GOTO start
		)
	) ELSE (
		ECHO Check "log 2" and "eexit 3" options in your miner.cfg file.
		CHOICE /C yn /T 30 /D y /M "Create default miner.cfg"
		IF ERRORLEVEL ==2 (
			ECHO [%Y1%.%M1%.%D1%][%H1%:%X1%:%C1%] Error. %MinerProcessLog% is missing. Check it, please. >> %~n0.log
			ECHO [%Y1%.%M1%.%D1%][%H1%:%X1%:%C1%] Check "log 2" and "eexit 3" options in your miner.cfg file. >> %~n0.log
		) ELSE (
			DEL /Q /F miner.cfg 2>NUL 1>&2
			GOTO start
		)
	)
) ELSE (
	ECHO Connected to %MinerProcessLog%. Start reading...
)
SET FirstRun=0
SET HashrateErrorsAmount=0
SET OldHashrate=0
:check
SET Hashcount=0
SET SumHash=0
SET SumResult=0
COLOR 02
timeout /T 5 /nobreak >NUL
FOR /F %%D IN ('wmic.exe OS GET localdatetime ^| findstr ^[0-9]') DO (SET t2=%%D)
SET Y2=%t2:~0,4%
SET M2=%t2:~4,2%
SET D2=%t2:~6,2%
SET H2=%t2:~8,2%
SET X2=%t2:~10,2%
SET C2=%t2:~12,2%
SET /A s2=H2*60*60*100+X2*60*100+C2*100
IF %D2% GTR %D1% (
	SET /A days=D2-D1
	SET /A s3=^(days*8640000^)-s1
) ELSE (
	IF %M2% NEQ %M1% (
		ECHO [%Y2%.%M2%.%D2%][%H2%:%X2%:%C2%] Warning. Miner must be restarted, please wait. >> %~n0.log
		GOTO hardstart
	)
	IF %s2% GEQ %s1% (SET /A s3=s2-s1) ELSE (SET /A s3=s1-s2)
)
SET /A t3_h=s3/100/60/60
SET /A t3_m=s3 %% ^(100*60*60^)/100/60
SET /A t3_s=s3 %% ^(100*60^)/100
IF %t3_h% LSS 10 (SET t3_h=0%t3_h%) ELSE (SET t3_h=%t3_h%)
IF %t3_m% LSS 10 (SET t3_m=0%t3_m%) ELSE (SET t3_m=%t3_m%)
IF %t3_s% LSS 10 (SET t3_s=0%t3_s%) ELSE (SET t3_s=%t3_s%)
SET t3=%t3_h%:%t3_m%:%t3_s%
IF %D2% NEQ %D1% (
	IF %AutoRestartComputerAtMidnight% EQU 1 (
		GOTO ctimer
	) ELSE (
		IF %AutoRestartMinerAtMidnight% EQU 1 GOTO mtimer
	)
)
IF %AutoRestartComputerEveryHour% EQU 1 (
	IF "%X2%" == "00" GOTO ctimer
	IF %AutoRestartComputerEveryHour% EQU 2 (
		IF "%H2%%X2%" == "0100" GOTO ctimer
		IF "%H2%%X2%" == "0300" GOTO ctimer
		IF "%H2%%X2%" == "0500" GOTO ctimer
		IF "%H2%%X2%" == "0700" GOTO ctimer
		IF "%H2%%X2%" == "0900" GOTO ctimer
		IF "%H2%%X2%" == "1100" GOTO ctimer
		IF "%H2%%X2%" == "1300" GOTO ctimer
		IF "%H2%%X2%" == "1500" GOTO ctimer
		IF "%H2%%X2%" == "1700" GOTO ctimer
		IF "%H2%%X2%" == "1900" GOTO ctimer
		IF "%H2%%X2%" == "2100" GOTO ctimer
		IF "%H2%%X2%" == "2300" GOTO ctimer
	)
) ELSE (
	IF %AutoRestartMinerEveryHour% EQU 1 (
		IF "%X2%" == "00" GOTO mtimer
	)
	IF %AutoRestartMinerEveryHour% EQU 2 (
		IF "%H2%%X2%" == "0100" GOTO mtimer
		IF "%H2%%X2%" == "0300" GOTO mtimer
		IF "%H2%%X2%" == "0500" GOTO mtimer
		IF "%H2%%X2%" == "0700" GOTO mtimer
		IF "%H2%%X2%" == "0900" GOTO mtimer
		IF "%H2%%X2%" == "1100" GOTO mtimer
		IF "%H2%%X2%" == "1300" GOTO mtimer
		IF "%H2%%X2%" == "1500" GOTO mtimer
		IF "%H2%%X2%" == "1700" GOTO mtimer
		IF "%H2%%X2%" == "1900" GOTO mtimer
		IF "%H2%%X2%" == "2100" GOTO mtimer
		IF "%H2%%X2%" == "2300" GOTO mtimer
	)
	IF %AutoRestartComputerAtMidday% EQU 1 (
		IF "%H2%%X2%" == "1200" GOTO ctimer
	) ELSE (
		IF %AutoRestartMinerAtMidday% EQU 1 (
			IF "%H2%%X2%" == "1200" GOTO mtimer
		)
	)
)
IF %ErrorsCounter% GEQ %ErrorsAmount% (
	ECHO [%Y2%.%M2%.%D2%][%H2%:%X2%:%C2%] Warning. Too many errors, need clear GPU cash. Miner works %t3% >> %~n0.log
	COLOR 0C
	ECHO ==================================================================
	ECHO +----------------------------------------------------------------+
	ECHO + Now %Y2%.%M2%.%D2% %H2%:%X2%                                           +
	ECHO + Miner was started at %Y1%.%M1%.%D1% %H1%:%X1%                          +
	ECHO + Miner works %t3%                                           +
	ECHO + Warning. Too many errors, need clear GPU cash.                 +
	ECHO + Computer restarting...                                         +
	ECHO +----------------------------------------------------------------+
	ECHO ==================================================================
	GOTO restart
)
IF %AverageHashrate% GTR 0 (
	timeout /T 5 /nobreak >NUL
	FOR /F "tokens=3 delims= " %%E IN ('findstr /R /C:"Total speed: [0-9]* Sol/s" %MinerProcessLog%') DO (
		SET /A Hashcount+=1
		SET /A SumHash=SumHash+%%E
		SET /A SumResult=SumHash/Hashcount
		IF !SumResult! NEQ %OldHashrate% (
			IF !SumResult! LSS %AverageHashrate% (
				COLOR 0C
				IF %EnableGPUOverClockControl% NEQ 0 (
					tasklist /FI "IMAGENAME eq %GPUOverClockProcess%" 2>NUL | find /I /N "%GPUOverClockProcess%" >NUL
					IF ERRORLEVEL ==1 (
						ECHO [%Y2%.%M2%.%D2%][%H2%:%X2%:%C2%] Error. Process %GPUOverClockProcess% crashed. Miner works %t3% >> %~n0.log
						IF %EnableTelegramNotifications% EQU 1 (
							IF EXIST "%CurlPath%" (
								IF %ChatId% NEQ "000000000" "%CurlPath%" "https://api.telegram.org/bot438597926:AAGGY2wHtvLriYdlvgOuptjw8FJYj6rimac/sendMessage?chat_id=%ChatId%&text=%RigName%: Process %GPUOverClockProcess% crashed." 2>NUL 1>&2
							)
						)
						IF %EnableGPUOverClockControl% EQU 1 SET ErrorEcho=+ Error. Process %GPUOverClockProcess% crashed...                           +
						IF %EnableGPUOverClockControl% EQU 2 SET ErrorEcho=+ Error. Process %GPUOverClockProcess% crashed...                   +
						IF %EnableGPUOverClockControl% EQU 3 SET ErrorEcho=+ Error. Process %GPUOverClockProcess% crashed...                       +
						GOTO error
					)
				)
				IF %HashrateErrorsAmount% GEQ 5 (
					ECHO [%Y2%.%M2%.%D2%][%H2%:%X2%:%C2%] Warning. Low Hashrate. Miner works %t3% >> %~n0.log
					SET ErrorEcho=+ Warning. Low Hashrate...                                       +
					GOTO error
				)
				IF %EnableTelegramNotifications% EQU 1 (
					IF EXIST "%CurlPath%" (
						IF %ChatId% NEQ "000000000" "%CurlPath%" "https://api.telegram.org/bot438597926:AAGGY2wHtvLriYdlvgOuptjw8FJYj6rimac/sendMessage?chat_id=%ChatId%&text=%RigName%: Check your hashrate. !SumResult!/%AverageHashrate%" 2>NUL 1>&2
					)
				)
				ECHO [%Y2%.%M2%.%D2%][%H2%:%X2%:%C2%] Warning. Check your hashrate. [!SumResult!/%AverageHashrate%]
				ECHO [%Y2%.%M2%.%D2%][%H2%:%X2%:%C2%] Warning. Check your hashrate. [!SumResult!/%AverageHashrate%] >> %~n0.log
				SET /A HashrateErrorsAmount+=1
				SET OldHashrate=!SumResult!
			)
		)
	)
)
timeout /T 5 /nobreak >NUL
FOR /F "delims=" %%F IN ('findstr %ConfigErrorsList% %InternetErrorsList% %MinerErrorsList% %CriticalErrorsList% %OtherErrorsList% %MinerProcessLog%') DO (
	COLOR 0C
	IF %EnableTelegramNotifications% EQU 1 (
		IF EXIST "%CurlPath%" (
			IF %EnableInternetErrorsList% EQU 0 (
				ECHO %%F | findstr /V %InternetErrorsList% 2>NUL 1>&2 && (
					IF %ChatId% NEQ "000000000" "%CurlPath%" "https://api.telegram.org/bot438597926:AAGGY2wHtvLriYdlvgOuptjw8FJYj6rimac/sendMessage?chat_id=%ChatId%&text=%RigName%: %%F." 2>NUL 1>&2
				)
			) ELSE (
				IF %ChatId% NEQ "000000000" "%CurlPath%" "https://api.telegram.org/bot438597926:AAGGY2wHtvLriYdlvgOuptjw8FJYj6rimac/sendMessage?chat_id=%ChatId%&text=%RigName%: %%F." 2>NUL 1>&2
			)
		)
	)
	timeout /T 10 /nobreak >NUL
	ECHO %%F | findstr %ConfigErrorsList% 2>NUL && (
		ECHO [%Y2%.%M2%.%D2%][%H2%:%X2%:%C2%] Error. Carefully configure config.bat, miner.cfg or/and %MinerProcessBat% >> %~n0.log
		ECHO %%F >> %~n0.log
		ECHO ==================================================================
		ECHO +----------------------------------------------------------------+
		ECHO + Now %Y2%.%M2%.%D2% %H2%:%X2%                                           +
		ECHO + Miner was started at %Y1%.%M1%.%D1% %H1%:%X1%                          +
		ECHO + Carefully configure config.bat, miner.cfg or/and %MinerProcessBat%     +
		ECHO + Miner restarting with default values...                        +
		ECHO +----------------------------------------------------------------+
		ECHO ==================================================================
		CHOICE /C yn /T 30 /D y /M "Create default %MinerProcessBat% and continue mining"
		IF ERRORLEVEL ==2 EXIT
		taskkill /F /IM "%MinerProcessProgram%" 2>NUL 1>&2
		taskkill /F /FI "IMAGENAME eq cmd.exe" /FI "WINDOWTITLE eq %MinerProcessBat%*" 2>NUL 1>&2
		SET UseBatOrExe=2
		timeout /T 5 /nobreak >NUL
		ECHO TITLE %MinerProcessBat% > %MinerProcessBat%
		ECHO miner --server eu1-zcash.flypool.org --port 3333 --user t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv.imaginary --pass x --log 2 --fee 2 --templimit 80 --eexit 3 --pec>> %MinerProcessBat%
		ECHO EXIT >> %MinerProcessBat%
		ECHO Default %MinerProcessBat% created... Check it, please.
		SET /A ErrorsCounter+=1
		GOTO start
	)
	IF %EnableInternetErrorsList% EQU 1 (
		ping google.com 2>NUL 1>&2 | find /i "TTL=" 2>NUL 1>&2 || (
			ECHO %%F | findstr %InternetErrorsList% 2>NUL && (
				ECHO [%Y2%.%M2%.%D2%][%H2%:%X2%:%C2%] Error. Something wrong with Internet. Check it, please. Miner works %t3% >> %~n0.log
				ECHO %%F >> %~n0.log
				ECHO ==================================================================
				ECHO +----------------------------------------------------------------+
				ECHO + Now %Y2%.%M2%.%D2% %H2%:%X2%                                           +
				ECHO + Miner was started at %Y1%.%M1%.%D1% %H1%:%X1%                          +
				ECHO + Miner works %t3%                                           +
				ECHO + Something wrong with Internet...                               +
				ECHO + Waiting 12 minutes...                                          +
				ECHO +----------------------------------------------------------------+
				ECHO ==================================================================
				CHOICE /C yn /T 660 /D y /M "Restart miner"
				IF ERRORLEVEL ==2 EXIT
				IF EXIST "Logs\miner_*.log" (
					CHOICE /C yn /T 60 /D n /M "Clean %MinerPath%Logs folder now"
					IF ERRORLEVEL ==2 (
						SET /A ErrorsCounter+=1
						GOTO start
					)
					DEL /F /Q "Logs\*" && ECHO Clean %MinerPath%Logs finished.
				)
				GOTO start
			)
		)
	)
	ECHO %%F | findstr %MinerErrorsList% 2>NUL && (
		ECHO [%Y2%.%M2%.%D2%][%H2%:%X2%:%C2%] Error. Something wrong with GPU, Voltage or OverClock. Miner works %t3% >> %~n0.log
		ECHO %%F >> %~n0.log
		SET ErrorEcho=+ Something wrong with GPU, Voltage or OC...                     +
		GOTO error
	)
	ECHO %%F | findstr %CriticalErrorsList% 2>NUL && (
		ECHO [%Y2%.%M2%.%D2%][%H2%:%X2%:%C2%] Critical error. Check your GPU, Voltage or OverClock. Miner works %t3% >> %~n0.log
		ECHO %%F >> %~n0.log
		GOTO restart
	)
	ECHO %%F | findstr /V %ConfigErrorsList% %InternetErrorsList% %MinerErrorsList% %CriticalErrorsList% 2>NUL && (
		ECHO [%Y2%.%M2%.%D2%][%H2%:%X2%:%C2%] Error. New error found. Miner works %t3% >> %~n0.log
		ECHO %%F >> %~n0.log
		SET ErrorEcho=+ New error found...                                             +
		GOTO error
	)
)
timeout /T 5 /nobreak >NUL
tasklist /FI "IMAGENAME eq %MinerProcessProgram%" 2>NUL | find /I /N "%MinerProcessProgram%" >NUL
IF ERRORLEVEL ==1 (
	ECHO [%Y2%.%M2%.%D2%][%H2%:%X2%:%C2%] Error. Process %MinerProcessProgram% crashed. Miner works %t3% >> %~n0.log
	IF %EnableTelegramNotifications% EQU 1 (
		IF EXIST "%CurlPath%" (
			IF %ChatId% NEQ "000000000" "%CurlPath%" "https://api.telegram.org/bot438597926:AAGGY2wHtvLriYdlvgOuptjw8FJYj6rimac/sendMessage?chat_id=%ChatId%&text=%RigName%: Process %MinerProcessProgram% crashed." 2>NUL 1>&2
		)
	)
	SET ErrorEcho=+ Error. Process %MinerProcessProgram% crashed...                            +
	GOTO error
)
IF %EnableAUAutorun% EQU 1 (
	timeout /T 5 /nobreak >NUL
	tasklist /FI "IMAGENAME eq %AUProcessName%" 2>NUL | find /I /N "%AUProcessName%" >NUL
	IF ERRORLEVEL ==1 (
		ECHO [%Y2%.%M2%.%D2%][%H2%:%X2%:%C2%] Error. %AUProcessName% crashed. Miner works %t3% >> %~n0.log
		IF %EnableTelegramNotifications% EQU 1 (
			IF EXIST "%CurlPath%" (
				IF %ChatId% NEQ "000000000" "%CurlPath%" "https://api.telegram.org/bot438597926:AAGGY2wHtvLriYdlvgOuptjw8FJYj6rimac/sendMessage?chat_id=%ChatId%&text=%RigName%: %AUProcessName% crashed." 2>NUL 1>&2
			)
		)
		SET ErrorEcho=+ Error. Additional program crashed...                           +
		GOTO error
	)
)
SET GPUCount=0
IF %FirstRun% EQU 0 (
	IF %GPUDevicesAmount% GEQ 1 (
		timeout /T 10 /nobreak >NUL
		FOR /F "delims=" %%G IN ('findstr /R /C:"CUDA: Device: [0-9]* .* PCI: .*" %MinerProcessLog%') DO (SET /A GPUCount+=1)
		IF %GPUDevicesAmount% NEQ !GPUCount! (
			ECHO [%Y2%.%M2%.%D2%][%H2%:%X2%:%C2%] Error. Something wrong with GPU, failed load all GPU. Amount of GPU [!GPUCount!/%GPUDevicesAmount%]. Miner works %t3% >> %~n0.log
			IF %EnableTelegramNotifications% EQU 1 (
				IF EXIST "%CurlPath%" (
					IF %ChatId% NEQ "000000000" "%CurlPath%" "https://api.telegram.org/bot438597926:AAGGY2wHtvLriYdlvgOuptjw8FJYj6rimac/sendMessage?chat_id=%ChatId%&text=%RigName%: Something wrong with GPU, failed load all GPU. Amount of GPU !GPUCount!/%GPUDevicesAmount%." 2>NUL 1>&2
				)
			)
			COLOR 0C
			ECHO ==================================================================
			ECHO +----------------------------------------------------------------+
			ECHO + Now %Y2%.%M2%.%D2% %H2%:%X2%                                           +
			ECHO + Miner was started at %Y1%.%M1%.%D1% %H1%:%X1%                          +
			ECHO + Miner works %t3%                                           +
			ECHO + Something wrong with GPU, failed load all GPU.                 +
			ECHO + Amount of GPU: [!GPUCount!/%GPUDevicesAmount%]                                           +
			ECHO + Computer restarting...                                         +
			ECHO +----------------------------------------------------------------+
			ECHO ==================================================================
			GOTO restart
		)
	) ELSE (
		ECHO GPU activated check is disabled.
	)
	ECHO ==================================================================
	ECHO +----------------------------------------------------------------+
	ECHO + Miner was started at %Y1%.%M1%.%D1% %H1%:%X1%                          +
	ECHO + Process %MinerProcessProgram% is running - don't worry                     +
	IF %EnableGPUOverClockControl% NEQ 0 (
		IF %EnableGPUOverClockControl% EQU 1 (
			ECHO + Process %GPUOverClockProcess% is running...                               +
		)
		IF %EnableGPUOverClockControl% EQU 2 (
			ECHO + Process %GPUOverClockProcess% is running...                       +
		)
		IF %EnableGPUOverClockControl% EQU 3 (
			ECHO + Process %GPUOverClockProcess% is running...                           +
		)
		IF %EnableGPUOverClockControl% GEQ 4 (
			ECHO + GPU OverClock monitor: Wrong config.                           +
		)
	) ELSE (
		ECHO + GPU OverClock monitor: Disabled                                +
	)
	IF %AllowRestartComputer% EQU 1 (
		ECHO + Restart computer: Allowed                                      +
	) ELSE (
		ECHO + Restart computer: Denied                                       +
	)
	IF %AutoRestartMinerEveryHour% EQU 1 (
		ECHO + Autorestart miner every hour: Enabled                          +
	) ELSE (
		ECHO + Autorestart miner every hour: Disabled                         +
	)
	IF %AutoRestartMinerAtMidnight% EQU 1 (
		ECHO + Autorestart miner at 00:00: Enabled                            +
	) ELSE (
		ECHO + Autorestart miner at 00:00: Disabled                           +
	)
	IF %AutoRestartMinerAtMidday% EQU 1 (
		ECHO + Autorestart miner at 12:00: Enabled                            +
	) ELSE (
		ECHO + Autorestart miner at 12:00: Disabled                           +
	)
	IF %AutoRestartComputerEveryHour% EQU 0 (
		ECHO + Autorestart computer every hour: Disabled                      +
	) ELSE (
		ECHO + Autorestart computer every hour: Enabled                       +
	)
	IF %AutoRestartComputerAtMidnight% EQU 1 (
		ECHO + Autorestart computer at 00:00: Enabled                         +
	) ELSE (
		ECHO + Autorestart computer at 00:00: Disabled                        +
	)
	IF %AutoRestartComputerAtMidday% EQU 1 (
		ECHO + Autorestart computer at 12:00: Enabled                         +
	) ELSE (
		ECHO + Autorestart computer at 12:00: Disabled                        +
	)
	IF %EnableAUAutorun% EQU 1 (
		ECHO + Additional program autorun: Enabled                            +
	) ELSE (
		ECHO + Additional program autorun: Disabled                           +
	)
	ECHO + Amount of errors: [%ErrorsCounter%/%ErrorsAmount%], GPU: [!GPUCount!/%GPUDevicesAmount%]                            +
	ECHO +----------------------------------------------------------------+
	ECHO ==================================================================
	SET FirstRun=1
	IF EXIST "Logs\miner_*.log" (
		CHOICE /C yn /T 60 /D n /M "Clean %MinerPath%Logs folder now"
		IF ERRORLEVEL ==2 (
			ECHO Now I will take care of your %RigName%, and you can take a rest.
			GOTO check
		) ELSE (
			DEL /F /Q "Logs\*" && ECHO Clean %MinerPath%Logs finished.
		)
		CHOICE /C yn /T 60 /D n /M "Clean %MinerPath% folder now"
		IF ERRORLEVEL ==2 (
			ECHO Now I will take care of your %RigName%, and you can take a rest.
			GOTO check
		) ELSE (
			CHOICE /C yn /T 60 /D n /M "Really, delete all useless files and folders from %MinerPath%"
			IF ERRORLEVEL ==2 (
				ECHO Now I will take care of your %RigName%, and you can take a rest.
				GOTO check
			) ELSE (
				FOR %%H IN ("%MinerPath%*") DO (IF NOT "%%H" == "%MinerPath%%~n0.bat" IF NOT "%%H" == "%MinerPath%%~n0.log" IF NOT "%%H" == "%MinerPath%autorun.exe" IF NOT "%%H" == "%MinerPath%config.bat" IF NOT "%%H" == "%MinerPath%miner.cfg" IF NOT "%%H" == "%MinerPath%%MinerProcessBat%" IF NOT "%%H" == "%MinerPath%cudart32_80.dll" IF NOT "%%H" == "%MinerPath%cudart64_80.dll" IF NOT "%%H" == "%MinerPath%miner.exe" IF NOT "%%H" == "%MinerPath%%MinerProcessProgram%" IF NOT "%%H" == "%MinerPath%%MinerProcessLog%" DEL /Q /F "%%H")
				FOR /F "tokens=*" %%I IN ('DIR %MinerPath% /A:D /B') DO (IF /I NOT "%%I" == "Logs" IF /I NOT "%%I" == "Profiles" IF /I NOT "%%I" == "curl-7.55.1-win64-mingw"  (RD /S /Q "%MinerPath%%%I"))
				ECHO Good. Folder %MinerPath% clean now.
				ECHO Now I will take care of your %RigName%, and you can take a rest.
				GOTO check
			)
		)
	)
)
GOTO check