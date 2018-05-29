# **Donations:**
* **ZEC: t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv**
* **BTC: 1wdJBYkVromPoiYk82JfSGSSVVyFJnenB**
* **LTC: LMQXFoKT5Y7me76Z7jF4rM7C8giQvzdBEs**
* **ETH: 0x4a98909270621531dda26de63679c1c6fdcf32ea**
* **ETC: 0x23f914ef283b06d5cdfe0aca6902edcac9211177**
* **HUSH: t1X2iAPjDVm8MoaUkEhbzM8wPA82S3X4tKe**
* **XMR: 4JUdGzvrMFDWrUUwY3toJATSeNwjn54LkCnKBPRzDuhz
i5vSepHfUckJNxRL2gjkNrSqtCoRUrEDAgRwsQvVCjZbS5VF8ypv8VF3GUiS1J**

# **Files:**
**Ewbf Equihash** - *Ewbfautorun.bat*, **Dstm Equihash** - *Dstmautorun.bat*, **Claymore Equihash** - *ClayZECautorun.bat*, **Claymore CryptoNote** - *ClayXMRautorun.bat*, **Claymore NeoScrypt** - *ClayNSautorun.bat*, **Claymore Dagger-Hashimoto** - *ClayETHautorun.bat*, **Ethminer Dagger-Hashimoto** - *Ethrautorun.bat*, **Ccminer tpruvot, alexis (palgin), zealot enemy, KlausT** - *CCautorun.bat*, **Cast XMR CryptoNote** - *Castautorun.bat*, **Phoenix Ethash** - *Phnxautorun.bat*

# **About:**
Hello, guys! FarmWatchBot (Miner autorestart, autorun, watchdog) by Acrefawn (me).
Opensource CMD/BAT file. **If you found or corrected an error, please contact me immediately!** Together we can work out any bugs as well as add features and functionality to further automate the process of mining.

First of all I have to say, this script was developed for me and for my friends to make mining process easy and stable. This script monitors mining process for errors and takes some corrective measures depending on the issue that arises from the miner or hardware. After running this script personally to ensure stability, I decided to share this script with the community.

Functionality is fully brought to the mind, everything works without problems and errors. I thank those who spent their time and helped me to make this script better. You worked for the common cause! The script is in active development. Feature requests, suggested changes and error corrections are welcomed by everyone.

If you use this script and find it helpful and it has stabilized your mining productivity, **please donate**. This is an open source project and you are not required to pay for it. When I ask for donations I’m not referring to monetary donations exclusively. You can donate with your **SHARES**, **LIKES** and **FEEDBACK** as well. Thank you very much!

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
1. Download **.bat** file [from GitHub Releases page](https://github.com/Undertrey/FarmWatchBot/releases) (Depending on which miner or algorithm you are going to use). Please do not rename it.
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
5. The presence of miners **.log** file. The **.bat** script works using the data in your **.log** file. Make sure you added special option to the **config.ini** file. If you experience difficulties with the log file or this script, please delete **config.ini** file and run through steps 2 and 3 of the instructions again. This values already exist in default **config.ini**, just not remove them.
6. It is advised that you disable **“User Account Control”**.
7. Right click on the window of CMD prompt, then select “Properties” and remove the tick for **“Quick Edit”**.
8. Powershell WMF 5.1 (for **premium** Windows 7 users).
9. Use **24 hours** format. (OS date/time settings).
10. Attention and lack of desire to put your hands into the code yourself, write to me, I will do everything. Then to disassemble, that there was, and that became, it is long and it is not interesting! **Also, note that I will not help people who have changed the code or have not read the instructions for free**.


# **Contacts:**
For support **find me** on Telegram: http://t.me/acrefawn.

**My [topic on bitcointalk](https://bitcointalk.org/index.php?topic=2071108.0) (eng)**

**My [topic on forum.zcash](https://forum.z.cash/t/cmd-farmwatchbot-autorun-watchdog-for-ewbf-claymore-dstm-ccminer-bminer-ethminer/20640) (eng)**

**My [topic on bits.media](https://forum.bits.media/index.php?/topic/45680-zcash-miner-autorun/) (rus)**

**My [topic on cryptoff](https://forum.cryptoff.org/index.php?/topic/6727-zcash-miner-autorun-autorestart-watchdog-for-ewbf-miner/) (rus)**

*Thank you for supporting!*

**[https://vk.com/zcash](https://vk.com/zcash)**

**[https://vk.com/gpu_mining](https://vk.com/gpu_mining)**

# **Premium:**
If you interested in premium version, price is **20$** equivalent in any cryptocurrency from donations list. The premium version offers the user to use a certain range of commands via a telegram bot. This list includes such commands as:  **/config, /exit, /forget, /group, /info, /miner, /ping, /pool, /profile, /remember, /restart, /server, /shutdown, /startover, /status, /stop, /teamviewer, /anydesk, /online, /update**. And also receive notifications from the bot when the **Rig is offline**. Send **20$** equivalent in cryptocurrency to donation address and [contact me in Telegram](https://t.me/acrefawn) for further instructions.

**[Detailed documentation about premium commands.](https://docs.google.com/document/d/1LPFG3PbjhT1HyWZgj2aF0sjgqlp7v7lcPEGrj23GIsk/edit?usp=sharing)**

**[Подробная документация о премиум командах.](https://docs.google.com/document/d/1UI1__t-ToZzKf35JCfFgeo1yQcRxwnsQfwXb03Wiv8k/edit?usp=sharing)**

# **Donations:**
* **ZEC: t1S8HRoMoyhBhwXq6zY5vHwqhd9MHSiHWKv**
* **BTC: 1wdJBYkVromPoiYk82JfSGSSVVyFJnenB**
* **LTC: LMQXFoKT5Y7me76Z7jF4rM7C8giQvzdBEs**
* **ETH: 0x4a98909270621531dda26de63679c1c6fdcf32ea**
* **ETC: 0x23f914ef283b06d5cdfe0aca6902edcac9211177**
* **HUSH: t1X2iAPjDVm8MoaUkEhbzM8wPA82S3X4tKe**
* **XMR: 4JUdGzvrMFDWrUUwY3toJATSeNwjn54LkCnKBPRzDuhz
i5vSepHfUckJNxRL2gjkNrSqtCoRUrEDAgRwsQvVCjZbS5VF8ypv8VF3GUiS1J**
