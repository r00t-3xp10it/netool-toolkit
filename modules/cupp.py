#!/usr/bin/python
####
#
#  [Program]
#  CUPP 1.0
#  Common User Passwords Profiler
#
#  [Author]
#  Muris Kurgas aka j0rgan
#  jorganwd [at] gmail [dot] com
#
#
#  [License]
#  This program is free software; you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation; either version 3 of the License, or
#  any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program; if not, write to the Free Software
#  Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
#  See 'docs/LICENSE' for more information.
###







# -----------------------------
# inport libs
# -----------------------------
import sys
import os





# -----------------------------
# script colorize output
# -----------------------------
BLUE = '\033[94m'
RED = '\033[91m'
GREEN = '\033[32m'
WHITE  = '\033[0m'
ORANGE  = '\033[33m'
BUS = '\033[34m'




# ----------------------------
# framework banner
# ---------------------------

print ""
print RED+"                  ,__,             "
print RED+"                  (oo)____         "
print RED+"                  (__)    )\ "
print RED+"                     ||--|| *      "
print BLUE+"         'Common User Password Profiler'"
print BLUE+"        [Author] Muris Kurgas aka j0rgan"
print ""
print ""
print BUS+"[*] [input target info]:"+WHITE+" to make a dictionary [low cases!]"
print ORANGE+"[*] If you don't know all the info, just hit enter when asked!\r\n"






# --------------------------------
# start script functions
# --------------------------------
print WHITE+""
name = raw_input("> Name: ")
if len(name) == 0 or name == " " or name == "  " or name == "   ":
	print RED+"\r\n[x] You must enter a name at least!"
	print RED+"[X] Now exiting...\r\n"
        print WHITE+""
	sys.exit()

surname = raw_input("> Surname: ")
nick = raw_input("> Nickname: ")
birthdate = raw_input("> Birthdate (DDMMYYYY; i.e. 04111985): ")
if len(birthdate) != 0:
	if len(birthdate) != 8:
		print RED+"\r\n[x] You must enter 8 digits for birthday!"
		print RED+"[x] Now exiting...\r\n"
                print WHITE+""
		sys.exit()


print ""
wife = raw_input("> Wife's(husband's) name: ")
wifen = raw_input("> Wife's(husband's) nickname: ")
wifeb = raw_input("> Wife's(husband's) birthdate (DDMMYYYY; i.e. 04111985): ")
if len(wifeb) != 0:
	if len(wifeb) != 8:
		print RED+"\r\n[x] You must enter 8 digits for birthday!"
		print RED+"[x] Now exiting...\r\n"
                print WHITE+""
		sys.exit()


print ""
kid = raw_input("> Child's name: ")
kidn = raw_input("> Child's nickname: ")
kidb = raw_input("> Child's birthdate (DDMMYYYY; i.e. 04111985): ")
if len(kidb) != 0:
	if len(kidb) != 8:
		print RED+"\r\n[x] You must enter 8 digits for birthday!"
		print RED+"[X] Now exiting...\r\n"
                print WHITE+""
		sys.exit()


print ""
pet = raw_input("> Pet's name: ")
company = raw_input("> Company name: ")

print ""
words = ['']
oth = raw_input("> Do you want to add some key words about the victim? [Y/N]: ")
if oth == "y" or oth == "Y":
	words = raw_input("> Please enter the words, separated by comma. [i.e. hacker, juice, black]: ").split(", ")




print BUS+"\r\n[*] [please wait]:"+WHITE+" making a dictionary..."


# ----------------------------------------
# Now me must do some string modifications
# ----------------------------------------
birthdate_yy = birthdate[-2:]
birthdate_yyy = birthdate[-3:]
birthdate_yyyy = birthdate[-4:]
birthdate_xd = birthdate[1:2]
birthdate_xm = birthdate[3:4]
birthdate_dd = birthdate[:2]
birthdate_mm = birthdate[2:4]

wifeb_yy = wifeb[-2:]
wifeb_yyy = wifeb[-3:]
wifeb_yyyy = wifeb[-4:]
wifeb_xd = wifeb[1:2]
wifeb_xm = wifeb[3:4]
wifeb_dd = wifeb[:2]
wifeb_mm = wifeb[2:4]

kidb_yy = kidb[-2:]
kidb_yyy = kidb[-3:]
kidb_yyyy = kidb[-4:]
kidb_xd = kidb[1:2]
kidb_xm = kidb[3:4]
kidb_dd = kidb[:2]
kidb_mm = kidb[2:4]

# ----------------------------------
# Convert first letters to uppercase
# ----------------------------------
nameup = name.title()
surnameup = surname.title()
nickup = nick.title()
wifeup = wife.title()
wifenup = wifen.title()
kidup = kid.title()
kidnup = kidn.title()
petup = pet.title()
companyup = company.title()
wordsup = []
for words1 in words:
	wordsup.append(words1.title())

word = words+wordsup

# ------------------------------
# reverse a name
# -----------------------------
rev_name = name[::-1]
rev_nameup = nameup[::-1]
rev_nick = nick[::-1]
rev_nickup = nickup[::-1]
rev_wife = wife[::-1]
rev_wifeup = wifeup[::-1]
rev_kid = kid[::-1]
rev_kidup = kidup[::-1]

reverse = [rev_name, rev_nameup, rev_nick, rev_nickup, rev_wife, rev_wifeup, rev_kid, rev_kidup]
rev_n = [rev_name, rev_nameup, rev_nick, rev_nickup]
rev_w = [rev_wife, rev_wifeup]
rev_k = [rev_kid, rev_kidup]

# --------------------------------
# Let's do some serious work! This will be a mess of code, but... who cares? :)
# --------------------------------
bds = [birthdate_yy, birthdate_yyy, birthdate_yyyy, birthdate_xd, birthdate_xm, birthdate_dd, birthdate_mm]

bdss = []

for bds1 in bds:
	bdss.append(bds1)
	for bds2 in bds:
		if bds.index(bds1) != bds.index(bds2):
			bdss.append(bds1+bds2)
			for bds3 in bds:
				if bds.index(bds1) != bds.index(bds2) and bds.index(bds2) != bds.index(bds3) and bds.index(bds1) != bds.index(bds3):
					bdss.append(bds1+bds2+bds3)



# ---------------------------------
# For a woman
# ---------------------------------
wbds = [wifeb_yy, wifeb_yyy, wifeb_yyyy, wifeb_xd, wifeb_xm, wifeb_dd, wifeb_mm]

wbdss = []

for wbds1 in wbds:
	wbdss.append(wbds1)
	for wbds2 in wbds:
		if wbds.index(wbds1) != wbds.index(wbds2):
			wbdss.append(wbds1+wbds2)
			for wbds3 in wbds:
				if wbds.index(wbds1) != wbds.index(wbds2) and wbds.index(wbds2) != wbds.index(wbds3) and wbds.index(wbds1) != wbds.index(wbds3):
					wbdss.append(wbds1+wbds2+wbds3)



# ---------------------------------
# and a child
# ---------------------------------
kbds = [kidb_yy, kidb_yyy, kidb_yyyy, kidb_xd, kidb_xm, kidb_dd, kidb_mm]

kbdss = []

for kbds1 in kbds:
	kbdss.append(kbds1)
	for kbds2 in kbds:
		if kbds.index(kbds1) != kbds.index(kbds2):
			kbdss.append(kbds1+kbds2)
			for kbds3 in kbds:
				if kbds.index(kbds1) != kbds.index(kbds2) and kbds.index(kbds2) != kbds.index(kbds3) and kbds.index(kbds1) != kbds.index(kbds3):
					kbdss.append(kbds1+kbds2+kbds3)


# ---------------------------------
# string combinations
# ---------------------------------
kombinaac = [pet, petup, company, companyup]

kombina = [name, surname, nick, nameup, surnameup, nickup]

kombinaw = [wife, wifen, wifeup, wifenup, surname, surnameup]

kombinak = [kid, kidn, kidup, kidnup, surname, surnameup]

kombinaa = []
for kombina1 in kombina:
	kombinaa.append(kombina1)
	for kombina2 in kombina:
		if kombina.index(kombina1) != kombina.index(kombina2) and kombina.index(kombina1.title()) != kombina.index(kombina2.title()):
			kombinaa.append(kombina1+kombina2)

kombinaaw = []
for kombina1 in kombinaw:
	kombinaaw.append(kombina1)
	for kombina2 in kombinaw:
		if kombinaw.index(kombina1) != kombinaw.index(kombina2) and kombinaw.index(kombina1.title()) != kombinaw.index(kombina2.title()):
			kombinaaw.append(kombina1+kombina2)

kombinaak = []
for kombina1 in kombinak:
	kombinaak.append(kombina1)
	for kombina2 in kombinak:
		if kombinak.index(kombina1) != kombinak.index(kombina2) and kombinak.index(kombina1.title()) != kombinak.index(kombina2.title()):
			kombinaak.append(kombina1+kombina2)



# inserting some years, you can add more if you want...
years = ['2000', '2001', '2002', '2003', '2004', '2005', '2006', '2007', '2008', '2009', '2010']
# and some random numbers to make a pwnsauce.., :)
def concats(seq, start, stop):
    for mystr in seq:
        for num in xrange(start, stop):
            yield mystr + str(num)




# -----------------------------------
# now sorting and making combinations
# -----------------------------------
def komb(seq, start):
    for mystr in seq:
        for mystr1 in start:
            yield mystr + mystr1

komb1 = list(komb(kombinaa, bdss))
komb2 = list(komb(kombinaaw, wbdss))
komb3 = list(komb(kombinaak, kbdss))
komb4 = list(komb(kombinaa, years))
komb5 = list(komb(kombinaac, years))
komb6 = list(komb(kombinaaw, years))
komb7 = list(komb(kombinaak, years))
komb8 = list(komb(word, bdss))
komb9 = list(komb(word, wbdss))
komb10 = list(komb(word, kbdss))
komb11 = list(komb(word, years))
# adding random numbers from 0 to 1000, you can change this...
komb12 = list(concats(word, 0, 1000))
komb13 = list(concats(kombinaa, 0, 1000))
komb14 = list(concats(kombinaac, 0, 1000))
komb15 = list(concats(kombinaaw, 0, 1000))
komb16 = list(concats(kombinaak, 0, 1000))
komb17 = list(komb(reverse, years))
komb18 = list(komb(rev_w, years))
komb19 = list(komb(rev_k, kbdss))
komb20 = list(komb(rev_n, bdss))
komb21 = list(concats(reverse, 0, 1000))

print BUS+"[*]"+WHITE+" Sorting list and removing duplicates..."

komb_unique1 = dict.fromkeys(komb1).keys()
komb_unique2 = dict.fromkeys(komb2).keys()
komb_unique3 = dict.fromkeys(komb3).keys()
komb_unique4 = dict.fromkeys(komb4).keys()
komb_unique5 = dict.fromkeys(komb5).keys()
komb_unique6 = dict.fromkeys(komb6).keys()
komb_unique7 = dict.fromkeys(komb7).keys()
komb_unique8 = dict.fromkeys(komb8).keys()
komb_unique9 = dict.fromkeys(komb9).keys()
komb_unique10 = dict.fromkeys(komb10).keys()
komb_unique11 = dict.fromkeys(komb11).keys()
komb_unique12 = dict.fromkeys(komb12).keys()
komb_unique13 = dict.fromkeys(komb13).keys()
komb_unique14 = dict.fromkeys(komb14).keys()
komb_unique15 = dict.fromkeys(komb15).keys()
komb_unique16 = dict.fromkeys(komb16).keys()
komb_unique17 = dict.fromkeys(komb17).keys()
komb_unique18 = dict.fromkeys(komb18).keys()
komb_unique19 = dict.fromkeys(komb19).keys()
komb_unique20 = dict.fromkeys(komb20).keys()
komb_unique21 = dict.fromkeys(komb21).keys()
komb_unique01 = dict.fromkeys(kombinaa).keys()
komb_unique02 = dict.fromkeys(kombinaac).keys()
komb_unique03 = dict.fromkeys(kombinaaw).keys()
komb_unique04 = dict.fromkeys(kombinaak).keys()
komb_unique05 = dict.fromkeys(word).keys()

uniqlist = bdss+wbdss+kbdss+reverse+komb_unique01+komb_unique02+komb_unique03+komb_unique04+komb_unique05+komb_unique1+komb_unique2+komb_unique3+komb_unique4+komb_unique5+komb_unique6+komb_unique7+komb_unique8+komb_unique9+komb_unique10+komb_unique11+komb_unique12+komb_unique13+komb_unique14+komb_unique15+komb_unique16+komb_unique17+komb_unique18+komb_unique19+komb_unique20+komb_unique21

unique_list = dict.fromkeys(uniqlist).keys()


f = open ( name+'.txt', 'w' )
f.write (os.linesep.join(unique_list))
f.close()

lines = 0
fcount = open ( name+'.txt', 'r' )
for line in fcount:
	lines += 1

fcount.close()

print BUS+"[*]"+WHITE+" Saving dictionary to "+GREEN+"[opensource/logs/"+name+".txt]"+WHITE+", counting "+GREEN+"["+str(lines)+"]"+WHITE+" words."
print BUS+"[*]"+WHITE+" Now load your pistolero with "+GREEN+"["+name+".txt]"+WHITE+" and shoot! Good luck!"
print WHITE+""
print WHITE+""

# ---------------------------
# end of file
# ---------------------------
