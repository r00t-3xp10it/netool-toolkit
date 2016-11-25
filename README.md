[![Version](https://img.shields.io/badge/NETOOL-4.6-brightgreen.svg?maxAge=259200)]()
[![Build](https://img.shields.io/badge/Supported_OS-linux-orange.svg)]()
[![Github All Releases](https://img.shields.io/github/downloads/atom/atom/total.svg)]()
[![AUR](https://img.shields.io/aur/license/yaourt.svg)]()


# NETOOL - MitM pentesting toolkit [ scan/sniff/exploit ]
    Version release : v4.6
    Author : pedro ubuntu  [ r00t-3xp10it ]
    Distros Supported : Linux Ubuntu, Kali, Mint, Parrot OS
    Suspicious-Shell-Activity (SSA) RedTeam develop @2016

# LEGAL DISCLAMER
    The author does not hold any responsibility about the bad use of this script,
    remmenber that attacking targets without prior concent its ilegal and punish
    by law, However you are allowed to protect yourselfe from any intruder by any
    meens necessary (using this tool the ethical way) please read the license.



# Framework description
    netool.sh toolkit provides a fast and easy way For new arrivals to IT security
    pentesting and also to experience users to use allmost all features that the
    Man-In-The-Middle can provide under local lan, since scanning, sniffing and
    social engeneering attacks (metasploit & veil needs to be manually installed)

    netool toolkit its 'divided' in 3 diferent categories, the first stage it will
    be scanning/gathering-information using Nmap framework, the second stage it will
    be sniffing/manipulation-of-tcp-packets using Ettercap framework and the last stage
    it will be using 'rootsector' module to deliver a payload to target (mitm+dns_spoof)

# Framework additional settings
    Additional tool settings can be configurated just by editing the 'toolkit_config'
    file befor running the tool, settings like: config paths to frameworks installed,
    and some internal toolkit settings.

# Dependencies
    Toolkit Dependencies : zenity, Nmap, Ettercap, Macchanger, Metasploit, Driftnet, Apache2, sslstrip
    INURLBR Dependencies : curl, libcurl3, libcurl3-dev, php5, php5-cli, php5-curl 



# Download/Install
    1º - Download framework from github
         tar.gz OR zip OR git clone

    2º - Install dependencies
         cd opensource
         sudo chmod +x INSTALL.sh && ./INSTALL.sh

    3º - Run main tool
         sudo ./netool.sh

# Credits
    Fyodor (nmap) | Alor & Naga (ettercap) | HD Moore (metasploit)
    Moxie M (sslstrip) | Chris L (driftnet) | j0rgan (cupp.py)
    ReL1K (unicorn.py) | Cleiton P (inurlbr.php) | KyRecon (shellter)
    Chris Tyler (zenity) and Rob McCool (apache).


_EOF

