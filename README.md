# **Functions:**
* Fine tuning of mining process by using of config.bat file.
* Control of the mining process.
* Activity monitoring of GPU OC software such as MSI Afterburner, GIGABYTE Xtreme Gaming Engine, ASUS GPU Tweak II, EVGA Precision X and auto restart of it, if necessary. Ability to auto enable specified Overclock Profile for MSI Afterburner.
* Average hashrate monitoring and control. Average hashrate hourly report in Telegram.
* The ability to run and activity control of another miner or any other program (Minergate, TeamViewer, Storj etc).
* Control of active GPUs number, based on settings in config.bat.
* Ability to periodically reboot the miner or computer with specified time intervals.
* Reboots the PC after critical errors. This script uses an error list which includes errors that require the PC to be restarted in order to resolve the issue.
* Monitors internet availability. Restarts PC in regular time intervals if connection has not restored.
* Supports an extra back up pool server switch over, when main server is inaccessible.
* GPU overheat control.
* Checking the presence of the necessary files. Removes unnecessary files on request. Sorts logs into the Logs folder, with the ability to clean it.
* Maintain your logs in the autorun.log file. Errors, warnings, messages regarding successful start.
* Sound notifications in case of error or any other situation requiring attention of the user.
* Telegram notifications in case of any problems, corrective actions taken, hourly activity report.

# **Instruction:**
1. Create a blank .txt file and rename it to autorun.bat.
2. Follow the link at the top of this post, copy the entire script code into the autorun.bat file.
3. Move autorun.bat file to the folder with the EWBF miner, double click the autorun.bat file. New config.bat file will be created with default settings at first run.
4. Close autorun.bat CMD window and open the created config.bat file for editing. Configure settings in this file according to your needs using notepad. Before the next step, check config.bat again to ensure your settings are correct!
5. Delete the old batch file you were using to run your miner. Autorun.bat will create a new one, with the settings that you set in the config.bat. Double check files miner.cfg, miner.bat, config.bat before you start!
6. Run autorun.bat if you are satisfied with settings in the above mentioned files and enjoy the automation!


# **Telegram instruction (bot for one user):**
1.  [Add a bot to Telegram](https://t.me/ZcashMinerAutorunBot) (just start chat), this bot will send you notifications from your Zcash farm.
2.  [Add another bot](https://t.me/get_id_bot), it will tell you the Chat ID number, write this number in config.bat, in the ChatId field, instead of 000000000. This bot can be deleted, it is no longer needed.
3.  [Download “cURL”](https://goo.gl/b7N6qV). You can download from the site cURL: https://curl.haxx.se, you will need the latest version of Win64 x86_64 7zip with Binary SSL SSH. ([What is cURL?](https://en.wikipedia.org/wiki/CURL). Specifically in our case, it is needed to send messages to Telegram, without opening the browser tabs).
4.  Unpack the archive in the same folder as the miner (or in any other folder of your choosing). Search in config.bat file for CurlPath and change path to the location you unpacked cURL. (Default path assumes you unpacked inside the same folder as miner).
5.  In config.bat file search for RigName and choose a name for this rig. This is necessary if you want to receive notifications from multiple servers at once to a Telegram bot. The RigName helps to differentiate between servers.
6.  Change the value of EnableTelegramNotifications in config.bat file to 1.
7.  Setup is complete! Run autorun.bat and everything should work.


# **Telegram instruction (bot for group chat):**
1.  Read instruction for one user first to understand how it works!
2.  Create group chat. Invite your friends into this group.
3.  Invite Telegram bot by the search, type @ZcashMinerAutorunBot or Zcash Miner Autorun, or add bot to Telegram and use “Add to group” button in bot profile. This bot will send you notifications from your Zcash farm.
4.  Invite another bot @get_id_bot into this group. Write /start@get_id_bot in group chat. Bot will tell you the Chat ID number of this group (starting from “-”), write this number in config.bat, in the ChatId field (with "-"), instead of 000000000. This bot can be deleted, it is no longer needed.
5.  The setup is complete, run autorun.bat, everything should work.


# **Requirements:**
1. Windows 10 Pro x64 Creators Update (May not work on others).
2. All programs for overclocking must be installed in their default directories.
3. The presence of .log file (the standard name miner.log). The autorun.bat script works using the data in your .log file. Make sure you added --log 2 to the batch file to run the miner. Also ensure you added the name of the .log file to config.bat. If you experience difficulties with the log file or this script, please run through steps 4 and 5 of the instructions again.
4. It is advised that you disable “User Account Control”, but it is not a requirement.
5. Right click on the window of CMD prompt, then select “Properties” and remove the tick for “Quick Edit”.
6. Attention and lack of desire to put your hands into the code yourself, write to me, I will do everything. Then to disassemble, that there was, and that became, it is long and it is not interesting!
7. Powershell (for premium users).

**Donation adress:**

**ZEC: t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv**

**BTC: 1wdJBYkVromPoiYk82JfSGSSVVyFJnenB**
