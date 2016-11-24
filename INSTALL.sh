#!/bin/sh
#########################################################################
#             .::[ NETOOL TOOLKIT 4.6 -> Installer ]::.                 #
#                By r00t-3xp10it and rawstring enox                     #
#-----------------------------------------------------------------------#
#                                                                       #
#                            * WARNING *                                #
#   this 'installer' as build to work on linux Ubuntu or Kali distros   #
#   if you wish to install the toolkit in another (linux) distro,       #
#   download 'opensouce[kali].tar.gz' and follow the instructions       #
#   on my 'WIKI' webpage hosted on sourceforge here:                    #
#  http://sourceforge.net/p/netoolsh/wiki/netool.sh%20script%20project/ #
#-----------------------------------------------------------------------#
#   Special Thanks to rawstring_enox for the support provided in the    #
#   develop of this 'installer' and for the debug that cames later :/   #
#########################################################################






# ----------------------------------------
# Variable declarations
####################################################################################
ver="4.6"                              # netool.sh version                         #
IdU=`id -u`                            # check user ID (0=root 1000=gest)          #
H0m3=`echo ~`                          # local user Home path                      #           
OS=`awk '{print $1}' /etc/issue`       # grab Operative System distro              #
spath=`pwd`                            # toolkit current installed directory       #
rpath="$H0m3/opensource"               # toolkit correct directory (default)       #
CuRl=`which curl`                      # curl install path                         #
Z3n=`which zenity`                     # zenity install path                       #
usera=`who | cut -d' ' -f1 | sort | uniq` # grab account username                  #
# ---------------------------------------------------------------------------------#
D1sTr0=`cat netool.sh | egrep -m 1 "D1str0" | cut -d ':' -f2`                      #
PhP=`cat toolkit_config | egrep -m 1 "PHP5_INSTALL_PATH" | cut -d '=' -f2`         #
find=`cat toolkit_config | egrep -m 1 "ZENMAP_INSTALL_PATH" | cut -d '=' -f2`      #
find2=`cat toolkit_config | egrep -m 1 "ETTERCAP_INSTALL_PATH" | cut -d '=' -f2`   #
find3=`cat toolkit_config | egrep -m 1 "MACCHANGER_INSTALL_PATH" | cut -d '=' -f2` #
find4=`cat toolkit_config | egrep -m 1 "METASPLOIT_INSTALL_PATH" | cut -d '=' -f2` #
apache=`cat toolkit_config | egrep -m 1 "APACHE_INSTALL_PATH" | cut -d '=' -f2`    #
confW=`cat toolkit_config | egrep -m 1 "DRIFTNET_INSTALL_PATH" | cut -d '=' -f2`   #
####################################################################################






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






# ----------------------------------------
# start script functions
# ----------------------------------------
Colors;

       dtr=`date`
       # build logfile to store install bugs (dtr.log)
       echo "" > /tmp/dtr.log && echo "_::NETOOL::T00LKIT::=>::$ver::INSTALLER::BUG::REPORT::" >> /tmp/dtr.log
       echo "_::OS::=>::$OS::HOME::=>::$H0m3::PWD::=>::$spath::" >> /tmp/dtr.log
       echo "_::T00LKIT::DISTRO=>::$D1sTr0::USERNAME::=>::$usera::ID::=>::$IdU::" >> /tmp/dtr.log
       echo "_::" >> /tmp/dtr.log





# ----------------------------------------
# GNU - FREE SOFTWARE FOUNDATION - LICENSE
# ----------------------------------------
Colors;
echo ${YellowF}
cat << !


      ,           , 
     /             \ 
    ((__-^^-,-^^-__)) 
     '-_---'  ---_-'
      '--|o' 'o|--' 
         \  '  / 
          ): :( 
          :o_o: 
           "-"  GNU PUBLIC LICENSE (GPL)
     Copyright © 2015 - License - Terms of Use <http://fsf.org/>
     Everyone is permitted to copy and distribute verbatim copies
     of this license document, but changing it is not allowed.

---
-- 1) You are not required to accept this License since you have not
-- signed it, However nothing else grants you permission to modify or
-- distribute the Program or its derivative works under another author
-- name besides 'pedr0 ubuntu - r00t-3xp10it' or change the software
-- name from 'netool toolkit', Therefore by modifying or distributing
-- the Program you indicate your acceptance of this License.
--
-- 2) You can use this software and distribute it with anyone else
-- as long as you do this for free and keep author credits, also the
-- license must be included into the program without any changes made.
-- However you are allowed to reverse engineer it and distribute it
-- under this terms and conditions. 
--
-- 3) This project can only be distributed in open source format
-- and any adjustments to the source code to spy or control user
-- activity will not be allowed by third part companies/persons. 
--
-- 4) You assume full responsibility for any unlawful actions taken
-- by using this software againts hosts in a local lan or wan networks
-- without owner previous consent, However you are allowed to protect
-- yourselfe from any intruder by any meens necessary.
--
-- 5) This software uses licenced frameworks develop by others
-- and by any meens infringe that licenses by automating then.
--   But offcourse that all the credits goes go:
--   Fyodor (nmap) | Alor & Naga (ettercap) | HD Moore (metasploit)
--   Moxie M (sslstrip) | Chris L (driftnet) | j0rgan (cupp.py)
--   ReL1K (unicorn.py) | Cleiton P (inurlbr.php) | KyRecon (shellter)
--   Chris Tyler (zenity) and Rob McCool (apache).
-- Assuming that you allready have this programs installed then you
-- have allready acept there's terms and conditions.
---

Copyright © 2015 - netool toolkit
!
sleep 3
QuE=$(zenity --question --title "GNU PUBLIC LICENSE (GPL)" --text "Do you agree with terms\nand conditions (GPL)?" --width 300) > /dev/null 2>&1
if [ "$?" -eq "0" ]; then
echo "license agree" > /dev/null 2>&1
else
exit
fi



# ----------------------------
# installer banner display
# ----------------------------
echo ${white}
cat << !
           ┌┐┌┌─┐┌┬┐  ┌┬┐┌─┐┌─┐┬  ┌─┐
           │││├┤  │    │ │ ││ ││  └─┐
           ┘└┘└─┘ ┴    ┴ └─┘└─┘┴─┘└─┘ $ver
 +-------------------------------------------------+
 |   Installer by: r00t-3xp10it & rawstring_enox   |
 +-------------------------------------------------+
 |     Script to quickly 'install' the toolkit     |
 |     in is right path, set permitions to all     |
 |     files, install dependencies, and start      |
 |      toolkit as root user (ubuntu distros)      |
 +-------------------------------------------------+

!
Colors;
sleep 2






 # ----------------------------
 # check if compatible OS distro (node name)
 # ----------------------------
 if [ "$OS" "=" "Kali" ]; then
   echo ${BlueF}[${GreenF}✔${BlueF}][Verify OS Compatibility]..[${GreenF} OK ${BlueF}]${Reset};

 else

   # fail comparing toolkit version to current installed Operative System
   echo ${RedF}[x]${BlueF}[Verify OS Compatibility]..[${RedF} FAIL ${BlueF}]${Reset};
   sleep 2
cat << !

  OPERATIVE SYSTEM  : $OS
  INSTALLER SET TO  : KALI
 +--------------------------------------------------------+
 |       This installer only works in Kali distros        |
 +--------------------------------------------------------+
 |  IF YOU WISH TO INSTALL THE T00LKIT IN ANOTHER DISTRO  |
 |     FOLLOW THE INSTRUCTIONS ON MY 'WIKI' WEBPAGE       |
 +--------------------------------------------------------+

!
     dtr=`date`
     echo ${BlueF}[☆ ][WIKI]${white}http://sourceforge.net/p/netoolsh/discussion/readteam/thread/aae85509/ ${Reset};
     echo ${RedF}[x]${BlueF}[Exit Installer][${YellowF} PLEASE CHECK YOUR LOGFILE '->' $spath/logs/dtr.log ${BlueF}]${Reset};
     echo "_::$dtr::=>::COMPARING::OPERATIVE-SYSTEM::$OS::NOT-SUPPORTED::" >> /tmp/dtr.log
     echo "_::" >> /tmp/dtr.log && echo "_::EOF" >> /tmp/dtr.log
     mv /tmp/dtr.log $spath/logs/dtr.log > /dev/null 2>&1
   exit
 fi
sleep 2





   # ----------------------------
   # check if toolkit release matches OS node name
   # ----------------------------
   if [ "$OS" "=" "$D1sTr0" ]; then
     echo ${BlueF}[${GreenF}✔${BlueF}][Check Toolkit Release]....[${GreenF} OK ${BlueF}]${Reset};

   else

     # fail comparing toolkit release with current installed Operative System
     echo ${RedF}[x]${BlueF}[Check Toolkit Release]....[${RedF} FAIL ${BlueF}]${Reset};
    sleep 2
cat << !

  T00LKIT RELEASE  : $D1sTr0
  OPERATIVE SYSTEM : $OS
 +-------------------------------------------------+
 | Our operative system does not match the toolkit |
 | release, Please download the correct version.   |
 +-------------------------------------------------+
 |  opensource.tar.gz       => linux - Ubuntu      |
 |  opensource[kali].tar.gz => most linux distros  |
 +-------------------------------------------------+

!
     dtr=`date`
     # exit installer and write logfile in opensource/logs
     echo "_::$dtr::=>::T00LKIT-RELEASE::=>::$D1sTr0::OS::=>::$OS::NOT-SUPPORTED::" >> /tmp/dtr.log
     echo ${RedF}[x]${BlueF}[Exit Installer][${YellowF} PLEASE CHECK YOUR LOGFILE '->' $spath/logs/dtr.log ${BlueF}]${Reset};
     echo "_::" >> /tmp/dtr.log && echo "_::EOF" >> /tmp/dtr.log
     mv /tmp/dtr.log $spath/logs/dtr.log > /dev/null 2>&1
     exit
   fi
sleep 2





   # ----------------------------
   # check if script its in correct directory (path)
   # ----------------------------
   if [ "$rpath" "=" "$spath" ]; then
     echo ${BlueF}[${GreenF}✔${BlueF}][Toolkit Install Path].....[${GreenF} OK ${BlueF}]${Reset};
     default=yes

   else

     dtr=`date`
     M1ss=yes
     # move toolkit to the rigth path depending of user input
     echo ${RedF}[x]${BlueF}[Toolkit Install Path].....[${RedF} FAIL ${BlueF}]${Reset};
     sleep 2
cat << !

  T00LKIT INSTALL PATH : $spath
  T00LKIT DEFAULT PATH : $H0m3/opensource
 +-------------------------------------------------+
 |      THIS MAY CAUSE A SCRIPT MALFUNCTION        |
 +-------------------------------------------------+
 |   Move toolkit directory to the right path?     |
 +-------------------------------------------------+

!


     echo "_::$dtr::=>::INSTALL-PATH::WRONG::DIRECTORY::=>::$spath::" >> /tmp/dtr.log
     read -p "[?]::[Move toolkit directory to the right path (y|n)]::" pass
     if test "$pass" = "y"
        then

          # FINALLY WE ARE IN THE RIGTH DIRECTION :D CONGRATZ FOR HAVING INSTALLED THIS SHIT IN THE RIGTH PATH :P
          echo ${BlueF}[${GreenF}✔${BlueF}][Toolkit 'install' path][${GreenF} MOVING TO ${YellowF}'->'${GreenF} "$rpath" ${BlueF}] ${Reset};
          dtr=`date` # log file just for me to know whats happening during the install
          sleep 2 && echo "_::$dtr::=>::T00LKIT::MOVED::TO::=>::$rpath::" >> /tmp/dtr.log
          cp -r "$spath" "$rpath" > /dev/null 2>&1 # copy toolkit to default path
          rm -r "$spath" > /dev/null 2>&1 # remove old path
          default=yes # set a variable for me to know that we are in the rigth track
          cd $rpath # change to default directory

     else

          dtr=`date`
          M1ss=yes
          echo ""
          # abort moving toolkit path to rigth location (path)
          echo ${RedF}[x]${BlueF}[Toolkit 'install' path][${RedF} ABORTED ${BlueF}] ${Reset};
          echo ${RedF}[x][warning]${YellowF}TOOLKIT:MAY:DISPLAY:BUGS:WORKING:IN:ANOTHER:PATH ${Reset};
          echo "_::$dtr::=>::INSTALL-PATH::MOVE::ABORTED::DEFINED::BY::USER::SETTINGS" >> /tmp/dtr.log
          echo ""

       fi
   fi
sleep 2






# ----------------------------
# execute privs on all files
# ----------------------------
chmod +x *.sh && cd INURLBR && chmod +x *.php && cd ..
cd modules && chmod +x *.sh *.py *.rb && cd ..
cd sslstrip-0.9 && chmod +x *.py && cd ..
echo ${BlueF}[${GreenF}✔${BlueF}][Setting 'File' Permitions]..[${GreenF} DONE ${BlueF}]${Reset};
sleep 2










# ----------------------------------------
# INSTALL ALL DEPENDENCIES
# ----------------------------------------
echo ${BlueF}[${GreenF}✔${BlueF}]['Install' Dependencies].....[${GreenF} RUNING ${BlueF}]${Reset};
sleep 2




   # check if macchanger installation exists
   if [ -e $find3 ]; then
   echo ${BlueF}[${GreenF}✔${BlueF}][Macchanger]...............[${GreenF} Installation found ${BlueF}]${Reset};

else

   dtr=`date`
   M1ss=yes
   # missing dependencie OR wrong path config
   echo ${RedF}[x][warning]${BlueF}[Macchanger][${RedF} Not Found In ${YellowF}'->'${RedF} $find3 ${BlueF}]${Reset};
   echo "_::$dtr::=>::Macchanger::bug::not::found::in::=>::$find3::" >> /tmp/dtr.log
   # chose to config settings or download from network
   QuE=$(zenity --question --title="WARNING: TOOLKIT_CONFIG" --text "Edit 'toolkit_config' file to fix path to macchanger?\nChosing [ NO ] will 'apt-get install macchanger'" --width 450) > /dev/null 2>&1
     if [ "$?" -eq "0" ]; then
       find3=`cat toolkit_config | egrep -m 1 "MACCHANGER_INSTALL_PATH" | cut -d '=' -f2`
       rep=$(zenity --title="ENTER MACCHANGER INSTALL PATH" --text "Open terminal and write: locate macchanger" --entry --width 320) > /dev/null 2>&1
       sed "s|$find3|$rep|g" toolkit_config > copy.int
       mv copy.int toolkit_config > /dev/null 2<&1
       echo ${RedF}[x]${BlueF}[${YellowF}setting macchanger path ${GreenF}'->'${YellowF} FIXED ${BlueF}]${Reset};

     else

       sleep 2
       # missing dependencie - install
       echo ${BlueF}[${GreenF}✔${BlueF}][Please wait][${GreenF} DOWNLOADING FROM NETWORK ${BlueF}]${Reset};
       echo ""
       sudo apt-get install macchanger macchanger-gtk
       echo ""
     fi
fi
sleep 2



   #check if metasploit exists
   if [ -d $find4 ]; then
   echo ${BlueF}[${GreenF}✔${BlueF}][Metasploit]...............[${GreenF} Installation found ${BlueF}]${Reset};

else

   dtr=`date`
   M1ss=yes
   # missing dependencie - redirect to darkoperator webpage
   echo ${RedF}[x][warning]${BlueF}[Metasploit][${RedF} Not Found In ${YellowF}'->'${RedF} $find4 ${BlueF}]${Reset};
   # chose to config settings or download from network
   QuE=$(zenity --question --title="WARNING: TOOLKIT_CONFIG" --text "Edit 'toolkit_config' file to fix path to metasploit?" --width 450) > /dev/null 2>&1
     if [ "$?" -eq "0" ]; then
       find4=`cat toolkit_config | egrep -m 1 "METASPLOIT_INSTALL_PATH" | cut -d '=' -f2`
       rep=$(zenity --title="ENTER METASPLOIT INSTALL PATH" --text "Open terminal and write: locate msfconsole" --entry --width 320) > /dev/null 2>&1
       sed "s|$find4|$rep|g" toolkit_config > copy.int
       mv copy.int toolkit_config > /dev/null 2<&1
       echo ${RedF}[x]${BlueF}[${YellowF}setting metasploit path ${GreenF}'->'${YellowF} FIXED ${BlueF}]${Reset};

     else

       echo ${RedF}[x]${YellowF}'more info' here: http://www.darkoperator.com/installing-metasploit-in-ubunt/ ${Reset};
       sleep 3
     fi
fi
sleep 2



   # check if driftnet installation existes
   if [ -d $confW ]; then
   echo ${BlueF}[${GreenF}✔${BlueF}][Driftnet].................[${GreenF} Installation found ${BlueF}]${Reset};

else

   dtr=`date`
   M1ss=yes
   # missing dependencie OR wrong path config
   echo ${RedF}[x][warning]${BlueF}[Driftnet][${RedF} Not Found In ${YellowF}'->'${RedF} $confW ${BlueF}]${Reset};
   echo "_::$dtr::=>::Driftnet::bug::not::found::in::=>::$confW::" >> /tmp/dtr.log
   # chose to config settings or download from network
   QuE=$(zenity --question --title="WARNING: TOOLKIT_CONFIG" --text "Edit 'toolkit_config' file to fix path to driftnet?\nChosing [ NO ] will 'apt-get install driftnet'" --width 450) > /dev/null 2>&1
     if [ "$?" -eq "0" ]; then
       confW=`cat toolkit_config | egrep -m 1 "DRIFTNET_INSTALL_PATH" | cut -d '=' -f2`
       rep=$(zenity --title="ENTER DRIFTNET INSTALL PATH" --text "Open terminal and write: locate driftnet" --entry --width 320) > /dev/null 2>&1
       sed "s|$confW|$rep|g" toolkit_config > copy.int
       mv copy.int toolkit_config > /dev/null 2<&1
       echo ${RedF}[x]${BlueF}[${YellowF}setting driftnet path ${GreenF}'->'${YellowF} FIXED ${BlueF}]${Reset};

     else

       sleep 2
       # missing dependencie - install
       echo ${BlueF}[${GreenF}✔${BlueF}][Please wait][${GreenF} DOWNLOADING FROM NETWORK ${BlueF}]${Reset};
       echo ""
       sudo apt-get install driftnet
       echo ""
     fi
fi
sleep 2



   # check if ettercap installation exists
   if [ -d $find2 ]; then
   echo ${BlueF}[${GreenF}✔${BlueF}][Ettercap].................[${GreenF} Installation found ${BlueF}]${Reset};

else
 
   dtr=`date`
   M1ss=yes
  # missing dependencie OR wrong path config
   echo ${RedF}[x][warning]${BlueF}[Ettercap][${RedF} Not Found In ${YellowF}'->'${RedF} $find2 ${BlueF}]${Reset};
   echo "_::$dtr::=>::Ettercap::bug::not::found::in::=>::$find2::" >> /tmp/dtr.log
   # chose to config settings or download from network
   QuE=$(zenity --question --title="WARNING: TOOLKIT_CONFIG" --text "Edit 'toolkit_config' file to fix path to ettercap?\n(check etter.dns and etter.conf paths too)\n\nChosing [ NO ] will 'apt-get install ettercap'" --width 450) > /dev/null 2>&1
     if [ "$?" -eq "0" ]; then
       find2=`cat toolkit_config | egrep -m 1 "ETTERCAP_INSTALL_PATH" | cut -d '=' -f2`
       rep=$(zenity --title="ENTER ETTERCAP INSTALL PATH" --text "Open terminal and write: locate ettercap" --entry --width 320) > /dev/null 2>&1
       sed "s|$find2|$rep|g" toolkit_config > copy.int
       mv copy.int toolkit_config > /dev/null 2<&1
       echo ${RedF}[x]${BlueF}[${YellowF}setting ettercap path ${GreenF}'->'${YellowF} FIXED ${BlueF}]${Reset};

     else

       sleep 2
       # missing dependencie - install
       echo ${BlueF}[${GreenF}✔${BlueF}][Please wait][${GreenF} DOWNLOADING FROM NETWORK ${BlueF}]${Reset};
       echo ""
       sudo apt-get install ettercap-text-only ettercap-graphical
       echo ""
     fi
fi
sleep 2

 
 
   #check if apache exists
   if [ -d $apache ]; then
   echo ${BlueF}[${GreenF}✔${BlueF}][Apache]...................[${GreenF} Installation found ${BlueF}]${Reset};
 
else
 
   dtr=`date`
   M1ss=yes
   # missing dependencie OR wrong path config
   echo ${RedF}[x][warning]${BlueF}[Apache2][${RedF} Not Found In ${YellowF}'->'${RedF} $apache ${BlueF}]${Reset};
   echo "_::$dtr::=>::Apache2::bug::not::found::in::=>::$apache::" >> /tmp/dtr.log 
   # chose to config settings or download from network
   QuE=$(zenity --question --title="WARNING: TOOLKIT_CONFIG" --text "Edit 'toolkit_config' file to fix path to apache2?\nChosing [ NO ] will 'apt-get install apache2'" --width 450) > /dev/null 2>&1
     if [ "$?" -eq "0" ]; then
       apache=`cat toolkit_config | egrep -m 1 "APACHE_INSTALL_PATH" | cut -d '=' -f2`
       rep=$(zenity --title="ENTER APACHE2 INSTALL PATH" --text "Open terminal and write: locate apache2" --entry --width 320) > /dev/null 2>&1
       sed "s|$apache|$rep|g" toolkit_config > copy.int
       mv copy.int toolkit_config > /dev/null 2<&1
       echo ${RedF}[x]${BlueF}[${YellowF}setting apache2 path ${GreenF}'->'${YellowF} FIXED ${BlueF}]${Reset};

     else

       sleep 2
       # missing dependencie - install
       echo ${BlueF}[${GreenF}✔${BlueF}][Please wait][${GreenF} DOWNLOADING FROM NETWORK ${BlueF}]${Reset};
       echo ""
       sudo apt-get install apache2
       echo ""
     fi
fi
sleep 2
 

 
   #check if zenity exists
   if [ -e $Z3n ]; then
   echo ${BlueF}[${GreenF}✔${BlueF}][Zenity]...................[${GreenF} Installation found ${BlueF}]${Reset};
 
else
 
   dtr=`date`
   M1ss=yes
   # missing dependencie - install
   echo ${RedF}[x][warning]${BlueF}[Zenity][${RedF} Not Found In ${YellowF}'->'${RedF} $Z3n ${BlueF}]${Reset};
   echo "_::$dtr::=>::zenity::bug::dependencie::not::found::in::=>$Z3n::" >> /tmp/dtr.log

     sleep 2
     # missing dependencie - install
     echo ${BlueF}[${GreenF}✔${BlueF}][Please wait][${GreenF} DOWNLOADING FROM NETWORK ${BlueF}]${Reset};
     echo ""
     sudo apt-get install zenity libnotify
     echo ""
fi
sleep 2

 
 
   # check if nmap installation exists
   if [ -d $find ]; then
   echo ${BlueF}[${GreenF}✔${BlueF}][Nmap].....................[${GreenF} Installation found ${BlueF}]${Reset};
 
else
 
   dtr=`date`
   M1ss=yes
   # missing dependencie OR wrong path config
   echo ${RedF}[x][warning]${BlueF}[Nmap][${RedF} Not Found In ${YellowF}'->'${RedF} $find ${BlueF}]${Reset};
   echo "_::$dtr::=>::Nmap::bug::not::found::in::=>::$find::" >> /tmp/dtr.log 
   # chose to config settings or download from network
   QuE=$(zenity --question --title="WARNING: TOOLKIT_CONFIG" --text "Edit 'toolkit_config' file to fix path to nmap?\nChosing [ NO ] will 'apt-get install nmap'" --width 450) > /dev/null 2>&1
     if [ "$?" -eq "0" ]; then
       find=`cat toolkit_config | egrep -m 1 "ZENMAP_INSTALL_PATH" | cut -d '=' -f2`
       rep=$(zenity --title="ENTER NMAP INSTALL PATH" --text "Open terminal and write: locate nmap" --entry --width 320) > /dev/null 2>&1
       sed "s|$find|$rep|g" toolkit_config > copy.int
       mv copy.int toolkit_config > /dev/null 2<&1
       echo ${RedF}[x]${BlueF}[${YellowF}setting nmap path ${GreenF}'->'${YellowF} FIXED ${BlueF}]${Reset};

     else

       sleep 2
       # missing dependencie - install
       echo ${BlueF}[${GreenF}✔${BlueF}][Please wait][${GreenF} DOWNLOADING FROM NETWORK ${BlueF}]${Reset};
       echo ""
       sudo apt-get install nmap
       echo ""
     fi
fi
sleep 2
 
 
   # check for INURLBR dependencies (php5 and curl)
   if [ -e $CuRl ]; then
   echo ${BlueF}[${GreenF}✔${BlueF}][Curl].....................[${GreenF} Installation found ${BlueF}]${Reset};
   sleep 2
   if [ -e $PhP ]; then
   echo ${BlueF}[${GreenF}✔${BlueF}][php5].....................[${GreenF} Installation found ${BlueF}]${Reset};
 
else
 
   echo ""
   dtr=`date`
   M1ss=yes
   # not found dependencies = install
   echo ${RedF}[x]${BlueF}[INURLBR dependencies][${RedF} FAIL ${BlueF}]${Reset};
   echo "_::$dtr::=>::inurlbr::bug::dependencies::not::found::" >> /tmp/dtr.log

     sleep 2
     # missing dependencie - install
     echo ${BlueF}[${GreenF}✔${BlueF}][Please wait][${GreenF} DOWNLOADING FROM NETWORK ${BlueF}]${Reset};
     echo ${BlueF}[${GreenF}✔${BlueF}][Installing]:${YellowF}curl'::'libcurl3'::'libcurl3-dev'::'php5'::'php5-curl'::'php5-cli'::' ${Reset};
     echo ""
     sudo apt-get install curl libcurl3 libcurl3-dev php5 php5-cli php5-curl
     /etc/init.d/apache2 restart > /dev/null 2>&1
     echo ""
  fi
fi
sleep 2








# -----------------------------------------------
# BUILD SHORTCUT (special thanks to Igor Eduardo) 
# -----------------------------------------------
QuE=$(zenity --question --title "BUILD A SHORTCUT?" --text "build a shortcut to netool toolkit?" --width 300) > /dev/null 2>&1
  if [ "$?" -eq "0" ]; then
    # check if gnome-desktop-item-edit its installed
    desk=`which gnome-desktop-item-edit`
    if [ "$?" -eq "0" ]; then

      # present help and start gnome-desktop-item-edit
      echo ${BlueF}[${GreenF}✔${BlueF}][build shortcut]...........[${GreenF} RUNNING ${BlueF}]${Reset};
      sleep 2
      echo ""
      echo ${white}  in ${GreenF}type${white} select ${GreenF}application on the console${Reset};
      echo ${white}  in ${GreenF}name${white} write ${GreenF}netool toolkit${Reset};
      echo ${white}  in ${GreenF}command${white} write ${GreenF}sudo /path/to/netool.sh${Reset};
      echo ${white}  in ${GreenF}comment${white} write ${GreenF}MITM pentesting toolkit${Reset};
      echo ""
      sleep 2
      sudo gnome-desktop-item-edit /usr/share/applications/netool.desktop --create-new

    else

      echo ${RedF}[x]${BlueF}[gnome-desktop-item-edit]..[${RedF} NOT FOUND ${BlueF}]${Reset};
      echo ${BlueF}[${GreenF}✔${BlueF}][Please wait][${GreenF} DOWNLOADING FROM NETWORK ${BlueF}]${Reset};
      sleep 2
      echo ""
      sudo apt-get install --no-install-recommends gnome-panel
      echo ""
      # present help and start gnome-desktop-item-edit
      echo ${BlueF}[${GreenF}✔${BlueF}][build shortcut]...........[${GreenF} RUNNING ${BlueF}]${Reset};
      echo ${white}  in ${GreenF}type${white} select ${GreenF}application on the console${Reset};
      echo ${white}  in ${GreenF}name${white} write ${GreenF}netool toolkit${Reset};
      echo ${white}  in ${GreenF}command${white} write ${GreenF}sudo /path/to/netool.sh${Reset};
      echo ${white}  in ${GreenF}comment${white} write ${GreenF}MITM pentesting toolkit${Reset};
      echo ""
      sudo gnome-desktop-item-edit /usr/share/applications/netool.desktop --create-new
    fi

  else
    echo ${BlueF}[${GreenF}✔${BlueF}][build shortcut]...........[${YellowF} ABORTED ${BlueF}]${Reset};
    sleep 2
fi







# ----------------------------------------------------
# display dependencies current state and build logfile
# ----------------------------------------------------
   echo "_::" >> /tmp/dtr.log
   echo "_::EOF" >> /tmp/dtr.log
   if [ "$M1ss" "=" "yes" ]; then
     # warn user that dependencies are partially installed
     echo ${BlueF}[${GreenF}✔${BlueF}][FINISHING INSTALLER]......[${RedF} WITH SOME ERRORS ${BlueF}]${Reset};
     rm /tmp/dtr.log > /dev/null 2>&1
     sleep 2
 
else
 
  # everything ok :D
  echo ${BlueF}[${GreenF}✔${BlueF}][FINISHING INSTALLER]......[${GreenF} OK ${BlueF}]${Reset};
  rm /tmp/dtr.log > /dev/null 2>&1
fi
sleep 2





 
# ----------------------------------------
# END INSTALL DEPENDENCIES
# ----------------------------------------
 
   # display toolkit current install path clean old files and run the tool
   if [ "$default" "=" "yes" ]; then
     echo ${BlueF}[${GreenF}✔${BlueF}]['Install' Path][${GreenF} $rpath/netool.sh ${BlueF}]${Reset};
     sleep 2
     cp $H0m3/dtr.log $rpath/logs/dtr.log > /dev/null 2>&1
     echo ${RedF}_${Reset};
     echo ${BlueF}[➽][ PRESS${GreenF} ENTER ${BlueF}TO START T00LKIT ]${Reset};
     read op && clear
     sudo $rpath/netool.sh
 
   else
 
     # display toolkit current install path clean old files and run the tool
     echo ${BlueF}[${GreenF}✔${BlueF}]['Install' Path][${GreenF} $spath/netool.sh ${BlueF}]${Reset};
     sleep 2
     cp $H0m3/dtr.log $spath/logs/dtr.log > /dev/null 2>&1
     echo ${RedF}_${Reset};
     echo ${BlueF}[➽][ PRESS${GreenF} ENTER ${BlueF}TO START T00LKIT ]${Reset};
     read op && clear
     sudo $spath/netool.sh
 
fi
