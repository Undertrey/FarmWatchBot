REM Developer acrefawn. Contact me: acrefawn@gmail.com, t.me/acrefawn
@ECHO OFF
SETLOCAL ENABLEDELAYEDEXPANSION
MODE CON cols=67 lines=40
shutdown.exe /A 2>NUL 1>&2
FOR /F "tokens=1 delims=." %%A IN ('wmic.exe OS GET localdatetime^|Find "."') DO SET DT0=%%A
TITLE Miner-autorun(%DT0%)
SET Version=1.8.7
SET FirstRun=0
:hardstart
CLS
COLOR 1F
ECHO +================================================================+
ECHO         AutoRun v.%Version% for Nicehash Miner - by Acrefawn
ECHO              ZEC: t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv
ECHO               BTC: 1wdJBYkVromPoiYk82JfSGSSVVyFJnenB
ECHO +================================================================+
REM Attention. Change the options below only if its really needed.
REM Amount of errors before computer restart (5 - default, only numeric values)
SET ErrorsAmount=5
REM Name miner process. (in English, without special symbols and spaces)
SET MinerProcess1=NiceHash Miner 2.exe
SET MinerProcess2=excavator.exe
SET MinerProcess3=xmr-stak-cpu.exe
REM Name config .bat file. (in English, without special symbols and spaces)
SET Configfile=config.bat
REM Check to see if autorun.bat has already been started. (0 - false, 1 - true)
SET EnableDoubleWindowCheck=1
REM Default config.
SET EnableGPUOverclockMonitor=0
SET AutorunMSIAWithProfile=0
SET MSIADelayTimer=120
SET RestartGPUOverclockMonitor=0
SET EveryHourMinerAutoRestart=0
SET EveryHourComputerAutoRestart=0
SET MiddayAutoRestart=0
SET MidnightAutoRestart=0
SET EnableInternetConnectivityCheck=1
SET EnableGPUEnvironments=1
SET RigName=%COMPUTERNAME%
SET ChatId=0
SET EnableEveryHourInfoSend=0
SET EnableAPAutorun=0
SET APProcessName=TeamViewer.exe
SET APProcessPath=C:\Program Files (x86)\TeamViewer\TeamViewer.exe
REM Attention. Do not touch the options below in any case.
SET rtpt=d2a
SET HrDiff=00
SET MeDiff=00
SET SsDiff=00
SET AllowSend=0
SET tprt=WYHfeJU
SET prt=AAFWKz6wv7
SET ErrorsCounter=0
SET rtp=%rtpt%eV6idp
SET tpr=C8go_jp8%tprt%
SET /A Num=(3780712+3780711)*6*9
SET InternetErrorsCancel=/C:".* Connected.*" /C:".* Sending method.*" /C:".* Recived method.*"
SET CriticalErrorsList=/C:".*child process exited.*"
SET MinerErrorsList=/C:".*Failed for sendData.*" /C:".*Connection ERROR Error.*" /C:".*Connection closed.*"
SET InternetErrorsList=/C:".*Connection lost.*" /C:".*Failed to resolve.*" /C:".*error = Error: getaddrinfo ENOENT.*"
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
		FOR %%A IN (%~n0.bat) DO IF %%~ZA LSS 33000 EXIT
		FOR %%B IN (%Configfile%) DO (
			IF %%~ZB GEQ 2800 (
				CALL %Configfile%
				timeout.exe /T 2 /nobreak >NUL
				ECHO Config.bat loaded.
				>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Config.bat loaded.
				IF DEFINED EnableGPUOverclockMonitor IF DEFINED AutorunMSIAWithProfile IF DEFINED MSIADelayTimer IF DEFINED RestartGPUOverclockMonitor IF DEFINED EveryHourMinerAutoRestart IF DEFINED EveryHourComputerAutoRestart IF DEFINED MiddayAutoRestart IF DEFINED MidnightAutoRestart IF DEFINED EnableInternetConnectivityCheck IF DEFINED EnableGPUEnvironments IF DEFINED RigName IF DEFINED ChatId IF DEFINED EnableEveryHourInfoSend IF DEFINED EnableAPAutorun IF DEFINED APProcessName IF DEFINED APProcessPath GOTO start
			)
			ECHO Config.bat file error. It is corrupted.
			IF %ChatId% NEQ 0 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Config.bat file error. It is corrupted. Please check it...')" 2>NUL 1>&2
			>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Config.bat file error. It is corrupted.
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
>> %Configfile% ECHO REM =================================================== [Overclock program]
>> %Configfile% ECHO REM Enable GPU Overclock control monitor. [0 - false, 1 - true XTREMEGE, 2 - true AFTERBURNER, 3 - true GPUTWEAK, 4 - true PRECISION, 5 - true AORUSGE, 6 - true THUNDERMASTER]
>> %Configfile% ECHO REM Autorun and run-check of GPU Overclock programs.
>> %Configfile% ECHO SET EnableGPUOverclockMonitor=%EnableGPUOverclockMonitor%
>> %Configfile% ECHO REM Additional option to auto-enable Overclock Profile for MSI Afterburner. Please, do not use this option if it is not needed. [0 - false, 1 - Profile 1, 2 - Profile 2, 3 - Profile 3, 4 - Profile 4, 5 - Profile 5]
>> %Configfile% ECHO SET AutorunMSIAWithProfile=%AutorunMSIAWithProfile%
>> %Configfile% ECHO REM Set MSI Afterburner wait timer (default - 120 sec, min value - 1 sec)
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
IF %ChatId% NEQ 0 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Scheduled computer restart, please wait...')" 2>NUL 1>&2
>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Scheduled computer restart, please wait... Miner ran for %HrDiff%:%MeDiff%:%SsDiff%.
:restart
powershell.exe -command "Add-Type -AssemblyName System.Windows.Forms; Add-type -AssemblyName System.Drawing; $Screen = [System.Windows.Forms.SystemInformation]::VirtualScreen; $bitmap = New-Object System.Drawing.Bitmap $Screen.Width, $Screen.Height; $graphic = [System.Drawing.Graphics]::FromImage($bitmap); $graphic.CopyFromScreen($Screen.Left, $Screen.Top, 0, 0, $bitmap.Size); $bitmap.Save('%HOMEDRIVE%%HOMEPATH%\AppData\Roaming\nhm2\logs\Screenshots\miner_%Mh1%.%Dy1%_%Hr1%.%Me1%.jpg');" 2>NUL 1>&2
COLOR 4F
ECHO Computer restarting...
IF %ChatId% NEQ 0 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Computer restarting...')" 2>NUL 1>&2
>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Computer restarting...
tskill.exe /A /V %GPUOverclockProcess% 2>NUL 1>&2 && ECHO Process %GPUOverclockProcess%.exe was successfully killed.
taskkill.exe /F /IM "%MinerProcess1%" 2>NUL 1>&2 && ECHO Process %MinerProcess1% was successfully killed.
taskkill.exe /F /IM "%MinerProcess2%" 2>NUL 1>&2
taskkill.exe /F /IM "%MinerProcess3%" 2>NUL 1>&2
IF %EnableAPAutorun% EQU 1 taskkill.exe /F /IM "%APProcessName%" 2>NUL 1>&2 && ECHO Process %APProcessName% was successfully killed.
shutdown.exe /T 30 /R /F /C "Your computer will restart after 30 seconds. To cancel restart, close this window and start %~n0.bat manually."
EXIT
:mtimer
CLS
ECHO +================================================================+
ECHO               Scheduled miner restart, please wait...
ECHO                        Miner ran for %HrDiff%:%MeDiff%:%SsDiff%
ECHO                            Restarting...
ECHO +================================================================+
IF %ChatId% NEQ 0 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Scheduled miner restart, please wait...')" 2>NUL 1>&2
>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Scheduled miner restart, please wait... Miner ran for %HrDiff%:%MeDiff%:%SsDiff%.
GOTO start
:error
CLS
COLOR 4F
SET /A ErrorsCounter+=1
IF %ErrorsCounter% GEQ %ErrorsAmount% (
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
powershell.exe -command "Add-Type -AssemblyName System.Windows.Forms; Add-type -AssemblyName System.Drawing; $Screen = [System.Windows.Forms.SystemInformation]::VirtualScreen; $bitmap = New-Object System.Drawing.Bitmap $Screen.Width, $Screen.Height; $graphic = [System.Drawing.Graphics]::FromImage($bitmap); $graphic.CopyFromScreen($Screen.Left, $Screen.Top, 0, 0, $bitmap.Size); $bitmap.Save('%HOMEDRIVE%%HOMEPATH%\AppData\Roaming\nhm2\logs\Screenshots\miner_%Mh1%.%Dy1%_%Hr1%.%Me1%.jpg');" 2>NUL 1>&2
IF %ChatId% NEQ 0 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Miner restarting...')" 2>NUL 1>&2
>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Miner restarting... Miner ran for %HrDiff%:%MeDiff%:%SsDiff%.
:start
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
IF NOT EXIST "%MinerProcess1%" (
	ECHO "%MinerProcess1%" is missing. Please check the directory for missing files. Exiting...
	PAUSE
	EXIT
)
IF NOT EXIST "%HOMEDRIVE%%HOMEPATH%\AppData\Roaming\nhm2\logs\Logs" MD %HOMEDRIVE%%HOMEPATH%\AppData\Roaming\nhm2\logs\Logs && ECHO Folder Logs created.
IF NOT EXIST "%HOMEDRIVE%%HOMEPATH%\AppData\Roaming\nhm2\logs\Screenshots" MD %HOMEDRIVE%%HOMEPATH%\AppData\Roaming\nhm2\logs\Screenshots && ECHO Folder Screenshots created.
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
				IF %ChatId% NEQ 0 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* %GPUOverclockProcess%.exe was started.')" 2>NUL 1>&2
				>> %~n0.log ECHO [%Date%][%Time:~-11,8%] %GPUOverclockProcess%.exe was started.
				SET FirstRun=0
			) || (
				ECHO Unable to start %GPUOverclockProcess%.exe.
				IF %ChatId% NEQ 0 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Unable to start %GPUOverclockProcess%.exe.')" 2>NUL 1>&2
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
				IF %ChatId% NEQ 0 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* %APProcessName% was started.')" 2>NUL 1>&2
				>> %~n0.log ECHO [%Date%][%Time:~-11,8%] %APProcessName% was started.
			) || (
				ECHO Unable to start %APProcessName%.
				IF %ChatId% NEQ 0 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Unable to start %APProcessName%.')" 2>NUL 1>&2
				>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Unable to start %APProcessName%.
				SET EnableAPAutorun=0
				GOTO error
			)
		)
	)
)
tskill.exe /A /V WerFault 2>NUL 1>&2 && ECHO Process WerFault.exe was successfully killed.
taskkill.exe /F /IM "WerFault.exe" 2>NUL 1>&2 && ECHO Process WerFault.exe was successfully killed.
taskkill.exe /F /IM "%MinerProcess1%" 2>NUL 1>&2 && ECHO Process %MinerProcess1% was successfully killed.
taskkill.exe /F /IM "%MinerProcess2%" 2>NUL 1>&2
taskkill.exe /F /IM "%MinerProcess3%" 2>NUL 1>&2
>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Process %MinerProcess1% was successfully killed.
ECHO Please wait 30 seconds or press any key to continue...
timeout.exe /T 30 >NUL
IF EXIST "%HOMEDRIVE%%HOMEPATH%\AppData\Roaming\nhm2\logs\log.txt" (
	MOVE /Y %HOMEDRIVE%%HOMEPATH%\AppData\Roaming\nhm2\logs\log.txt %HOMEDRIVE%%HOMEPATH%\AppData\Roaming\nhm2\logs\Logs\miner_%Mh1%.%Dy1%_%Hr1%.%Me1%.log 2>NUL 1>&2 || (
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Unable to rename or access log.txt. Attempting to delete log.txt and continue...
		DEL /Q /F "%HOMEDRIVE%%HOMEPATH%\AppData\Roaming\nhm2\logs\log.txt" >NUL || (
			ECHO Unable to delete log.txt.
			IF %ChatId% NEQ 0 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Unable to delete log.txt.')" 2>NUL 1>&2
			>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Unable to delete log.txt.
			GOTO error
		)
	) && (
		ECHO log.txt renamed and moved to Logs folder.
		timeout.exe /T 5 /nobreak >NUL
	)
)
timeout.exe /T 2 /nobreak >NUL
START /B "" "%MinerProcess1%" 2>NUL 1>&2 && (
	ECHO Miner was started at %Time:~-11,8%.
	IF %ChatId% NEQ 0 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Miner was started.')" 2>NUL 1>&2
	>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Miner was started. v.%Version%.
	timeout.exe /T 30 /nobreak >NUL
) || (
	ECHO Unable to start miner.
	IF %ChatId% NEQ 0 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Unable to start miner.')" 2>NUL 1>&2
	>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Unable to start miner. v.%Version%.
	GOTO error
)
IF NOT EXIST "%HOMEDRIVE%%HOMEPATH%\AppData\Roaming\nhm2\logs\log.txt" (
	ECHO log.txt is missing.
	ECHO Check permissions of this folder. This script requires permission to create files.
	ECHO Ensure logging option is added to the miners command line.
	IF %ChatId% NEQ 0 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* log.txt is missing. Ensure logging option is added to the miners command line. Check permissions of this folder. This script requires permission to create files.')" 2>NUL 1>&2
	>> %~n0.log ECHO [%Date%][%Time:~-11,8%] log.txt is missing. Check permissions of this folder. This script requires permission to create files.
	>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Ensure logging option is added to the miners command line.
	GOTO error
) ELSE (
	ECHO Log monitoring started.
	ECHO Collecting information. Please wait...
	timeout.exe /T 5 /nobreak >NUL
)
SET FirstRun=0
:check
SET InternetErrorsCounter=1
SET LastError=0
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
		IF %ChatId% NEQ 0 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Miner must be restarted, please wait...')" 2>NUL 1>&2
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
IF %Hr2% NEQ %Hr1% IF %Hr2% EQU 12 (
	IF %MiddayAutoRestart% EQU 1 GOTO mtimer
	IF %MiddayAutoRestart% EQU 2 GOTO ctimer
)
timeout.exe /T 2 /nobreak >NUL
FOR /F "delims=" %%N IN ('findstr.exe /I /R %MinerErrorsList% %InternetErrorsList% %HOMEDRIVE%%HOMEPATH%\AppData\Roaming\nhm2\logs\log.txt ^| findstr.exe /V /R /I /C:".*DevFee.*"') DO SET LastError=%%N
IF !LastError! NEQ 0 (
	IF %EnableInternetConnectivityCheck% EQU 1 (
		ECHO !LastError!| findstr.exe /I /R %InternetErrorsList% 2>NUL 1>&2 && (
			FOR /F "delims=" %%n IN ('findstr.exe /I /R %InternetErrorsList% %InternetErrorsCancel% %HOMEDRIVE%%HOMEPATH%\AppData\Roaming\nhm2\logs\log.txt') DO SET LastInternetError=%%n
			ECHO !LastInternetError!| findstr.exe /I /R %InternetErrorsList% >NUL && (
				timeout.exe /T 30 /nobreak >NUL
				FOR /F "delims=" %%n IN ('findstr.exe /I /R %InternetErrorsList% %InternetErrorsCancel% %HOMEDRIVE%%HOMEPATH%\AppData\Roaming\nhm2\logs\log.txt') DO SET LastInternetError=%%n
				ECHO !LastInternetError!| findstr.exe /I /R %InternetErrorsList% >NUL && (
					IF %ChatId% NEQ 0 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* !LastError!')" 2>NUL 1>&2
					>> %~n0.log ECHO [%Date%][%Time:~-11,8%] !LastError!
					ping.exe google.com| find.exe /I "TTL=" >NUL || (
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
						FOR /F "delims=" %%n IN ('findstr.exe /I /R %InternetErrorsList% %InternetErrorsCancel% %HOMEDRIVE%%HOMEPATH%\AppData\Roaming\nhm2\logs\log.txt') DO SET LastInternetError=%%n
						ECHO !LastInternetError!| findstr.exe /I /R %InternetErrorsCancel% && (
							ECHO +================================================================+
							ECHO                   Connection has been restored...
							ECHO                         Continue mining...
							ECHO +================================================================+
							IF %ChatId% NEQ 0 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Something was wrong with your Internet. Connection has been restored. Continue mining...')" 2>NUL 1>&2
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
						IF %ChatId% NEQ 0 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Something was wrong with your Internet. Connection has been restored. Miner restarting...')" 2>NUL 1>&2
						>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Something was wrong with your Internet. Connection has been restored. Miner restarting...
						GOTO start
					)
				)
			)
		)
	)
	ECHO !LastError!| findstr.exe /I /R %MinerErrorsList% 2>NUL && (
		IF %ChatId% NEQ 0 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* !LastError!')" 2>NUL 1>&2
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] !LastError!
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Error from GPU. Voltage or Overclock issue.
		GOTO error
	)
	ECHO !LastError!| findstr.exe /I /R %CriticalErrorsList% 2>NUL && (
		IF %ChatId% NEQ 0 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* !LastError!')" 2>NUL 1>&2
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] !LastError!
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Critical error from GPU. Voltage or Overclock issue. Miner ran for %HrDiff%:%MeDiff%:%SsDiff%.
		GOTO restart
	)
)
timeout.exe /T 2 /nobreak >NUL
tasklist.exe /FI "IMAGENAME eq %MinerProcess1%" 2>NUL| find.exe /I /N "%MinerProcess1%" >NUL || (
	IF %ChatId% NEQ 0 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Process *%MinerProcess1%* crashed.')" 2>NUL 1>&2
	>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Process %MinerProcess1% crashed.
	GOTO error
)
tasklist.exe /FI "IMAGENAME eq WerFault.exe" 2>NUL| find.exe /I /N "WerFault.exe" >NUL && taskkill.exe /F /IM "WerFault.exe" 2>NUL 1>&2
IF %EnableGPUOverclockMonitor% NEQ 0 (
	timeout.exe /T 2 /nobreak >NUL
	tasklist.exe /FI "IMAGENAME eq %GPUOverclockProcess%.exe" 2>NUL| find.exe /I /N "%GPUOverclockProcess%.exe" >NUL || (
		IF %ChatId% NEQ 0 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Process %GPUOverclockProcess%.exe crashed.')" 2>NUL 1>&2
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Process %GPUOverclockProcess%.exe crashed.
		GOTO error
	)
)
IF %EnableAPAutorun% EQU 1 (
	timeout.exe /T 2 /nobreak >NUL
	tasklist.exe /FI "IMAGENAME eq %APProcessName%" 2>NUL| find.exe /I /N "%APProcessName%" >NUL || (
		IF %ChatId% NEQ 0 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Process *%APProcessName%* crashed.')" 2>NUL 1>&2
		>> %~n0.log ECHO [%Date%][%Time:~-11,8%] %APProcessName% crashed.
		START /MIN "%APProcessName%" "%APProcessPath%" && (
			ECHO %APProcessName% was started at %Time:~-11,8%.
			IF %ChatId% NEQ 0 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* %APProcessName% was started.')" 2>NUL 1>&2
			>> %~n0.log ECHO [%Date%][%Time:~-11,8%] %APProcessName% was started.
		) || (
			ECHO Unable to start %APProcessName%.
			IF %ChatId% NEQ 0 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Unable to start %APProcessName%.')" 2>NUL 1>&2
			>> %~n0.log ECHO [%Date%][%Time:~-11,8%] Unable to start %APProcessName%.
			SET EnableAPAutorun=0
			GOTO error
		)
	)
)
IF !FirstRun! EQU 0 (
	SET FirstRun=1
	IF EXIST "%HOMEDRIVE%%HOMEPATH%\AppData\Roaming\nhm2\logs\Logs\*.jpg" FOR /F "skip=50 usebackq delims=" %%i IN (`DIR /B /A:-D /O:-D /T:W "%HOMEDRIVE%%HOMEPATH%\AppData\Roaming\nhm2\logs\Logs\"`) DO DEL /F /Q "%HOMEDRIVE%%HOMEPATH%\AppData\Roaming\nhm2\logs\Logs\%%~i"
	IF EXIST "%HOMEDRIVE%%HOMEPATH%\AppData\Roaming\nhm2\logs\Screenshots\*.jpg" FOR /F "skip=50 usebackq delims=" %%i IN (`DIR /B /A:-D /O:-D /T:W "%HOMEDRIVE%%HOMEPATH%\AppData\Roaming\nhm2\logs\Screenshots\"`) DO DEL /F /Q "%HOMEDRIVE%%HOMEPATH%\AppData\Roaming\nhm2\logs\Screenshots\%%~i"
	GOTO check
)
CLS
COLOR 1F
ECHO +================================================================+
ECHO         AutoRun v.%Version% for Nicehash Miner - by Acrefawn
ECHO              ZEC: t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv
ECHO               BTC: 1wdJBYkVromPoiYk82JfSGSSVVyFJnenB
ECHO +============================================================[%Time:~-5,2%]+
ECHO Process %MinerProcess1% is running...
ECHO +================================================================+
IF %EnableGPUOverclockMonitor% NEQ 0 ECHO Process %GPUOverclockProcess%.exe is running...
IF %EnableGPUOverclockMonitor% EQU 0 ECHO GPU Overclock monitor: Disabled
IF %EnableGPUOverclockMonitor% GEQ 7 ECHO GPU Overclock monitor: Disabled
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
ECHO +================================================================+
ECHO                          Runtime errors: %ErrorsCounter%/%ErrorsAmount%
ECHO                        Miner ran for %HrDiff%:%MeDiff%:%SsDiff%
ECHO +================================================================+
ECHO Now I will take care of your %RigName% and you can take a rest.
IF %ChatId% NEQ 0 (
	IF %Me2% LSS 30 SET AllowSend=1
	IF %AllowSend% EQU 1 IF %Me2% GEQ 30 (
		IF %EnableEveryHourInfoSend% EQU 1 IF %ChatId% NEQ 0 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&chat_id=%ChatId%&text=*%RigName%:* Online, *%HrDiff%:%MeDiff%:%SsDiff%*.')" 2>NUL 1>&2 && SET AllowSend=0
		IF %EnableEveryHourInfoSend% EQU 2 IF %ChatId% NEQ 0 powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%Num%:%prt%-%rtp%%tpr%/sendMessage?parse_mode=markdown&disable_notification=true&chat_id=%ChatId%&text=*%RigName%:* Online, *%HrDiff%:%MeDiff%:%SsDiff%*.')" 2>NUL 1>&2 && SET AllowSend=0
	)
)
GOTO check