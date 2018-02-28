# **Donations:**
* **ZEC: t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv**
* **BTC: 1wdJBYkVromPoiYk82JfSGSSVVyFJnenB**
* **LTC: LMQXFoKT5Y7me76Z7jF4rM7C8giQvzdBEs**

# **Functions:**
* Fine tuning of mining process by using of **config.ini** file.
* Control of the mining process.
* Activity monitoring of GPU OC software such as *MSI Afterburner, GIGABYTE Xtreme Gaming Engine, ASUS GPU Tweak II, EVGA Precision X, AORUS Gaming Engine, Palit Thunder Master* and auto restart of it, if necessary. Ability to auto enable specified Overclock Profile for MSI Afterburner.
* Average hashrate monitoring and control. Information about average hashrate, last total hashrate, current temperature, current pool server hourly reports in Telegram.
* The ability to run and activity control of another miner or any other program (Minergate, TeamViewer, Storj etc).
* Control of active GPUs number, based on settings in **config.ini** or on last loaded amount.
* Ability to periodically reboot the miner or computer with specified time intervals.
* Reboots the PC after critical errors. This script uses an error list which includes errors that require the PC to be restarted in order to resolve the issue.
* Monitors internet availability. Restarts PC in regular time intervals if connection has not restored.
* Supports an extra back up pool server switch over, when main server is inaccessible.
* GPU overheat control.
* Checking the presence of the necessary files. Sorts logs into the Logs folder, with the ability to clean it. Maintain your logs in the autorun.log file. Errors, warnings, messages regarding successful start. Screenshot desktop in case of errors and sort them into the Screenshots folder.
* Sound notifications in case of error or any other situation requiring attention of the user.
* Telegram notifications in case of any problems, corrective actions taken, hourly activity report.
* Bot commands for **premium** users with ability to administrate your Rigs through Telegram.
* Notifications for **premium** users about Rigs offline through Telegram.


# **Instruction:**
1. Download **.bat** file from GitHub Releases page (Depending on which miner or algorithm you are going to use). Please do not rename it.
2. Move **.bat** file to the folder with the miner, double click the .bat file. New **config.ini** file will be created with default settings at first run.
3. Close **.bat** CMD window and open the created **config.ini** file for editing. Configure settings in this file according to your needs using notepad. The configuration file is always at a higher priority than the variables inside the script.
4. Add a **SHORTCUT** to **.bat** file in your Startup folder (WIN+R shell:startup).
5. Run **.bat** file if you are satisfied with settings in the above mentioned files and enjoy the automation!


# **Telegram instruction (bot for one user):**
1. Add [@FarmWatchBot](https://t.me/FarmWatchBot) to Telegram, this bot will send you notifications from your Rig.
2. Write **/start** in chat. Bot will tell you the **ChatId number**. Write this number in **config.ini**, in the **chatid** field, after =, instead of **0**.
3. In **config.ini** file search for **rigname** and choose a name for this rig. This is necessary if you want to receive notifications from multiple computers at once to a Telegram bot. The **rigname** helps to differentiate between computers.
4. Setup is complete! Run **.bat** file and everything should work.


# **Telegram instruction (bot for group chat):**
1. Create group chat (not channel). Invite your friends into this group. Invite bot by the search, type [@FarmWatchBot](https://t.me/FarmWatchBot), or add bot to group using **“Add to group”** button in bot profile. This bot will send you notifications from your Rig.
2. Write **/start@farmwatchbot** in group chat. Bot will tell you the **ChatId number** of this group starting from **“-”** (minus). Write this number **with “-” (minus)** in **config.ini** file, in the **chatid** field, after =, instead of **0**.
3. Setup is complete! Run **.bat** file and everything should work.


# **Requirements:**
1. Ignore **SmartScreen**, you can open **.bat** for editing and check that it is not a virus.
2. **Windows 10 Pro x64** Creators Update or higher (May not work on others).
3. All programs for overclocking must be installed in their default directories.
4. Use path, folders, **.bat** file name in English, without special symbols and spaces.
5. The presence of miners **.log** file. The autorun.bat script works using the data in your **.log** file. Make sure you added special option to the **config.ini** file. If you experience difficulties with the log file or this script, please delete **config.ini** file and run through steps 2 and 3 of the instructions again. This values already exist in default **config.ini**, just not remove them.
6. It is advised that you disable **“User Account Control”**.
7. Right click on the window of CMD prompt, then select “Properties” and remove the tick for **“Quick Edit”**.
8. Powershell WMF 5.1 (for **premium** Windows 7 users).
9. Use **24 hours** format. (OS date/time settings).
10. Attention and lack of desire to put your hands into the code yourself, write to me, I will do everything. Then to disassemble, that there was, and that became, it is long and it is not interesting! **Also, note that I will not help people who have changed the code or have not read the instructions for free**.


# **Premium:**
If you interested in premium version, price is 0.05 ZEC or equivalent in any other cryptocurrency. The premium version offers the user to use a certain range of commands via a telegram bot. This list includes such commands as:  /forget, /info, /miner, /ping, /pool, /profile, /remember, /reports, /restart, /server, /shutdown, /startover, /status, /stop, /teamviewer, /online, /update. And also receive notifications from the bot when the Rig is offline. Send 0.05 ZEC to donation address and contact me in Telegram for further instructions.


# **Donations:**
* **ZEC: t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv**
* **BTC: 1wdJBYkVromPoiYk82JfSGSSVVyFJnenB**
* **LTC: LMQXFoKT5Y7me76Z7jF4rM7C8giQvzdBEs**
