#!/bin/bash

# Remove bloadware from Onn. 4k streaming box
# Author: Amit Raut
# Edited by: Kali Lentz for the 2023 Onn TV Box  


# Dictionary of pre-installed bloatware apps

declare -A bw

bw['YouTube']='com.google.android.youtube.tv'
bw['Apple TV']='com.apple.atve.androidtv.appletv'
bw['Disney']='com.disney.disneyplus'
bw['ESPN']='com.espn.score_center'
bw['HULU']='com.hulu.livingroomplus'
bw['MAX (formerly HBO MAX)']='com.wbd.stream'
bw['Paramount+']='com.cbs.ott'
bw['Prime Video']='com.amazon.amazonvideo.livingroom'
bw['YouTube Music']='com.google.android.youtube.tvmusic'
bw['Play Games']='com.google.android.play.games'
bw['Default TV Launcher']='com.google.android.apps.tv.launcherx'
bw['Play Movies & TV']='com.google.android.videos'
bw['Netflix']='com.netflix.ninja'
bw['Tubi']='com.tubitv'
bw['Youtube TV']='com.google.android.youtube.tvunplugged'




for i in "${!bw[@]}"; do
    read -p "[?] Do you want remove \"$i\"? (y/n) " yn

    case $yn in
        y ) adb shell su -c pm uninstall --user 0 ${bw[$i]} > /dev/null && echo "[+] Removed $i." || echo "[!] Failed to remove $i. Already removed/Not installed";;
        n ) echo "[-] Keeping $i";;
    esac
done
