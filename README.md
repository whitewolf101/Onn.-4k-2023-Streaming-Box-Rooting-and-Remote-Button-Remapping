# Onn. 4k Streaming Box Rooting and Remote Button Remapping + Useful Android Tv Scripts

#### Disclaimer

<b>The content in this post is for educational purposes only. Use the content as per the regulations. This is a simple rework of the scripts provided [here](https://github.com/amit-raut/Onn.-4k-Streaming-Box-Rooting-and-Remote-Button-Remapping)  for my 2023 model Onn box, your milage may vary</b> 
-

<hr>
</br>
### Environment:
I am doing this in a Linux environment (Manjaro Linux) with ADB & Fastboot installed via the android-tools package, I do not see any issues running this install on Windows but again, your milage may vary and all scripts are written for Linux so commands will not be the same as listed in this guide. I am using a MicroUSB cable to connect the TV box to my PC, it seems to also provide enough power over the USB 2.0 port to power the device

### Step 1: Perform initial setup with upgrade and Google sign in

Configure the Onn. 4k streaming device normally to setup remote and the initial Google sign in. (This is required and can not be skipped, the update will not break the root (as of 11/24/2023)

<hr>

### Step 2: Enable Developer Option and USB debugging

Go to `Settings -> Device Preferences -> About -> Build` and press `Build` option 7 times and you should see pop-up message as "You are a developer". After enabling Developer option go to `Settings -> Device Preferences -> Developer Options` and enable `USB debugging`

Reboot the device

This should trigger a pop-up to allow USB debugging when the Onn. 4k streaming box is connected to a Linux system. Select always allow debugging option for the Linux system.

Ensure your device is connected with 
```bash
adb devices
```
you should expect to see 
```bash
username@system: adb devices                                                                                 
List of devices attached
GUSA2321006342  device
```
If you see
```bash
username@system: adb devices                                                                                 
List of devices attached
GUSA2321006342  unauthorized
```
ensure you allowed your computer to debug via ADB on the Onn TV box
<hr>

### Step 3: Unlock boot loader

Unlock the bootloader with adb commands <b>###THIS WILL FACTORY RESET THE DEVICE###</b>

```bash
adb devices
```
```bash
adb reboot bootloader
```
Wait until the TV Device appears stuck at the 'onn.' boot screen
```bash
fastboot devices
```
Ensure you see your device, if not ensure Drivers are installed (on Windows) or try restarting the device and starting from Step 3
```bash
fastboot flashing unlock
```
You should see 
```bash
username@system: fastboot flashing unlock                                                                  
OKAY [  0.290s]
Finished. Total time: 0.290s
```
If you see an error, try re-running the command two more times (or until it says OKAY) then proceed on)
```bash
fastboot getvar unlocked
```
Expected result - 
```bash
fastboot getvar unlocked                                                                   
unlocked: yes
Finished. Total time: 0.002s
```
If you see "unlocked: no" - reboot and restart from Step 3, try running the fastboot unlock command more, until you receive an "OKAY" result
```bash
fastboot reboot
```

<hr>


### Step 4: Repeat Steps 1 and 2

Now the boot loader is unlocked repeat [steps 1 and 2](https://github.com/whitewolf101/Onn.-4k-2023-Streaming-Box-Rooting-and-Remote-Button-Remapping#step-1-perform-initial-setup-with-upgrade-and-google-signin) to setup the Onn. 4k streaming box again. We'll work on getting root access next.

<hr>

### Step 5: Rooting the device

First of all, thanks to the XDADevelopers user Functioner in [this thread](https://forum.xda-developers.com/t/walmart-onn-google-tv.4586587/post-88777153)
<br><br/>
<b> NOTICE - Please ensure you use Magisk 26.1, the vendor_boot.img is spesificly tied to this version! I have attempted to create a vendor_boot.img for Magisk 26.4 with no success </b>

- Download [Magisk Manager 26.1](https://github.com/topjohnwu/Magisk/releases/tag/v26.1) (Currently the only supported version for this device) from [here](https://objects.githubusercontent.com/github-production-release-asset-2e65be/67702184/32b02342-3b4d-4b65-9daf-61a08ce313c8?X-Amz-Algorithm=AWS4-HMAC-SHA256&X-Amz-Credential=AKIAIWNJYAX4CSVEH53A%2F20230806%2Fus-east-1%2Fs3%2Faws4_request&X-Amz-Date=20230806T202836Z&X-Amz-Expires=300&X-Amz-Signature=7db1a17a8e917b131a67ca7cfb02d0364d8bf0ab34844841fe9d40eaae8abe16&X-Amz-SignedHeaders=host&actor_id=3161177&key_id=0&repo_id=67702184&response-content-disposition=attachment%3B%20filename%3DMagisk-v26.1.apk&response-content-type=application%2Fvnd.android.package-archive)
- Download [vendor_boot-magisk_patched-26100.img](https://github.com/whitewolf101/Onn.-4k-2023-Streaming-Box-Rooting-and-Remote-Button-Remapping/raw/main/vendor_boot-magisk_patched-26100.img)
- Ensure your terminal is in the same location you downloaded the APK & Image to, then run
```bash
adb devices
adb install Magisk-v26.1.apk
adb reboot bootloader
```
- Wait for device to be stuck at 'Onn.' boot screen then run 
```bash
fastboot devices
fastboot flash vendor_boot vendor_boot-magisk_patched-26100.img
```
Expected Result - 
```bash
username@system: fastboot flash vendor_boot vendor_boot-magisk_patched-26100.img                    1 ✘ 
Sending 'vendor_boot_b' (22056 KB)                 OKAY [  0.897s]
Writing 'vendor_boot_b'                            OKAY [  0.891s]
Finished. Total time: 1.796s
```

```bash
fastboot reboot
```
- Once system boots go to `Settings --> Apps --> See all apps --> Magisk --> Open
- Allow Magisk to run Additional Setup, your device will reboot
- Reopen Magisk and enjoy root access!

<hr>


### Step 6: Remap the Onn. 4k streaming box remote 

Use [Remap-Remote-Buttons.sh](https://github.com/whitewolf101/Onn.-4k-2023-Streaming-Box-Rooting-and-Remote-Button-Remapping/blob/main/Remap-Remote-Buttons.sh) script to remap the remote buttons. When the script is executed you will need to Allow ADB to execute commands as root by selecting `grant` on the on screen popup, the script will then 

- Copy the `onntvremap` folder in to `/sdcard/Download`
- Move the `onntvremap` folder to `/data/adb/modules/` directory as root user
- Reboot the device

Once the device comes back online. No button mapping will be present for the buttons like `YouTube`, `Netflix`, `Disney+`, `Paramount+`. Install [Button Mapper](https://play.google.com/store/apps/details?id=flar2.homebutton&hl=en_US&gl=US) application from the Play Store, grant superuser access to `Button Mapper` and remap the buttons on the remote as per your liking.

- Open Buttonmapper
- Select the hambuger menu in the top right

- Select `Check for Root`

- Select `Grant` to allow ButtonMapper SuperUser Access

- Congrats! Setup your new buttons and enjoy your custom remote
<hr>


### Step 7: Install a new Launcher & Setup the Launcher

This guide will cover using [Projectivity Launcher](https://play.google.com/store/search?q=Projectivity%20Launcher&c=apps&hl=en_US&gl=US) as this is what I personally like

- Install [Projectivity Launcher](https://play.google.com/store/search?q=Projectivity%20Launcher&c=apps&hl=en_US&gl=US) on your device from the Play Store
- Launch Projectivity Launcher and go through setup/tutorial, allow & grant any access it wants, also be sure to scroll to `System --> Accessibility Service --> Show Accessibility settings --> Yes --> Projectivy Launcher --> Enable` press back until you are back at the Projectivity Launcher home page
- Scroll to `Projectivy Launcher Settings --> General` and select `Override Current Launcher` also if the option is there to select a default launcher do that at this time, that option showed up the second time I opened the menu so your milage may vary
- Reboot device and make sure it launches Projectivity on boot and that the home button only opens Projectivity as the next step will remove the default ad filled launcher

<hr>



### Step 8: Remove bloatware from Onn. 4k streaming box

Onn. 4k streaming box contains following pre-installed apps:

1. YouTube
2. Disney Plus
3. MAX (formerly HBO MAX)
4. YouTube Music
5. HULU
6. Google Play Games
7. Google Play Movies & TV
8. Apple TV
9. ESPN
10. Prime Video
11. Paramount+
12. Default TV Launcher

Run [Remove-Bloatware.sh](https://github.com/whitewolf101/Onn.-4k-2023-Streaming-Box-Rooting-and-Remote-Button-Remapping/blob/main/Remove-Bloatware.sh) script to remove the pre-installed apps you do not need.

<hr>


### Step 9: Install some useful apps

Personally these are apps I like to install once I am finished with setup!

- [SmartTubeNext](https://github.com/yuliskov/SmartTubeNext) [Install](https://github.com/yuliskov/SmartTubeNext#installation)
- [FX File Manager](https://play.google.com/store/search?q=fx+file+explorer&c=apps&hl=en_US&gl=US)
- [VLC](https://play.google.com/store/apps/details?id=org.videolan.vlc&hl=en_US&gl=US)
- [Speed Test WiFi Analyzer](https://play.google.com/store/apps/details?id=com.analiti.fastest.android&hl=en_US&gl=US)
- [Downloader by AFTV](https://play.google.com/store/apps/details?id=com.esaba.downloader&hl=en_US&gl=US)
- [Plex](https://play.google.com/store/apps/details?id=com.plexapp.android&hl=en_US&gl=US)
- [Wireguard (for my travel device)](https://play.google.com/store/apps/details?id=com.wireguard.android&hl=en_US&gl=US)


<hr>


## Step 10: Enjoy


Thats it, install whatever apps you like, hook it up to your tv with its USB brick and enjoy your customized ad-free $20 Android TV box!
