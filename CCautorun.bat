REM Developer acrefawn. Contact me: acrefawn@gmail.com, t.me/acrefawn
@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
MODE CON cols=67 lines=40
shutdown.exe /A 2>NUL 1>&2
FOR /F "tokens=1 delims=." %%A IN ('wmic.exe OS GET localdatetime^|Find "."') DO SET DT0=%%A
TITLE Miner-autorun(%DT0%)
SET Version=1.8.8
SET Program=CCMiner
SET FirstRun=0
:hardstart
CLS
COLOR 1F
ECHO +================================================================+
ECHO              AutoRun v.%Version% for %Program% - by Acrefawn
ECHO              ZEC: t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv
ECHO               BTC: 1wdJBYkVromPoiYk82JfSGSSVVyFJnenB
ECHO +================================================================+
REM Attention. Change the options below only if its really needed.
REM Amount of errors before computer restart (5 - default, only numeric values)
SET ErrorsAmount=5
REM Amount of hashrate errors before miner restart (5 - default, only numeric values)
SET HashrateErrorsAmount=5
REM Name miner process. (in English, without special symbols and spaces)
SET MinerProcess=ccminer-x64.exe
IF EXIST "ccminer.exe" RENAME ccminer.exe %MinerProcess%
IF EXIST "ccminer-x64.exe" RENAME ccminer-x64.exe %MinerProcess%
REM Name start mining .bat file. (in English, without special symbols and spaces)
SET MinerBat=miner.bat
REM Name miner .log file. (in English, without special symbols and spaces)
SET Logfile=miner.log
REM Name config .bat file. (in English, without special symbols and spaces)
SET Configfile=config.bat
REM Check to see if autorun.bat has already been started. (0 - false, 1 - true)
SET EnableDoubleWindowCheck=1
REM Default config.
SET EnableGPUOverclockMonitor=0
SET AutorunMSIAWithProfile=0
SET MSIADelayTimer=120
SET RestartGPUOverclockMonitor=0
SET NumberOfGPUs=0
SET AllowRestartGPU=1
SET AverageTotalHashrate=0
SET Server1BatCommand=%MinerProcess% -o stratum+tcp://yiimp.eu:4533 -a lyra2v2 -u Vy197bshDoH6dmGRx5ZwiGMfiPCf7ZG3yj -p c=VTC --no-color
SET Server2BatCommand=%MinerProcess% -o stratum+tcp://yiimp.eu:4533 -a lyra2v2 -u Vy197bshDoH6dmGRx5ZwiGMfiPCf7ZG3yj -p c=VTC --no-color
SET Server3BatCommand=%MinerProcess% -o stratum+tcp://yiimp.eu:4533 -a lyra2v2 -u Vy197bshDoH6dmGRx5ZwiGMfiPCf7ZG3yj -p c=VTC --no-color
SET Server4BatCommand=%MinerProcess% -o stratum+tcp://yiimp.eu:4533 -a lyra2v2 -u Vy197bshDoH6dmGRx5ZwiGMfiPCf7ZG3yj -p c=VTC --no-color
SET Server5BatCommand=%MinerProcess% -o stratum+tcp://yiimp.eu:4533 -a lyra2v2 -u Vy197bshDoH6dmGRx5ZwiGMfiPCf7ZG3yj -p c=VTC --no-color
SET EveryHourMinerAutoRestart=48
SET EveryHourComputerAutoRestart=0
SET MiddayAutoRestart=0
SET MidnightAutoRestart=0
SET EnableInternetConnectivityCheck=1
SET EnableGPUEnvironments=0
SET EnableLastShareDiffCheck=1
SET RigName=%COMPUTERNAME%
SET ChatId=0
SET EnableEveryHourInfoSend=2
SET EnableAPAutorun=0
SET APProcessName=TeamViewer.exe
SET APProcessPath=C:\Program Files (x86)\TeamViewer\TeamViewer.exe
REM Attention. Do not touch the options below in any case.
SET PTOS=0
SET rtpt=d2a
SET HrDiff=00
SET MeDiff=00
SET SsDiff=00
SET AllowSend=0
SET tprt=WYHfeJU
SET ServerQueue=1
SET prt=AAFWKz6wv7
SET ErrorsCounter=0
SET rtp=%rtpt%eV6idp
SET SwitchToDefault=0
SET tpr=C8go_jp8%tprt%
SET /A Num=(3780712+3780711)*6*9
SET LstShareDiff=0
SET CurrServerName=No data...
SET CurTemp=Current temp: No data..
SET CurrSpeed=Current speed: No data..
SET MinerWarningsList=/C:".*temperature too high.*" /C:".*thermal limit.*"
SET InternetErrorsCancel=/C:".*accepted:.*"
SET CriticalErrorsList=/C:".*CUDA-capable.*"
SET MinerErrorsList=/C:".*Thread exited.*" /C:".*CUDA error.*" /C:".*error.*" /C:".*cuda.*failed.*" /C:".* [0-5]C .*"
SET InternetErrorsList=/C:".*connection .*ed.*" /C:".*not resolve.*" /C:".*subscribe .*" /C:".*connect .*" /C:".*No properly.*" /C:".*authorization failed.*" /C:".*Unknown algo parameter.*"
IF %EnableDoubleWindowCheck% EQU 1 (
	tasklist.exe /V /NH /FI "imagename eq cmd.exe"| findstr.exe /V /R /C:".*Miner-autorun(%DT0%)"| findstr.exe /R /C:".*Miner-autorun.*" 2>NUL 1>&2 && (
		ECHO This script is already running...
		ECHO Current window will close in 10 seconds.
		timeout.exe /T 10 /nobreak >NUL
		EXIT
	)
)
:checkconfig
timeout.exe /T 2 /nobreak >NUL
IF EXIST "%Configfile%" (
	findstr.exe /C:"%Version%" %Configfile% >NUL && (
		FOR %%A IN (%~n0.bat) DO IF %%~ZA LSS 47489 EXIT
		FOR %%B IN (%Configfile%) DO (
			IF %%~ZB GEQ 4100 (
				CALL %Configfile%
				timeout.exe /T 2 /nobreak >NUL
				ECHO %Configfile% loaded.
				>> %~n0.log ECHO [%Date%][%Time:~-11,8%] %Configfile% loaded.
				IF DEFINED EnableGPUOverclockMonitor IF DEFINED AutorunMSIAWithProfile IF DEFINED MSIADelayTimer IF DEFINED RestartGPUOverclockMonitor IF DEFINED NumberOfGPUs IF DEFINED AllowRestartGPU IF DEFINED AverageTotalHashrate IF DEFINED Server1BatCommand IF DEFINED Server2BatCommand IF DEFINED Server3BatCommand IF DEFINED Server4BatCommand IF DEFINED Server5BatCommand IF DEFINED EveryHourMinerAutoRestart IF DEFINED EveryHourComputerAutoRestart IF DEFINED MiddayAutoRestart IF DEFINED MidnightAutoRestart IF DEFINED EnableInternetConnectivityCheck IF DEFINED EnableGPUEnvironments IF DEFINED RigName IF DEFINED ChatId IF DEFINED EnableEveryHourInfoSend IF DEFINED EnableAPAutorun IF DEFINED APProcessName IF DEFINED APProcessPath GOTO start
			)
			ECHO %Configfile% file error. It is corrupted.
			IF %ChatId% NEQ 0 CALL :telegram "false" "%Configfile% file error. It is corrupted. Please check it..."
			>> %~n0.log ECHO [%Date%][%Time:~-11,8%] %Configfile% file error. It is corrupted.
		)
	) || (
		CALL %Configfile%
		timeout.exe /T 2 /nobreak >NUL
		ECHO Your %Configfile% is out of date.
	)
	MOVE /Y %Configfile% config_backup.bat >NUL && ECHO Created backup of your old %Configfile%.
)
> %Configfile% ECHO @ECHO off
>> %Configfile% ECHO REM Configuration file v. %Version%
>> %Configfile% ECHO REM =================================================== [GPU]
>> %Configfile% ECHO REM Set how many GPU devices are enabled.
>> %Configfile% ECHO SET NumberOfGPUs=%NumberOfGPUs%
>> %Configfile% ECHO REM Allow computer restart if number of loaded GPUs is not equal to number of enabled GPUs. [0 - false, 1 - true]
>> %Configfile% ECHO SET AllowRestartGPU=%AllowRestartGPU%
>> %Configfile% ECHO REM Set total average hashrate of this Rig. [you can use average hashrate value from your pool]
>> %Configfile% ECHO SET AverageTotalHashrate=%AverageTotalHashrate%
>> %Configfile% ECHO REM =================================================== [Miner]
>> %Configfile% ECHO REM Set main server miner command here to auto-create %MinerBat% file if it is missing or wrong. [keep default order]
>> %Configfile% ECHO SET Server1BatCommand=%Server1BatCommand%
>> %Configfile% ECHO REM When the main server fails, %~n0 will switch to the additional server below immediately. [in order]
>> %Configfile% ECHO REM Configure miner command here. Old %MinerBat% will be removed and a new one will be created with this value. [keep default order] EnableInternetConnectivityCheck=1 required.
>> %Configfile% ECHO SET Server2BatCommand=%Server2BatCommand%
>> %Configfile% ECHO SET Server3BatCommand=%Server3BatCommand%
>> %Configfile% ECHO SET Server4BatCommand=%Server4BatCommand%
>> %Configfile% ECHO SET Server5BatCommand=%Server5BatCommand%
>> %Configfile% ECHO REM =================================================== [Overclock program]
>> %Configfile% ECHO REM Enable GPU Overclock control monitor. [0 - false, 1 - true XTREMEGE, 2 - true AFTERBURNER, 3 - true GPUTWEAK, 4 - true PRECISION, 5 - true AORUSGE, 6 - true THUNDERMASTER]
>> %Configfile% ECHO REM Autorun and run-check of GPU Overclock programs.
>> %Configfile% ECHO SET EnableGPUOverclockMonitor=%EnableGPUOverclockMonitor%
>> %Configfile% ECHO REM Additional option to auto-enable Overclock Profile for MSI Afterburner. Please, do not use this option if it is not needed. [0 - false, 1 - Profile 1, 2 - Profile 2, 3 - Profile 3, 4 - Profile 4, 5 - Profile 5]
>> %Configfile% ECHO SET AutorunMSIAWithProfile=%AutorunMSIAWithProfile%
>> %Configfile% ECHO REM Set MSI Afterburner wait timer [default - 120 sec, min value - 1 sec]
IF %NumberOfGPUs% GEQ 1 SET /A MSIADelayTimer=%NumberOfGPUs%*15
>> %Configfile% ECHO SET MSIADelayTimer=%MSIADelayTimer%
>> %Configfile% ECHO REM Allow Overclock programs to be restarted when miner is restarted. Please, do not use this option if it is not needed. [0 - false, 1 - true]
>> %Configfile% ECHO SET RestartGPUOverclockMonitor=%RestartGPUOverclockMonitor%
>> %Configfile% ECHO REM =================================================== [Timers]
>> %Configfile% ECHO REM Restart MINER every X hours. Set value of hours delay between miner restarts. [0 - false, 1-999 - scheduled hours delay]
>> %Configfile% ECHO SET EveryHourMinerAutoRestart=%EveryHourMinerAutoRestart%
>> %Configfile% ECHO REM Restart COMPUTER every X hours. Set value of hours delay between computer restarts. [0 - false, 1-999 - scheduled hours delay]
>> %Configfile% ECHO SET EveryHourComputerAutoRestart=%EveryHourComputerAutoRestart%
>> %Configfile% ECHO REM Restart miner or computer every day at 12:00. [1 - true miner, 2 - true computer, 0 - false]
>> %Configfile% ECHO SET MiddayAutoRestart=%MiddayAutoRestart%
>> %Configfile% ECHO REM Restart miner or computer every day at 00:00. [1 - true miner, 2 - true computer, 0 - false]
>> %Configfile% ECHO SET MidnightAutoRestart=%MidnightAutoRestart%
>> %Configfile% ECHO REM =================================================== [Other]
>> %Configfile% ECHO REM Enable Internet connectivity check. [0 - false, 1 - true]
>> %Configfile% ECHO REM Disable Internet connectivity check only if you have difficulties with your connection. [ie. high latency, intermittent connectivity]
>> %Configfile% ECHO SET EnableInternetConnectivityCheck=%EnableInternetConnectivityCheck%
>> %Configfile% ECHO REM Enable additional environments. Please do not use this option if it is not needed, or if you do not understand its function. [0 - false, 1 - true]
>> %Configfile% ECHO REM GPU_FORCE_64BIT_PTR 0, GPU_MAX_HEAP_SIZE 100, GPU_USE_SYNC_OBJECTS 1, GPU_MAX_ALLOC_PERCENT 100, GPU_SINGLE_ALLOC_PERCENT 100
>> %Configfile% ECHO SET EnableGPUEnvironments=%EnableGPUEnvironments%
>> %Configfile% ECHO REM Enable last share timeout check. [0 - false, 1 - true]
>> %Configfile% ECHO SET EnableLastShareDiffCheck=%EnableLastShareDiffCheck%
>> %Configfile% ECHO REM =================================================== [Telegram notifications]
>> %Configfile% ECHO REM To enable Telegram notifications enter here your ChatId, from Telegram @FarmWatchBot. [0 - disable]
>> %Configfile% ECHO SET ChatId=%ChatId%
>> %Configfile% ECHO REM Name your Rig. [in English, without special symbols]
>> %Configfile% ECHO SET RigName=%RigName%
>> %Configfile% ECHO REM Enable hourly statistics through Telegram. [0 - false, 1 - true full, 2 - true full in silent mode, 3 - true short, 4 - true short in silent mode]
>> %Configfile% ECHO SET EnableEveryHourInfoSend=%EnableEveryHourInfoSend%
>> %Configfile% ECHO REM =================================================== [Additional program]
>> %Configfile% ECHO REM Enable additional program check on startup. [ie. TeamViewer, Minergate, Storj etc] [0 - false, 1 - true]
>> %Configfile% ECHO SET EnableAPAutorun=%EnableAPAutorun%
>> %Configfile% ECHO REM Process name of additional program. [Press CTRL+ALT+DEL to find the process name]
>> %Configfile% ECHO SET APProcessName=%APProcessName%
>> %Configfile% ECHO REM Path to file of additional program. [ie. C:\Program Files\TeamViewer\TeamViewer.exe]
>> %Configfile% ECHO SET APProcessPath=%APProcessPath%
ECHO Default %Configfile% created.
ECHO Please check it and restart %~n0.bat.
>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Default %Configfile% created. Please check it and restart %~n0.bat.
timeout.exe /T 5 /nobreak >NUL
GOTO hardstart
:ctimer
CLS
ECHO +================================================================+
ECHO             Scheduled computer restart, please wait...
ECHO                        Miner ran for %HrDiff%:%MeDiff%:%SsDiff%
ECHO                            Restarting...
ECHO +================================================================+
IF %ChatId% NEQ 0 CALL :telegram "false" "Scheduled computer restart, please wait..."
>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Scheduled computer restart, please wait... Miner ran for %HrDiff%:%MeDiff%:%SsDiff%.
:restart
powershell.exe -command "Add-Type -AssemblyName System.Windows.Forms; Add-type -AssemblyName System.Drawing; $Screen = [System.Windows.Forms.SystemInformation]::VirtualScreen; $bitmap = New-Object System.Drawing.Bitmap $Screen.Width, $Screen.Height; $graphic = [System.Drawing.Graphics]::FromImage($bitmap); $graphic.CopyFromScreen($Screen.Left, $Screen.Top, 0, 0, $bitmap.Size); $bitmap.Save('Screenshots\miner_%Mh1%.%Dy1%_%Hr1%.%Me1%.jpg');" 2>NUL 1>&2
COLOR 4F
ECHO Computer restarting...
IF %ChatId% NEQ 0 CALL :telegram "false" "Computer restarting..."
>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Computer restarting...
tskill.exe /A /V %GPUOverclockProcess% 2>NUL 1>&2 && ECHO Process %GPUOverclockProcess%.exe was successfully killed.
taskkill.exe /F /IM "%MinerProcess%" 2>NUL 1>&2 && ECHO Process %MinerProcess% was successfully killed.
timeout.exe /T 5 /nobreak >NUL
taskkill.exe /F /FI "IMAGENAME eq cmd.exe" /FI "WINDOWTITLE eq %MinerBat%*" 2>NUL 1>&2
IF %EnableAPAutorun% EQU 1 taskkill.exe /F /IM "%APProcessName%" 2>NUL 1>&2 && ECHO Process %APProcessName% was successfully killed.
shutdown.exe /T 30 /R /F /C "Your computer will restart after 30 seconds. To cancel restart, close this window and start %~n0.bat manually."
EXIT
:switch
CLS
ECHO +================================================================+
ECHO           Attempting to switch to the main pool server...
ECHO                        Miner ran for %HrDiff%:%MeDiff%:%SsDiff%
ECHO                         Miner restarting...
ECHO +================================================================+
IF %ChatId% NEQ 0 CALL :telegram "false" "Attempting to switch to the main pool server..."
>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Attempting to switch to the main pool server...
SET SwitchToDefault=0
SET ServerQueue=1
GOTO start
:mtimer
CLS
ECHO +================================================================+
ECHO               Scheduled miner restart, please wait...
ECHO                        Miner ran for %HrDiff%:%MeDiff%:%SsDiff%
ECHO                            Restarting...
ECHO +================================================================+
IF %ChatId% NEQ 0 CALL :telegram "false" "Scheduled miner restart, please wait..."
>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Scheduled miner restart, please wait... Miner ran for %HrDiff%:%MeDiff%:%SsDiff%.
GOTO start
:error
CLS
COLOR 4F
SET /A ErrorsCounter+=1
IF %ErrorsCounter% GTR %ErrorsAmount% (
	ECHO +================================================================+
	ECHO              Too many errors, need clear GPU cash...
	ECHO                        Miner ran for %HrDiff%:%MeDiff%:%SsDiff%
	ECHO                       Computer restarting...
	ECHO +================================================================+
	>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Too many errors. A restart of the computer to clear GPU cache is required. Restarting... Miner ran for %HrDiff%:%MeDiff%:%SsDiff%.
	GOTO restart
)
ECHO +================================================================+
ECHO                        Something is wrong...
ECHO                        Miner ran for %HrDiff%:%MeDiff%:%SsDiff%
ECHO                         Miner restarting...
ECHO +================================================================+
powershell.exe -command "Add-Type -AssemblyName System.Windows.Forms; Add-type -AssemblyName System.Drawing; $Screen = [System.Windows.Forms.SystemInformation]::VirtualScreen; $bitmap = New-Object System.Drawing.Bitmap $Screen.Width, $Screen.Height; $graphic = [System.Drawing.Graphics]::FromImage($bitmap); $graphic.CopyFromScreen($Screen.Left, $Screen.Top, 0, 0, $bitmap.Size); $bitmap.Save('Screenshots\miner_%Mh1%.%Dy1%_%Hr1%.%Me1%.jpg');" 2>NUL 1>&2
IF %ChatId% NEQ 0 CALL :telegram "false" "Miner restarting..."
>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Miner restarting... Miner ran for %HrDiff%:%MeDiff%:%SsDiff%.
:start
SET AverageTotalHashrate=%AverageTotalHashrate: =%
SET NumberOfGPUs=%NumberOfGPUs: =%
SET ChatId=%ChatId: =%
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
FOR /F "tokens=1 delims=." %%A IN ('wmic.exe OS GET localdatetime^|Find "."') DO SET DT1=%%A
SET Mh1=1%DT1:~4,2%
SET Dy1=1%DT1:~6,2%
SET Hr1=1%DT1:~8,2%
SET Me1=1%DT1:~10,2%
SET Ss1=1%DT1:~12,2%
SET /A Mh1=%Mh1%-100
SET /A Dy1=%Dy1%-100
SET /A Hr1=%Hr1%-100
SET /A Me1=%Me1%-100
SET /A Ss1=%Ss1%-100
SET /A DTDiff1=%Hr1%*60*60+%Me1%*60+%Ss1%
IF NOT EXIST "%MinerProcess%" (
	ECHO "%MinerProcess%" is missing. Please check the directory for missing files. Exiting...
	PAUSE
	EXIT
)
IF NOT EXIST "Logs" MD Logs && ECHO Folder Logs created.
IF NOT EXIST "Screenshots" MD Screenshots && ECHO Folder Screenshots created.
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
IF %EnableGPUOverclockMonitor% EQU 6 (
	SET GPUOverclockProcess=THPanel
	SET GPUOverclockPath=\Thunder Master\
)
IF %EnableGPUOverclockMonitor% GTR 0 IF %EnableGPUOverclockMonitor% LEQ 6 (
	IF NOT EXIST "%programfiles(x86)%%GPUOverclockPath%" (
		ECHO Incorrect path to %GPUOverclockProcess%.exe. Default install path required to function. Please reinstall the software using the default path.
		SET EnableGPUOverclockMonitor=0
	) ELSE (
		IF !FirstRun! NEQ 0 IF %RestartGPUOverclockMonitor% EQU 1 (
			tskill.exe /A /V %GPUOverclockProcess% 2>NUL 1>&2
			>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Process %GPUOverclockProcess%.exe was successfully killed.
		)
		timeout.exe /T 5 /nobreak >NUL
		tasklist.exe /FI "IMAGENAME eq %GPUOverclockProcess%.exe" 2>NUL| find.exe /I /N "%GPUOverclockProcess%.exe" >NUL || (
			START "" "%programfiles(x86)%%GPUOverclockPath%%GPUOverclockProcess%.exe" && (
				ECHO %GPUOverclockProcess%.exe was started at %Time:~-11,8%.
				IF %ChatId% NEQ 0 CALL :telegram "false" "%GPUOverclockProcess%.exe was started."
				>> %~n0.log ECHO [%Date%][%Time:~-11,8%] %GPUOverclockProcess%.exe was started.
				SET FirstRun=0
			) || (
				ECHO Unable to start %GPUOverclockProcess%.exe.
				IF %ChatId% NEQ 0 CALL :telegram "false" "Unable to start %GPUOverclockProcess%.exe."
				>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Unable to start %GPUOverclockProcess%.exe.
				SET EnableGPUOverclockMonitor=0
				GOTO error
			)
		)
		IF %AutorunMSIAWithProfile% GEQ 1 IF %AutorunMSIAWithProfile% LEQ 5 IF !EnableGPUOverclockMonitor! EQU 2 (
			IF !FirstRun! EQU 0 (
				ECHO Waiting %MSIADelayTimer% sec. for the full load of Msi Afterburner...
				timeout.exe /T %MSIADelayTimer% >NUL
			)
			"%programfiles(x86)%%GPUOverclockPath%%GPUOverclockProcess%.exe" -Profile%AutorunMSIAWithProfile% >NUL
			SET FirstRun=1
		)
	)
) ELSE (
	SET EnableGPUOverclockMonitor=0
)
IF %EnableAPAutorun% EQU 1 (
	IF NOT EXIST "%APProcessPath%" (
		ECHO Incorrect path to %APProcessName%.
		SET EnableAPAutorun=0
	) ELSE (
		tasklist.exe /FI "IMAGENAME eq %APProcessName%" 2>NUL| find.exe /I /N "%APProcessName%" >NUL || (
			timeout.exe /T 5 /nobreak >NUL
			START /MIN "%APProcessName%" "%APProcessPath%" && (
				ECHO %APProcessName% was started at %Time:~-11,8%.
				IF %ChatId% NEQ 0 CALL :telegram "false" "%APProcessName% was started."
				>> %~n0.log ECHO [%Date%][%Time:~-11,8%] %APProcessName% was started.
			) || (
				ECHO Unable to start %APProcessName%.
				IF %ChatId% NEQ 0 CALL :telegram "false" "Unable to start %APProcessName%."
				>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Unable to start %APProcessName%.
				SET EnableAPAutorun=0
				GOTO error
			)
		)
	)
)
tskill.exe /A /V WerFault 2>NUL 1>&2 && ECHO Process WerFault.exe was successfully killed.
taskkill.exe /F /IM "WerFault.exe" 2>NUL 1>&2 && ECHO Process WerFault.exe was successfully killed.
tasklist.exe /FI "IMAGENAME eq %MinerProcess%" 2>NUL| find.exe /I /N "%MinerProcess%" >NUL && (
	taskkill.exe /F /IM "%MinerProcess%" 2>NUL 1>&2 && (
		timeout.exe /T 5 /nobreak >NUL
		taskkill.exe /F /FI "IMAGENAME eq cmd.exe" /FI "WINDOWTITLE eq %MinerBat%*" 2>NUL 1>&2
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Process %MinerProcess% was successfully killed.
		ECHO Process %MinerProcess% was successfully killed.
	) || (
		ECHO Unable to kill %MinerProcess%. Retrying...
		IF %ChatId% NEQ 0 CALL :telegram "false" "Unable to kill %MinerProcess%. Retrying..."
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Unable to kill %MinerProcess%. Retrying...
		GOTO start
	)
)
ECHO Please wait 30 seconds or press any key to continue...
timeout.exe /T 30 >NUL
IF EXIST "%Logfile%" (
	MOVE /Y %Logfile% Logs\miner_%Mh1%.%Dy1%_%Hr1%.%Me1%.log 2>NUL 1>&2 && (
		ECHO %Logfile% renamed and moved to Logs folder.
		IF EXIST "%~dp0Logs\*.log" FOR /F "skip=50 usebackq delims=" %%i IN (`DIR /B /A:-D /O:-D /T:W "%~dp0Logs\"`) DO DEL /F /Q "%~dp0Logs\%%~i"
		IF EXIST "%~dp0Logs\*.jpg" FOR /F "skip=50 usebackq delims=" %%i IN (`DIR /B /A:-D /O:-D /T:W "%~dp0Screenshots\"`) DO DEL /F /Q "%~dp0Screenshots\%%~i"
		timeout.exe /T 5 /nobreak >NUL
	) || (
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Unable to rename or access %Logfile%. Attempting to delete %Logfile% and continue...
		DEL /Q /F "%Logfile%" >NUL || (
			ECHO Unable to delete %Logfile%.
			IF %ChatId% NEQ 0 CALL :telegram "false" "Unable to delete %Logfile%."
			>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Unable to delete %Logfile%.
			GOTO error
		)
	)
)
> %MinerBat% ECHO @ECHO off
>> %MinerBat% ECHO TITLE %MinerBat%
>> %MinerBat% ECHO REM Configure miners command line in %Configfile% file. Not in %MinerBat%.
>> %MinerBat% ECHO ECHO Output from miner redirected into %Logfile% file. Miner working OK. Do not worry.
IF !ServerQueue! EQU 1 >> %MinerBat% ECHO ^>^> miner.log 2^>^&1 %Server1BatCommand%
IF !ServerQueue! EQU 2 >> %MinerBat% ECHO ^>^> miner.log 2^>^&1 %Server2BatCommand%
IF !ServerQueue! EQU 3 >> %MinerBat% ECHO ^>^> miner.log 2^>^&1 %Server3BatCommand%
IF !ServerQueue! EQU 4 >> %MinerBat% ECHO ^>^> miner.log 2^>^&1 %Server4BatCommand%
IF !ServerQueue! EQU 5 >> %MinerBat% ECHO ^>^> miner.log 2^>^&1 %Server5BatCommand%
REM Default pool server settings for debugging. Will be activated only in case of mining failed on all user pool servers, to detect errors. Will be deactivated automatically in 30 minutes and switched back to settings of main pool server.
IF !ServerQueue! GEQ 6 >> %MinerBat% ECHO ^>^> miner.log 2^>^&1 %MinerProcess% -o stratum+tcp://yiimp.eu:4533 -a lyra2v2 -u Vy197bshDoH6dmGRx5ZwiGMfiPCf7ZG3yj -p c=VTC --no-color
>> %MinerBat% ECHO EXIT
timeout.exe /T 5 /nobreak >NUL
START "%MinerBat%" "%MinerBat%" && (
	ECHO Miner was started at %Time:~-11,8%.
	IF %ChatId% NEQ 0 CALL :telegram "false" "Miner was started."
	>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Miner was started. v.%Version%.
	FOR /F "tokens=6,7 delims=/:= " %%a IN ('findstr.exe /C:"%MinerProcess%" %MinerBat%') DO (
		SET CurrServerName=%%b
		ECHO %%a| findstr.exe /I /R /C:".*stratum.*" /C:".*ssl.*" /C:".*tcp.*" >NUL || SET CurrServerName=%%a
		ECHO !CurrServerName!| findstr.exe /R /C:".*\..*" >NUL || SET CurrServerName=No data...
	)
	timeout.exe /T 30 /nobreak >NUL
) || (
	ECHO Unable to start miner.
	IF %ChatId% NEQ 0 CALL :telegram "false" "Unable to start miner."
	>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Unable to start miner. v.%Version%.
	GOTO error
)
IF NOT EXIST "%Logfile%" (
	ECHO %Logfile% is missing.
	ECHO Check permissions of this folder. This script requires permission to create files.
	ECHO Ensure ^>^> miner.log option is added to the miners command line.
	IF %ChatId% NEQ 0 CALL :telegram "false" "%Logfile% is missing. Ensure *^>^> miner.log* option is added to the miners command line. Check permissions of this folder. This script requires permission to create files."
	>> %~n0.log ECHO [%Date%][%Time:~-11,8%] %Logfile% is missing. Check permissions of this folder. This script requires permission to create files.
	>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Ensure ^>^> miner.log option is added to the miners command line.
	GOTO error
) ELSE (
	findstr.exe /R /C:".*--no-color.*" %MinerBat% 2>NUL 1>&2 || (
		ECHO Ensure --no-color option is added to the miners command line in correct order.
		IF %ChatId% NEQ 0 CALL :telegram "false" "Ensure *--no-color* option is added to the miners command line in correct order."
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Ensure --no-color option is added to the miners command line in correct order.
	)
	ECHO Log monitoring started.
	ECHO Collecting information. Please wait...
	timeout.exe /T 5 /nobreak >NUL
)
SET HashrateErrorsCount=0
SET OldHashrate=0
SET FirstRun=0
SET GPUCount=0
:check
SET InternetErrorsCounter=1
SET MinHashrate=0
SET Hashcount=0
SET LastError=0
SET SumHash=0
FOR /F "tokens=1 delims=." %%A IN ('wmic.exe OS GET localdatetime^|Find "."') DO SET DT2=%%A
SET Mh2=1%DT2:~4,2%
SET Dy2=1%DT2:~6,2%
SET Hr2=1%DT2:~8,2%
SET Me2=1%DT2:~10,2%
SET Ss2=1%DT2:~12,2%
SET /A Mh2=%Mh2%-100
SET /A Dy2=%Dy2%-100
SET /A Hr2=%Hr2%-100
SET /A Me2=%Me2%-100
SET /A Ss2=%Ss2%-100
SET /A DTDiff2=%Hr2%*60*60+%Me2%*60+%Ss2%
IF %Dy2% GTR %Dy1% (
	SET /A DTDiff=^(%Dy2%-%Dy1%^)*86400-%DTDiff1%+%DTDiff2%
) ELSE (
	IF %Mh2% NEQ %Mh1% (
		IF %ChatId% NEQ 0 CALL :telegram "false" "Miner must be restarted, please wait..."
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Miner must be restarted, please wait...
		GOTO hardstart
	)
	IF %DTDiff2% GEQ %DTDiff1% (
		SET /A DTDiff=%DTDiff2%-%DTDiff1%
	) ELSE (
		SET /A DTDiff=%DTDiff1%-%DTDiff2%
	)
)
SET /A HrDiff=%DTDiff%/60/60
SET /A MeDiff=%DTDiff% %% 3600/60
SET /A SsDiff=%DTDiff% %% 60
IF %HrDiff% LSS 10 SET HrDiff=0%HrDiff%
IF %MeDiff% LSS 10 SET MeDiff=0%MeDiff%
IF %SsDiff% LSS 10 SET SsDiff=0%SsDiff%
IF %MidnightAutoRestart% EQU 1 IF %Dy2% NEQ %Dy1% GOTO mtimer
IF %MidnightAutoRestart% EQU 2 IF %Dy2% NEQ %Dy1% GOTO ctimer
IF %EveryHourMinerAutoRestart% GEQ 1 IF %HrDiff% GEQ %EveryHourMinerAutoRestart% GOTO mtimer
IF %EveryHourComputerAutoRestart% GEQ 1 IF %HrDiff% GEQ %EveryHourComputerAutoRestart% GOTO ctimer
IF %HrDiff% GEQ 1 IF %Hr2% EQU 12 (
	IF %MiddayAutoRestart% EQU 1 GOTO mtimer
	IF %MiddayAutoRestart% EQU 2 GOTO ctimer
)
IF %HrDiff% EQU 0 IF %MeDiff% GEQ 30 IF %SwitchToDefault% EQU 1 GOTO switch
timeout.exe /T 5 /nobreak >NUL
FOR /F "delims=" %%N IN ('findstr.exe /I /R %CriticalErrorsList% %MinerErrorsList% %MinerWarningsList% %InternetErrorsList% %Logfile%') DO SET LastError=%%N
IF !LastError! NEQ 0 (
	IF %EnableInternetConnectivityCheck% EQU 1 (
		ECHO !LastError!| findstr.exe /I /R %InternetErrorsList% 2>NUL 1>&2 && (
			FOR /F "delims=" %%n IN ('findstr.exe /I /R %InternetErrorsList% %InternetErrorsCancel% %Logfile%') DO SET LastInternetError=%%n
			ECHO !LastInternetError!| findstr.exe /I /R %InternetErrorsList% >NUL && (
				timeout.exe /T 30 /nobreak >NUL
				FOR /F "delims=" %%n IN ('findstr.exe /I /R %InternetErrorsList% %InternetErrorsCancel% %Logfile%') DO SET LastInternetError=%%n
				ECHO !LastInternetError!| findstr.exe /I /R %InternetErrorsList% >NUL && (
					IF %ChatId% NEQ 0 CALL :telegram "false" "!LastError!"
					>> %~n0.log ECHO [%Date%][%Time:~-11,8%] !LastError!
					ping.exe google.com| find.exe /I "TTL=" >NUL && (
						CLS
						COLOR 4F
						taskkill.exe /F /IM "%MinerProcess%" 2>NUL 1>&2
						timeout.exe /T 5 /nobreak >NUL
						taskkill.exe /F /FI "IMAGENAME eq cmd.exe" /FI "WINDOWTITLE eq %MinerBat%*" 2>NUL 1>&2
						ECHO +================================================================+
						ECHO       Check %Configfile% file for errors or pool is offline...
						ECHO                        Miner ran for %HrDiff%:%MeDiff%:%SsDiff%
						ECHO               Miner restarting with default values...
						ECHO +================================================================+
						SET SwitchToDefault=1
						SET /A ServerQueue+=1
						ECHO Pool server was switched to !ServerQueue!. Please check your %Configfile% file carefully for spelling errors or incorrect parameters. Otherwise check if the pool you are connecting to is online.
						IF %ChatId% NEQ 0 CALL :telegram "false" "Pool server was switched to *!ServerQueue!*. Please check your %Configfile% file carefully for spelling errors or incorrect parameters. Otherwise check if the pool you are connecting to is online."
						>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Pool server was switched to !ServerQueue!. Please check your %Configfile% file carefully for spelling errors or incorrect parameters. Otherwise check if the pool you are connecting to is online.
						IF !ServerQueue! GTR 6 SET ServerQueue=1
						SET /A ErrorsCounter+=1
						GOTO start
					) || (
						CLS
						COLOR 4F
						ECHO +================================================================+
						ECHO               Something is wrong with your Internet...
						ECHO                        Miner ran for %HrDiff%:%MeDiff%:%SsDiff%
						ECHO                      Attempting to reconnect...
						ECHO +================================================================+
						>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Something is wrong with your Internet. Please check your connection. Miner ran for %HrDiff%:%MeDiff%:%SsDiff%.
						:tryingreconnect
						IF %HrDiff% EQU 0 IF %MeDiff% GEQ 15 IF %InternetErrorsCounter% GTR 10 GOTO restart
						IF %InternetErrorsCounter% GTR 60 GOTO restart
						ECHO Attempt %InternetErrorsCounter% to restore Internet connection.
						SET /A InternetErrorsCounter+=1
						FOR /F "delims=" %%n IN ('findstr.exe /I /R %InternetErrorsList% %InternetErrorsCancel% %Logfile%') DO SET LastInternetError=%%n
						ECHO !LastInternetError!| findstr.exe /I /R %InternetErrorsCancel% && (
							ECHO +================================================================+
							ECHO                   Connection has been restored...
							ECHO                         Continue mining...
							ECHO +================================================================+
							IF %ChatId% NEQ 0 CALL :telegram "false" "Something was wrong with your Internet. Connection has been restored. Continue mining..."
							>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Something was wrong with your Internet. Connection has been restored. Continue mining...
							GOTO check
						)
						ping.exe google.com| find.exe /I "TTL=" >NUL && GOTO reconnected || (
							timeout.exe /T 60 /nobreak >NUL
							GOTO tryingreconnect
						)
						:reconnected
						ECHO +================================================================+
						ECHO                   Connection has been restored...
						ECHO                         Miner restarting...
						ECHO +================================================================+
						IF %ChatId% NEQ 0 CALL :telegram "false" "Something was wrong with your Internet. Connection has been restored. Miner restarting..."
						>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Something was wrong with your Internet. Connection has been restored. Miner restarting...
						GOTO start
					)
				)
			)
		)
	)
	ECHO !LastError!| findstr.exe /I /R %MinerErrorsList% 2>NUL && (
		IF %ChatId% NEQ 0 CALL :telegram "false" "!LastError!"
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] !LastError!
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Error from GPU. Voltage or Overclock issue.
		GOTO error
	)
	ECHO !LastError!| findstr.exe /I /R %CriticalErrorsList% 2>NUL && (
		IF %ChatId% NEQ 0 CALL :telegram "false" "!LastError!"
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] !LastError!
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Critical error from GPU. Voltage or Overclock issue. Miner ran for %HrDiff%:%MeDiff%:%SsDiff%.
		GOTO restart
	)
	ECHO !LastError!| findstr.exe /I /R %MinerWarningsList% 2>NUL && (
		CLS
		COLOR 4F
		ECHO +================================================================+
		ECHO                     Temperature limit reached...
		ECHO                        Miner ran for %HrDiff%:%MeDiff%:%SsDiff%
		ECHO +================================================================+
		ECHO !CurTemp!.
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] !CurTemp!.
		IF %HrDiff% EQU 0 IF %MeDiff% LEQ 10 (
			tskill.exe /A /V %GPUOverclockProcess% 2>NUL 1>&2 && ECHO Process %GPUOverclockProcess%.exe was successfully killed.
			taskkill.exe /F /IM "%MinerProcess%" 2>NUL 1>&2 && ECHO Process %MinerProcess% was successfully killed.
			timeout.exe /T 5 /nobreak >NUL
			taskkill.exe /F /FI "IMAGENAME eq cmd.exe" /FI "WINDOWTITLE eq %MinerBat%*" 2>NUL 1>&2
			ECHO Please ensure your GPUs have enough air flow.
			ECHO GPUs will now STOP MINING.
			ECHO Waiting for users input...
			IF %ChatId% NEQ 0 CALL :telegram "false" "!CurTemp!.%%%%0A%%%%0ATemperature limit reached. GPUs will now *STOP MINING*. Please ensure your GPUs have enough air flow. *Waiting for users input...*"
			>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Temperature limit reached. GPUs will now STOP MINING. Please ensure your GPUs have enough air flow. Miner ran for %HrDiff%:%MeDiff%:%SsDiff%.
			PAUSE
			GOTO hardstart
		)
		ECHO Fans may be stuck.
		IF %ChatId% NEQ 0 CALL :telegram "false" "!CurTemp!.%%%%0A%%%%0ATemperature limit reached. Fans may be stuck. Attempting to restart computer..."
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Temperature limit reached. Fans may be stuck. Miner ran for %HrDiff%:%MeDiff%:%SsDiff%.
		GOTO restart
	)
)
timeout.exe /T 5 /nobreak >NUL
tasklist.exe /FI "IMAGENAME eq WerFault.exe" 2>NUL| find.exe /I /N "WerFault.exe" >NUL && (
	tskill.exe /A /V WerFault 2>NUL 1>&2 && ECHO Process WerFault.exe was successfully killed.
	taskkill.exe /F /IM "WerFault.exe" 2>NUL 1>&2 && ECHO Process WerFault.exe was successfully killed.
)
tasklist.exe /FI "IMAGENAME eq %MinerProcess%" 2>NUL| find.exe /I /N "%MinerProcess%" >NUL || (
	IF %ChatId% NEQ 0 CALL :telegram "false" "Process *%MinerProcess%* crashed."
	>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Process %MinerProcess% crashed.
	GOTO error
)
IF %EnableGPUOverclockMonitor% NEQ 0 (
	timeout.exe /T 5 /nobreak >NUL
	tasklist.exe /FI "IMAGENAME eq %GPUOverclockProcess%.exe" 2>NUL| find.exe /I /N "%GPUOverclockProcess%.exe" >NUL || (
		IF %ChatId% NEQ 0 CALL :telegram "false" "Process %GPUOverclockProcess%.exe crashed."
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Process %GPUOverclockProcess%.exe crashed.
		GOTO error
	)
)
IF %EnableAPAutorun% EQU 1 (
	timeout.exe /T 5 /nobreak >NUL
	tasklist.exe /FI "IMAGENAME eq %APProcessName%" 2>NUL| find.exe /I /N "%APProcessName%" >NUL || (
		IF %ChatId% NEQ 0 CALL :telegram "false" "Process *%APProcessName%* crashed."
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] %APProcessName% crashed.
		START /MIN "%APProcessName%" "%APProcessPath%" && (
			ECHO %APProcessName% was started at %Time:~-11,8%.
			IF %ChatId% NEQ 0 CALL :telegram "false" "%APProcessName% was started."
			>> %~n0.log ECHO [%Date%][%Time:~-11,8%] %APProcessName% was started.
		) || (
			ECHO Unable to start %APProcessName%.
			IF %ChatId% NEQ 0 CALL :telegram "false" "Unable to start %APProcessName%."
			>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Unable to start %APProcessName%.
			SET EnableAPAutorun=0
			GOTO error
		)
	)
)
IF !FirstRun! EQU 0 (
	SET FirstRun=1
	timeout.exe /T 5 /nobreak >NUL
	FOR /F "tokens=3 delims= " %%A IN ('findstr.exe /R /C:".*miner threads started.*" %Logfile%') DO SET /A GPUCount=%%A
	IF !GPUCount! EQU 0 SET GPUCount=1
	IF !NumberOfGPUs! EQU 0 SET NumberOfGPUs=!GPUCount!
	IF !NumberOfGPUs! GTR !GPUCount! (
		IF %AllowRestartGPU% EQU 1 (
			CLS
			COLOR 4F
			ECHO +================================================================+
			ECHO              Failed load all GPUs. Number of GPUs: !GPUCount!/!NumberOfGPUs!
			ECHO                        Miner ran for %HrDiff%:%MeDiff%:%SsDiff%
			ECHO                       Computer restarting...
			ECHO +================================================================+
			IF %ChatId% NEQ 0 CALL :telegram "false" "Failed load all GPUs. Number of GPUs *!GPUCount!/!NumberOfGPUs!*."
			>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Failed load all GPUs. Number of GPUs !GPUCount!/!NumberOfGPUs!. Miner ran for %HrDiff%:%MeDiff%:%SsDiff%.
			GOTO restart
		) ELSE (
			ECHO Failed load all GPUs. Number of GPUs: !GPUCount!/!NumberOfGPUs!.
			IF %ChatId% NEQ 0 CALL :telegram "false" "Failed load all GPUs. Number of GPUs *!GPUCount!/!NumberOfGPUs!*."
			>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Failed load all GPUs. Number of GPUs !GPUCount!/!NumberOfGPUs!.
			SET /A AverageTotalHashrate=%AverageTotalHashrate%/!NumberOfGPUs!*!GPUCount!
		)
	)
	IF !NumberOfGPUs! LSS !GPUCount! (
		ECHO Loaded too many GPUs. This must be set to a number higher than !NumberOfGPUs! in your %Configfile% file under NumberOfGPUs. Number of GPUs: !GPUCount!/!NumberOfGPUs!.
		IF %ChatId% NEQ 0 CALL :telegram "false" "Loaded too many GPUs. This must be set to a number higher than *!NumberOfGPUs!* in your *%Configfile%* file under *NumberOfGPUs*. Number of GPUs *!GPUCount!/!NumberOfGPUs!*."
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Loaded too many GPUs. This must be set to a number higher than !NumberOfGPUs! in your %Configfile% file under NumberOfGPUs. Number of GPUs: !GPUCount!/!NumberOfGPUs!.
		IF %AllowRestartGPU% EQU 1 GOTO restart
	)
)
timeout.exe /T 5 /nobreak >NUL
FOR /L %%A IN (0,1,!NumberOfGPUs!) DO (
	IF %%A EQU 0 (
		SET CurrSpeed=Current speed:
		SET CurTemp=Current temp:
		SET LastHashrate=0
	)
	SET SpeedData=0
	SET TempData=0
	FOR /F "tokens=7,8,9,10,11 delims=:#. " %%a IN ('findstr.exe /R /C:".*GPU.*#%%A.*,.*/s.*" %Logfile%') DO (
		SET LastSymb0=%%a
		SET LastSymb0=!LastSymb0:~-1!
		SET LastSymb1=%%b
		SET LastSymb1=!LastSymb1:~-1!
		SET LastSymb2=%%c
		SET LastSymb2=!LastSymb2:~-1!
		SET LastSymb3=%%d
		SET LastSymb3=!LastSymb3:~-1!
		IF "!LastSymb0!" EQU "," IF "%%b" NEQ "" IF %%b GEQ 0 SET SpeedData=%%b
		IF "!LastSymb1!" EQU "," IF "%%c" NEQ "" IF %%c GEQ 0 SET SpeedData=%%c
		IF "!LastSymb2!" EQU "," IF "%%d" NEQ "" IF %%d GEQ 0 SET SpeedData=%%d
		IF "!LastSymb3!" EQU "," IF "%%e" NEQ "" IF %%e GEQ 0 SET SpeedData=%%e
		IF !SpeedData! NEQ 0 (
			SET /A Hashcount+=1
			SET /A SumHash=SumHash+!SpeedData!
			SET /A SumResult=SumHash/Hashcount*!NumberOfGPUs!
		)
	)
	IF !SpeedData! NEQ 0 (
		IF EXIST "%PROGRAMFILES%\NVIDIA Corporation\NVSMI\nvidia-smi.exe" (
			FOR /F "delims=" %%a IN ('"%PROGRAMFILES%\NVIDIA Corporation\NVSMI\nvidia-smi.exe" --id^=%%A --query-gpu^=temperature.gpu --format^=csv,noheader') DO (
				IF "%%a" NEQ "" IF "%%a" NEQ "No devices were found" IF %%a GEQ 0 IF %%a LSS 70 SET TempData=%%A %%a
				IF "%%a" NEQ "" IF "%%a" NEQ "No devices were found" IF %%a GEQ 70 SET TempData=%%A *%%a*
			)
		)
		SET /A LastHashrate=LastHashrate+!SpeedData!
		IF !LastHashrate! LSS %AverageTotalHashrate% SET /A MinHashrate+=1
		IF !LastHashrate! EQU 0 SET /A MinHashrate+=1
		IF !SpeedData! EQU 0 SET /A MinHashrate+=1
		SET CurrSpeed=!CurrSpeed! G%%A !SpeedData! S/s,
	)
	IF !TempData! NEQ 0 SET CurTemp=!CurTemp! G!TempData!C,
	IF !MinHashrate! GEQ 99 GOTO passaveragecheck
	IF %%A EQU !NumberOfGPUs! (
		IF "!CurrSpeed!" EQU "Current speed:" SET CurrSpeed=Current speed: No data..
		IF "!CurTemp!" EQU "Current temp:" SET CurTemp=Current temp: No data..
		IF "!CurrSpeed!" NEQ "Current speed:" IF "!CurrSpeed!" NEQ "Current speed: No data.." SET CurrSpeed=!CurrSpeed:~0,-1!
		IF "!CurTemp!" NEQ "Current temp:" IF "!CurTemp!" NEQ "Current temp: No data.." SET CurTemp=!CurTemp:~0,-1!
	)
)
timeout.exe /T 5 /nobreak >NUL
IF !SumResult! NEQ !OldHashrate! (
	IF !SumResult! LSS !OldHashrate! IF !SumResult! LSS %AverageTotalHashrate% (
		IF !HashrateErrorsCount! GEQ %HashrateErrorsAmount% (
			:passaveragecheck
			IF %ChatId% NEQ 0 CALL :telegram "false" "Low hashrate. Average: *!SumResult!/%AverageTotalHashrate%* Last: *!LastHashrate!/%AverageTotalHashrate%*."
			>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Low hashrate. Average: !SumResult!/%AverageTotalHashrate% Last: !LastHashrate!/%AverageTotalHashrate%.
			GOTO error
		)
		ECHO Abnormal hashrate. Average: !SumResult!/%AverageTotalHashrate% Last: !LastHashrate!/%AverageTotalHashrate%.
		IF %ChatId% NEQ 0 CALL :telegram "false" "Abnormal hashrate. Average: *!SumResult!/%AverageTotalHashrate%* Last: *!LastHashrate!/%AverageTotalHashrate%*."
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Abnormal hashrate. Average: !SumResult!/%AverageTotalHashrate% Last: !LastHashrate!/%AverageTotalHashrate%.
		SET /A HashrateErrorsCount+=1
	)
	SET OldHashrate=!SumResult!
)
IF %EnableLastShareDiffCheck% EQU 1 (
	SET /A NextReqTime=%Me2%+5
	IF !PTOS! GTR !NextReqTime! SET PTOS=0
	IF !PTOS! LSS %Me2% (
		timeout.exe /T 5 /nobreak >NUL
		SET /A PTOS=%Me2%+5
		SET LstShareDiff=0
		SET LstShareMin=1%DT1:~10,2%
		FOR /F "tokens=3 delims=: " %%A IN ('findstr.exe /R /C:".*accepted: [0-9]*/[0-9]*.*" /C:".*S/A/T.* [0-9]*/[0-9]*/[0-9]*.*" %Logfile%') DO SET LstShareMin=1%%A
		SET /A LstShareMin=!LstShareMin!-100
		IF !LstShareMin! GEQ 0 IF %Me2% GTR 0 (
			IF !LstShareMin! EQU 0 SET LstShareMin=59
			IF !LstShareMin! LSS %Me2% SET /A LstShareDiff=%Me2%-!LstShareMin!
			IF !LstShareMin! GTR %Me2% SET /A LstShareDiff=!LstShareMin!-%Me2%
			IF !LstShareMin! GTR 50 IF %Me2% LEQ 10 SET /A LstShareDiff=60-!LstShareMin!+%Me2%
			IF !LstShareMin! LEQ 10 IF %Me2% GTR 50 SET /A LstShareDiff=60-%Me2%+!LstShareMin!
			IF !LstShareDiff! GTR 10 (
				IF %ChatId% NEQ 0 CALL :telegram "false" "Long share timeout... !LstShareMin!/%Me2%."
				>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Long share timeout... !LstShareMin!/%Me2%.
				GOTO error
			)
		)
	)
)
CLS
COLOR 1F
ECHO +================================================================+
ECHO              AutoRun v.%Version% for %Program% - by Acrefawn
ECHO              ZEC: t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv
ECHO               BTC: 1wdJBYkVromPoiYk82JfSGSSVVyFJnenB
ECHO +============================================================[%Time:~-5,2%]+
ECHO Process %MinerProcess% is running...
ECHO Server: !CurrServerName!
ECHO !CurTemp!.
ECHO !CurrSpeed!.
ECHO +================================================================+
IF %EnableGPUOverclockMonitor% NEQ 0 ECHO Process %GPUOverclockProcess%.exe is running...
IF %EnableGPUOverclockMonitor% EQU 0 ECHO GPU Overclock monitor: Disabled
IF %MidnightAutoRestart% LEQ 0 ECHO Autorestart at 00:00: Disabled
IF %MidnightAutoRestart% GTR 0 ECHO Autorestart at 00:00: Enabled
IF %MiddayAutoRestart% LEQ 0 ECHO Autorestart at 12:00: Disabled
IF %MiddayAutoRestart% GTR 0 ECHO Autorestart at 12:00: Enabled
IF %EveryHourMinerAutoRestart% LEQ 0 ECHO Autorestart miner every hour: Disabled
IF %EveryHourMinerAutoRestart% GTR 0 ECHO Autorestart miner every hour: Enabled
IF %EveryHourComputerAutoRestart% LEQ 0 ECHO Autorestart computer every hour: Disabled
IF %EveryHourComputerAutoRestart% GTR 0 ECHO Autorestart computer every hour: Enabled
IF %ChatId% EQU 0 ECHO Telegram notifications: Disabled
IF %ChatId% NEQ 0 ECHO Telegram notifications: Enabled
IF %EnableAPAutorun% LEQ 0 ECHO Additional program autorun: Disabled
IF %EnableAPAutorun% EQU 1 ECHO Additional program autorun: Enabled
IF %EnableLastShareDiffCheck% EQU 0 ECHO Last share timeout: Disabled
IF %EnableLastShareDiffCheck% EQU 1 ECHO Last share timeout: Enabled
ECHO +================================================================+
ECHO            Runtime errors: %ErrorsCounter%/%ErrorsAmount% Hashrate errors: !HashrateErrorsCount!/%HashrateErrorsAmount% !MinHashrate!/99
ECHO                 GPUs: !GPUCount!/!NumberOfGPUs! Last share timeout: !LstShareDiff!/15
IF DEFINED SumResult IF DEFINED LastHashrate ECHO                    Average S/s: !SumResult! Last S/s: !LastHashrate!
ECHO                        Miner ran for %HrDiff%:%MeDiff%:%SsDiff%
ECHO +================================================================+
ECHO Now I will take care of your %RigName% and you can take a rest.
IF %ChatId% NEQ 0 (
	IF %Me2% LSS 30 SET AllowSend=1
	IF %AllowSend% EQU 1 IF %Me2% GEQ 30 (
		IF %EnableEveryHourInfoSend% EQU 1 IF %ChatId% NEQ 0 CALL :telegram "false" "Miner has been running for *%HrDiff%:%MeDiff%:%SsDiff%* on !CurrServerName!.%%%%0AAverage total hashrate: *!SumResult!*.%%%%0ALast total hashrate: *!LastHashrate!*.%%%%0A!CurrSpeed!.%%%%0A!CurTemp!." && SET AllowSend=0
		IF %EnableEveryHourInfoSend% EQU 2 IF %ChatId% NEQ 0 CALL :telegram "true" "Miner has been running for *%HrDiff%:%MeDiff%:%SsDiff%* on !CurrServerName!.%%%%0AAverage total hashrate: *!SumResult!*.%%%%0ALast total hashrate: *!LastHashrate!*.%%%%0A!CurrSpeed!.%%%%0A!CurTemp!." && SET AllowSend=0
		IF %EnableEveryHourInfoSend% EQU 3 IF %ChatId% NEQ 0 CALL :telegram "false" "Online, *%HrDiff%:%MeDiff%:%SsDiff%*, *!LastHashrate!*." && SET AllowSend=0
		IF %EnableEveryHourInfoSend% EQU 4 IF %ChatId% NEQ 0 CALL :telegram "true" "Online, *%HrDiff%:%MeDiff%:%SsDiff%*, *!LastHashrate!*." && SET AllowSend=0
	)
)
GOTO check
:telegram
powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&&disable_notification=%~1&&chat_id=%ChatId%&text=*%RigName%:* %~2')" 2>NUL 1>&2
EXIT /b