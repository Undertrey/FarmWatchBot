@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
shutdown.exe /A 2>NUL 1>&2
:hardstart
CLS
COLOR 1F
MODE CON cols=67 lines=40
SET Version=1.7.2
ECHO +================================================================+
ECHO            AutoRun v.%Version% for EWBF Miner - by Acrefawn
ECHO              ZEC: t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv
ECHO               BTC: 1wdJBYkVromPoiYk82JfSGSSVVyFJnenB
ECHO +================================================================+
REM Attention. Change the options below only if it's really needed.
REM Amount of errors before computer restart (5 - default)
SET ErrorsAmount=5
REM Amount of hashrate errors before miner restart (5 - default)
SET HashrateErrorsAmount=5
REM Name miner process. (in English, without special symbols and spaces)
SET MinerProcess=miner.exe
REM Name start mining .bat file. (in English, without special symbols and spaces)
SET MinerBat=miner.bat
REM Check to see if %~n0.bat has already been started. (0 - false, 1 - true)
SET EnableDoubleWindowCheck=1
REM Attention. Do not touch the options below in any case.
FOR /F "tokens=1 delims=." %%A IN ('wmic.exe OS GET localdatetime^|Find "."') DO SET DT0=%%A
TITLE Miner-autorun(%DT0%)
IF %EnableDoubleWindowCheck% EQU 1 (
	tasklist.exe /V /NH /FI "imagename eq cmd.exe"| findstr.exe /V /R /C:".*Miner-autorun(%DT0%)"| findstr.exe /R /C:".*Miner-autorun.*" 2>NUL 1>&2 && (
		ECHO This script is already running...& ECHO Current window will close in 10 seconds.
		CHOICE /C yn /T 10 /D n /M "Continue this process"
		IF ERRORLEVEL ==2 EXIT
	)
)
SET PTOS1=0
SET Mtimer=0
SET Ctimer=0
SET rtpt=d2a
SET FirstRun=0
SET AllowSend=0
SET tprt=WYHfeJU
SET ServerQueue=1
SET prt=AAFWKz6wv7
SET ErrorsCounter=0
SET rtp=%rtpt%eV6idp
SET SwitchToDefault=0
SET tpr=C8go_jp8%tprt%
SET OtherErrorsList=/C:"ERROR:.*"
SET /A Num=(3780712+3780711)*6*9
SET OtherWarningsList=/C:"WARNING:.*"
SET InternetErrorsCancel=/C:".*Connection restored.*" /C:".*Connected.*" /C:".*Authorized.*"
SET MinerWarningsList=/C:".*Temperature limit are reached.*" /C:".*reached STOP temperature.*"
SET CriticalErrorsList=/C:".*Cannot initialize NVML. Temperature monitor will not work.*" /C:".*no CUDA-capable device is detected.*"
SET MinerErrorsList=/C:".*Thread exited.*" /C:".* 0.000 H/s.*" /C:"Total Speed: 0.000 H/s" /C:".* 0 Sol/s.*" /C:"Total speed: 0 Sol/s" /C:".*benchmark error.*" /C:".*Api bind error.*" /C:".*CUDA error.*" /C:".*Looks like.*"
SET InternetErrorsList=/C:".*Lost connection.*" /C:".*Connection lost.*" /C:".*Cannot resolve.*" /C:".*subscribe timeout.*" /C:".*Cannot connect.*" /C:".*No properly.*" /C:".*Failed to connect.*"
SET EnableGPUOverclockMonitor=0
SET AutorunMSIAWithProfile=0
SET RestartGPUOverclockMonitor=0
SET NumberOfGPUs=0
SET AllowRestartGPU=1
SET AverageTotalHashrate=0
SET MainServerBatCommand=miner --server eu1-zcash.flypool.org --port 3333 --user t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv.fr172 --pass x --log 2 --fee 0 --templimit 90 --pec
SET EnableAdditionalServer=0
SET AdditionalServer1BatCommand=miner --server eu1-zcash.flypool.org --port 3333 --user t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv.fr172 --pass x --log 2 --fee 0 --templimit 90 --pec
SET AdditionalServer2BatCommand=miner --server eu1-zcash.flypool.org --port 3333 --user t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv.fr172 --pass x --log 2 --fee 0 --templimit 90 --pec
SET AdditionalServer3BatCommand=miner --server eu1-zcash.flypool.org --port 3333 --user t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv.fr172 --pass x --log 2 --fee 0 --templimit 90 --pec
SET AdditionalServer4BatCommand=miner --server eu1-zcash.flypool.org --port 3333 --user t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv.fr172 --pass x --log 2 --fee 0 --templimit 90 --pec
SET EveryHourAutoRestart=0
SET MiddayAutoRestart=0
SET MidnightAutoRestart=0
SET SkipBeginMiningConfirmation=0
SET EnableInternetConnectivityCheck=1
SET EnableGPUEnvironments=0
SET EnableTelegramNotifications=0
SET RigName=Zcash Farm
SET ChatId=000000000
SET EnableEveryHourInfoSend=0
SET EnableAPAutorun=0
SET APProcessName=TeamViewer.exe
SET APProcessPath=C:\Program Files (x86)\TeamViewer\TeamViewer.exe
:checkconfig
IF EXIST "config.bat" (
	findstr.exe /C:"%Version%" config.bat >NUL && (
		FOR %%A IN (%~n0.bat) DO IF %%~ZA LSS 45900 EXIT
		FOR %%B IN (config.bat) DO (
			IF %%~ZB LSS 4800 (
				ECHO Config.bat file error. It is corrupted, check it please.
			) ELSE (
				CALL config.bat && ECHO Config.bat loaded.
				GOTO prestart
			)
		)
	) || (
		CALL config.bat && ECHO Your config.bat is out of date.
	)
	CHOICE /C yn /T 15 /D y /M "Backup existing and create an updated config.bat"
	IF ERRORLEVEL ==2 EXIT
	MOVE /Y config.bat config_backup.bat >NUL && ECHO Created backup of your old config.bat.
)
> config.bat ECHO @ECHO off
>> config.bat ECHO REM Configuration file v. %Version%
>> config.bat ECHO REM =================================================== [Overclock program]
>> config.bat ECHO REM Enable GPU Overclock control monitor. (0 - false, 1 - true XTREMEGE, 2 - true AFTERBURNER, 3 - true GPUTWEAK, 4 - true PRECISION, 5 - true AORUSGE)
>> config.bat ECHO REM Autorun and run-check of GPU Overclock programs.
>> config.bat ECHO SET EnableGPUOverclockMonitor=%EnableGPUOverclockMonitor%
>> config.bat ECHO REM Additional option to auto-enable Overclock Profile for MSI Afterburner. (0 - false, 1 - Profile 1, 2 - Profile 2, 3 - Profile 3, 4 - Profile 4, 5 - Profile 5)
>> config.bat ECHO SET AutorunMSIAWithProfile=%AutorunMSIAWithProfile%
>> config.bat ECHO REM Allow Overclock programs to be restarted when miner is restarted. (0 - false, 1 - true)
>> config.bat ECHO REM Please, do not use this option if it is not needed.
>> config.bat ECHO SET RestartGPUOverclockMonitor=%RestartGPUOverclockMonitor%
>> config.bat ECHO REM =================================================== [GPU]
>> config.bat ECHO REM Set how many GPU devices are enabled.
>> config.bat ECHO SET NumberOfGPUs=%NumberOfGPUs%
>> config.bat ECHO REM Allow computer restart if number of loaded GPUs is not equal to number of enabled GPUs. (0 - false, 1 - true)
>> config.bat ECHO SET AllowRestartGPU=%AllowRestartGPU%
>> config.bat ECHO REM Set total average hashrate of this Rig. (you can use average hashrate value from your pool)
>> config.bat ECHO SET AverageTotalHashrate=%AverageTotalHashrate%
>> config.bat ECHO REM =================================================== [Miner]
>> config.bat ECHO REM Set miner command here to auto-create %MinerBat% file if it is missing or wrong. (keep default order)
>> config.bat ECHO SET MainServerBatCommand=%MainServerBatCommand%
>> config.bat ECHO REM Enable additional server. When the main server fails, %~n0 will switch to the additional server immediately. (0 - false, 1 - true) EnableInternetConnectivityCheck=1 required.
>> config.bat ECHO SET EnableAdditionalServer=0
>> config.bat ECHO REM Configure miner command here. Old %MinerBat% will be removed and a new one will be created with this value. (keep default order) EnableInternetConnectivityCheck=1 required.
>> config.bat ECHO SET AdditionalServer1BatCommand=%AdditionalServer1BatCommand%
>> config.bat ECHO SET AdditionalServer2BatCommand=%AdditionalServer2BatCommand%
>> config.bat ECHO SET AdditionalServer3BatCommand=%AdditionalServer3BatCommand%
>> config.bat ECHO SET AdditionalServer4BatCommand=%AdditionalServer4BatCommand%
>> config.bat ECHO REM =================================================== [Timers]
>> config.bat ECHO REM Restart miner or computer every hour. (1 - true miner every One hour, 2 - true miner every Two hours, 3 - true computer every One hour, 4 - true computer every Two hours, 0 - false)
>> config.bat ECHO SET EveryHourAutoRestart=%EveryHourAutoRestart%
>> config.bat ECHO REM Restart miner or computer every day at 12:00. (1 - true miner, 2 - true computer, 0 - false)
>> config.bat ECHO SET MiddayAutoRestart=%EveryHourAutoRestart%
>> config.bat ECHO REM Restart miner or computer every day at 00:00. (1 - true miner, 2 - true computer, 0 - false)
>> config.bat ECHO SET MidnightAutoRestart=%EveryHourAutoRestart%
>> config.bat ECHO REM =================================================== [Other]
>> config.bat ECHO REM Skip miner startup confirmation. (0 - false, 1 - true)
>> config.bat ECHO SET SkipBeginMiningConfirmation=%SkipBeginMiningConfirmation%
>> config.bat ECHO REM Enable Internet connectivity check. (0 - false, 1 - true)
>> config.bat ECHO REM Disable Internet connectivity check only if you have difficulties with your connection. (ie. high latency, intermittent connectivity)
>> config.bat ECHO SET EnableInternetConnectivityCheck=%EnableInternetConnectivityCheck%
>> config.bat ECHO REM Enable additional environments. Please do not use this option if it is not needed, or if you do not understand it's function. (0 - false, 1 - true)
>> config.bat ECHO REM GPU_FORCE_64BIT_PTR 0, GPU_MAX_HEAP_SIZE 100, GPU_USE_SYNC_OBJECTS 1, GPU_MAX_ALLOC_PERCENT 100, GPU_SINGLE_ALLOC_PERCENT 100
>> config.bat ECHO SET EnableGPUEnvironments=%EnableGPUEnvironments%
>> config.bat ECHO REM =================================================== [Telegram notifications]
>> config.bat ECHO REM Enable Telegram notifications. Don't forget to add @FarmWatchBot in Telegram. (0 - false, 1 - true)
>> config.bat ECHO SET EnableTelegramNotifications=%EnableTelegramNotifications%
>> config.bat ECHO REM Name your Rig. (in English, without special symbols)
>> config.bat ECHO SET RigName=%RigName%
>> config.bat ECHO REM Enter here your ChatId, from Telegram @FarmWatchBot.
>> config.bat ECHO SET ChatId=%ChatId%
>> config.bat ECHO REM Enable hourly statistics through Telegram. (0 - false, 1 - true, 2 - true in silent mode, 3 - true short, 4 - true short in silent mode)
>> config.bat ECHO SET EnableEveryHourInfoSend=%EnableEveryHourInfoSend%
>> config.bat ECHO REM =================================================== [Additional program]
>> config.bat ECHO REM Enable additional program check on startup. (ie. TeamViewer, Minergate, Storj etc) (0 - false, 1 - true)
>> config.bat ECHO SET EnableAPAutorun=%EnableAPAutorun%
>> config.bat ECHO REM Process name of additional program. (Press CTRL+ALT+DEL to find the process name)
>> config.bat ECHO SET APProcessName=%APProcessName%
>> config.bat ECHO REM Path to file of additional program. (ie. C:\Program Files (x86)\TeamViewer\TeamViewer.exe)
>> config.bat ECHO SET APProcessPath=%APProcessPath%
ECHO Default config.bat created.& ECHO Please check it and restart %~n0.bat.
GOTO checkconfig
:prestart
IF %EnableGPUEnvironments% EQU 1 (
	SETX GPU_FORCE_64BIT_PTR 0 2>NUL 1>&2 && ECHO GPU_FORCE_64BIT_PTR 0
	SETX GPU_MAX_HEAP_SIZE 100 2>NUL 1>&2 && ECHO GPU_MAX_HEAP_SIZE 100
	SETX GPU_USE_SYNC_OBJECTS 1 2>NUL 1>&2 && ECHO GPU_USE_SYNC_OBJECTS 1
	SETX GPU_MAX_ALLOC_PERCENT 100 2>NUL 1>&2 && ECHO GPU_MAX_ALLOC_PERCENT 100
	SETX GPU_SINGLE_ALLOC_PERCENT 100 2>NUL 1>&2 && ECHO GPU_SINGLE_ALLOC_100
) ELSE (
	REG DELETE HKCU\Environment /F /V GPU_FORCE_64BIT_PTR 2>NUL 1>&2 && ECHO GPU_FORCE_64BIT_PTR successfully removed from environments.
	REG DELETE HKCU\Environment /F /V GPU_MAX_HEAP_SIZE 2>NUL 1>&2 && ECHO GPU_MAX_HEAP_SIZE successfully removed from environments.
	REG DELETE HKCU\Environment /F /V GPU_USE_SYNC_OBJECTS 2>NUL 1>&2 && ECHO GPU_USE_SYNC_OBJECTS successfully removed from environments.
	REG DELETE HKCU\Environment /F /V GPU_MAX_ALLOC_PERCENT 2>NUL 1>&2 && ECHO GPU_MAX_ALLOC_PERCENT successfully removed from environments.
	REG DELETE HKCU\Environment /F /V GPU_SINGLE_ALLOC_PERCENT 2>NUL 1>&2 && ECHO GPU_SINGLE_ALLOC_PERCENT successfully removed from environments.
)
IF %SkipBeginMiningConfirmation% EQU 0 (
	CHOICE /C yn /T 30 /D y /M "Begin mining"
	IF ERRORLEVEL ==2 EXIT
	GOTO start
) ELSE (
	timeout.exe /T 1 /nobreak >NUL
	GOTO start
)
:restart
COLOR 4F
CHOICE /C yn /T 30 /D y /M "Restart your computer now"
IF ERRORLEVEL ==2 GOTO hardstart
tskill.exe /A /V %GPUOverclockProcess% 2>NUL 1>&2
taskkill.exe /F /IM "%MinerProcess%" 2>NUL 1>&2
IF %EnableAPAutorun% EQU 1 taskkill.exe /F /IM "%APProcessName%" 2>NUL 1>&2
IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Computer restarting...')" 2>NUL 1>&2
>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Computer restarting...
shutdown.exe /T 30 /R /F /C "Your computer will restart after 30 seconds. To cancel restart, close this window and start %~n0.bat manually."
EXIT
:switch
CLS
COLOR 4F
MODE CON cols=67 lines=40
IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Attempting to switch to the main pool server...')" 2>NUL 1>&2
>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Attempting to switch to the main pool server...
ECHO +================================================================+
ECHO           Attempting to switch to the main pool server...
ECHO                      Miner ran for %DyDiff% d. %HrDiff%:%MeDiff%
ECHO                         Miner restarting...
ECHO +================================================================+
GOTO hardstart
:shedule
CLS
COLOR 4F
MODE CON cols=67 lines=40
IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Scheduled restart, please wait...')" 2>NUL 1>&2
>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Scheduled restart, please wait... Miner ran for %DyDiff% d. %HrDiff%:%MeDiff%.
ECHO +================================================================+
ECHO                  Scheduled restart, please wait...
ECHO                      Miner ran for %DyDiff% d. %HrDiff%:%MeDiff%
ECHO                            Restarting...
ECHO +================================================================+
IF %Ctimer% EQU 1 GOTO restart
IF %Mtimer% EQU 1 GOTO hardstart
:error
CLS
COLOR 4F
MODE CON cols=67 lines=40
IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Miner restarting...')" 2>NUL 1>&2
>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Miner restarting...
ECHO +================================================================+
ECHO                        Something is wrong...
ECHO                      Miner ran for %DyDiff% d. %HrDiff%:%MeDiff%
ECHO                         Miner restarting...
ECHO +================================================================+
SET /A ErrorsCounter+=1
GOTO start
:start
FOR /F "tokens=1 delims=." %%A IN ('wmic.exe OS GET localdatetime^|Find "."') DO SET DT1=%%A
SET Mh1=1%DT1:~4,2%
SET Dy1=1%DT1:~6,2%
SET Hr1=1%DT1:~8,2%
SET Me1=1%DT1:~10,2%
SET /A Mh1=%Mh1%-100
SET /A Dy1=%Dy1%-100
SET /A Hr1=%Hr1%-100
SET /A Me1=%Me1%-100
IF NOT EXIST "%MinerProcess%" (
	ECHO "%MinerProcess%" is missing. Please check the directory for missing files. Exiting...
	PAUSE
	EXIT
)
IF NOT EXIST "Logs" MD Logs && ECHO Folder Logs created.
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
IF %EnableGPUOverclockMonitor% EQU 5 (
	SET GPUOverclockProcess=AORUS
	SET GPUOverclockPath=\GIGABYTE\AORUS GRAPHICS ENGINE\
)
IF %EnableGPUOverclockMonitor% GTR 0 IF %EnableGPUOverclockMonitor% LEQ 5 (
	IF NOT EXIST "%programfiles(x86)%%GPUOverclockPath%" (
		ECHO Incorrect path to %GPUOverclockProcess%.exe. Default install path required to function. Please reinstall the software using the default path.
	) ELSE (
		IF %FirstRun% EQU 1 IF %RestartGPUOverclockMonitor% EQU 1 (
			tskill.exe /A /V %GPUOverclockProcess% 2>NUL 1>&2
			>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Process %GPUOverclockProcess%.exe was successfully killed.
		)
		tasklist.exe /FI "IMAGENAME eq %GPUOverclockProcess%.exe" 2>NUL| find.exe /I /N "%GPUOverclockProcess%.exe" >NUL || (
			timeout.exe /T 5 /nobreak >NUL
			START "" "%programfiles(x86)%%GPUOverclockPath%%GPUOverclockProcess%.exe" && (
				ECHO %GPUOverclockProcess%.exe was started.
				IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* %GPUOverclockProcess%.exe was started.')" 2>NUL 1>&2
				>> %~n0.log ECHO [%Date%][%Time:~-11,8%] %GPUOverclockProcess%.exe was started.
			) || (
				ECHO Unable to start %GPUOverclockProcess%.exe.
				IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Unable to start %GPUOverclockProcess%.exe.')" 2>NUL 1>&2
				>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Unable to start %GPUOverclockProcess%.exe.
				GOTO hardstart
			)
		)
	)
)
IF %EnableAPAutorun% EQU 1 (
	IF NOT EXIST "%APProcessPath%" (
		ECHO Incorrect path to %APProcessName%.
	) ELSE (
		tasklist.exe /FI "IMAGENAME eq %APProcessName%" 2>NUL| find.exe /I /N "%APProcessName%" >NUL || (
			timeout.exe /T 5 /nobreak >NUL
			START /MIN "%APProcessName%" "%APProcessPath%" && (
				ECHO %APProcessName% was started.
				IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* %APProcessName% was started.')" 2>NUL 1>&2
				>> %~n0.log ECHO [%Date%][%Time:~-11,8%] %APProcessName% was started.
			) || (
				ECHO Unable to start %APProcessName%.
				IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Unable to start %APProcessName%.')" 2>NUL 1>&2
				>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Unable to start %APProcessName%.
				GOTO hardstart
			)
		)
	)
)
taskkill.exe /F /IM "%MinerProcess%" 2>NUL 1>&2 && (
	>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Process %MinerProcess% was successfully killed.
	ECHO Please wait...
	timeout.exe /T 30 /nobreak >NUL
)
IF EXIST "miner.log" (
	MOVE /Y miner.log Logs\miner_%Mh1%.%Dy1%_%Hr1%.%Me1%.log 2>NUL 1>&2 || (
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Unable to rename or access miner.log. Attempting to delete miner.log and continue...
		DEL /Q /F "miner.log" >NUL || (
			ECHO Unable to rename or access miner.log.
			IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Unable to delete miner.log.')" 2>NUL 1>&2
			>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Unable to delete miner.log.
			GOTO hardstart
		)
	) && (
		ECHO miner.log renamed and moved to Logs folder.
		timeout.exe /T 5 /nobreak >NUL
	)
)
IF NOT EXIST "%MinerBat%" (
	> %MinerBat% ECHO @ECHO off
	>> %MinerBat% ECHO TITLE %MinerBat%
	>> %MinerBat% ECHO REM Configure miner's command line in config.bat file. Not in %MinerBat%.
	>> %MinerBat% ECHO %MainServerBatCommand%
	>> %MinerBat% ECHO EXIT
	ECHO %MinerBat% created. Please check it for errors.
	GOTO start
) ELSE (
	IF %SwitchToDefault% EQU 0 (
		findstr.exe /L /C:"%MainServerBatCommand%" %MinerBat% 2>NUL 1>&2 || (
			> %MinerBat% ECHO @ECHO off
			>> %MinerBat% ECHO TITLE %MinerBat%
			>> %MinerBat% ECHO REM Configure miner's command line in config.bat file. Not in %MinerBat%.
			>> %MinerBat% ECHO %MainServerBatCommand%
			>> %MinerBat% ECHO EXIT
		)
	)
	timeout.exe /T 1 /nobreak >NUL
	START "%MinerBat%" "%MinerBat%" && (
		ECHO Miner was started.
		IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Miner was started.')" 2>NUL 1>&2
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Miner was started. Autorun v. %Version%.
		timeout.exe /T 10 /nobreak >NUL
		IF %EnableGPUOverclockMonitor% EQU 2 IF %AutorunMSIAWithProfile% GEQ 1 IF %AutorunMSIAWithProfile% LEQ 5 "%programfiles(x86)%%GPUOverclockPath%%GPUOverclockProcess%.exe" -Profile%AutorunMSIAWithProfile% >NUL
	) || (
		ECHO Unable to start miner.
		IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Unable to start miner.')" 2>NUL 1>&2
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Unable to start miner. Autorun v. %Version%.
		GOTO hardstart
	)
	IF NOT EXIST "miner.log" (
		ECHO miner.log is missing.
		ECHO Ensure "--log 2" option is added to the miner's command line.
		ECHO Check permissions of this folder. This script requires permission to create files.
		IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* miner.log is missing.%%0ACheck permissions of this folder. This script requires permission to create files.')" 2>NUL 1>&2
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] miner.log is missing.
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Ensure "--log 2" option is added to the miner's command line.
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Check permissions of this folder. This script requires permission to create files.
		GOTO hardstart
	) ELSE (
		ECHO Log monitoring started.
	)
)
SET InternetErrorsCounter=1
SET HashrateErrorsCount=0
SET OldHashrate=0
SET FirstRun=0
:check
timeout.exe /T 1 /nobreak >NUL
SET LastInternetError=0
SET MinHashrate=0
SET Hashcount=0
SET SumHash=0
FOR /F "tokens=1 delims=." %%A IN ('wmic.exe OS GET localdatetime^|Find "."') DO SET DT2=%%A
SET Mh2=1%DT2:~4,2%
SET Dy2=1%DT2:~6,2%
SET Hr2=1%DT2:~8,2%
SET Me2=1%DT2:~10,2%
SET /A Mh2=%Mh2%-100
SET /A Dy2=%Dy2%-100
SET /A Hr2=%Hr2%-100
SET /A Me2=%Me2%-100
SET /A DTDiff=%Me2%+(%Hr2%*60)+(%Dy2%*1440)+(%Mh2%43200)-(%Mh1%43200)-(%Dy1%*1440)-(%Hr1%*60)-%Me1%
SET /A DyDiff=%DTDiff%/1440
SET /A HrDiff=(%DTDiff%-%DyDiff%*1440)/60
SET /A MeDiff=%DTDiff%-%HrDiff%*60-%DyDiff%*1440
IF %DyDiff% LSS 10 SET DyDiff=0%DyDiff%
IF %HrDiff% LSS 10 SET HrDiff=0%HrDiff%
IF %MeDiff% LSS 10 SET MeDiff=0%MeDiff%
IF %MidnightAutoRestart% EQU 1 IF %Dy2% NEQ %Dy1% SET Mtimer=1&& GOTO shedule
IF %MidnightAutoRestart% EQU 2 IF %Dy2% NEQ %Dy1% SET Ctimer=1&& GOTO shedule
IF %EveryHourAutoRestart% EQU 1 IF %HrDiff% GEQ 1 SET Mtimer=1&& GOTO shedule
IF %EveryHourAutoRestart% EQU 2 IF %HrDiff% GEQ 2 SET Mtimer=1&& GOTO shedule
IF %EveryHourAutoRestart% EQU 3 IF %HrDiff% GEQ 1 SET Ctimer=1&& GOTO shedule
IF %EveryHourAutoRestart% EQU 4 IF %HrDiff% GEQ 2 SET Ctimer=1&& GOTO shedule
IF %Hr2% NEQ %Hr1% IF %Hr2% EQU 12 (
	IF %MiddayAutoRestart% EQU 1 SET Mtimer=1&& GOTO shedule
	IF %MiddayAutoRestart% EQU 2 SET Ctimer=1&& GOTO shedule
)
IF %SwitchToDefault% EQU 1 IF %Hr2% NEQ %Hr1% GOTO switch
IF %SwitchToDefault% EQU 1 IF %Me2% EQU 30 GOTO switch
timeout.exe /T 1 /nobreak >NUL
IF %ErrorsCounter% GEQ %ErrorsAmount% (
	>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Too many errors. A restart of the computer to clear GPU cache is required. Restarting... Miner ran for %DyDiff% d. %HrDiff%:%MeDiff%.
	ECHO              Too many errors, need clear GPU cash...
	ECHO                      Miner ran for %DyDiff% d. %HrDiff%:%MeDiff%
	ECHO                       Computer restarting...
	ECHO +================================================================+
	GOTO restart
)
timeout.exe /T 1 /nobreak >NUL
FOR /F "delims=" %%A IN ('findstr.exe /R /C:"Temp: GPU.*C.*" miner.log') DO SET CurrentTemp=%%A
timeout.exe /T 1 /nobreak >NUL
FOR /F "delims=" %%A IN ('findstr.exe /R /C:"GPU.*: .* Sol/s .*" miner.log') DO SET CurrentSpeed=%%A
timeout.exe /T 1 /nobreak >NUL
FOR /F "tokens=3 delims= " %%A IN ('findstr.exe /R /C:"Total speed: [0-9]* Sol/s" miner.log') DO (
	IF %%A LSS %AverageTotalHashrate% SET /A MinHashrate+=1
	IF !MinHashrate! GEQ 50 GOTO passaveragecheck
	SET LastHashrate=%%A
	SET /A Hashcount+=1
	SET /A SumHash=SumHash+%%A
	SET /A SumResult=SumHash/Hashcount
)
timeout.exe /T 1 /nobreak >NUL
IF !SumResult! NEQ %OldHashrate% IF !SumResult! LSS %AverageTotalHashrate% (
	IF %HashrateErrorsCount% GEQ %HashrateErrorsAmount% (
		:passaveragecheck
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Low hashrate. Average: !SumResult!/%AverageTotalHashrate% Last: !LastHashrate!/%AverageTotalHashrate%. Miner ran for %DyDiff% d. %HrDiff%:%MeDiff%.
		GOTO error
	)
	IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Abnormal hashrate. Average: *!SumResult!/%AverageTotalHashrate%* Last: *!LastHashrate!/%AverageTotalHashrate%*')" 2>NUL 1>&2
	>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Abnormal hashrate. Average: !SumResult!/%AverageTotalHashrate% Last: !LastHashrate!/%AverageTotalHashrate%.
	ECHO Abnormal hashrate. Average: !SumResult!/%AverageTotalHashrate% Last: !LastHashrate!/%AverageTotalHashrate%.
	SET /A HashrateErrorsCount+=1
	SET OldHashrate=!SumResult!
)
timeout.exe /T 1 /nobreak >NUL
IF !PTOS1! GEQ 59 SET PTOS1=0
IF !PTOS1! LSS %Me2% (
	SET PTOS1=%Me2%
	SET LstShareDiff=0
	SET LstShareMin=-1
	timeout.exe /T 1 /nobreak >NUL
	FOR /F "tokens=3 delims=: " %%A IN ('findstr.exe /R /C:"INFO .* share .*" miner.log') DO SET LstShareMin=1%%A
	SET /A LstShareMin=!LstShareMin!-100
	IF !LstShareMin! GEQ 0 IF %Me2% GTR 0 (
		IF !LstShareMin! EQU 0 SET LstShareMin=59
		IF !LstShareMin! LSS %Me2% SET /A LstShareDiff=%Me2%-!LstShareMin!
		IF !LstShareMin! GTR %Me2% SET /A LstShareDiff=!LstShareMin!-%Me2%
		IF !LstShareMin! GTR 50 IF %Me2% LEQ 10 SET /A LstShareDiff=60-!LstShareMin!+%Me2%
		IF !LstShareDiff! GTR 10 (
			IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Long share timeout... Miner ran for %DyDiff% d. %HrDiff%:%MeDiff%.')" 2>NUL 1>&2
			>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Long share timeout... !LstShareDiff!/!LstShareMin!/%Me2%. Miner ran for %DyDiff% d. %HrDiff%:%MeDiff%.
			GOTO error
		)
	)
)
timeout.exe /T 1 /nobreak >NUL
IF %EnableInternetConnectivityCheck% EQU 1 (
	FOR /F "delims=" %%A IN ('findstr.exe /R %InternetErrorsList% %InternetErrorsCancel% miner.log') DO SET LastInternetError=%%A
	ECHO !LastInternetError!| findstr.exe /R %InternetErrorsList% && (
		timeout.exe /T 15 /nobreak >NUL
		FOR /F "delims=" %%B IN ('findstr.exe /R %InternetErrorsList% %InternetErrorsCancel% miner.log') DO SET LastInternetError=%%B
		ECHO !LastInternetError!| findstr.exe /R %InternetErrorsList% && (
			>> %~n0.log ECHO [%Date%][%Time:~-11,8%] !LastInternetError!
			CLS
			COLOR 4F
			MODE CON cols=67 lines=40
			ping.exe google.com| find.exe /I "TTL=" >NUL && (
				ECHO +================================================================+
				ECHO       Check config.bat file for errors or pool is offline...
				ECHO                      Miner ran for %DyDiff% d. %HrDiff%:%MeDiff%
				ECHO               Miner restarting with default values...
				ECHO +================================================================+
				taskkill.exe /F /IM "%MinerProcess%" 2>NUL 1>&2
				> %MinerBat% ECHO @ECHO off
				>> %MinerBat% ECHO TITLE %MinerBat%
				>> %MinerBat% ECHO REM Configure miner's command line in config.bat file. Not in %MinerBat%.
				IF %EnableAdditionalServer% EQU 1 (
					IF %ServerQueue% EQU 0 (
						>> %MinerBat% ECHO miner --server eu1-zcash.flypool.org --port 3333 --user t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv.fr172 --pass x --log 2 --fee 0 --templimit 90 --pec
						SET ServerQueue=1
						SET SwitchToDefault=1
					)
					IF %ServerQueue% EQU 1 (
						>> %MinerBat% ECHO %AdditionalServer1BatCommand%
						SET ServerQueue=2
						SET SwitchToDefault=1
					)
					IF %ServerQueue% EQU 2 (
						>> %MinerBat% ECHO %AdditionalServer2BatCommand%
						SET ServerQueue=3
						SET SwitchToDefault=1
					)
					IF %ServerQueue% EQU 3 (
						>> %MinerBat% ECHO %AdditionalServer3BatCommand%
						SET ServerQueue=4
						SET SwitchToDefault=1
					)
					IF %ServerQueue% EQU 4 (
						>> %MinerBat% ECHO %AdditionalServer4BatCommand%
						SET ServerQueue=0
						SET SwitchToDefault=1
					)
				) ELSE (
					>> %MinerBat% ECHO miner --server eu1-zcash.flypool.org --port 3333 --user t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv.fr172 --pass x --log 2 --fee 0 --templimit 90 --pec
					SET SwitchToDefault=1
				)
				>> %MinerBat% ECHO EXIT
				IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Pool server was switched. Please check your config.bat file carefully for spelling errors or incorrect parameters. Otherwise check if the pool you are connecting to is online.')" 2>NUL 1>&2
				>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Pool server was switched. Please check your config.bat file carefully for spelling errors or incorrect parameters. Otherwise check if the pool you are connecting to is online.
				ECHO Pool server was switched. Please check your config.bat file carefully for spelling errors or incorrect parameters. Otherwise check if the pool you are connecting to is online.
				ECHO Default %MinerBat% created. Please check it for errors.
				SET /A ErrorsCounter+=1
				GOTO start
			) || (
				IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Something is wrong with your Internet. Please check your connection.')" 2>NUL 1>&2
				>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Something is wrong with your Internet. Please check your connection. Miner ran for %DyDiff% d. %HrDiff%:%MeDiff%.
				ECHO +================================================================+
				ECHO               Something is wrong with your Internet...
				ECHO                      Miner ran for %DyDiff% d. %HrDiff%:%MeDiff%
				ECHO                      Attempting to reconnect...
				ECHO +================================================================+
				:tryingreconnect
				IF %DyDiff% EQU 0 IF %HrDiff% EQU 0 IF %MeDiff% GEQ 10 IF %InternetErrorsCounter% GTR 10 GOTO restart
				IF %InternetErrorsCounter% GTR 60 GOTO restart
				ECHO Attempt !InternetErrorsCounter! to restore Internet connection.
				SET /A InternetErrorsCounter+=1
				FOR /F "delims=" %%C IN ('findstr.exe /R %InternetErrorsList% %InternetErrorsCancel% miner.log') DO SET LastInternetError=%%C
				ECHO !LastInternetError!| findstr.exe /R %InternetErrorsCancel% && GOTO reconnected
				ping.exe google.com| find.exe /I "TTL=" >NUL || (
					CHOICE /C yn /T 60 /D n /M "Restart miner manually"
					IF ERRORLEVEL ==2 GOTO tryingreconnect
					SET /A ErrorsCounter+=1
					GOTO start
				)
				:reconnected
				IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Something was wrong with your Internet. Connection has been restored. Miner restarting...')" 2>NUL 1>&2
				>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Something was wrong with your Internet. Connection has been restored. Miner restarting...
				ECHO +================================================================+
				ECHO                   Connection has been restored...
				ECHO                      Miner ran for %DyDiff% d. %HrDiff%:%MeDiff%
				ECHO                         Miner restarting...
				ECHO +================================================================+
				GOTO start
			)
		)
	)
)
timeout.exe /T 1 /nobreak >NUL
FOR /F "delims=" %%A IN ('findstr.exe /R %MinerErrorsList% %MinerWarningsList% %CriticalErrorsList% %OtherErrorsList% %OtherWarningsList% miner.log') DO (
	ECHO %%A| findstr.exe /R %MinerErrorsList% 2>NUL && (
		IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* %%A')" 2>NUL 1>&2
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] %%A
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Error from GPU. Voltage, Riser or Overclock issue. Miner ran for %DyDiff% d. %HrDiff%:%MeDiff%.
		GOTO error
	)
	ECHO %%A| findstr.exe /R %MinerWarningsList% 2>NUL && (
		CLS
		COLOR 4F
		MODE CON cols=67 lines=15
		ECHO +================================================================+
		ECHO                     Temperature limit reached...
		ECHO                      Miner ran for %DyDiff% d. %HrDiff%:%MeDiff%
		ECHO +================================================================+
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Current !CurrentTemp!
		IF %DyDiff% EQU 0 IF %HrDiff% EQU 0 IF %MeDiff% LSS 10 (
			IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Current !CurrentTemp!%%0A%%0ATemperature limit reached. GPUs will now *STOP MINING*. Please ensure your GPUs have enough air flow. *Waiting for users input...*')" 2>NUL 1>&2
			>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Temperature limit reached. GPUs will now STOP MINING. Please ensure your GPUs have enough air flow. Miner ran for %DyDiff% d. %HrDiff%:%MeDiff%.
			tskill.exe /A /V %GPUOverclockProcess% >NUL
			taskkill.exe /F /IM "%MinerProcess%" 2>NUL 1>&2
			ECHO Current !CurrentTemp!& ECHO Please ensure your GPUs have enough air flow.& ECHO GPUs will now STOP MINING.& ECHO Waiting for users input...
			PAUSE
			GOTO hardstart
		) ELSE (
			IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Current !CurrentTemp!%%0A%%0ATemperature limit reached. Fans may be stuck. Attempting to restart computer...')" 2>NUL 1>&2
			>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Temperature limit reached. Fans may be stuck. Miner ran for %DyDiff% d. %HrDiff%:%MeDiff%.
			ECHO Current !CurrentTemp!& ECHO Fans may be stuck.
			GOTO restart
		)
	)
	ECHO %%A| findstr.exe /R %CriticalErrorsList% 2>NUL && (
		IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* %%A')" 2>NUL 1>&2
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] %%A
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Critical error from GPU. Voltage or Overclock issue. Miner ran for %DyDiff% d. %HrDiff%:%MeDiff%.
		GOTO restart
	)
	ECHO %%A| findstr.exe /R /V %MinerErrorsList% %CriticalErrorsList% %MinerWarningsList% %InternetErrorsList% 2>NUL && (
		IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* %%A')" 2>NUL 1>&2
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] %%A
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Unknown error or warning found. Please send this message to developer. Miner ran for %DyDiff% d. %HrDiff%:%MeDiff%.
		GOTO error
	)
)
timeout.exe /T 1 /nobreak >NUL
tasklist.exe /FI "IMAGENAME eq %MinerProcess%" 2>NUL| find.exe /I /N "%MinerProcess%" >NUL || (
	IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Process *%MinerProcess%* crashed.')" 2>NUL 1>&2
	>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Process %MinerProcess% crashed. Miner ran for %DyDiff% d. %HrDiff%:%MeDiff%.
	GOTO error
)
timeout.exe /T 1 /nobreak >NUL
IF %EnableGPUOverclockMonitor% LEQ 5 IF %EnableGPUOverclockMonitor% GTR 0 (
	tasklist.exe /FI "IMAGENAME eq %GPUOverclockProcess%.exe" 2>NUL| find.exe /I /N "%GPUOverclockProcess%.exe" >NUL || (
		IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Process %GPUOverclockProcess%.exe crashed.')" 2>NUL 1>&2
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Process %GPUOverclockProcess%.exe crashed. Miner ran for %DyDiff% d. %HrDiff%:%MeDiff%.
		GOTO error
	)
)
timeout.exe /T 1 /nobreak >NUL
IF %EnableAPAutorun% EQU 1 (
	tasklist.exe /FI "IMAGENAME eq %APProcessName%" 2>NUL| find.exe /I /N "%APProcessName%" >NUL || (
		IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Process *%APProcessName%* crashed.')" 2>NUL 1>&2
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] %APProcessName% crashed. Miner ran for %DyDiff% d. %HrDiff%:%MeDiff%.
		GOTO error
	)
)
IF %FirstRun% EQU 0 (
	SET FirstRun=1
	SET GPUCount=0
	ECHO +================================================================+
	ECHO Process %MinerProcess% is running...
	IF %EnableGPUOverclockMonitor% EQU 1 ECHO Process %GPUOverclockProcess%.exe is running...
	IF %EnableGPUOverclockMonitor% EQU 2 ECHO Process %GPUOverclockProcess%.exe is running...
	IF %EnableGPUOverclockMonitor% EQU 3 ECHO Process %GPUOverclockProcess%.exe is running...
	IF %EnableGPUOverclockMonitor% EQU 4 ECHO Process %GPUOverclockProcess%.exe is running...
	IF %EnableGPUOverclockMonitor% EQU 5 ECHO Process %GPUOverclockProcess%.exe is running...
	IF %EnableGPUOverclockMonitor% LEQ 0 IF %EnableGPUOverclockMonitor% GEQ 6 ECHO GPU Overclock monitor: Disabled
	IF %MidnightAutoRestart% LEQ 0 ECHO Autorestart at 00:00: Disabled
	IF %MidnightAutoRestart% GTR 0 ECHO Autorestart at 00:00: Enabled
	IF %MiddayAutoRestart% LEQ 0 ECHO Autorestart at 12:00: Disabled
	IF %MiddayAutoRestart% GTR 0 ECHO Autorestart at 12:00: Enabled
	IF %EveryHourAutoRestart% LEQ 0 ECHO Autorestart every hour: Disabled
	IF %EveryHourAutoRestart% GTR 0 ECHO Autorestart every hour: Enabled
	IF %EnableTelegramNotifications% LEQ 0 ECHO Telegram notifications: Disabled
	IF %EnableTelegramNotifications% GTR 0 ECHO Telegram notifications: Enabled
	IF %EnableAPAutorun% LEQ 0 ECHO Additional program autorun: Disabled
	IF %EnableAPAutorun% EQU 1 ECHO Additional program autorun: Enabled
	ECHO +================================================================+
	FOR /F "delims=" %%A IN ('findstr.exe /R /C:"CUDA: Device: [0-9]* .* PCI: .*" miner.log') DO SET /A GPUCount+=1
	IF %NumberOfGPUs% NEQ 0 (
		IF %NumberOfGPUs% GTR !GPUCount! (
			IF %AllowRestartGPU% EQU 1 (
				IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Failed load all GPUs. Number of GPUs *!GPUCount!/%NumberOfGPUs%*')" 2>NUL 1>&2
				>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Failed load all GPUs. Number of GPUs !GPUCount!/%NumberOfGPUs%. Miner ran for %DyDiff% d. %HrDiff%:%MeDiff%.
				ECHO              Failed load all GPUs. Number of GPUs: !GPUCount!/%NumberOfGPUs%
				ECHO                      Miner ran for %DyDiff% d. %HrDiff%:%MeDiff%
				ECHO                       Computer restarting...
				ECHO +================================================================+
				GOTO restart
			) ELSE (
				IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Failed load all GPUs. Number of GPUs *!GPUCount!/%NumberOfGPUs%*')" 2>NUL 1>&2
				>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Failed load all GPUs. Number of GPUs !GPUCount!/%NumberOfGPUs%.
				ECHO Failed load all GPUs. Number of GPUs: !GPUCount!/%NumberOfGPUs%
				SET /A AverageTotalHashrate=%AverageTotalHashrate%/%NumberOfGPUs%*!GPUCount!
			)
		)
		IF %NumberOfGPUs% LSS !GPUCount! (
			IF %EnableTelegramNotifications% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Loaded too many GPUs. This must be set to a number higher than *%NumberOfGPUs%* in your *config.bat* file under *NumberOfGPUs*. Number of GPUs *!GPUCount!/%NumberOfGPUs%*')" 2>NUL 1>&2
			>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Loaded too many GPUs. This must be set to a number higher than %NumberOfGPUs% in your config.bat file under NumberOfGPUs. Number of GPUs: !GPUCount!/%NumberOfGPUs%.
			ECHO Loaded too many GPUs. This must be set to a number higher than %NumberOfGPUs% in your config.bat file under NumberOfGPUs. Number of GPUs: !GPUCount!/%NumberOfGPUs%
		)
	)
	IF EXIST "Logs\miner_*.log" (
		CHOICE /C yn /T 30 /D n /M "Clean Logs folder now"
		IF ERRORLEVEL ==2 (
			ECHO Now I will take care of your %RigName% and you can take a rest.
		) ELSE (
			DEL /F /Q "Logs\*" && ECHO Clean Logs folder finished.
			ECHO Now I will take care of your %RigName% and you can take a rest.
		)
	) ELSE (
		ECHO Now I will take care of your %RigName% and you can take a rest.
	)
	GOTO check
)
CLS
COLOR 1F
MODE CON cols=67 lines=15
ECHO +================================================================+
ECHO            AutoRun v.%Version% for EWBF Miner - by Acrefawn
ECHO              ZEC: t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv
ECHO               BTC: 1wdJBYkVromPoiYk82JfSGSSVVyFJnenB
ECHO +================================================================+
ECHO            Runtime errors: %ErrorsCounter%/%ErrorsAmount% Hashrate errors: %HashrateErrorsCount%/%HashrateErrorsAmount% !MinHashrate!/50
ECHO                 GPUs: !GPUCount!/%NumberOfGPUs% Last share timeout: !LstShareDiff!/10
ECHO                 Average Sol/s: !SumResult! Last Sol/s: !LastHashrate!
ECHO                      Miner ran for %DyDiff% d. %HrDiff%:%MeDiff%
ECHO +============================================================[%Time:~-5,2%]+
IF %EnableTelegramNotifications% EQU 1 (
	IF %Me2% LSS 30 SET AllowSend=1
	IF %AllowSend% EQU 1 IF %Me2% GEQ 30 (
		IF %EnableEveryHourInfoSend% EQU 1 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Miner has been running for *%DyDiff%* d. *%HrDiff%:%MeDiff%* - do not worry.%%0AAverage total hashrate: *!SumResult!*.%%0ALast total hashrate: *!LastHashrate!*.%%0ACurrent Speed: !CurrentSpeed!%%0ACurrent !CurrentTemp!')" 2>NUL 1>&2 && SET AllowSend=0
		IF %EnableEveryHourInfoSend% EQU 2 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&disable_notification=true&text=*%RigName%:* Miner has been running for *%DyDiff%* d. *%HrDiff%:%MeDiff%* - do not worry.%%0AAverage total hashrate: *!SumResult!*.%%0ALast total hashrate: *!LastHashrate!*.%%0ACurrent Speed: !CurrentSpeed!%%0ACurrent !CurrentTemp!')" 2>NUL 1>&2 && SET AllowSend=0
		IF %EnableEveryHourInfoSend% EQU 3 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Online, *%DyDiff%* d. *%HrDiff%:%MeDiff%*, *!LastHashrate!*.')" 2>NUL 1>&2 && SET AllowSend=0
		IF %EnableEveryHourInfoSend% EQU 4 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&disable_notification=true&text=*%RigName%:* Online, *%DyDiff%* d. *%HrDiff%:%MeDiff%*, *!LastHashrate!*.')" 2>NUL 1>&2 && SET AllowSend=0
	)
)
GOTO check