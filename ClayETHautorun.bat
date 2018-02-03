REM Developer acrefawn. Contact me: acrefawn@gmail.com, t.me/acrefawn
@ECHO off
SETLOCAL EnableExtensions EnableDelayedExpansion
MODE CON cols=67 lines=40
shutdown.exe /A 2>NUL 1>&2
FOR /F "tokens=1 delims=." %%A IN ('wmic.exe OS GET localdatetime^|Find "."') DO SET dt0=%%A
TITLE Miner-autorun(%dt0%)
SET ver=1.9.0
SET mn=Clay
SET firstrun=0
:hardstart
CLS
COLOR 1F
ECHO +================================================================+
ECHO            AutoRun v.%ver% for %mn% Miner - by Acrefawn
ECHO           ETH: 0x4a98909270621531dda26de63679c1c6fdcf32ea
ECHO               BTC: 1wdJBYkVromPoiYk82JfSGSSVVyFJnenB
ECHO +================================================================+
REM Attention. Change the options below only if its really needed.
REM Amount of errors before computer restart [5 - default, only numeric values]
SET runtimeerrors=5
REM Amount of hashrate errors before miner restart [5 - default, only numeric values]
SET hashrateerrors=5
REM Name miner process. [in English, without special symbols and spaces]
SET minerprocess=EthDcrMiner64.exe
REM Name miner file or path. [in English, without special symbols and spaces]
SET minerpath=%minerprocess%
REM Name start mining .bat file. [in English, without special symbols and spaces]
SET bat=miner.bat
REM Name miner .log file. [in English, without special symbols and spaces]
SET log=miner.log
REM Name config .ini file. [in English, without special symbols and spaces]
SET config=Config_e%mn%.ini
REM Name server for ping [in English, without special symbols and spaces]
SET pingserver=google.com
REM Slowdown script for weak CPUs. Increase this value 1 by 1 if your hashrate drops because of script [5 - default, only numeric values]
SET cputimeout=5
REM Allow computer to be restarted.
SET pcrestart=1
REM Check to see if autorun.bat has already been started. [0 - false, 1 - true]
SET cmddoubleruncheck=1
REM Default config.
SET gpus=0
SET allowrestart=1
SET hashrate=0
SET commandserver1=%minerpath% -epool eu1.ethermine.org:4444 -ewal 0x4a98909270621531dda26de63679c1c6fdcf32ea.fr190 -epsw x -dpool stratum+tcp://sia-eu1.nanopool.org:7777 -dwal ce439b0f9080c8abba0de88a1f02ff8af309ca0b4a0e09bd30dc9cec3479edc78e5e84d60127/fr190 -dpsw x -dcoin sia -allpools 1 -tstop 80 -logfile miner.log -wd 0
SET commandserver2=%minerpath% -epool eu1.ethermine.org:4444 -ewal 0x4a98909270621531dda26de63679c1c6fdcf32ea.fr190 -epsw x -dpool stratum+tcp://sia-eu1.nanopool.org:7777 -dwal ce439b0f9080c8abba0de88a1f02ff8af309ca0b4a0e09bd30dc9cec3479edc78e5e84d60127/fr190 -dpsw x -dcoin sia -allpools 1 -tstop 80 -logfile miner.log -wd 0
SET commandserver3=%minerpath% -epool eu1.ethermine.org:4444 -ewal 0x4a98909270621531dda26de63679c1c6fdcf32ea.fr190 -epsw x -dpool stratum+tcp://sia-eu1.nanopool.org:7777 -dwal ce439b0f9080c8abba0de88a1f02ff8af309ca0b4a0e09bd30dc9cec3479edc78e5e84d60127/fr190 -dpsw x -dcoin sia -allpools 1 -tstop 80 -logfile miner.log -wd 0
SET commandserver4=%minerpath% -epool eu1.ethermine.org:4444 -ewal 0x4a98909270621531dda26de63679c1c6fdcf32ea.fr190 -epsw x -dpool stratum+tcp://sia-eu1.nanopool.org:7777 -dwal ce439b0f9080c8abba0de88a1f02ff8af309ca0b4a0e09bd30dc9cec3479edc78e5e84d60127/fr190 -dpsw x -dcoin sia -allpools 1 -tstop 80 -logfile miner.log -wd 0
SET commandserver5=%minerpath% -epool eu1.ethermine.org:4444 -ewal 0x4a98909270621531dda26de63679c1c6fdcf32ea.fr190 -epsw x -dpool stratum+tcp://sia-eu1.nanopool.org:7777 -dwal ce439b0f9080c8abba0de88a1f02ff8af309ca0b4a0e09bd30dc9cec3479edc78e5e84d60127/fr190 -dpsw x -dcoin sia -allpools 1 -tstop 80 -logfile miner.log -wd 0
SET overclockprogram=0
SET msiaprofile=0
SET msiatimeout=120
SET restartoverclockprogram=0
SET minertimeoutrestart=48
SET computertimeoutrestart=0
SET noonrestart=0
SET midnightrestart=0
SET internetcheck=1
SET environments=1
SET sharetimeout=1
SET rigname=%COMPUTERNAME%
SET chatid=0
SET everyhourinfo=0
SET approgram=0
SET approcessname=TeamViewer.exe
SET approcesspath=C:\Program Files (x86)\TeamViewer\TeamViewer.exe
REM Attention. Do not touch the options below in any case.
SET ptos=0
SET hrdiff=00
SET mediff=00
SET ssdiff=00
SET allowsend=0
SET queue=1
SET lastsharediff=0
SET serversamount=0
SET errorscounter=0
SET switchtodefault=0
SET tprt=WYHfeJU
SET rtpt=d2a
SET prt=AAFWKz6wv7
SET rtp=%rtpt%eV6i
SET tpr=C8go_jp8%tprt%
SET /A num=(3780712+3780711)*6*9
SET warningslist=/C:".*reached.*"
SET errorscancel=/C:".*Connected.*"
SET criticalerrorslist=/C:".*CUDA-capable.*" /C:".*No AMD OPENCL or NVIDIA CUDA GPUs found.*" /C:".*GPU .* hangs.*" /C:".*Restarting failed.*"
SET errorslist=/C:".*t.[0-5]C.*"
SET interneterrorslist=/C:".*Connection lost.*" /C:".*not resolve.*" /C:".*subscribe .*" /C:".*connect .*" /C:".*No properly.*" /C:".*Failed to get.*" /C:".*Job timeout, disconnect.*"
IF %cmddoubleruncheck% EQU 1 (
	tasklist.exe /V /NH /FI "imagename eq cmd.exe"| findstr.exe /V /R /C:".*Miner-autorun(%dt0%)"| findstr.exe /R /C:".*Miner-autorun.*" 2>NUL 1>&2 && (
		ECHO This script is already running...
		ECHO Current window will close in 10 seconds.
		timeout.exe /T 10 /nobreak >NUL
		EXIT
	)
)
:checkconfig
timeout.exe /T 3 /nobreak >NUL
IF NOT EXIST "%config%" GOTO createconfig
findstr.exe /C:"%ver%" %config% >NUL || (
	FOR /F "eol=# delims=" %%a IN (%config%) DO SET "%%a"
	timeout.exe /T 3 /nobreak >NUL
	CALL :inform "false" "0" "Your %config% is out of date." "2"
	GOTO createconfig
)
FOR %%A IN (%~n0.bat) DO IF %%~ZA LSS 39000 EXIT
FOR %%B IN (%config%) DO IF %%~ZB LSS 3450 GOTO corruptedconfig
FOR /F "eol=# delims=" %%a IN (%config%) DO SET "%%a"
timeout.exe /T 3 /nobreak >NUL
CALL :inform "false" "0" "%config% loaded." "2"
FOR %%A IN (gpus allowrestart hashrate commandserver1 overclockprogram msiaprofile msiatimeout restartoverclockprogram minertimeoutrestart computertimeoutrestart noonrestart noonrestart midnightrestart internetcheck environments sharetimeout rigname chatid everyhourinfo approgram approcessname approcesspath) DO IF NOT DEFINED %%A GOTO corruptedconfig
FOR /F "eol=# delims=" %%A IN ('findstr.exe /R /C:"commandserver.*" %config%') DO SET /A serversamount+=1
IF %queue% GTR %serversamount% SET queue=1
FOR /L %%A IN (1,1,%serversamount%) DO (
	FOR %%B IN (commandserver%%A) DO IF NOT DEFINED %%B GOTO corruptedconfig
)
GOTO start
:corruptedconfig
CALL :inform "false" "%config% file error. It is corrupted. Please check it..." "1" "1"
:createconfig
IF EXIST "%config%" MOVE /Y %config% Backup.ini >NUL && ECHO Created backup of your old %config%.
> %config% ECHO # Configuration file v. %ver%
>> %config% ECHO # =================================================== [GPU]
>> %config% ECHO # Set how many GPU devices are enabled.
>> %config% ECHO gpus=%gpus%
>> %config% ECHO # Allow computer restart if number of loaded GPUs is not equal to number of enabled GPUs. [0 - false, 1 - true]
>> %config% ECHO allowrestart=%allowrestart%
>> %config% ECHO # Set total average hashrate of this Rig. [you can use average hashrate value from your pool]
>> %config% ECHO hashrate=%hashrate%
>> %config% ECHO # =================================================== [Miner]
>> %config% ECHO # Set main server miner command here to auto-create %bat% file if it is missing or wrong. [keep default order]
>> %config% ECHO commandserver1=%commandserver1%
IF DEFINED commandserver2 >> %config% ECHO # When the main server fails, %~n0 will switch to the additional server below immediately. [in order]
IF DEFINED commandserver2 >> %config% ECHO # Configure miner command here. Old %bat% will be removed and a new one will be created with this value. [keep default order] internetcheck=1 required.
IF DEFINED commandserver2 >> %config% ECHO commandserver2=%commandserver2%
IF DEFINED commandserver3 >> %config% ECHO commandserver3=%commandserver3%
IF DEFINED commandserver4 >> %config% ECHO commandserver4=%commandserver4%
IF DEFINED commandserver5 >> %config% ECHO commandserver5=%commandserver5%
>> %config% ECHO # =================================================== [Overclock program]
>> %config% ECHO # Autorun and run-check of GPU Overclock program. [0 - false, 1 - true XTREMEGE, 2 - true AFTERBURNER, 3 - true GPUTWEAK, 4 - true PRECISION, 5 - true AORUSGE, 6 - true THUNDERMASTER]
>> %config% ECHO overclockprogram=%overclockprogram%
>> %config% ECHO # Additional option to auto-enable Overclock Profile for MSI Afterburner. Please, do not use this option if it is not needed. [0 - false, 1 - Profile 1, 2 - Profile 2, 3 - Profile 3, 4 - Profile 4, 5 - Profile 5]
>> %config% ECHO msiaprofile=%msiaprofile%
>> %config% ECHO # Set MSI Afterburner wait timer after start. Important on weak processors. [default - 120 sec, min value - 1 sec]
IF %gpus% GEQ 1 SET /A msiatimeout=%gpus%*15
>> %config% ECHO msiatimeout=%msiatimeout%
>> %config% ECHO # Allow Overclock programs to be restarted when miner is restarted. Please, do not use this option if it is not needed. [0 - false, 1 - true]
>> %config% ECHO restartoverclockprogram=%restartoverclockprogram%
>> %config% ECHO # =================================================== [Timers]
>> %config% ECHO # Restart MINER every X hours. Set value of hours delay between miner restarts. [0 - false, 1-999 - scheduled hours delay]
>> %config% ECHO minertimeoutrestart=%minertimeoutrestart%
>> %config% ECHO # Restart COMPUTER every X hours. Set value of hours delay between computer restarts. [0 - false, 1-999 - scheduled hours delay]
>> %config% ECHO computertimeoutrestart=%computertimeoutrestart%
>> %config% ECHO # Restart miner or computer every day at 12:00. [1 - true miner, 2 - true computer, 0 - false]
>> %config% ECHO noonrestart=%noonrestart%
>> %config% ECHO # Restart miner or computer every day at 00:00. [1 - true miner, 2 - true computer, 0 - false]
>> %config% ECHO midnightrestart=%midnightrestart%
>> %config% ECHO # =================================================== [Other]
>> %config% ECHO # Enable Internet connectivity check. [0 - false, 1 - true]
>> %config% ECHO # Disable Internet connectivity check only if you have difficulties with your connection. [ie. high latency, intermittent connectivity]
>> %config% ECHO internetcheck=%internetcheck%
>> %config% ECHO # Enable additional environments. Please do not use this option if it is not needed, or if you do not understand its function. [0 - false, 1 - true]
>> %config% ECHO # GPU_FORCE_64BIT_PTR 0, GPU_MAX_HEAP_SIZE 100, GPU_USE_SYNC_OBJECTS 1, GPU_MAX_ALLOC_PERCENT 100, GPU_SINGLE_ALLOC_PERCENT 100
>> %config% ECHO environments=%environments%
>> %config% ECHO # Enable last share timeout check. [0 - false, 1 - true]
>> %config% ECHO sharetimeout=%sharetimeout%
>> %config% ECHO # =================================================== [Telegram notifications]
>> %config% ECHO # To enable Telegram notifications enter here your chatid, from Telegram @FarmWatchBot. [0 - disable]
>> %config% ECHO chatid=%chatid%
>> %config% ECHO # Name your Rig. [in English, without special symbols]
>> %config% ECHO rigname=%rigname%
>> %config% ECHO # Enable hourly statistics through Telegram. [0 - false, 1 - true full, 2 - true full in silent mode, 3 - true short, 4 - true short in silent mode]
>> %config% ECHO everyhourinfo=%everyhourinfo%
>> %config% ECHO # =================================================== [Additional program]
>> %config% ECHO # Enable additional program check on startup. [ie. TeamViewer, Minergate, Storj etc] [0 - false, 1 - true]
>> %config% ECHO approgram=%approgram%
>> %config% ECHO # Process name of additional program. [Press CTRL+ALT+DEL to find the process name]
>> %config% ECHO approcessname=%approcessname%
>> %config% ECHO # Path to file of additional program. [ie. C:\Program Files\TeamViewer\TeamViewer.exe]
>> %config% ECHO approcesspath=%approcesspath%
CALL :inform "false" "0" "Default %config% created. Please check it." "2"
timeout.exe /T 3 /nobreak >NUL
GOTO hardstart
:ctimer
CLS
ECHO +================================================================+
ECHO             Scheduled computer restart, please wait...
ECHO                        Miner ran for %hrdiff%:%mediff%:%ssdiff%
ECHO                            Restarting...
ECHO +================================================================+
CALL :inform "false" "Scheduled computer restart, please wait..." "Scheduled computer restart, please wait... Miner ran for %hrdiff%:%mediff%:%ssdiff%." "0"
timeout.exe /T 3 /nobreak >NUL
:restart
COLOR 4F
CALL :screenshot
CALL :inform "false" "Computer restarting..." "1" "0"
CALL :kill "1" "1" "1" "1"
IF %pcrestart% EQU 1 shutdown.exe /T 30 /R /F /C "Your computer will restart after 30 seconds. To cancel restart, close this window and start %~n0.bat manually."
EXIT
:switch
CLS
ECHO +================================================================+
ECHO           Attempting to switch to the main pool server...
ECHO                        Miner ran for %hrdiff%:%mediff%:%ssdiff%
ECHO                         Miner restarting...
ECHO +================================================================+
CALL :inform "false" "Attempting to switch to the main pool server..." "Attempting to switch to the main pool server... Miner ran for %hrdiff%:%mediff%:%ssdiff%." "0"
SET switchtodefault=0
SET queue=1
timeout.exe /T 3 /nobreak >NUL
GOTO start
:mtimer
CLS
ECHO +================================================================+
ECHO               Scheduled miner restart, please wait...
ECHO                        Miner ran for %hrdiff%:%mediff%:%ssdiff%
ECHO                            Restarting...
ECHO +================================================================+
CALL :inform "false" "Scheduled miner restart, please wait..." "Scheduled miner restart, please wait... Miner ran for %hrdiff%:%mediff%:%ssdiff%." "0"
timeout.exe /T 3 /nobreak >NUL
GOTO start
:error
CLS
COLOR 4F
SET /A errorscounter+=1
IF %errorscounter% GTR %runtimeerrors% (
	ECHO +================================================================+
	ECHO              Too many errors, need clear GPU cash...
	ECHO                        Miner ran for %hrdiff%:%mediff%:%ssdiff%
	ECHO                       Computer restarting...
	ECHO +================================================================+
	CALL :inform "false" "Too many errors. A restart of the computer to clear GPU cache is required. Restarting..." "Too many errors. A restart of the computer to clear GPU cache is required. Restarting...  Miner ran for %hrdiff%:%mediff%:%ssdiff%." "0"
	timeout.exe /T 3 /nobreak >NUL
	GOTO restart
)
ECHO +================================================================+
ECHO                        Something is wrong...
ECHO                        Miner ran for %hrdiff%:%mediff%:%ssdiff%
ECHO                         Miner restarting...
ECHO +================================================================+
CALL :inform "false" "Miner restarting, please wait..." "Miner restarting, please wait... Miner ran for %hrdiff%:%mediff%:%ssdiff%." "0"
CALL :screenshot
timeout.exe /T 3 /nobreak >NUL
:start
SET chatid=%chatid: =%
SET gpus=%gpus: =%
SET hashrate=%hashrate: =%
IF %environments% EQU 1 FOR %%a IN ("GPU_FORCE_64BIT_PTR 0" "GPU_MAX_HEAP_SIZE 100" "GPU_USE_SYNC_OBJECTS 1" "GPU_MAX_ALLOC_PERCENT 100" "GPU_SINGLE_ALLOC_PERCENT 100") DO SETX %%~a 2>NUL 1>&2 && ECHO %%~a.
IF %environments% EQU 0 FOR %%a IN ("GPU_FORCE_64BIT_PTR" "GPU_MAX_HEAP_SIZE" "GPU_USE_SYNC_OBJECTS" "GPU_MAX_ALLOC_PERCENT" "GPU_SINGLE_ALLOC_PERCENT") DO REG DELETE HKCU\Environment /F /V %%~a 2>NUL 1>&2 && ECHO %%~a successfully removed from environments.
FOR /F "tokens=1 delims=." %%A IN ('wmic.exe OS GET localdatetime^|Find "."') DO SET dt1=%%A
SET mh1=1%dt1:~4,2%
SET dy1=1%dt1:~6,2%
SET hr1=1%dt1:~8,2%
SET me1=1%dt1:~10,2%
SET ss1=1%dt1:~12,2%
SET /A mh1=%mh1%-100
SET /A dy1=%dy1%-100
SET /A hr1=%hr1%-100
SET /A me1=%me1%-100
SET /A ss1=%ss1%-100
SET /A dtdiff1=%hr1%*60*60+%me1%*60+%ss1%
IF NOT EXIST "%minerpath%" (
	ECHO "%minerprocess%" is missing. Please check the directory for missing files. Exiting...
	PAUSE
	EXIT
)
tasklist.exe /FI "IMAGENAME eq werfault.exe" 2>NUL| find.exe /I /N "werfault.exe" >NUL && CALL :killwerfault
tasklist.exe /FI "IMAGENAME eq %minerprocess%" 2>NUL| find.exe /I /N "%minerprocess%" >NUL && (
	taskkill.exe /T /F /IM "%minerprocess%" 2>NUL 1>&2 && (
		timeout.exe /T 4 /nobreak >NUL && taskkill.exe /F /FI "IMAGENAME eq cmd.exe" /FI "WINDOWTITLE eq %bat%*" 2>NUL 1>&2
		CALL :inform "false" "0" "Process %minerprocess% was successfully killed." "2"
	) || (
		CALL :inform "false" "Unable to kill %minerprocess%. Retrying..." "1" "1"
		GOTO error
	)
)
ECHO Please wait 30 seconds or press any key to continue...
timeout.exe /T 30 >NUL
IF NOT EXIST "Logs" MD Logs && ECHO Folder Logs created.
IF NOT EXIST "Screenshots" MD Screenshots && ECHO Folder Screenshots created.
IF %overclockprogram% GEQ 1 IF %overclockprogram% LEQ 6 (
	FOR /F "tokens=%overclockprogram% delims= " %%A IN ("Xtreme MSIAfterburner GPUTweakII PrecisionX_x64 AORUS THPanel") DO (
		SET overclockprocessname=%%A
	)
	FOR /F "tokens=%overclockprogram% delims=," %%A IN ("\GIGABYTE\XTREME GAMING ENGINE\,\MSI Afterburner\,\ASUS\GPU TweakII\,\EVGA\Precision XOC\,\GIGABYTE\AORUS GRAPHICS ENGINE\,\Thunder Master\") DO (
		SET overclockprocesspath=%%A
	)
)
IF DEFINED overclockprocessname IF DEFINED overclockprocesspath IF NOT EXIST "%programfiles(x86)%%overclockprocesspath%" (
	ECHO Incorrect path to %overclockprocessname%.exe. Default install path required to function. Please reinstall the software using the default path.
	SET overclockprogram=0
)
IF %overclockprogram% NEQ 0 (
	IF %firstrun% NEQ 0 IF %restartoverclockprogram% EQU 1 (
		tskill.exe /A /V %overclockprocessname% 2>NUL 1>&2 
		CALL :inform "false" "0" "Process %overclockprocessname%.exe was successfully killed." "2"
	)
	timeout.exe /T 5 /nobreak >NUL
	tasklist.exe /FI "IMAGENAME eq %overclockprocessname%.exe" 2>NUL| find.exe /I /N "%overclockprocessname%.exe" >NUL || (
		START "" "%programfiles(x86)%%overclockprocesspath%%overclockprocessname%.exe" && (
			CALL :inform "false" "%overclockprocessname%.exe was started." "1" "1"
			SET firstrun=0
		) || (
			CALL :inform "false" "Unable to start %overclockprocessname%.exe." "1" "1"
			SET overclockprogram=0
			GOTO error
		)
	)
)
IF %msiaprofile% GEQ 1 IF %msiaprofile% LEQ 5 IF %overclockprogram% EQU 2 (
	IF %firstrun% EQU 0 (
		ECHO Waiting %msiatimeout% sec. for the full load of Msi Afterburner...
		timeout.exe /T %msiatimeout% >NUL
	)
	"%programfiles(x86)%%overclockprocesspath%%overclockprocessname%.exe" -Profile%msiaprofile% >NUL && ECHO MSI Afterburner profile %msiaprofile% activated.
	SET firstrun=1
)
IF %approgram% NEQ 0 IF NOT EXIST "%approcesspath%" (
	ECHO Incorrect path to %approcessname%.
	SET approgram=0
)
IF %approgram% NEQ 0 (
	timeout.exe /T 5 /nobreak >NUL
	tasklist.exe /FI "IMAGENAME eq %approcessname%" 2>NUL| find.exe /I /N "%approcessname%" >NUL || (
		START /MIN "%approcessname%" "%approcesspath%" && (
			CALL :inform "false" "%approcessname% was started." "1" "1"
		) || (
			CALL :inform "false" "Unable to start %approcessname%." "1" "1"
			SET approgram=0
			GOTO error
		)
	)
)
IF EXIST "%log%" (
	MOVE /Y %log% Logs\miner_%mh1%.%dy1%_%hr1%.%me1%.log 2>NUL 1>&2 && (
		CALL :inform "false" "0" "%log% moved to Logs folder as miner_%mh1%.%dy1%_%hr1%.%me1%.log" "2"
		IF EXIST "%~dp0Logs\*.log" FOR /F "skip=50 usebackq delims=" %%a IN (`DIR /B /A:-D /O:-D /T:W "%~dp0Logs\"`) DO DEL /F /Q "%~dp0Logs\%%~a" >NUL
		IF EXIST "%~dp0Logs\*.jpg" FOR /F "skip=50 usebackq delims=" %%a IN (`DIR /B /A:-D /O:-D /T:W "%~dp0Screenshots\"`) DO DEL /F /Q "%~dp0Screenshots\%%~a" >NUL
	) || (
		CALL :inform "false" "Unable to rename or access %log%. Attempting to delete %log% and continue..." "1" "1"
		DEL /Q /F "%log%" >NUL
		IF EXIST "%log%" (
			CALL :inform "false" "Unable to delete %log%." "1" "1"
			GOTO error
		)
	)
)
> %bat% ECHO @ECHO off
>> %bat% ECHO TITLE %bat%
>> %bat% ECHO REM Configure miners command line in %config% file. Not in %bat%.
IF %queue% GEQ 1 IF %queue% LEQ %serversamount% >> %bat% ECHO !commandserver%queue%!
REM Default pool server settings for debugging. Will be activated only in case of mining failed on all user pool servers, to detect errors. Will be deactivated automatically in 30 minutes and switched back to settings of main pool server.
IF %queue% EQU 0 >> %bat% ECHO %minerpath% -epool eu1.ethermine.org:4444 -ewal 0x4a98909270621531dda26de63679c1c6fdcf32ea.fr190 -epsw x -dpool stratum+tcp://sia-eu1.nanopool.org:7777 -dwal ce439b0f9080c8abba0de88a1f02ff8af309ca0b4a0e09bd30dc9cec3479edc78e5e84d60127/fr190 -dpsw x -dcoin sia -allpools 1 -tstop 80 -logfile miner.log -wd 0
>> %bat% ECHO EXIT
timeout.exe /T 3 /nobreak >NUL
START "%bat%" "%bat%" && (
	CALL :inform "false" "Miner was started." "Miner was started. Script v.%ver%." "Miner was started at %Time:~-11,8%"
	FOR /F "tokens=3,4 delims=/:= " %%a IN ('findstr.exe /R /C:".*%minerprocess%" %bat%') DO (
		ECHO %%b| findstr.exe /V /I /R /C:".*stratum.*" /C:".*ssl.*" /C:".*tcp.*" /C:".*http.*" /C:".*https.*"| findstr.exe /R /C:".*\..*" >NUL && (
			SET curservername=%%b
		) || (
			ECHO %%a| findstr.exe /V /I /R /C:".*stratum.*" /C:".*ssl.*" /C:".*tcp.*" /C:".*http.*" /C:".*https.*"| findstr.exe /R /C:".*\..*" >NUL && (
				SET curservername=%%a
			)
		)
	)
	timeout.exe /T 5 /nobreak >NUL
) || (
	CALL :inform "false" "Unable to start miner." "1" "1"
	GOTO error
)
IF NOT DEFINED curservername SET curservername=unknown
IF NOT EXIST "%log%" (
	findstr.exe /R /C:".*-logfile %log%.*" %bat% 2>NUL 1>&2 || (
		CALL :inform "false" "%log% is missing. Ensure *-logfile %log%* option is added to the miners command line." "%log% is missing. Ensure -logfile %log% option is added to the miners command line." "2"
		GOTO error
	)
	CALL :inform "false" "%minerprocess% hangs..." "1" "1"
	GOTO restart
) ELSE (
	findstr.exe /R /C:".*%minerprocess% -epool.*-tstop.*-logfile %log%.*" %bat% 2>NUL 1>&2 || (
		CALL :inform "false" "Ensure *%minerpath% -epool -tstop -logfile %log%* options added to the miners command line in this order." "Ensure %minerpath% -epool -tstop -logfile %log% options added to the miners command line in this order." "2"
	)
	ECHO log monitoring started.
	ECHO Collecting information. Please wait...
	timeout.exe /T 25 /nobreak >NUL
)
SET hashrateerrorscount=0
SET oldhashrate=0
SET firstrun=0
SET gpucount=0
:check
SET interneterrorscount=1
SET lastinterneterror=0
SET minhashrate=0
SET hashcount=0
SET lasterror=0
SET sumresult=0
SET sumhash=0
FOR /F "tokens=1 delims=." %%A IN ('wmic.exe OS GET localdatetime^|Find "."') DO SET dt2=%%A
SET mh2=1%dt2:~4,2%
SET dy2=1%dt2:~6,2%
SET hr2=1%dt2:~8,2%
SET me2=1%dt2:~10,2%
SET ss2=1%dt2:~12,2%
SET /A mh2=%mh2%-100
SET /A dy2=%dy2%-100
SET /A hr2=%hr2%-100
SET /A me2=%me2%-100
SET /A ss2=%ss2%-100
SET /A dtdiff2=%hr2%*60*60+%me2%*60+%ss2%
SET /A nextreqtime=%me2%+7
IF %ptos% GTR %nextreqtime% SET ptos=0
IF %dy2% GTR %dy1% (
	SET /A dtdiff=^(%dy2%-%dy1%^)*86400-%dtdiff1%+%dtdiff2%
) ELSE (
	IF %mh2% NEQ %mh1% (
		CALL :inform "false" "Miner must be restarted, please wait..." "1" "1"
		GOTO hardstart
	)
	IF %dtdiff2% GEQ %dtdiff1% (
		SET /A dtdiff=%dtdiff2%-%dtdiff1%
	) ELSE (
		SET /A dtdiff=%dtdiff1%-%dtdiff2%
	)
)
SET /A hrdiff=%dtdiff%/60/60
SET /A mediff=%dtdiff% %% 3600/60
SET /A ssdiff=%dtdiff% %% 60
IF %hrdiff% LSS 10 SET hrdiff=0%hrdiff%
IF %mediff% LSS 10 SET mediff=0%mediff%
IF %ssdiff% LSS 10 SET ssdiff=0%ssdiff%
IF %midnightrestart% EQU 1 IF %dy2% NEQ %dy1% GOTO mtimer
IF %midnightrestart% EQU 2 IF %dy2% NEQ %dy1% GOTO ctimer
IF %minertimeoutrestart% GEQ 1 IF %hrdiff% GEQ %minertimeoutrestart% GOTO mtimer
IF %computertimeoutrestart% GEQ 1 IF %hrdiff% GEQ %computertimeoutrestart% GOTO ctimer
IF %hrdiff% GEQ 1 IF %hr2% EQU 12 (
	IF %noonrestart% EQU 1 GOTO mtimer
	IF %noonrestart% EQU 2 GOTO ctimer
)
IF %hrdiff% EQU 0 IF %mediff% GEQ 30 IF %switchtodefault% EQU 1 GOTO switch
IF %hrdiff% GEQ 96 (
	CALL :inform "false" "Miner must be restarted, large log file size, please wait..." "1" "1"
	GOTO hardstart
)
timeout.exe /T %cputimeout% /nobreak >NUL
FOR /F "delims=" %%N IN ('findstr.exe /I /R %criticalerrorslist% %errorslist% %warningslist% %interneterrorslist% %log% ^| findstr.exe /V /R /I /C:".*DevFee.*" /C:".*DCR.*" /C:".*SC.*" /C:".*LBC.*" /C:".*PASC.*"') DO SET lasterror=%%N
IF "%lasterror%" NEQ "0" (
	IF %internetcheck% EQU 1 (
		ECHO %lasterror%| findstr.exe /I /R %interneterrorslist% 2>NUL 1>&2 && (
			FOR /F "delims=" %%n IN ('findstr.exe /I /R %interneterrorslist% %errorscancel% %log% ^| findstr.exe /V /R /I /C:".*DevFee.*" /C:".*DCR.*" /C:".*SC.*" /C:".*LBC.*" /C:".*PASC.*"') DO SET lastinterneterror=%%n
			ECHO !lastinterneterror!| findstr.exe /I /R %interneterrorslist% >NUL && (
				ECHO Something is wrong with your Internet. Waiting for confirmation...
				timeout.exe /T 120 /nobreak >NUL
				FOR /F "delims=" %%n IN ('findstr.exe /I /R %interneterrorslist% %errorscancel% %log% ^| findstr.exe /V /R /I /C:".*DevFee.*" /C:".*DCR.*" /C:".*SC.*" /C:".*LBC.*" /C:".*PASC.*"') DO SET lastinterneterror=%%n
				ECHO !lastinterneterror!| findstr.exe /I /R %interneterrorslist% >NUL && (
					CALL :inform "false" "%lasterror%" "1" "0"
					ping.exe %pingserver%| find.exe /I "TTL=" >NUL && (
						CLS
						COLOR 4F
						CALL :kill "0" "0" "1" "1"
						SET switchtodefault=1
						SET /A queue+=1
						SET /A errorscounter+=1
						ECHO +================================================================+
						ECHO       Check %config% file for errors or pool is offline...
						ECHO                        Miner ran for %hrdiff%:%mediff%:%ssdiff%
						ECHO               Miner restarting with default values...
						ECHO +================================================================+
						IF !queue! GTR %serversamount% SET queue=0
						CALL :inform "false" "Pool server was switched to *!queue!*. Please check your *%config%* file carefully for spelling errors or incorrect parameters. Otherwise check if the pool you are connecting to is online." "Pool server was switched to !queue!. Please check your %config% file carefully for spelling errors or incorrect parameters. Otherwise check if the pool you are connecting to is online." "2"
						GOTO start
					) || (
						CALL :inform "false" "Something is wrong with your Internet. Please check your connection." "Something is wrong with your Internet. Please check your connection. Miner ran for %hrdiff%:%mediff%:%ssdiff%." "0"
						:tryingreconnect
						CLS
						COLOR 4F
						ECHO +================================================================+
						ECHO               Something is wrong with your Internet...
						ECHO                        Miner ran for %hrdiff%:%mediff%:%ssdiff%
						ECHO                      Attempting to reconnect...
						ECHO +================================================================+
						IF %hrdiff% EQU 0 IF %mediff% GEQ 15 IF %interneterrorscount% GTR 10 GOTO restart
						IF %interneterrorscount% GTR 60 GOTO restart
						ECHO Attempt %interneterrorscount% to restore Internet connection.
						SET /A interneterrorscount+=1
						FOR /F "delims=" %%n IN ('findstr.exe /I /R %interneterrorslist% %errorscancel% %log% ^| findstr.exe /V /R /I /C:".*DevFee.*" /C:".*DCR.*" /C:".*SC.*" /C:".*LBC.*" /C:".*PASC.*"') DO SET lastinterneterror=%%n
						ECHO !lastinterneterror!| findstr.exe /I /R %errorscancel% && (
							ECHO +================================================================+
							ECHO                   Connection has been restored...
							ECHO                         Continue mining...
							ECHO +================================================================+
							CALL :inform "false" "Something was wrong with your Internet. Connection has been restored. Continue mining..." "1" "0"
							GOTO check
						)
						ping.exe %pingserver%| find.exe /I "TTL=" >NUL && GOTO reconnected || (
							timeout.exe /T 60 /nobreak >NUL
							GOTO tryingreconnect
						)
						:reconnected
						ECHO +================================================================+
						ECHO                   Connection has been restored...
						ECHO                         Miner restarting...
						ECHO +================================================================+
						CALL :inform "false" "Something was wrong with your Internet. Connection has been restored. Miner restarting..." "Something was wrong with your Internet. Connection has been restored. Miner restarting... Miner ran for %hrdiff%:%mediff%:%ssdiff%." "0"
						GOTO start
					)
				)
			)
		)
	)
	ECHO %lasterror%| findstr.exe /I /R %errorslist% 2>NUL && (
		CALL :inform "false" "%lasterror%" "1" "0"
		GOTO error
	)
	ECHO %lasterror%| findstr.exe /I /R %criticalerrorslist% 2>NUL && (
		CALL :inform "false" "%lasterror%" "1" "0"
		GOTO restart
	)
	ECHO %lasterror%| findstr.exe /I /R %warningslist% 2>NUL && (
		CLS
		COLOR 4F
		ECHO +================================================================+
		ECHO                     Temperature limit reached...
		ECHO                        Miner ran for %hrdiff%:%mediff%:%ssdiff%
		ECHO +================================================================+
		CALL :inform "false" "0" "%curtemp%." "2"
		IF %hrdiff% EQU 0 IF %mediff% LEQ 10 (
			CALL :kill "1" "1" "1" "1"
			CALL :inform "false" "Current temp: %curtemp%.%%%%0A%%%%0ATemperature limit reached. Process %minerprocess% was successfully killed. GPUs will now *STOP MINING*. Please ensure your GPUs have enough air flow.%%%%0A%%%%0A*Waiting for users input...*" "Please ensure your GPUs have enough air flow. GPUs will now STOP MINING. Miner ran for %hrdiff%:%mediff%:%ssdiff%." "Please ensure your GPUs have enough air flow. GPUs will now STOP MINING. Waiting for users input..."
			SET waituserinput=1
			GOTO hardstart
		)
		CALL :inform "false" "%curtemp%.%%%%0A%%%%0ATemperature limit reached. Fans may be stuck. Attempting to restart computer..." "Temperature limit reached. Fans may be stuck." "2"
		GOTO restart
	)
)
timeout.exe /T %cputimeout% /nobreak >NUL
tasklist.exe /FI "IMAGENAME eq werfault.exe" 2>NUL| find.exe /I /N "werfault.exe" >NUL && CALL :killwerfault
tasklist.exe /FI "IMAGENAME eq %minerprocess%" 2>NUL| find.exe /I /N "%minerprocess%" >NUL || (
	CALL :inform "false" "Process %minerprocess% crashed." "1" "1"
	GOTO error
)
IF %overclockprogram% NEQ 0 (
	timeout.exe /T %cputimeout% /nobreak >NUL
	tasklist.exe /FI "IMAGENAME eq %overclockprocessname%.exe" 2>NUL| find.exe /I /N "%overclockprocessname%.exe" >NUL || (
		CALL :inform "false" "Process %overclockprocessname%.exe crashed." "1" "1"
		GOTO error
	)
)
IF %approgram% EQU 1 (
	timeout.exe /T %cputimeout% /nobreak >NUL
	tasklist.exe /FI "IMAGENAME eq %approcessname%" 2>NUL| find.exe /I /N "%approcessname%" >NUL || (
		CALL :inform "false" "%approcessname% crashed." "1" "1"
		START /MIN "%approcessname%" "%approcesspath%" && (
			CALL :inform "false" "%approcessname% was started." "1" "1"
		) || (
			CALL :inform "false" "Unable to start %approcessname%." "1" "1"
			SET approgram=0
			GOTO error
		)
	)
)
IF %firstrun% EQU 0 (
	timeout.exe /T %cputimeout% /nobreak >NUL
	FOR /F "tokens=3 delims= " %%A IN ('findstr.exe /R /C:"Total cards: .*" %log%') DO SET /A gpucount=%%A
	IF !gpucount! EQU 0 SET gpucount=1
	IF %gpus% EQU 0 SET gpus=!gpucount!
)
IF %firstrun% EQU 0 (
	IF %gpus% GTR %gpucount% (
		IF %allowrestart% EQU 1 (
			CLS
			COLOR 4F
			ECHO +================================================================+
			ECHO              Failed load all GPUs. Number of GPUs: !gpucount!/%gpus%
			ECHO                        Miner ran for %hrdiff%:%mediff%:%ssdiff%
			ECHO                       Computer restarting...
			ECHO +================================================================+
			CALL :inform "false" "Failed load all GPUs. Number of GPUs *%gpucount%/%gpus%*." "Failed load all GPUs. Number of GPUs %gpucount%/%gpus%." "2"
			GOTO restart
		) ELSE (
			CALL :inform "false" "Failed load all GPUs. Number of GPUs *%gpucount%/%gpus%*." "Failed load all GPUs. Number of GPUs %gpucount%/%gpus%." "2"
			SET /A hashrate=%hashrate%/%gpus%*%gpucount%
		)
	)
	IF %gpus% LSS %gpucount% (
		CALL :inform "false" "Loaded too many GPUs. This must be set to a number higher than *%gpus%* in your *%config%* file under *gpus*. Number of GPUs *%gpucount%/%gpus%*." "Loaded too many GPUs. This must be set to a number higher than %gpus% in your %config% file under gpus. Number of GPUs: %gpucount%/%gpus%." "2"
		IF %allowrestart% EQU 1 GOTO restart
	)
	SET firstrun=1
)
timeout.exe /T %cputimeout% /nobreak >NUL
FOR /F "tokens=5 delims=. " %%A IN ('findstr.exe /R /C:".*- Total Speed: .* Mh/s.*" %log% ^| findstr.exe /V /R /I /C:".*DevFee.*" /C:".*DCR.*" /C:".*SC.*" /C:".*LBC.*" /C:".*PASC.*"') DO (
	SET lasthashrate=%%A
	IF %%A LSS %hashrate% SET /A minhashrate+=1
	IF %%A EQU 0 SET /A minhashrate+=1
	SET /A hashcount+=1
	SET /A sumhash=sumhash+%%A
	SET /A sumresult=sumhash/hashcount
	IF !minhashrate! GEQ 99 GOTO passaveragecheck
)
timeout.exe /T %cputimeout% /nobreak >NUL
FOR /F "delims=" %%A IN ('findstr.exe /R /C:".*GPU.* t=.*C fan=.*" %log%') DO SET curtempcash=%%A
IF DEFINED curtempcash (
	FOR /F "tokens=2,5,8,11,14,17,20,23,26,29 delims=,tC " %%a IN ("%curtempcash%") DO (
		SET curtemp=Current temp:
		SET gpunum=0
		IF !gpunum! LEQ %gpus% (
			FOR %%A IN (%%a %%b %%c %%d %%e %%f %%g %%h %%i %%j) DO (
				IF "%%A" NEQ "" (
					SET Cut=%%A
					SET Cut=!Cut:~-2!
					IF !Cut! GEQ 0 IF !Cut! LSS 70 SET curtemp=!curtemp! G!gpunum! !Cut!C,
					IF !Cut! GEQ 70 SET curtemp=!curtemp! G!gpunum! *!Cut!C*,
				)
				SET /A gpunum+=1
			)
		)
		IF "!curtemp!" EQU "Current temp:" SET curtemp=unknown
		IF "!curtemp!" NEQ "unknown" SET curtemp=!curtemp:~0,-1!
	)
)
timeout.exe /T %cputimeout% /nobreak >NUL
FOR /F "delims=" %%A IN ('findstr.exe /R /C:".*GPU.* .* Mh/s.*" %log% ^| findstr.exe /V /R /I /C:".*DevFee.*" /C:".*DCR.*" /C:".*SC.*" /C:".*LBC.*" /C:".*PASC.*"') DO SET curspeedcash=%%A
IF DEFINED curspeedcash (
	FOR /F "tokens=3,6,9,12,15,18,21,24,27,30 delims=.,Mh/s " %%a IN ("%curspeedcash%") DO (
		SET curspeed=Current speed:
		SET gpunum=0
		IF !gpunum! LEQ %gpus% (
			FOR %%A IN (%%a %%b %%c %%d %%e %%f %%g %%h %%i %%j) DO (
				IF "%%A" NEQ "" IF %%A GEQ 0 SET curspeed=!curspeed! G!gpunum! %%A,
				SET /A gpunum+=1
			)
		)
		IF "!curspeed!" EQU "Current speed:" SET curspeed=unknown
		IF "!curspeed!" NEQ "unknown" SET curspeed=!curspeed:~0,-1!
		ECHO !curspeed!| findstr.exe /R /C:".* 0 .*" 2>NUL 1>&2 && SET /A minhashrate+=1
		IF !minhashrate! GEQ 99 GOTO passaveragecheck
	)
)
timeout.exe /T %cputimeout% /nobreak >NUL
IF "%sumresult%" NEQ "0" IF %sumresult% LSS %oldhashrate% IF %sumresult% LSS %hashrate% (
	IF %hashrateerrorscount% GEQ %hashrateerrors% (
		:passaveragecheck
		CALL :inform "false" "Low hashrate. Average: *%sumresult%/%hashrate%* Last: *%lasthashrate%/%hashrate%*." "Low hashrate. Average: %sumresult%/%hashrate% Last: %lasthashrate%/%hashrate%." "2"
		GOTO error
	)
	CALL :inform "false" "Abnormal hashrate. Average: *%sumresult%/%hashrate%* Last: *%lasthashrate%/%hashrate%*." "Abnormal hashrate. Average: %sumresult%/%hashrate% Last: %lasthashrate%/%hashrate%." "2"
	SET /A hashrateerrorscount+=1
)
IF "%sumresult%" NEQ "0" IF %sumresult% NEQ %oldhashrate% SET oldhashrate=%sumresult%
IF %sharetimeout% EQU 1 IF %ptos% LSS %me2% (
	timeout.exe /T %cputimeout% /nobreak >NUL
	SET /A ptos=%me2%+7
	SET lastsharediff=0
	SET lastsharemin=1%dt1:~10,2%
	FOR /F "tokens=2 delims=:" %%A IN ('findstr.exe /R /C:".*SHARE FOUND.*" /C:".*Share accepted.*" %log%') DO SET lastsharemin=1%%A
	SET /A lastsharemin=!lastsharemin!-100
	IF !lastsharemin! GEQ 0 IF %me2% GTR 0 (
		IF !lastsharemin! EQU 0 SET lastsharemin=59
		IF !lastsharemin! LSS %me2% SET /A lastsharediff=%me2%-!lastsharemin!
		IF !lastsharemin! GTR %me2% SET /A lastsharediff=!lastsharemin!-%me2%
		IF !lastsharemin! GTR 50 IF %me2% LEQ 10 SET /A lastsharediff=60-!lastsharemin!+%me2%
		IF !lastsharemin! LEQ 10 IF %me2% GTR 50 SET /A lastsharediff=60-%me2%+!lastsharemin!
		IF !lastsharediff! GTR 10 (
			CALL :inform "false" "Long share timeout... *!lastsharemin!/%me2%*." "Long share timeout... !lastsharemin!/%me2%." "2"
			GOTO error
		)
	)
)
IF NOT DEFINED curtemp SET curtemp=unknown
IF NOT DEFINED curspeed SET curspeed=unknown
CLS
COLOR 1F
ECHO +================================================================+
ECHO            AutoRun v.%ver% for %mn% Miner - by Acrefawn
ECHO           ETH: 0x4a98909270621531dda26de63679c1c6fdcf32ea
ECHO               BTC: 1wdJBYkVromPoiYk82JfSGSSVVyFJnenB
ECHO +============================================================[%Time:~-5,2%]+
ECHO Process %minerprocess% is running...
IF "%curservername%" NEQ "unknown" ECHO Server: %curservername%
IF "%curtemp%" NEQ "unknown" ECHO %curtemp%.
IF "%curspeed%" NEQ "unknown" ECHO %curspeed%.
ECHO +================================================================+
IF %overclockprogram% NEQ 0 ECHO Process %overclockprocessname%.exe is running...
IF %overclockprogram% EQU 0 ECHO GPU Overclock monitor: Disabled
IF %msiaprofile% GEQ 1 IF %msiaprofile% LEQ 5 IF %overclockprogram% EQU 2 ECHO MSI Afterburner profile: %msiaprofile%
IF "%midnightrestart%" EQU "0" ECHO Autorestart at 00:00: Disabled
IF "%midnightrestart%" NEQ "0" ECHO Autorestart at 00:00: Enabled
IF "%noonrestart%" EQU "0" ECHO Autorestart at 12:00: Disabled
IF "%noonrestart%" NEQ "0" ECHO Autorestart at 12:00: Enabled
IF "%minertimeoutrestart%" EQU "0" ECHO Autorestart miner every hour: Disabled
IF "%minertimeoutrestart%" NEQ "0" ECHO Autorestart miner every hour: %minertimeoutrestart%
IF "%computertimeoutrestart%" EQU "0" ECHO Autorestart computer every hour: Disabled
IF "%computertimeoutrestart%" NEQ "0" ECHO Autorestart computer every hour: %computertimeoutrestart%
IF %sharetimeout% EQU 0 ECHO Last share timeout: Disabled
IF %sharetimeout% EQU 1 ECHO Last share timeout: Enabled
IF "%chatid%" EQU "0" ECHO Telegram notifications: Disabled
IF "%chatid%" NEQ "0" ECHO Telegram notifications: %chatid%
IF "%approgram%" EQU "0" ECHO Additional program autorun: Disabled
IF "%approgram%" EQU "1" ECHO Additional program autorun: %approcessname%
ECHO +================================================================+
ECHO            Runtime errors: %errorscounter%/%runtimeerrors% Hashrate errors: %hashrateerrorscount%/%hashrateerrors% %minhashrate%/99
ECHO                 GPUs: %gpucount%/%gpus% Last share timeout: %lastsharediff%/15
IF "%sumresult%" NEQ "0" IF DEFINED lasthashrate ECHO                Average speed: %sumresult% Last speed: %lasthashrate%
ECHO                        Miner ran for %hrdiff%:%mediff%:%ssdiff%
ECHO +================================================================+
ECHO Now I will take care of your %rigname% and you can take a rest.
SET statusmessage=Running for *%hrdiff%:%mediff%:%ssdiff%*
IF "%curservername%" NEQ "unknown" SET statusmessage=%statusmessage% on %curservername%
IF "%sumresult%" NEQ "0" SET statusmessage=%statusmessage%%%%%0AAverage total hashrate: *%sumresult%*
IF DEFINED lasthashrate SET statusmessage=%statusmessage%%%%%0ALast total hashrate: *%lasthashrate%*
IF "%curspeed%" NEQ "unknown" SET statusmessage=%statusmessage%%%%%0A%curspeed%
IF "%curtemp%" NEQ "unknown" SET statusmessage=%statusmessage%%%%%0A%curtemp%
IF "%chatid%" NEQ "0" (
	IF %me2% LSS 30 SET allowsend=1
	IF %me2% GEQ 30 IF %allowsend% EQU 1 (
		IF %everyhourinfo% EQU 1 CALL :inform "false" "%statusmessage%" "0" "0"
		IF %everyhourinfo% EQU 2 CALL :inform "true" "%statusmessage%" "0" "0"
		IF %everyhourinfo% EQU 3 CALL :inform "false" "Online, *%hrdiff%:%mediff%:%ssdiff%*, *%lasthashrate%*" "0" "0"
		IF %everyhourinfo% EQU 4 CALL :inform "true" "Online, *%hrdiff%:%mediff%:%ssdiff%*, *%lasthashrate%*" "0" "0"
		SET allowsend=0
	)
)
GOTO check
:screenshot
powershell.exe -command "Add-Type -AssemblyName System.Windows.Forms; Add-type -AssemblyName System.Drawing; $Screen = [System.Windows.Forms.SystemInformation]::VirtualScreen; $bitmap = New-Object System.Drawing.Bitmap $Screen.Width, $Screen.Height; $graphic = [System.Drawing.Graphics]::FromImage($bitmap); $graphic.CopyFromScreen($Screen.Left, $Screen.Top, 0, 0, $bitmap.Size); $bitmap.Save('Screenshots\miner_%mh1%.%dy1%_%hr1%.%me1%.jpg');" 2>NUL 1>&2
EXIT /b
:kill
IF "%~1" EQU "1" IF %overclockprogram% NEQ 0 timeout.exe /T 2 /nobreak >NUL && taskkill.exe /T /F /IM "%overclockprocessname%" 2>NUL 1>&2 && ECHO Process %overclockprocessname% was successfully killed.
IF "%~2" EQU "1" IF %approgram% EQU 1 timeout.exe /T 2 /nobreak >NUL && taskkill.exe /F /IM "%approcessname%" 2>NUL 1>&2 && ECHO Process %approcessname% was successfully killed.
IF "%~3" EQU "1" timeout.exe /T 2 /nobreak >NUL && taskkill.exe /T /F /IM "%minerprocess%" 2>NUL 1>&2 && ECHO Process %minerprocess% was successfully killed.
IF "%~4" EQU "1" timeout.exe /T 4 /nobreak >NUL && taskkill.exe /T /F /FI "IMAGENAME eq cmd.exe" /FI "WINDOWTITLE eq *%bat%*" 2>NUL 1>&2
EXIT /b
:killwerfault
taskkill.exe /T /F /IM "werfault.exe" 2>NUL 1>&2 && ECHO Process werfault.exe was successfully killed.
tskill.exe /A /V werfault 2>NUL 1>&2 && ECHO Process werfault.exe was successfully killed.
EXIT /b
:inform
IF "%~4" NEQ "0" IF "%~4" NEQ "1" IF "%~4" NEQ "2" ECHO %~4
IF "%~4" EQU "1" ECHO %~2
IF "%~4" EQU "2" ECHO %~3
IF "%~3" NEQ "0" IF "%~3" NEQ "1" >> %~n0.log ECHO [%Date%][%Time:~-11,8%] %~3
IF "%~3" EQU "1" >> %~n0.log ECHO [%Date%][%Time:~-11,8%] %~2
IF "%~2" NEQ "0" IF "%chatid%" NEQ "0" powershell.exe -command "(new-object net.webclient).DownloadString('https://api.telegram.org/bot%num%:%prt%-%rtp%dp%tpr%/sendMessage?parse_mode=markdown&disable_notification=%~1&chat_id=%chatid%&text=*%rigname%:* %~2')" 2>NUL 1>&2
EXIT /b