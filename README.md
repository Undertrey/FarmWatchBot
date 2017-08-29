Instruction:
1. Create an autorun.bat file.
2. Follow the link at the top of this post, copy the entire script code into the autorun.bat file.
3. Move autorun.bat to the folder with EWBF miner, click on autorun.bat 2 times LMB (without any administrator rights).
4. autorun.bat creates config.bat.
5. Close autorun.bat, open config.bat. In it, you can configure the program as you will be comfortable, using notepad, manually. Check, configure.
6. I advise you to delete your old batch file to run the miner. Autorun.bat will create a new one, with the settings that you set in config.bat!
7. Run autorun.bat and everything works!
8. Do not forget add autorun.bat shortcut to autorun folder. (WIN+R shell:startup)

Telegram instruction (for 1 user):
1. [Add a bot to Telegram](https://t.me/ZcashMinerAutorunBot), this bot will send you notifications from your Zcash farm.
2. [Add another bot](https://t.me/get_id_bot), it will tell you the Chat ID number, write this number in config.bat, in the ChatId field, instead of 000000000. This bot can be deleted, it is no longer needed.
3. [Download "cURL"](https://goo.gl/b7N6qV). Else you can download from the [cURL site's](https://curl.haxx.se). You need the latest version of Win64 x86_64 7zip with Binary SSL SSH. [What is cURL?](https://en.wikipedia.org/wiki/CURL). Specifically in our case, it is needed to send messages to Telegram, without opening the browser tabs (in the background).
4. Unpack the archive in the folder with the miner (or in any other folder convenient for you). Check in config.bat file and type CurlPath (in case of unpacking to the folder with the miner, the appropriate value is already typed).
5. In config.bat file type RigName, this is necessary if you want to receive notifications from several farms at once to a Telegram bot in order not to be confused.
6. Change the value of EnableTelegramNotifications in config.bat file to 1.
7. The setup is complete, run autorun.bat, everything should work.

Telegram instruction (for group chat):
0. Read instruction for one user first to understand how it works!
1. Create group chat. Invite your friens into this group.
2. Invite Telegram bot by the search, type @ZcashMinerAutorunBot or Zcash Miner Autorun, or add bot to Telegram and use “Add to group” button in bot profile. This bot will send you notifications from your Zcash farm.
3. Invite another bot @get_id_bot into this group. Write /start@get_id_bot in group chat. Bot will tell you the Chat ID number of this group (starting from “-”), write this number in config.bat, in the ChatId field, instead of 000000000. This bot can be deleted, it is no longer needed.
4. The setup is complete, run autorun.bat, everything should work.

Requirements:
* Windows 10 Pro x64 Creators Update (on the other not tested, may not work).
* Names of folders without spaces.
* All programs for overclocking are installed in standard directories.
* Administrator rights are not required when starting the file (I start without them and everything works).
* The presence of .log (the standard name miner.log), the autorun.bat script works on the basis of data in .log.
Make sure! You added --log 2 to the batch file to run the miner. You added the name of the .log file to config.bat and .log file is created. If for you these are incomprehensible things, please, do steps 5 and 6 of the instruction.
* I advise you to disable "User Account Control".
* Attention and lack of desire to put your hands into the code yourself. Write to me, I will do everything. Then to disassemble, that there was, and that became, it is long and it is not interesting!

Functions:
* The presence of config.bat for more fine-tuning the script, disabling unnecessary or unwanted functions.
* Check if the process of the miner is running.
* Checking the processes of programs for overclocking graphics cards MSI Afterburner, GIGABYTE Xtreme Gaming Engine, ASUS GPU Tweak II, EVGA Precision X.
* The algorithm by which the script checks for overclocking on video cards, based on the average hash, which the user specified in config.bat.
* The ability to run and check another miner or any other program (minergate, teamviewer, etc.).
* Checks the number of connected video cards, based on user data in config.bat.
* Reboots the miner or computer every 1 hour or every 2 hours, at 12:00, at 00:00 (you can select / disable in config.bat).
* Reboot the computer for critical errors. The script works on a list of errors that only fixes the computer to reboot.
* Pause when you disconnect the Internet. Start at connect.
* Additional pool server support.
* Double-window verification of the script, protection against double launch.
* Checking the presence of the necessary files, creates a batch file to run, if it is missing. Removes unnecessary files on request. Sorts logs into the Logs folder, with the ability to clean it.
* Maintain your logs in the autorun.log file. Errors, warnings, messages about successful start.
* Sound notifications in case of error or any other situation requiring attention of the user.
* Telegram bot notifications.
* Running the miner both with .bat or with .exe.

Donation adress ZEC: t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv
