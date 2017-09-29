@ECHO OFF & SETLOCAL ENABLEDELAYEDEXPANSION
MODE CON cols=100 lines=35
shutdown /A >NUL
FOR /F %%A IN ('wmic.exe OS GET localdatetime ^| findstr ^[0-9]') DO SET t0=%%A
SET Y0=%t0:~0,4%
SET M0=%t0:~4,2%
SET D0=%t0:~6,2%
SET H0=%t0:~8,2%
SET X0=%t0:~10,2%
SET C0=%t0:~12,2%
TITLE Miner-autorun(%Y0%.%M0%.%D0%_%H0%:%X0%:%C0%)
SET Version=1.6.4
:hardstart
CLS
COLOR 06
ECHO ==================================================================
ECHO +----------------------------------------------------------------+
ECHO +          AutoRun for EWBF 0.3.4.b Miner - by Acrefawn          +
ECHO +                 acrefawn@gmail.com [v. %Version%]                  +
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
FOR /F "delims=" %%z IN ('tasklist /V /NH /FI "imagename eq cmd.exe" ^| findstr /V /R /C:".*Miner-autorun(%Y0%.%M0%.%D0%_%H0%:%X0%:%C0%)" ^| findstr /R /C:".*Miner-autorun.*"') DO (
	ECHO Warning. This process is already running. 
	ECHO The original process will continue, but this window will close in 10 seconds.
	CHOICE /C yn /T 10 /D y /M "Continue this process"
	IF ERRORLEVEL ==2 EXIT
)
REM Attention. Change this options bellow if it is really needed.
REM Amount of errors before computer restart (5 - default)
SET ErrorsAmount=5
REM Amount of hashrate errors before miner restart (5 - default)
SET HashrateErrorsAmount=5
REM Attention. Do not touch this options bellow in any case.
SET MinerPath=%~dp0
SET FirstRun=0
SET ErrorsCounter=0
SET InternetErrorsList=/C:".*Lost connection.*" /C:".*Cannot resolve hostname.*" /C:".*Stratum subscribe timeout.*" /C:".*Cannot connect to the pool.*" /C:".*No properly configured pool.*"
SET InternetErrorsCancel=/C:".*Connection restored.*"
SET MinerErrorsList=/C:".*Thread exited.*" /C:".* 0 Sol/s.*" /C:"Total speed: 0 Sol/s" /C:".*benchmark error.*" /C:".*Api bind error.*" /C:".*CUDA error.*" /C:".*Looks like .*"
SET CriticalErrorsList=/C:".*Cannot initialize NVML. Temperature monitor will not work.*"
SET OtherErrorsList=/C:"ERROR:.*"
SET MinerWarningsList=/C:".*Temperature limit are reached, gpu will be stopped.*"
SET OtherWarningsList=/C:"WARNING:.*"
SET ErrorEcho=+ Unknown error.                                                 +
SET ServerQueue=0
SET SwitchToDefault=0
SET OldMessageId=0
SET TelegramCommand=https://api.telegram.org/bot438597926:AAGGY2wHtvLriYdlvgOuptjw8FJYj6rimac/sendMessage?
:checkconfig
IF EXIST config.bat (
	FOR /F "tokens=5 delims= " %%B IN ('findstr /C:"Configuration file v." config.bat') DO (
		IF "%%B" == "%Version%" (
			FOR %%C IN (config.bat) DO (
				IF %%~ZC LSS 4290 (
					ECHO Config.bat file error. It is corrupted, check it please.
				) ELSE (
					CALL config.bat
					ECHO Config.bat loaded.
					GOTO prestart
				)
			)
		) ELSE (
			ECHO Your config.bat is out of date.
		)
		CHOICE /C yn /T 15 /D y /M "Backup existing and create an updated (default) config.bat"
		IF ERRORLEVEL ==2 EXIT
		MOVE /Y config.bat config_backup_%%B.bat >NUL && ECHO Created backup of your v. %%B config.bat.
	)
)
> config.bat ECHO @ECHO off
>> config.bat ECHO REM Configuration file v. %Version%
>> config.bat ECHO REM =================================================== [Overclock program]
>> config.bat ECHO REM Enable GPU Overclock control monitor. (0 - false, 1 - true GIGABYTE, 2 - true MSI, 3 - true ASUS, 4 - true EVGA)
>> config.bat ECHO REM Autorun and run-check of GPU Overclock programs.
>> config.bat ECHO SET EnableGPUOverclockMonitor=0
>> config.bat ECHO REM Additional option to auto-enable Overclock Profile for MSI Afterburner. (0 - false, 1 - Profile 1, 2 - Profile 2, 3 - Profile 3, 4 - Profile 4, 5 - Profile 5)
>> config.bat ECHO SET AutorunMSIAWithProfile=0
>> config.bat ECHO REM Allow Overclock programs to be restarted when miner is restarted. (1 - true, 0 - false)
>> config.bat ECHO REM Please, do not use this option if it is not needed.
>> config.bat ECHO SET RestartGPUOverclockMonitor=0
>> config.bat ECHO REM =================================================== [GPU]
>> config.bat ECHO REM Set how many GPU devices are enabled.
>> config.bat ECHO SET NumberOfGPUs=0
>> config.bat ECHO REM Set total average hashrate of this Rig. (you can use average hashrate value from your pool)
>> config.bat ECHO SET AverageTotalHashrate=0
>> config.bat ECHO REM =================================================== [Miner]
>> config.bat ECHO REM Use miner.bat or miner.exe file to start mining? (1 - .exe, 2 - .bat)
>> config.bat ECHO SET StartFromBatOrExe=2
>> config.bat ECHO REM Set miner command here to auto-create miner.bat or miner.cfg file if it is missing or wrong. (keep default order)
>> config.bat ECHO SET MainServerBatCommand=miner --server eu1-zcash.flypool.org --port 3333 --user t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv.imaginary --pass x --log 2 --fee 2 --templimit 90 --eexit 2 --pec
>> config.bat ECHO REM Enable additional server. When the main server fails, %~n0 will switch to the additional server immediately. (1 - true, 0 - false) EnableInternetConnectivityCheck=1 required.
>> config.bat ECHO SET EnableAdditionalServer=0
>> config.bat ECHO REM Configure miner command here. Old miner.bat will be removed and a new one will be created with this value. (keep default order) EnableInternetConnectivityCheck=1 required.
>> config.bat ECHO SET AdditionalServerBatCommand=miner --server eu1-zcash.flypool.org --port 3333 --user t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv.imaginary --pass x --log 2 --fee 2 --templimit 90 --eexit 2 --pec
>> config.bat ECHO REM =================================================== [Timers]
>> config.bat ECHO REM Restart miner or computer every hour. (1 - true miner every One hour, 2 - true miner every Two hours, 3 - true computer every One hour, 4 - true computer every Two hours, 0 - false)
>> config.bat ECHO SET EveryHourAutoRestart=0
>> config.bat ECHO REM Restart miner or computer every day at 12:00. (1 - true miner, 2 - true computer, 0 - false)
>> config.bat ECHO SET MiddayAutoRestart=0
>> config.bat ECHO REM Restart miner or computer every day at 00:00. (1 - true miner, 2 - true computer, 0 - false)
>> config.bat ECHO SET MidnightAutoRestart=0
>> config.bat ECHO REM =================================================== [Other]
>> config.bat ECHO REM Skip miner startup confirmation. (1 - true, 0 - false)
>> config.bat ECHO SET SkipBeginMiningConfirmation=0
>> config.bat ECHO REM Enable Internet connectivity check. (1 - true, 0 - false)
>> config.bat ECHO REM Disable Internet connectivity check only if you have difficulties with your connection. (ie. high latency, intermittent connectivity)
>> config.bat ECHO SET EnableInternetConnectivityCheck=1
>> config.bat ECHO REM Enable additional environments. Please do not use this option if it is not needed, or if you do not understand it's function. (1 - true, 0 - false)
>> config.bat ECHO REM GPU_FORCE_64BIT_PTR 0, GPU_MAX_HEAP_SIZE 100, GPU_USE_SYNC_OBJECTS 1, GPU_MAX_ALLOC_PERCENT 100, GPU_SINGLE_ALLOC_PERCENT 100
>> config.bat ECHO SET EnableGPUEnvironments=0
>> config.bat ECHO REM =================================================== [Telegram notifications]
>> config.bat ECHO REM Enable Telegram notifications. Don't forget to add @ZcashMinerAutorunBot in Telegram. (1 - true, 2 - false)
>> config.bat ECHO SET EnableTelegramNotifications=0
>> config.bat ECHO REM Path to "curl" library + curl.exe file. (in English, without special symbols and spaces)
>> config.bat ECHO SET CurlPath=curl-7.55.1-win64-mingw\bin\curl.exe
>> config.bat ECHO REM Name your Rig. (in English, without special symbols)
>> config.bat ECHO SET RigName=Zcash Farm
>> config.bat ECHO REM Enter here your chat_id, from Telegram @get_id_bot or @ZcashMinerAutorunBot.
>> config.bat ECHO SET ChatId=000000000
>> config.bat ECHO REM Enable hourly statistics through Telegram. (1 - true, 2 - true in silent mode, 0 - false)
>> config.bat ECHO SET EnableEveryHourInfoSend=0
>> config.bat ECHO REM =================================================== [Additional program]
>> config.bat ECHO REM Enable additional program check on startup. (ie. TeamViewer, Minergate, Storj etc) (1 - true, 0 - false)
>> config.bat ECHO SET EnableAPAutorun=0
>> config.bat ECHO REM Process name of additional program. (Press CTRL+ALT+DEL to find the process name)
>> config.bat ECHO SET APProcessName=TeamViewer.exe
>> config.bat ECHO REM Path to file of additional program. (ie. C:\Program Files (x86)\TeamViewer\TeamViewer.exe)
>> config.bat ECHO SET APProcessPath=C:\Program Files (x86)\TeamViewer\TeamViewer.exe
ECHO Default config.bat created. Please check it and restart %~n0.bat.
GOTO checkconfig
:restart
COLOR 0C
CHOICE /C yn /T 30 /D y /M "Restart your computer now"
IF ERRORLEVEL ==2 GOTO hardstart
tskill /A /V %GPUOverclockProcess% 2>NUL 1>&2 && ECHO Process %GPUOverclockProcess%.exe was successfully killed.
taskkill /F /IM "miner.exe" 2>NUL 1>&2 && ECHO Process miner.exe was successfully killed.
timeout /T 5 /nobreak >NUL
taskkill /F /FI "IMAGENAME eq cmd.exe" /FI "WINDOWTITLE eq miner.bat*" 2>NUL 1>&2
IF %EnableAPAutorun% EQU 1 (
	taskkill /F /IM "%APProcessName%" 2>NUL 1>&2 && ECHO Process %APProcessName% was successfully killed.
)
IF %EnableTelegramNotifications% EQU 1 "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&text=*%RigName%:* Computer restarting..." 2>NUL 1>&2
>> %~n0.log ECHO [%NowDate%][%NowTime%] Computer restarting...
shutdown /T 30 /R /F /C "Your computer will restart after 30 seconds. To cancel restart, close this window and start autorun.bat manually."
EXIT
:prestart
SET NumberOfGPUs=%NumberOfGPUs: =%
SET AverageTotalHashrate=%AverageTotalHashrate: =%
SET ChatId=%ChatId: =%
IF %ChatId% EQU "000000000" SET EnableTelegramNotifications=0
IF NOT EXIST "%CurlPath%" SET EnableTelegramNotifications=0
IF %EnableGPUEnvironments% EQU 1 (
	SETX GPU_FORCE_64BIT_PTR 0 2>NUL 1>&2 && ECHO GPU_FORCE_64BIT_PTR 0
	SETX GPU_MAX_HEAP_SIZE 100 2>NUL 1>&2 && ECHO GPU_MAX_HEAP_SIZE 100
	SETX GPU_USE_SYNC_OBJECTS 1 2>NUL 1>&2 && ECHO GPU_USE_SYNC_OBJECTS 1
	SETX GPU_MAX_ALLOC_PERCENT 100 2>NUL 1>&2 && ECHO GPU_MAX_ALLOC_PERCENT 100
	SETX GPU_SINGLE_ALLOC_PERCENT 100 2>NUL 1>&2 && ECHO GPU_SINGLE_ALLOC_100
) ELSE (
	REG DELETE HKCU\Environment /F /V GPU_FORCE_64BIT_PTR 2>NUL 1>&2 && ECHO GPU_FORCE_64BIT_PTR successfully removed from environments.
	REG DELETE HKCU\Environment /F /V GPU_MAX_HEAP_SIZE 2>NUL 1>&2 && ECHO GPU_MAX_HEAP_SIZE successfully removed from environments.
	REG DELETE HKCU\Environment /F /V GPU_USE_SYNC_OBJECTS 2>NUL 1>&2&& ECHO GPU_USE_SYNC_OBJECTS successfully removed from environments.
	REG DELETE HKCU\Environment /F /V GPU_MAX_ALLOC_PERCENT 2>NUL 1>&2 && ECHO GPU_MAX_ALLOC_PERCENT successfully removed from environments.
	REG DELETE HKCU\Environment /F /V GPU_SINGLE_ALLOC_PERCENT 2>NUL 1>&2 && ECHO GPU_SINGLE_ALLOC_PERCENT successfully removed from environments.
)
IF %SkipBeginMiningConfirmation% EQU 0 (
	CHOICE /C yn /T 30 /D y /M "Begin mining"
	IF ERRORLEVEL ==2 EXIT
	GOTO start
) ELSE (
	timeout /T 5 /nobreak >NUL
	GOTO start
)
:switch
COLOR 06
IF %EnableTelegramNotifications% EQU 1 "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&text=*%RigName%:* Attempting to switch to the main pool server." 2>NUL 1>&2
>> %~n0.log ECHO [%NowDate%][%NowTime%] Warning. Attempting to switch to the main pool server.
ECHO ==================================================================
ECHO +----------------------------------------------------------------+
ECHO + Now %NowDate% %NowTime%                                           +
ECHO + Miner was started at %StartDate% %StartTime%                          +
ECHO + Miner ran for %t3%                                         +
ECHO + Warning. Attempting to switch to the main pool server.         +
ECHO +----------------------------------------------------------------+
ECHO ==================================================================
GOTO hardstart
:ctimer
COLOR 06
IF %EnableTelegramNotifications% EQU 1 "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&text=*%RigName%:* Scheduled computer restart, please wait..." 2>NUL 1>&2
>> %~n0.log ECHO [%NowDate%][%NowTime%] Warning. Scheduled computer restart, please wait. Miner ran for %t3%.
ECHO ==================================================================
ECHO +----------------------------------------------------------------+
ECHO + Now %NowDate% %NowTime%                                           +
ECHO + Miner was started at %StartDate% %StartTime%                          +
ECHO + Miner ran for %t3%                                         +
ECHO + Warning. Scheduled computer restart, please wait...            +
ECHO +----------------------------------------------------------------+
ECHO ==================================================================
GOTO restart
:mtimer
COLOR 06
IF %EnableTelegramNotifications% EQU 1 "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&text=*%RigName%:* Scheduled miner restart, please wait..." 2>NUL 1>&2
>> %~n0.log ECHO [%NowDate%][%NowTime%] Warning. Scheduled miner restart, please wait. Miner ran for %t3%.
ECHO ==================================================================
ECHO +----------------------------------------------------------------+
ECHO + Now %NowDate% %NowTime%                                           +
ECHO + Miner was started at %StartDate% %StartTime%                          +
ECHO + Miner ran for %t3%                                         +
ECHO + Warning. Scheduled miner restart, please wait...               +
ECHO +----------------------------------------------------------------+
ECHO ==================================================================
GOTO hardstart
:error
COLOR 0C
IF %EnableTelegramNotifications% EQU 1 "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&text=*%RigName%:* Miner restarting..." 2>NUL 1>&2
ECHO ==================================================================
ECHO +----------------------------------------------------------------+
ECHO + Now %NowDate% %NowTime%                                           +
ECHO + Miner was started at %StartDate% %StartTime%                          +
ECHO + Miner ran for %t3%                                         +
ECHO %ErrorEcho%
ECHO + Miner restarting...                                            +
ECHO +----------------------------------------------------------------+
ECHO ==================================================================
SET /A ErrorsCounter+=1
:start
COLOR 06
FOR /F %%D IN ('wmic.exe OS GET localdatetime ^| findstr ^[0-9]') DO SET t1=%%D
SET Y1=%t1:~0,4%
SET M1=%t1:~4,2%
SET D1=%t1:~6,2%
SET H1=%t1:~8,2%
SET X1=%t1:~10,2%
SET C1=%t1:~12,2%
SET StartTime=%H1%:%X1%
SET StartDate=%Y1%.%M1%.%D1%
IF %M1:~0,1% ==0 SET M1=%M1:~1%
IF %D1:~0,1% ==0 SET D1=%D1:~1%
IF %H1:~0,1% ==0 SET H1=%H1:~1%
IF %X1:~0,1% ==0 SET X1=%X1:~1%
IF %C1:~0,1% ==0 SET C1=%C1:~1%
SET /A RestartHour=%H1%+2
SET /A s1=H1*60*60+X1*60+C1
IF %EnableGPUOverclockMonitor% GTR 0 (
	IF %AverageTotalHashrate% EQU 0 (
		ECHO Error. Average hashrate = 0. This must be set to a number higher than 0 in your config.bat file under AverageTotalHashrate.
		ECHO GPUOverclockControl will be disabled...
		SET EnableGPUOverclockMonitor=0
	)
	IF %EnableGPUOverclockMonitor% EQU 1 (
		SET GPUOverclockProcess=Xtreme
		SET GPUOverclockPath=\GIGABYTE\XTREME GAMING ENGINE\
	)
	IF %EnableGPUOverclockMonitor% EQU 2 (
		SET GPUOverclockProcess=MSIAfterburner
		SET GPUOverclockPath=\MSI Afterburner\
	)
	IF %EnableGPUOverclockMonitor% EQU 3 (
		SET GPUOverclockProcess=GPUTweakII
		SET GPUOverclockPath=\ASUS\GPU TweakII\
	)
	IF %EnableGPUOverclockMonitor% EQU 4 (
		SET GPUOverclockProcess=PrecisionX_x64
		SET GPUOverclockPath=\EVGA\Precision XOC\
	)
	IF NOT EXIST "%programfiles(x86)%%GPUOverclockPath%" (
		ECHO Warning. Incorrect path to %GPUOverclockProcess%.exe. Default install path required to function. Please reinstall the software using the default path.
		ECHO GPUOverclockControl will be disabled...
		SET EnableGPUOverclockMonitor=0
	)
) ELSE (
	ECHO ECHO Overclock control monitor was disabled.
	SET EnableGPUOverclockMonitor=0
)
IF NOT EXIST "miner.exe" (
	ECHO Error. "miner.exe" is missing. Please check the directory for missing files. Exiting...
	PAUSE
	EXIT
)
IF NOT EXIST "cudart64_80.dll" (
	ECHO Error. "cudart64_80.dll" is missing. Please check the directory for missing files. Exiting...
	PAUSE
	EXIT
)
IF EXIST "Logs" (
	ECHO Folder Logs exist.
) ELSE (
	MD Logs && ECHO Folder Logs created.
)
IF %EnableAPAutorun% EQU 1 (
	tasklist /FI "IMAGENAME eq %APProcessName%" 2>NUL | find /I /N "%APProcessName%" >NUL
	IF ERRORLEVEL ==1 (
		START /MIN "%APProcessName%" "%APProcessPath%" && ECHO %APProcessName% was started at %StartDate% %StartTime%
		IF %EnableTelegramNotifications% EQU 1 "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&text=*%RigName%:* %APProcessName% was started." 2>NUL 1>&2
		>> %~n0.log ECHO [%StartDate%][%StartTime%] %APProcessName% was started.
		timeout /T 5 /nobreak >NUL
	)
)
IF %EnableGPUOverclockMonitor% GEQ 1 (
	IF %RestartGPUOverclockMonitor% EQU 1 (
		IF %FirstRun% EQU 1 (
			tskill /A /V %GPUOverclockProcess% >NUL && ECHO Process %GPUOverclockProcess%.exe was successfully killed.
			IF %EnableTelegramNotifications% EQU 1 "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&text=*%RigName%:* Process %GPUOverclockProcess%.exe was successfully killed." 2>NUL 1>&2
			>> %~n0.log ECHO [%StartDate%][%StartTime%] Process %GPUOverclockProcess%.exe was successfully killed.
			timeout /T 5 /nobreak >NUL
		)
	)
	tasklist /FI "IMAGENAME eq %GPUOverclockProcess%.exe" 2>NUL | find /I /N "%GPUOverclockProcess%.exe" >NUL
	IF ERRORLEVEL ==1 (
		START /MIN "" "%programfiles(x86)%%GPUOverclockPath%%GPUOverclockProcess%.exe" && ECHO %GPUOverclockProcess%.exe was started at %StartDate% %StartTime%
		IF %EnableTelegramNotifications% EQU 1 "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&text=*%RigName%:* %GPUOverclockProcess%.exe was started." 2>NUL 1>&2
		>> %~n0.log ECHO [%StartDate%][%StartTime%] %GPUOverclockProcess%.exe was started.
		timeout /T 5 /nobreak >NUL
	)
	IF %EnableGPUOverclockMonitor% EQU 2 (
		IF %AutorunMSIAWithProfile% GEQ 1 (
			IF %AutorunMSIAWithProfile% LEQ 5 (
				"%programfiles(x86)%%GPUOverclockPath%%GPUOverclockProcess%.exe" -Profile%AutorunMSIAWithProfile% >NUL
			)
		)
	)
)
taskkill /F /IM "miner.exe" 2>NUL 1>&2 && (
	ECHO Process miner.exe was successfully killed.
	IF %EnableTelegramNotifications% EQU 1 "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&text=*%RigName%:* Process miner.exe was successfully killed." 2>NUL 1>&2
	>> %~n0.log ECHO [%StartDate%][%StartTime%] Process miner.exe was successfully killed.
	timeout /T 5 /nobreak >NUL
	taskkill /F /FI "IMAGENAME eq cmd.exe" /FI "WINDOWTITLE eq miner.bat*" 2>NUL 1>&2
	timeout /T 5 /nobreak >NUL
)
IF EXIST "miner.log" MOVE /Y miner.log Logs\miner_%Y0%.%M0%.%D0%_%H0%.%X0%.%C0%.log 2>NUL 1>&2
IF ERRORLEVEL ==1 (
	>> %~n0.log ECHO [%StartDate%][%StartTime%] Warning. Unable to rename or access miner.log. Attempting to delete miner.log and continue...
	DEL /Q /F miner.log >NUL || (
		ECHO Error. Unable to rename or access miner.log.
		IF %EnableTelegramNotifications% EQU 1 "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&text=*%RigName%:* Unable to delete miner.log." 2>NUL 1>&2
		>> %~n0.log ECHO [%StartDate%][%StartTime%] Error. Unable to delete miner.log.
		GOTO hardstart
	)
) ELSE (
	ECHO miner.log renamed and moved to Logs folder.
)
timeout /T 5 /nobreak >NUL
IF %StartFromBatOrExe% EQU 1 (
	IF NOT EXIST "miner.exe" (
		ECHO Mining is impossible, miner.exe is missing. Please ensure you've placed autorun.bat in the same directory as the EWBF miner.
		PAUSE
		EXIT
	)
	IF NOT EXIST "miner.cfg" (
		FOR /F "tokens=3,5,7,9 delims= " %%W IN ("%MainServerBatCommand%") DO (
			> miner.cfg ECHO # Common parameters
			>> miner.cfg ECHO # All the parameters here are similar to the command line arguments
			>> miner.cfg ECHO.
			>> miner.cfg ECHO [common]
			>> miner.cfg ECHO cuda_devices 0 1 2 3 4 5 6 7
			>> miner.cfg ECHO intensity    64 64 64 64 64 64 64 64
			>> miner.cfg ECHO templimit    80
			>> miner.cfg ECHO pec          1
			>> miner.cfg ECHO boff         0
			>> miner.cfg ECHO eexit        2
			>> miner.cfg ECHO tempunits    c
			>> miner.cfg ECHO log          2
			>> miner.cfg ECHO logfile      miner.log
			>> miner.cfg ECHO api          127.0.0.1:42000
			>> miner.cfg ECHO.
			>> miner.cfg ECHO # The miner start work from this server
			>> miner.cfg ECHO # When the server is fail, the miner will try to reconnect 3 times
			>> miner.cfg ECHO # After three unsuccessful attempts, the miner will switch to the next server
			>> miner.cfg ECHO # You can add up to 8 servers
			>> miner.cfg ECHO.
			>> miner.cfg ECHO # main server
			>> miner.cfg ECHO [server]
			>> miner.cfg ECHO server %%W
			>> miner.cfg ECHO port   %%X
			>> miner.cfg ECHO user   %%Y
			>> miner.cfg ECHO pass   %%Z
			>> miner.cfg ECHO.
			>> miner.cfg ECHO # additional server 1
			>> miner.cfg ECHO [server]
			>> miner.cfg ECHO server eu1-zcash.flypool.org
			>> miner.cfg ECHO port   3333
			>> miner.cfg ECHO user   t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv.imaginary
			>> miner.cfg ECHO pass   x
			ECHO miner.cfg created. Please check it for errors.
		)
	)
	START miner.exe && ECHO Miner was started at %StartDate% %StartTime%
	IF %EnableTelegramNotifications% EQU 1 "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&text=*%RigName%:* Miner was started." 2>NUL 1>&2
	>> %~n0.log ECHO [%StartDate%][%StartTime%] Miner was started. Autorun v. %Version%.
) ELSE (
	IF NOT EXIST "miner.bat" (
		> miner.bat ECHO @ECHO off
		>> miner.bat ECHO TITLE miner.bat
		>> miner.bat ECHO REM Configure miner's command line in config.bat file. Not in miner.bat.
		>> miner.bat ECHO %MainServerBatCommand%
		>> miner.bat ECHO EXIT
		ECHO miner.bat created. Please check it for errors.
		GOTO start
	) ELSE (
		IF %SwitchToDefault% EQU 0 (
			FOR /F "delims=" %%E IN ('findstr /R /C:"miner .*" miner.bat') DO (
				IF NOT "%%E" == "%MainServerBatCommand%" (
					> miner.bat ECHO @ECHO off
					>> miner.bat ECHO TITLE miner.bat
					>> miner.bat ECHO REM Configure miner's command line in config.bat file. Not in miner.bat.
					>> miner.bat ECHO %MainServerBatCommand%
					>> miner.bat ECHO EXIT
				)
			)
		)
	)
	START "miner.bat" miner.bat && ECHO Miner was started at %StartDate% %StartTime%
	IF %EnableTelegramNotifications% EQU 1 "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&text=*%RigName%:* Miner was started." 2>NUL 1>&2
	>> %~n0.log ECHO [%StartDate%][%StartTime%] Miner was started. Autorun v. %Version%.
)
timeout /T 5 /nobreak >NUL
IF NOT EXIST "miner.log" (
	ECHO Error. miner.log is missing.
	ECHO Check permissions in "%MinerPath%". This script requires permission to create files.
	IF %EnableTelegramNotifications% EQU 1 "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&text=*%RigName%:* Error. miner.log is missing.%%0ACheck permissions in "%MinerPath%". This script requires permission to create files." 2>NUL 1>&2
	>> %~n0.log ECHO [%StartDate%][%StartTime%] Error. miner.log is missing.
	>> %~n0.log ECHO [%StartDate%][%StartTime%] Check permissions in "%MinerPath%". This script requires permission to create files.
	IF %StartFromBatOrExe% EQU 2 (
		ECHO Ensure "--log 2" option is added to the miner's command line.
		>> %~n0.log ECHO [%StartDate%][%StartTime%] Ensure "--log 2" option is added to the miner's command line.
		> miner.bat ECHO @ECHO off
		>> miner.bat ECHO TITLE miner.bat
		>> miner.bat ECHO REM Configure miner's command line in config.bat file. Not in miner.bat.
		>> miner.bat ECHO %MainServerBatCommand%
		>> miner.bat ECHO EXIT
		ECHO miner.bat created. Please check it for errors.
		GOTO start
	) ELSE (
		ECHO Ensure "log 2" option is added in your miner.cfg file.
		>> %~n0.log ECHO [%StartDate%][%StartTime%] Ensure "log 2" option is added in your miner.cfg file.
		DEL /Q /F miner.cfg >NUL
		GOTO start
	)
) ELSE (
	ECHO Connected to miner.log. Log monitoring started...
)
SET FirstRun=0
SET HashrateErrorsCount=0
SET OldHashrate=0
SET InternetErrorsCounter=1
:check
IF %FirstRun% EQU 0 timeout /T 15 /nobreak >NUL
SET Hashcount=0
SET SumHash=0
SET SumResult=0
SET MinHashrate=0
COLOR 02
timeout /T 5 /nobreak >NUL
FOR /F %%F IN ('wmic.exe OS GET localdatetime ^| findstr ^[0-9]') DO SET t2=%%F
SET Y2=%t2:~0,4%
SET M2=%t2:~4,2%
SET D2=%t2:~6,2%
SET H2=%t2:~8,2%
SET X2=%t2:~10,2%
SET C2=%t2:~12,2%
SET NowTime=%H2%:%X2%
SET NowDate=%Y2%.%M2%.%D2%
IF %M2:~0,1% ==0 SET M2=%M2:~1%
IF %D2:~0,1% ==0 SET D2=%D2:~1%
IF %H2:~0,1% ==0 SET H2=%H2:~1%
IF %X2:~0,1% ==0 SET X2=%X2:~1%
IF %C2:~0,1% ==0 SET C2=%C2:~1%
SET /A s2=H2*60*60+X2*60+C2
IF %D2% GTR %D1% (
	SET /A s3=^(%D2%-%D1%^)*86400-%s1%+%s2%
) ELSE (
	IF %M2% NEQ %M1% (
		>> %~n0.log ECHO [%NowDate%][%NowTime%] Warning. Miner must be restarted, please wait...
		GOTO hardstart
	)
	IF %s2% GEQ %s1% (SET /A s3=%s2%-%s1%) ELSE (SET /A s3=%s1%-%s2%)
)
SET /A t3h=%s3%/60/60
SET /A t3m=%s3% %% 3600/60
SET /A t3s=%s3% %% 60
IF %t3h% LSS 10 SET t3h=0%t3h%
IF %t3m% LSS 10 SET t3m=0%t3m%
IF %t3s% LSS 10 SET t3s=0%t3s%
SET t3=%t3h%:%t3m%:%t3s%
IF %D2% NEQ %D1% (
	IF %MidnightAutoRestart% EQU 1 GOTO mtimer
	IF %MidnightAutoRestart% EQU 2 GOTO ctimer
)
IF %H2% NEQ %H1% (
	IF %EveryHourAutoRestart% EQU 1 GOTO mtimer
	IF %EveryHourAutoRestart% EQU 2 (
		IF %H2% GEQ %RestartHour% GOTO mtimer
		IF %H2% LSS %H1% GOTO mtimer
	)
	IF %EveryHourAutoRestart% EQU 3 GOTO ctimer
	IF %EveryHourAutoRestart% EQU 4 (
		IF %H2% GEQ %RestartHour% GOTO ctimer
		IF %H2% LSS %H1% GOTO ctimer
	)
	IF "%H2%" == "12" (
		IF %MiddayAutoRestart% EQU 1 GOTO mtimer
		IF %MiddayAutoRestart% EQU 2 GOTO ctimer
	)
)
IF %SwitchToDefault% EQU 1 (
	IF %H2% NEQ %H1% GOTO switch
	IF "%X2%" == "30" GOTO switch
)
IF %ErrorsCounter% GEQ %ErrorsAmount% (
	>> %~n0.log ECHO [%NowDate%][%NowTime%] Warning. Too many errors. A restart of the computer to clear GPU cache is required. Restarting... Miner ran for %t3%.
	COLOR 0C
	ECHO ==================================================================
	ECHO +----------------------------------------------------------------+
	ECHO + Now %NowDate% %NowTime%                                           +
	ECHO + Miner was started at %StartDate% %StartTime%                          +
	ECHO + Miner ran for %t3%                                         +
	ECHO + Warning. Too many errors, need clear GPU cash.                 +
	ECHO + Computer restarting...                                         +
	ECHO +----------------------------------------------------------------+
	ECHO ==================================================================
	GOTO restart
)
timeout /T 5 /nobreak >NUL
FOR /F "tokens=3 delims= " %%G IN ('findstr /R /C:"Total speed: [0-9]* Sol/s" miner.log') DO (
	SET LastHashrate=%%G
	SET /A Hashcount+=1
	SET /A SumHash=SumHash+%%G
	SET /A SumResult=SumHash/Hashcount
	IF %AverageTotalHashrate% GTR 0 (
		IF !LastHashrate! LSS %AverageTotalHashrate% SET /A MinHashrate+=1
		IF !MinHashrate! GEQ 100 GOTO passaveragecheck
		IF !SumResult! NEQ %OldHashrate% (
			IF !SumResult! LSS %AverageTotalHashrate% (
			:passaveragecheck
				COLOR 0C
				IF %EnableGPUOverclockMonitor% NEQ 0 (
					tasklist /FI "IMAGENAME eq %GPUOverclockProcess%.exe" 2>NUL | find /I /N "%GPUOverclockProcess%.exe" >NUL
					IF ERRORLEVEL ==1 (
						IF %EnableTelegramNotifications% EQU 1 "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&text=*%RigName%:* Process %GPUOverclockProcess%.exe crashed." 2>NUL 1>&2
						>> %~n0.log ECHO [%NowDate%][%NowTime%] Error. Process %GPUOverclockProcess%.exe crashed. Miner ran for %t3%.
						IF %EnableGPUOverclockMonitor% EQU 1 SET ErrorEcho=+ Error. Process %GPUOverclockProcess%.exe crashed...                           +
						IF %EnableGPUOverclockMonitor% EQU 2 SET ErrorEcho=+ Error. Process %GPUOverclockProcess%.exe crashed...                   +
						IF %EnableGPUOverclockMonitor% EQU 3 SET ErrorEcho=+ Error. Process %GPUOverclockProcess%.exe crashed...                       +
						GOTO error
					)
				)
				IF %HashrateErrorsCount% GEQ %HashrateErrorsAmount% (
					>> %~n0.log ECHO [%NowDate%][%NowTime%] Warning. Low hashrate. Miner ran for %t3%.
					SET ErrorEcho=+ Warning. Low hashrate...                                       +
					GOTO error
				)
				IF %EnableTelegramNotifications% EQU 1 "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&text=*%RigName%:* Abnormal hashrate. Average: *!SumResult!/%AverageTotalHashrate%* Last: *!LastHashrate!/%AverageTotalHashrate%*" >NUL
				>> %~n0.log ECHO [%NowDate%][%NowTime%] Warning. Abnormal hashrate. Average: !SumResult!/%AverageTotalHashrate% Last: !LastHashrate!/%AverageTotalHashrate%
				ECHO [%NowDate%][%NowTime%] Warning. Abnormal hashrate. Average: !SumResult!/%AverageTotalHashrate% Last: !LastHashrate!/%AverageTotalHashrate%
				SET /A HashrateErrorsCount+=1
				SET OldHashrate=!SumResult!
			)
		)
	)
)
timeout /T 5 /nobreak >NUL
FOR /F "delims=" %%T IN ('findstr /R /C:"Temp: GPU.*C.*" /C:"GPU.*: .* Sol/s .*" miner.log') DO (
	ECHO %%T | findstr /R /C:"Temp: GPU.*C.*" >NUL && SET CurrentTemp=%%T
	ECHO %%T | findstr /R /C:"GPU.*: .* Sol/s .*" >NUL && SET CurrentSpeed=%%T
)
timeout /T 5 /nobreak >NUL
FOR /F "delims=" %%N IN ('findstr /R %InternetErrorsList% %MinerErrorsList% %CriticalErrorsList% %OtherErrorsList% %MinerWarningsList% %OtherWarningsList% miner.log') DO (
	COLOR 0C
	IF %EnableTelegramNotifications% EQU 1 ECHO %%N | findstr /V /R %InternetErrorsList% %MinerWarningsList% >NUL && "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&text=*%RigName%:* %%N" 2>NUL 1>&2
	ECHO %%N | findstr /V /R %InternetErrorsList% >NUL && >> %~n0.log ECHO [%NowDate%][%NowTime%] %%N
	IF %EnableInternetConnectivityCheck% EQU 1 (
		timeout /T 10 /nobreak >NUL
		FOR /F "delims=" %%M IN ('findstr /R %InternetErrorsList% %InternetErrorsCancel% miner.log') DO SET LastInternetError=%%M
		ECHO !LastInternetError! | findstr /R %InternetErrorsList% >NUL && (
			ping google.com | find /i "TTL=" >NUL && (
				FOR /F "delims=" %%P IN ('findstr /R %InternetErrorsCancel% miner.log') DO (
					IF %EnableTelegramNotifications% EQU 1 "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&text=*%RigName%:* Something was wrong with your Internet. Connection has been restored. Miner restarting..." 2>NUL 1>&2
					>> %~n0.log ECHO [%NowDate%][%NowTime%] Something was wrong with your Internet. Connection has been restored. Miner restarting...
					ECHO ==================================================================
					ECHO +----------------------------------------------------------------+
					ECHO + Now %NowDate% %NowTime%                                           +
					ECHO + Miner was started at %StartDate% %StartTime%                          +
					ECHO + Something was wrong with your Internet.                        +
					ECHO + Connection has been restored.                                  +
					ECHO + Miner restarting...                                            +
					ECHO +----------------------------------------------------------------+
					ECHO ==================================================================
					GOTO start
				)
				ECHO %%N | findstr /R %InternetErrorsList% 2>NUL && (
					IF %EnableTelegramNotifications% EQU 1 "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&text=*%RigName%:* %%N" 2>NUL 1>&2
					ECHO ==================================================================
					ECHO +----------------------------------------------------------------+
					ECHO + Now %NowDate% %NowTime%                                           +
					ECHO + Miner was started at %StartDate% %StartTime%                          +
					ECHO + Carefully configure config.bat, miner.cfg or/and miner.bat     +
					ECHO + Check config file for errors or pool is offline                +
					ECHO + Miner restarting with default values...                        +
					ECHO +----------------------------------------------------------------+
					ECHO ==================================================================
					CHOICE /C yn /T 30 /D y /M "Create default miner.bat and continue mining"
					IF ERRORLEVEL ==2 EXIT
					taskkill /F /IM "miner.exe" 2>NUL 1>&2
					taskkill /F /FI "IMAGENAME eq cmd.exe" /FI "WINDOWTITLE eq miner.bat*" 2>NUL 1>&2
					SET StartFromBatOrExe=2
					timeout /T 5 /nobreak >NUL
					> miner.bat ECHO @ECHO off
					>> miner.bat ECHO TITLE miner.bat
					>> miner.bat ECHO REM Configure miner's command line in config.bat file. Not in miner.bat.
					IF %EnableAdditionalServer% EQU 1 (
						IF %ServerQueue% EQU 1 (
							>> miner.bat ECHO miner --server eu1-zcash.flypool.org --port 3333 --user t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv.developers --pass x --log 2 --fee 2 --templimit 90 --eexit 2 --pec
							SET ServerQueue=0
							SET SwitchToDefault=1
						)
						IF %ServerQueue% EQU 0 (
							>> miner.bat ECHO %AdditionalServerBatCommand%
							SET ServerQueue=1
							SET SwitchToDefault=1
						)
					) ELSE (
						>> miner.bat ECHO miner --server eu1-zcash.flypool.org --port 3333 --user t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv.developers --pass x --log 2 --fee 2 --templimit 90 --eexit 2 --pec
						SET SwitchToDefault=1
					)
					>> miner.bat ECHO EXIT
					IF %EnableTelegramNotifications% EQU 1 "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&text=*%RigName%:* Pool server was switched. Please check your config.bat, miner.cfg or miner.bat file carefully for spelling errors or incorrect parameters. Otherwise check if the pool you're connecting to is online." 2>NUL 1>&2
					>> %~n0.log ECHO [%NowDate%][%NowTime%] Warning. Pool server was switched. Please check your config.bat, miner.cfg or miner.bat file carefully for spelling errors or incorrect parameters. Otherwise check if the pool you're connecting to is online.
					ECHO Warning. Pool server was switched. Please check your config.bat, miner.cfg or miner.bat file carefully for spelling errors or incorrect parameters. Otherwise check if the pool you're connecting to is online.
					ECHO Default miner.bat created. Please check it for errors.
					SET /A ErrorsCounter+=1
					GOTO start
				)
			) || (
				ECHO %%N | findstr /R %InternetErrorsList% 2>NUL && (
					IF %EnableTelegramNotifications% EQU 1 "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&text=*%RigName%:* %%N" 2>NUL 1>&2
					>> %~n0.log ECHO [%NowDate%][%NowTime%] %%N
					>> %~n0.log ECHO [%NowDate%][%NowTime%] Error. Something is wrong with your Internet. Please check your connection. Miner ran for %t3%.
					ECHO ==================================================================
					ECHO +----------------------------------------------------------------+
					ECHO + Now %NowDate% %NowTime%                                           +
					ECHO + Miner was started at %StartDate% %StartTime%                          +
					ECHO + Miner ran for %t3%                                         +
					ECHO + Something is wrong with your Internet...                       +
					ECHO + Attempting to reconnect...                                     +
					ECHO +----------------------------------------------------------------+
					ECHO ==================================================================
					:tryingreconnect
					IF %t3h% EQU 0 IF %t3m% GEQ 10 IF %InternetErrorsCounter% GTR 10 GOTO restart
					IF %InternetErrorsCounter% GTR 60 GOTO restart
					SET /A InternetErrorsCounter+=1
					ECHO Attempt %InternetErrorsCounter% to restore Internet connection.
					FOR /F "delims=" %%L IN ('findstr /R %InternetErrorsCancel% miner.log') DO GOTO reconnected
					ping google.com | find /i "TTL=" >NUL || (
						CHOICE /C yn /T 60 /D n /M "Restart miner manually"
						IF ERRORLEVEL ==2 GOTO tryingreconnect
						SET /A ErrorsCounter+=1
						GOTO start
					)
					:reconnected
					ECHO Something was wrong with your Internet. Connection has been restored. Miner restarting...
					IF %EnableTelegramNotifications% EQU 1 "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&text=*%RigName%:* Something was wrong with your Internet. Connection has been restored. Miner restarting..." 2>NUL 1>&2
					>> %~n0.log ECHO [%NowDate%][%NowTime%] Something was wrong with your Internet. Connection has been restored. Miner restarting...
					GOTO start
				)
			)
		)
	)
	ECHO %%N | findstr /R %MinerErrorsList% 2>NUL && (
		>> %~n0.log ECHO [%NowDate%][%NowTime%] Error from GPU. Voltage or Overclock issue. Miner ran for %t3%.
		SET ErrorEcho=+ Error from GPU. Voltage or Overclock issue...                  +
		GOTO error
	)
	ECHO %%N | findstr /R %CriticalErrorsList% 2>NUL && (
		>> %~n0.log ECHO [%NowDate%][%NowTime%] Critical error from GPU. Voltage or Overclock issue. Miner ran for %t3%.
		GOTO restart
	)
	ECHO %%N | findstr /V /R %InternetErrorsList% %MinerErrorsList% %CriticalErrorsList% %MinerWarningsList% %OtherWarningsList% 2>NUL && (
		>> %~n0.log ECHO [%NowDate%][%NowTime%] Unknown error found. Please send this error to developer. Miner ran for %t3%.
		SET ErrorEcho=+ Unknown error found...                                         +
		GOTO error
	)
	ECHO %%N | findstr /R %MinerWarningsList% 2>NUL && (
		IF %t3h% EQU 0 (
			IF %t3m% LSS 10 (
				IF %EnableTelegramNotifications% EQU 1 "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&text=*%RigName%:* Temperature limit reached. GPU will now *STOP MINING*. Please ensure your GPUs have enough air flow. *Waiting for users input...*" 2>NUL 1>&2
				>> %~n0.log ECHO [%NowDate%][%NowTime%] Temperature limit reached. GPU will now STOP MINING. Please ensure your GPUs have enough air flow. Miner ran for %t3%.
				tskill /A /V %GPUOverclockProcess% >NUL && ECHO Process %GPUOverclockProcess%.exe was successfully killed.
				taskkill /F /IM "miner.exe" 2>NUL 1>&2 && ECHO Process miner.exe was successfully killed.
				timeout /T 5 /nobreak >NUL
				taskkill /F /FI "IMAGENAME eq cmd.exe" /FI "WINDOWTITLE eq miner.bat*" 2>NUL 1>&2
				ECHO Temperature limit reached. GPU will now STOP MINING. Please ensure your GPUs have enough air flow. Miner ran for %t3%.
				ECHO Waiting for users input...
				PAUSE
				GOTO hardstart
			)
		)
		IF %EnableTelegramNotifications% EQU 1 "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&text=*%RigName%:* Temperature limit reached. Fans may be stuck. Attempting to restart computer." 2>NUL 1>&2
		>> %~n0.log ECHO [%NowDate%][%NowTime%] Temperature limit reached. Fans may be stuck. Miner ran for %t3%. Computer restarting...
		ECHO Temperature limit reached. Fans may be stuck. Miner ran for %t3%.
		ECHO Computer restarting...
		GOTO restart
	)
	ECHO %%N | findstr /V /R %InternetErrorsList% %MinerErrorsList% %CriticalErrorsList% %OtherErrorsList% %MinerWarningsList% 2>NUL && (
		>> %~n0.log ECHO [%NowDate%][%NowTime%] Unknown warning found. Please send this warning to developer. Miner ran for %t3%.
		SET ErrorEcho=+ Unknown warning found...                                       +
		GOTO error
	)
)
timeout /T 5 /nobreak >NUL
tasklist /FI "IMAGENAME eq miner.exe" 2>NUL | find /I /N "miner.exe" >NUL
IF ERRORLEVEL ==1 (
	IF %EnableTelegramNotifications% EQU 1 "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&text=*%RigName%:* Process miner.exe crashed." 2>NUL 1>&2
	>> %~n0.log ECHO [%NowDate%][%NowTime%] Error. Process miner.exe crashed. Miner ran for %t3%.
	SET ErrorEcho=+ Error. Process miner.exe crashed...                            +
	GOTO error
)
IF %EnableAPAutorun% EQU 1 (
	timeout /T 5 /nobreak >NUL
	tasklist /FI "IMAGENAME eq %APProcessName%" 2>NUL | find /I /N "%APProcessName%" >NUL
	IF ERRORLEVEL ==1 (
		IF %EnableTelegramNotifications% EQU 1 "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&text=*%RigName%:* %APProcessName% crashed." 2>NUL 1>&2
		>> %~n0.log ECHO [%NowDate%][%NowTime%] Error. %APProcessName% crashed. Miner ran for %t3%.
		SET ErrorEcho=+ Error. Additional program crashed...                           +
		GOTO error
	)
)
SET GPUCount=0
IF %FirstRun% EQU 0 (
	IF %NumberOfGPUs% GEQ 1 (
		timeout /T 10 /nobreak >NUL
		FOR /F "delims=" %%I IN ('findstr /R /C:"CUDA: Device: [0-9]* .* PCI: .*" miner.log') DO SET /A GPUCount+=1
		IF %NumberOfGPUs% NEQ !GPUCount! (
			IF %EnableTelegramNotifications% EQU 1 "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&text=*%RigName%:* Failed load all GPUs. Number of GPUs !GPUCount!/%NumberOfGPUs%." 2>NUL 1>&2
			>> %~n0.log ECHO [%NowDate%][%NowTime%] Error. Failed load all GPUs. Number of GPUs [!GPUCount!/%NumberOfGPUs%]. Miner ran for %t3%.
			COLOR 0C
			ECHO ==================================================================
			ECHO +----------------------------------------------------------------+
			ECHO + Now %NowDate% %NowTime%                                           +
			ECHO + Miner was started at %StartDate% %StartTime%                          +
			ECHO + Miner ran for %t3%                                         +
			ECHO + Failed load all GPUs. Number of GPUs: [!GPUCount!/%NumberOfGPUs%]                    +
			ECHO + Computer restarting...                                         +
			ECHO +----------------------------------------------------------------+
			ECHO ==================================================================
			GOTO restart
		)
	) ELSE (
		ECHO GPU check is disabled.
	)
	ECHO ==================================================================
	ECHO +----------------------------------------------------------------+
	ECHO + Process miner.exe is running - do not worry                    +
	IF %EnableGPUOverclockMonitor% NEQ 0 (
		IF %EnableGPUOverclockMonitor% EQU 1 (
			ECHO + Process %GPUOverclockProcess%.exe is running...                               +
		)
		IF %EnableGPUOverclockMonitor% EQU 2 (
			ECHO + Process %GPUOverclockProcess%.exe is running...                       +
		)
		IF %EnableGPUOverclockMonitor% EQU 3 (
			ECHO + Process %GPUOverclockProcess%.exe is running...                           +
		)
		IF %EnableGPUOverclockMonitor% EQU 4 (
			ECHO + Process %GPUOverclockProcess%.exe is running...                       +
		)
		IF %EnableGPUOverclockMonitor% GEQ 5 (
			ECHO + GPU Overclock monitor: Wrong config.                           +
		)
	) ELSE (
		ECHO + GPU Overclock monitor: Disabled                                +
	)
	IF %MidnightAutoRestart% EQU 0 (
		ECHO + Autorestart at 00:00: Disabled                                 +
	) ELSE (
		ECHO + Autorestart at 00:00: Enabled                                  +
	)
	IF %MiddayAutoRestart% EQU 0 (
		ECHO + Autorestart at 12:00: Disabled                                 +
	) ELSE (
		ECHO + Autorestart at 12:00: Enabled                                  +
	)
	IF %EveryHourAutoRestart% EQU 0 (
		ECHO + Autorestart every hour: Disabled                               +
	) ELSE (
		ECHO + Autorestart every hour: Enabled                                +
	)
	IF %EnableTelegramNotifications% EQU 1 (
		ECHO + Telegram notifications: Enabled                                +
	) ELSE (
		ECHO + Telegram notifications: Disabled                               +
	)
	IF %EnableAPAutorun% EQU 1 (
		ECHO + Additional program autorun: Enabled                            +
	) ELSE (
		ECHO + Additional program autorun: Disabled                           +
	)
	ECHO + Number of errors: [%ErrorsCounter%/%ErrorsAmount%], GPUs: [!GPUCount!/%NumberOfGPUs%]                           +
	ECHO +----------------------------------------------------------------+
	ECHO ==================================================================
	SET FirstRun=1
	IF EXIST "Logs\miner_*.log" (
		CHOICE /C yn /T 60 /D n /M "Clean Logs folder now"
		IF ERRORLEVEL ==2 (
			ECHO Now I will take care of your %RigName% and you can take a rest.
		) ELSE (
			DEL /F /Q "Logs\*" && ECHO Clean Logs folder finished.
			ECHO Now I will take care of your %RigName% and you can take a rest.
		)
		GOTO check
	)
)
IF %EnableTelegramNotifications% EQU 1 (
	IF %X2% EQU 0 (
		IF %EnableEveryHourInfoSend% EQU 1 "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&text=*%RigName%:* Miner has been running for *%t3h%:%t3m%:%t3s%* - do not worry.%%0AAverage total hashrate: *!SumResult!*.%%0ALast total hashrate: *!LastHashrate!*.%%0ACurrent Speed: !CurrentSpeed!.%%0ACurrent !CurrentTemp!." 2>NUL 1>&2
		IF %EnableEveryHourInfoSend% EQU 2 "%CurlPath%" "%TelegramCommand%chat_id=%ChatId%&parse_mode=markdown&disable_notification=true&text=*%RigName%:* Miner has been running for *%t3h%:%t3m%:%t3s%* - do not worry.%%0AAverage total hashrate: *!SumResult!*.%%0ALast total hashrate: *!LastHashrate!*.%%0ACurrent Speed: !CurrentSpeed!.%%0ACurrent !CurrentTemp!." 2>NUL 1>&2
		timeout /T 60 /nobreak >NUL
	)
)
GOTO check