local function arrayToString(arr)
	local s = ""
	local sortedNames = {}
	for k, v in pairs(arr) do
		table.insert(sortedNames, STRINGS.NAMES[string.upper(v)])
	end
	table.sort(sortedNames)
	for k, v in pairs(sortedNames) do
		s = s .. v .. ", "
	end
	s = s:sub(1,-3)
	return s
end

--ToDo fix the error and uncopypasta this at some point

function currenteatfish(self,eatfish) self.inst.currenteatfish:set(eatfish) end
function currenteatturkey(self,eatturkey) self.inst.currenteatturkey:set(eatturkey) end
function currenteatpepper(self,eatpepper) self.inst.currenteatpepper:set(eatpepper) end
function currenteatbacon(self,eatbacon) self.inst.currenteatbacon:set(eatbacon) end
function currenteatmole(self,eatmole) self.inst.currenteatmole:set(eatmole) end
function currentsleeptent(self,sleeptent) self.inst.currentsleeptent:set(sleeptent) end
function currentsleepsiesta(self,sleepsiesta) self.inst.currentsleepsiesta:set(sleepsiesta) end
function currentreviveamulet(self,reviveamulet) self.inst.currentreviveamulet:set(reviveamulet) end
function currentfeedplayer(self,feedplayer) self.inst.currentfeedplayer:set(feedplayer) end
function currentbathbomb(self,bathbomb) self.inst.currentbathbomb:set(bathbomb) end
function currentevilflower(self,evilflower) self.inst.currentevilflower:set(evilflower) end
function currentroses(self,roses) self.inst.currentroses:set(roses) end
function currentdmgnodmg(self,dmgnodmg) self.inst.currentdmgnodmg:set(dmgnodmg) end
function currentbullkelp(self,bullkelp) self.inst.currentbullkelp:set(bullkelp) end
function currenthorrorhound(self,horrorhound) self.inst.currenthorrorhound:set(horrorhound) end
function currentslurtle(self,slurtle) self.inst.currentslurtle:set(slurtle) end
function currentwerepig(self,werepig) self.inst.currentwerepig:set(werepig) end
function currentfruitdragon(self,fruitdragon) self.inst.currentfruitdragon:set(fruitdragon) end
function currenttreeguard(self,treeguard) self.inst.currenttreeguard:set(treeguard) end
function currentspiderqueen(self,spiderqueen) self.inst.currentspiderqueen:set(spiderqueen) end
function currentvarg(self,varg) self.inst.currentvarg:set(varg) end
function currentkoaelefant(self,koaelefant) self.inst.currentkoaelefant:set(koaelefant) end
function currentmonkey(self,monkey) self.inst.currentmonkey:set(monkey) end
function currentbirchnut(self,birchnut) self.inst.currentbirchnut:set(birchnut) end
function currentrider(self,rider) self.inst.currentrider:set(rider) end
function currentfullsanity(self,fullsanity) self.inst.currentfullsanity:set(fullsanity) end
function currentfullhunger(self,fullhunger) self.inst.currentfullhunger:set(fullhunger) end
function currentpacifist(self,pacifist) self.inst.currentpacifist:set(pacifist) end

function currentsupereatamount(self,supereatamount) self.inst.currentsupereatamount:set(supereatamount) end
function currenteatmonsterlasagnaamount(self,eatmonsterlasagnaamount) self.inst.currenteatmonsterlasagnaamount:set(eatmonsterlasagnaamount) end
function currentmessiahamount(self,messiahamount) self.inst.currentmessiahamount:set(messiahamount) end
function currentwalktime(self,walktime) self.inst.currentwalktime:set(walktime) end
function currentemeralds(self,emeralds) self.inst.currentemeralds:set(emeralds) end

function currentcitrins(self,citrins) self.inst.currentcitrins:set(citrins) end
function currentambers(self,ambers) self.inst.currentambers:set(ambers) end
function currentsaddles(self,saddles) self.inst.currentsaddles:set(saddles) end
function currentbananas(self,bananas) self.inst.currentbananas:set(bananas) end
function currentspores(self,spores) self.inst.currentspores:set(spores) end
function currentblueprints(self,blueprints) self.inst.currentblueprints:set(blueprints) end
function currentboats(self,boats) self.inst.currentboats:set(boats) end
function currentmoonrocks(self,moonrocks) self.inst.currentmoonrocks:set(moonrocks) end
function currentgnomes(self,gnomes) self.inst.currentgnomes:set(gnomes) end
function currentmosquitos(self,mosquitos) self.inst.currentmosquitos:set(mosquitos) end

function currentstoptime(self,stoptime) self.inst.currentstoptime:set(stoptime) end
function currentevilamount(self,evilamount) self.inst.currentevilamount:set(evilamount) end
function currentdeathalotamount(self,deathalotamount) self.inst.currentdeathalotamount:set(deathalotamount) end
function currentnosanitytime(self,nosanitytime) self.inst.currentnosanitytime:set(nosanitytime) end
function currentsnakeamount(self,snakeamount) self.inst.currentsnakeamount:set(snakeamount) end
function currentpigfriendamount(self,pigfriendamount) self.inst.currentpigfriendamount:set(pigfriendamount) end
function currentfriendbunnyamount(self,friendbunnyamount) self.inst.currentfriendbunnyamount:set(friendbunnyamount) end
function currentfishamount(self,fishamount) self.inst.currentfishamount:set(fishamount) end
function currentpickamount(self,pickamount) self.inst.currentpickamount:set(pickamount) end
function currentchopamount(self,chopamount) self.inst.currentchopamount:set(chopamount) end
function currentcookamount(self,cookamount) self.inst.currentcookamount:set(cookamount) end
function currentmineamount(self,mineamount) self.inst.currentmineamount:set(mineamount) end
function currentbuildamount(self,buildamount) self.inst.currentbuildamount:set(buildamount) end
function currentattackeddamage(self,attackeddamage) self.inst.currentattackeddamage:set(attackeddamage) end
function currentangryamount(self,angryamount) self.inst.currentangryamount:set(angryamount) end
function currentstarvetime(self,starvetime) self.inst.currentstarvetime:set(starvetime) end
function currenticetime(self,icetime) self.inst.currenticetime:set(icetime) end
function currentfiretime(self,firetime) self.inst.currentfiretime:set(firetime) end
function currentmoisttime(self,moisttime) self.inst.currentmoisttime:set(moisttime) end
function currentage(self,age) self.inst.currentage:set(age) end

function currentfriendcatamount(self,friendcatamount) self.inst.currentfriendcatamount:set(friendcatamount) end
function currentbutcheramount(self,butcheramount) self.inst.currentbutcheramount:set(butcheramount) end
function currentgoatperdamount(self,goatperdamount) self.inst.currentgoatperdamount:set(goatperdamount) end
function currentmosslingamount(self,mosslingamount) self.inst.currentmosslingamount:set(mosslingamount) end
function currentweetuskamount(self,weetuskamount) self.inst.currentweetuskamount:set(weetuskamount) end
function currentnatureamount(self,natureamount) self.inst.currentnatureamount:set(natureamount) end
function currenthentaiamount(self,hentaiamount) self.inst.currenthentaiamount:set(hentaiamount) end

function currenteatall(self,eatall) self.inst.currenteatall:set(eatall) end

function currentgiantPlants(self,giantPlants) self.inst.currentgiantPlants:set(giantPlants) end

function currentfriendspideramount(self,friendspideramount) self.inst.currentfriendspideramount:set(friendspideramount) end
function currenttradeamount(self,tradeamount) self.inst.currenttradeamount:set(tradeamount) end
function currentfuzzyamount(self,fuzzyamount) self.inst.currentfuzzyamount:set(fuzzyamount) end
function currentcavetime(self,cavetime) self.inst.currentcavetime:set(cavetime) end
function currenteathotamount(self,eathotamount) self.inst.currenteathotamount:set(eathotamount) end
function currenteatcoldamount(self,eatcoldamount) self.inst.currenteatcoldamount:set(eatcoldamount) end
function currentdanceamount(self,danceamount) self.inst.currentdanceamount:set(danceamount) end
function currentstarspent(self,starspent) self.inst.currentstarspent:set(starspent) end
function currentfriendrocky(self,friendrocky) self.inst.currentfriendrocky:set(friendrocky) end
function currentteleportamount(self,teleportamount) self.inst.currentteleportamount:set(teleportamount) end

function currentruncount(self,runcount) self.inst.currentruncount:set(runcount) end

function checkintogame(self,intogame) local c = 0 if intogame then c=1 end self.inst.checkintogame:set(c) end
function checkfirsteat(self,firsteat) local c = 0 if firsteat then c=1 end self.inst.checkfirsteat:set(c) end
function checksupereat(self,supereat) local c = 0 if supereat then c=1 end self.inst.checksupereat:set(c) end
function checkeatmonsterlasagna(self,eatmonsterlasagna) local c = 0 if eatmonsterlasagna then c=1 end self.inst.checkeatmonsterlasagna:set(c) end
function checkmessiah(self,messiah) local c = 0 if messiah then c=1 end self.inst.checkmessiah:set(c) end
function checkemerald(self,emerald) local c = 0 if emerald then c=1 end self.inst.checkemerald:set(c) end
function checkcitrin(self,citrin) local c = 0 if citrin then c=1 end self.inst.checkcitrin:set(c) end
function checkamber(self,amber) local c = 0 if amber then c=1 end self.inst.checkamber:set(c) end
function checksaddle(self,saddle) local c = 0 if saddle then c=1 end self.inst.checksaddle:set(c) end
function checkbanana(self,banana) local c = 0 if banana then c=1 end self.inst.checkbanana:set(c) end
function checkspore(self,spore) local c = 0 if spore then c=1 end self.inst.checkspore:set(c) end
function checkblueprint(self,blueprint) local c = 0 if blueprint then c=1 end self.inst.checkblueprint:set(c) end
function checkboat(self,boat) local c = 0 if boat then c=1 end self.inst.checkboat:set(c) end
function checkmoonrock(self,moonrock) local c = 0 if moonrock then c=1 end self.inst.checkmoonrock:set(c) end
function checkgnome(self,gnome) local c = 0 if gnome then c=1 end self.inst.checkgnome:set(c) end
function checkmosquito(self,mosquito) local c = 0 if mosquito then c=1 end self.inst.checkmosquito:set(c) end

function checkwalkalot(self,walkalot) local c = 0 if walkalot then c=1 end self.inst.checkwalkalot:set(c) end
function checkstopalot(self,stopalot) local c = 0 if stopalot then c=1 end self.inst.checkstopalot:set(c) end
function checktooyoung(self,tooyoung) local c = 0 if tooyoung then c=1 end self.inst.checktooyoung:set(c) end
function checkevil(self,evil) local c = 0 if evil then c=1 end self.inst.checkevil:set(c) end
function checksnake(self,snake) local c = 0 if snake then c=1 end self.inst.checksnake:set(c) end
function checkdeathalot(self,deathalot) local c = 0 if deathalot then c=1 end self.inst.checkdeathalot:set(c) end
function checknosanity(self,nosanity) local c = 0 if nosanity then c=1 end self.inst.checknosanity:set(c) end
function checksick(self,sick) local c = 0 if sick then c=1 end self.inst.checksick:set(c) end
function checkcoldblood(self,coldblood) local c = 0 if coldblood then c=1 end self.inst.checkcoldblood:set(c) end
function checkburn(self,burn) local c = 0 if burn then c=1 end self.inst.checkburn:set(c) end
function checkfreeze(self,freeze) local c = 0 if freeze then c=1 end self.inst.checkfreeze:set(c) end
function checkpigfriend(self,pigfriend) local c = 0 if pigfriend then c=1 end self.inst.checkpigfriend:set(c) end
function checkfriendbunny(self,friendbunny) local c = 0 if friendbunny then c=1 end self.inst.checkfriendbunny:set(c) end
function checkfishmaster(self,fishmaster) local c = 0 if fishmaster then c=1 end self.inst.checkfishmaster:set(c) end
function checkpickmaster(self,pickmaster) local c = 0 if pickmaster then c=1 end self.inst.checkpickmaster:set(c) end
function checkchopmaster(self,chopmaster) local c = 0 if chopmaster then c=1 end self.inst.checkchopmaster:set(c) end
function checknoob(self,noob) local c = 0 if noob then c=1 end self.inst.checknoob:set(c) end
function checkcookmaster(self,cookmaster) local c = 0 if cookmaster then c=1 end self.inst.checkcookmaster:set(c) end
function checklongage(self,longage) local c = 0 if longage then c=1 end self.inst.checklongage:set(c) end
--function checkluck(self,luck) local c = 0 if luck then c=1 end self.inst.checkluck:set(c) end
function checkblack(self,black) local c = 0 if black then c=1 end self.inst.checkblack:set(c) end
function checkbuildmaster(self,buildmaster) local c = 0 if buildmaster then c=1 end self.inst.checkbuildmaster:set(c) end
function checktank(self,tank) local c = 0 if tank then c=1 end self.inst.checktank:set(c) end
function checkangry(self,angry) local c = 0 if angry then c=1 end self.inst.checkangry:set(c) end
function checkicebody(self,icebody) local c = 0 if icebody then c=1 end self.inst.checkicebody:set(c) end
function checkfirebody(self,firebody) local c = 0 if firebody then c=1 end self.inst.checkfirebody:set(c) end
function checkrigid(self,rigid) local c = 0 if rigid then c=1 end self.inst.checkrigid:set(c) end
function checkancient(self,ancient) local c = 0 if ancient then c=1 end self.inst.checkancient:set(c) end
function checkqueen(self,queen) local c = 0 if queen then c=1 end self.inst.checkqueen:set(c) end
function checkking(self,king) local c = 0 if king then c=1 end self.inst.checkking:set(c) end
function checkmoistbody(self,moistbody) local c = 0 if moistbody then c=1 end self.inst.checkmoistbody:set(c) end
function checkall(self,all) local c = 0 if all then c=1 end self.inst.checkall:set(c) end
function checkminotaur(self,minotaur) local c = 0 if minotaur then c=1 end self.inst.checkminotaur:set(c) end
function checkdragonfly(self,dragonfly) local c = 0 if dragonfly then c=1 end self.inst.checkdragonfly:set(c) end
function checkmalbatross(self,malbatross) local c = 0 if malbatross then c=1 end self.inst.checkmalbatross:set(c) end
function checkcrabking(self,crabking) local c = 0 if crabking then c=1 end self.inst.checkcrabking:set(c) end

function checkpickappren(self,pickappren) local c = 0 if pickappren then c=1 end self.inst.checkpickappren:set(c) end
function checkchopappren(self,chopappren) local c = 0 if chopappren then c=1 end self.inst.checkchopappren:set(c) end
function checkcookappren(self,cookappren) local c = 0 if cookappren then c=1 end self.inst.checkcookappren:set(c) end
function checkmineappren(self,mineappren) local c = 0 if mineappren then c=1 end self.inst.checkmineappren:set(c) end
function checkminemaster(self,minemaster) local c = 0 if minemaster then c=1 end self.inst.checkminemaster:set(c) end
function checkbuildappren(self,buildappren) local c = 0 if buildappren then c=1 end self.inst.checkbuildappren:set(c) end
function checksanta(self,santa) local c = 0 if santa then c=1 end self.inst.checksanta:set(c) end
function checkknight(self,knight) local c = 0 if knight then c=1 end self.inst.checkknight:set(c) end
function checkbishop(self,bishop) local c = 0 if bishop then c=1 end self.inst.checkbishop:set(c) end
function checkrook(self,rook) local c = 0 if rook then c=1 end self.inst.checkrook:set(c) end
function checkstarve(self,starve) local c = 0 if starve then c=1 end self.inst.checkstarve:set(c) end
function checkfriendcat(self,friendcat) local c = 0 if friendcat then c=1 end self.inst.checkfriendcat:set(c) end
function checkrose(self,rose) local c = 0 if rose then c=1 end self.inst.checkrose:set(c) end
function checkbutcher(self,butcher) local c = 0 if butcher then c=1 end self.inst.checkbutcher:set(c) end
function checkgoatperd(self,goatperd) local c = 0 if goatperd then c=1 end self.inst.checkgoatperd:set(c) end
function checkmossling(self,mossling) local c = 0 if mossling then c=1 end self.inst.checkmossling:set(c) end
function checkweetusk(self,weetusk) local c = 0 if weetusk then c=1 end self.inst.checkweetusk:set(c) end
function checksecondchance(self,secondchance) local c = 0 if secondchance then c=1 end self.inst.checksecondchance:set(c) end
function checknature(self,nature) local c = 0 if nature then c=1 end self.inst.checknature:set(c) end
function checkhutch(self,hutch) local c = 0 if hutch then c=1 end self.inst.checkhutch:set(c) end
function checkhentai(self,hentai) local c = 0 if hentai then c=1 end self.inst.checkhentai:set(c) end
function checkalldiet(self,alldiet) local c = 0 if alldiet then c=1 end self.inst.checkalldiet:set(c) end
function checkallgiantPlants(self,allgiantPlants) local c = 0 if allgiantPlants then c=1 end self.inst.checkallgiantPlants:set(c) end
function checkfriendspider(self,friendspider) local c = 0 if friendspider then c=1 end self.inst.checkfriendspider:set(c) end
function checksleep(self,sleep) local c = 0 if sleep then c=1 end self.inst.checksleep:set(c) end
function checktrader(self,trader) local c = 0 if trader then c=1 end self.inst.checktrader:set(c) end
function checkfuzzy(self,fuzzy) local c = 0 if fuzzy then c=1 end self.inst.checkfuzzy:set(c) end

function checkpet(self,pet) local c = 0 if pet then c=1 end self.inst.checkpet:set(c) end
function checkcaveage(self,caveage) local c = 0 if caveage then c=1 end self.inst.checkcaveage:set(c) end
function checkbirdclop(self,birdclop) local c = 0 if birdclop then c=1 end self.inst.checkbirdclop:set(c) end
function checkeathot(self,eathot) local c = 0 if eathot then c=1 end self.inst.checkeathot:set(c) end
function checkeatcold(self,eatcold) local c = 0 if eatcold then c=1 end self.inst.checkeatcold:set(c) end
function checkrot(self,rot) local c = 0 if rot then c=1 end self.inst.checkrot:set(c) end
function checkknowledge(self,knowledge) local c = 0 if knowledge then c=1 end self.inst.checkknowledge:set(c) end
function checkdance(self,dance) local c = 0 if dance then c=1 end self.inst.checkdance:set(c) end
function checkoldage(self,oldage) local c = 0 if oldage then c=1 end self.inst.checkoldage:set(c) end
function checksuperstar(self,superstar) local c = 0 if superstar then c=1 end self.inst.checksuperstar:set(c) end
function checkrocklob(self,rocklob) local c = 0 if rocklob then c=1 end self.inst.checkrocklob:set(c) end
function checkteleport(self,teleport) local c = 0 if teleport then c=1 end self.inst.checkteleport:set(c) end

function checkeatfish(self,eatfish) local c = 0 if eatfish then c=1 end self.inst.checkeatfish:set(c) end
function checkeatturkey(self,eatturkey) local c = 0 if eatturkey then c=1 end self.inst.checkeatturkey:set(c) end
function checkeatpepper(self,eatpepper) local c = 0 if eatpepper then c=1 end self.inst.checkeatpepper:set(c) end
function checkeatbacon(self,eatbacon) local c = 0 if eatbacon then c=1 end self.inst.checkeatbacon:set(c) end
function checkeatmole(self,eatmole) local c = 0 if eatmole then c=1 end self.inst.checkeatmole:set(c) end
function checksleeptent(self,sleeptent) local c = 0 if sleeptent then c=1 end self.inst.checksleeptent:set(c) end
function checksleepsiesta(self,sleepsiesta) local c = 0 if sleepsiesta then c=1 end self.inst.checksleepsiesta:set(c) end
function checkreviveamulet(self,reviveamulet) local c = 0 if reviveamulet then c=1 end self.inst.checkreviveamulet:set(c) end
function checkfeedplayer(self,feedplayer) local c = 0 if feedplayer then c=1 end self.inst.checkfeedplayer:set(c) end
function checkbathbomb(self,bathbomb) local c = 0 if bathbomb then c=1 end self.inst.checkbathbomb:set(c) end
--function checkshadowchester(self,shadowchester) local c = 0 if shadowchester then c=1 end self.inst.checkshadowchester:set(c) end
--function checksnowchester(self,snowchester) local c = 0 if snowchester then c=1 end self.inst.checksnowchester:set(c) end
function checkmusichutch(self,musichutch) local c = 0 if musichutch then c=1 end self.inst.checkmusichutch:set(c) end
function checklavae(self,lavae) local c = 0 if lavae then c=1 end self.inst.checklavae:set(c) end
function checkevilflower(self,evilflower) local c = 0 if evilflower then c=1 end self.inst.checkevilflower:set(c) end
function checkroses(self,roses) local c = 0 if roses then c=1 end self.inst.checkroses:set(c) end
function checkdrown(self,drown) local c = 0 if drown then c=1 end self.inst.checkdrown:set(c) end
function checkdmgnodmg(self,dmgnodmg) local c = 0 if dmgnodmg then c=1 end self.inst.checkdmgnodmg:set(c) end
function checkbullkelp(self,bullkelp) local c = 0 if bullkelp then c=1 end self.inst.checkbullkelp:set(c) end
function checkhorrorhound(self,horrorhound) local c = 0 if horrorhound then c=1 end self.inst.checkhorrorhound:set(c) end
function checkslurtle(self,slurtle) local c = 0 if slurtle then c=1 end self.inst.checkslurtle:set(c) end
function checkwerepig(self,werepig) local c = 0 if werepig then c=1 end self.inst.checkwerepig:set(c) end
function checkfruitdragon(self,fruitdragon) local c = 0 if fruitdragon then c=1 end self.inst.checkfruitdragon:set(c) end
function checktreeguard(self,treeguard) local c = 0 if treeguard then c=1 end self.inst.checktreeguard:set(c) end
function checkspiderqueen(self,spiderqueen) local c = 0 if spiderqueen then c=1 end self.inst.checkspiderqueen:set(c) end
function checkvarg(self,varg) local c = 0 if varg then c=1 end self.inst.checkvarg:set(c) end
function checkkoaelefant(self,koaelefant) local c = 0 if koaelefant then c=1 end self.inst.checkkoaelefant:set(c) end
function checkmonkey(self,monkey) local c = 0 if monkey then c=1 end self.inst.checkmonkey:set(c) end
function checklightning(self,lightning) local c = 0 if lightning then c=1 end self.inst.checklightning:set(c) end
function checkbirchnut(self,birchnut) local c = 0 if birchnut then c=1 end self.inst.checkbirchnut:set(c) end
function checkrider(self,rider) local c = 0 if rider then c=1 end self.inst.checkrider:set(c) end
function checkfullsanity(self,fullsanity) local c = 0 if fullsanity then c=1 end self.inst.checkfullsanity:set(c) end
function checkfullhunger(self,fullhunger) local c = 0 if fullhunger then c=1 end self.inst.checkfullhunger:set(c) end
function checkpacifist(self,pacifist) local c = 0 if pacifist then c=1 end self.inst.checkpacifist:set(c) end

function checkbosswinter(self,bosswinter) local c = 0 if bosswinter then c=1 end self.inst.checkbosswinter:set(c) end
function checkbossspring(self,bossspring) local c = 0 if bossspring then c=1 end self.inst.checkbossspring:set(c) end
function checkbossantlion(self,bossantlion) local c = 0 if bossantlion then c=1 end self.inst.checkbossantlion:set(c) end
function checkbossautumn(self,bossautumn) local c = 0 if bossautumn then c=1 end self.inst.checkbossautumn:set(c) end

--my additions
function checkspider(self,spider) local c = 0 if spider then c=1 end self.inst.checkspider:set(c) end
function checkspider_warrior(self,spider_warrior) local c = 0 if spider_warrior then c=1 end self.inst.checkspider_warrior:set(c) end
function checkhound(self,hound) local c = 0 if hound then c=1 end self.inst.checkhound:set(c) end
function checkbee(self,bee) local c = 0 if bee then c=1 end self.inst.checkbee:set(c) end
function checkfrog(self,frog) local c = 0 if frog then c=1 end self.inst.checkfrog:set(c) end
function checkclockwork(self,clockwork) local c = 0 if clockwork then c=1 end self.inst.checkclockwork:set(c) end
function checkeye_of_terror(self,eye_of_terror) local c = 0 if eye_of_terror then c=1 end self.inst.checkeye_of_terror:set(c) end
function checktwin_of_terror1(self,twin_of_terror1) local c = 0 if twin_of_terror1 then c=1 end self.inst.checktwin_of_terror1:set(c) end
function checktwin_of_terror2(self,twin_of_terror2) local c = 0 if twin_of_terror2 then c=1 end self.inst.checktwin_of_terror2:set(c) end
function checktwins_of_terror(self,twins_of_terror) local c = 0 if twins_of_terror then c=1 end self.inst.checktwins_of_terror:set(c) end

function currentspider(self,spideramount) self.inst.currentspider:set(spideramount) end
function currentspider_warrior(self,spider_warrioramount) self.inst.currentspider_warrior:set(spider_warrioramount) end
function currenthound(self,houndamount) self.inst.currenthound:set(houndamount) end
function currentbee(self,beeamount) self.inst.currentbee:set(beeamount) end
function currentfrog(self,frogamount) self.inst.currentfrog:set(frogamount) end
function currentclockwork(self,clockworkamount) self.inst.currentclockwork:set(clockworkamount) end


function currenteatlist(self,eatlist) self.inst.currenteatlist:set(arrayToString(eatlist)) end
function currentgiantPlantList(self,giantPlantList) self.inst.currentgiantPlantList:set(arrayToString(giantPlantList)) end


function meta_event_table()
	local event_functions_table = {
		eatlist = currenteatlist,
		giantPlantList = currentgiantPlantList,


		intogame = checkintogame,
		firsteat = checkfirsteat,
		supereat = checksupereat,
		eatmonsterlasagna = checkeatmonsterlasagna,
		messiah = checkmessiah,
		emerald = checkemerald,
		walkalot = checkwalkalot,
		stopalot = checkstopalot,
		tooyoung = checktooyoung,
		evil = checkevil,
		snake = checksnake,
		deathalot = checkdeathalot,
		nosanity = checknosanity,
		sick = checksick,
		coldblood = checkcoldblood,
		burn = checkburn,
		freeze = checkfreeze,
		pigfriend = checkpigfriend,
		friendbunny = checkfriendbunny,
		fishmaster = checkfishmaster,
		pickmaster = checkpickmaster,
		pickappren = checkpickappren,
		chopmaster = checkchopmaster,
		chopappren = checkchopappren,
		noob = checknoob,
		cookmaster = checkcookmaster,
		cookappren = checkcookappren,
		longage = checklongage,
		--luck = checkluck,
		black = checkblack,
		buildmaster = checkbuildmaster,
		buildappren = checkbuildappren,
		mineappren = checkmineappren,
		minemaster = checkminemaster,
		tank = checktank,
		angry = checkangry,
		icebody = checkicebody,
		firebody = checkfirebody,
		rigid = checkrigid,
		ancient = checkancient,
		queen = checkqueen,
		king = checkking,
		moistbody = checkmoistbody,
		all = checkall,
		minotaur = checkminotaur,
		knight = checkknight,
		bishop = checkbishop,
		rook = checkrook,
		santa = checksanta,
		starve = checkstarve,
		friendcat = checkfriendcat,
		rose = checkrose,
		mossling = checkmossling,
		weetusk = checkweetusk,
		butcher = checkbutcher,
		goatperd = checkgoatperd,
		secondchance = checksecondchance,
		nature = checknature,
		alldiet = checkalldiet,
		allgiantPlants = checkallgiantPlants,
		hutch = checkhutch,
		friendspider = checkfriendspider,
		hentai = checkhentai,
		dragonfly = checkdragonfly,
		malbatross = checkmalbatross,
		crabking = checkcrabking,
		sleep = checksleep,
		trader = checktrader,
		fuzzy = checkfuzzy,
		pet = checkpet,
		birdclop = checkbirdclop,
		caveage = checkcaveage,
		eathot = checkeathot,
		eatcold = checkeatcold,
		rot = checkrot,
		knowledge = checkknowledge,
		dance = checkdance,
		oldage = checkoldage,
		superstar = checksuperstar,
		rocklob = checkrocklob,
		teleport = checkteleport,
		citrin = checkcitrin,
		amber = checkamber,
		saddle = checksaddle,
		banana = checkbanana,
		spore = checkspore,
		blueprint = checkblueprint,
		boat = checkboat,
		moonrock = checkmoonrock,
		gnome = checkgnome,
		mosquito = checkmosquito,
		supereatamount = currentsupereatamount,
		eatmonsterlasagnaamount = currenteatmonsterlasagnaamount,
		messiahamount = currentmessiahamount,
		walktime = currentwalktime,
		emeralds = currentemeralds,
		stoptime = currentstoptime,
		evilamount = currentevilamount,
		deathalotamount = currentdeathalotamount,
		nosanitytime = currentnosanitytime,
		snakeamount = currentsnakeamount,
		pigfriendamount = currentpigfriendamount,
		friendbunnyamount = currentfriendbunnyamount,
		fishamount = currentfishamount,
		pickamount = currentpickamount,
		chopamount = currentchopamount,
		cookamount = currentcookamount,
		buildamount = currentbuildamount,
		mineamount = currentmineamount,
		attackeddamage = currentattackeddamage,
		angryamount = currentangryamount,
		icetime = currenticetime,
		firetime = currentfiretime,
		moisttime = currentmoisttime,
		starvetime = currentstarvetime,
		age = currentage,
		friendcatamount = currentfriendcatamount,
		butcheramount = currentbutcheramount,
		weetuskamount = currentweetuskamount,
		mosslingamount = currentmosslingamount,
		goatperdamount = currentgoatperdamount,
		natureamount = currentnatureamount,
		eatall = currenteatall,
		giantPlants = currentgiantPlants,
		hentaiamount = currenthentaiamount,
		friendspideramount = currentfriendspideramount,
		tradeamount = currenttradeamount,
		fuzzyamount = currentfuzzyamount,
		cavetime = currentcavetime,
		eathotamount = currenteathotamount,
		eatcoldamount = currenteatcoldamount,
		danceamount = currentdanceamount,
		friendrocky = currentfriendrocky,
		teleportamount = currentteleportamount,
		starspent = currentstarspent,
		bosswinter = checkbosswinter,
		bossspring = checkbossspring,
		bossantlion = checkbossantlion,
		bossautumn = checkbossautumn,
		citrins = currentcitrins,
		ambers = currentambers,
		saddles = currentsaddles,
		bananas = currentbananas,
		spores = currentspores,
		blueprints = currentblueprints,
		boats = currentboats,
		moonrocks = currentmoonrocks,
		gnomes = currentgnomes,
		mosquitos = currentmosquitos,
		runcount = currentruncount,
		
		eatfish = checkeatfish,
		eatfishamount = currenteatfish,
		eatturkey = checkeatturkey,
		eatturkeyamount = currenteatturkey,
		eatpepper = checkeatpepper,
		eatpepperamount = currenteatpepper,
		eatbacon = checkeatbacon,
		eatbaconamount = currenteatbacon,
		eatmole = checkeatmole,
		eatmoleamount = currenteatmole,
		sleeptent = checksleeptent,
		sleeptentamount = currentsleeptent,
		sleepsiesta = checksleepsiesta,
		sleepsiestaamount = currentsleepsiesta,
		reviveamulet = checkreviveamulet,
		reviveamuletamount = currentreviveamulet,
		feedplayer = checkfeedplayer,
		feedplayeramount = currentfeedplayer,
		bathbomb = checkbathbomb,
		bathbombamount = currentbathbomb,
		--shadowchester = checkshadowchester,
		--snowchester = checksnowchester,
		musichutch = checkmusichutch,
		lavae = checklavae,
		evilflower = checkevilflower,
		evilfloweramount = currentevilflower,
		roses = checkroses,
		rosesamount = currentroses,
		drown = checkdrown,
		dmgnodmg = checkdmgnodmg,
		dmgnodmgamount = currentdmgnodmg,
		bullkelp = checkbullkelp,
		bullkelpamount = currentbullkelp,
		horrorhound = checkhorrorhound,
		horrorhoundamount = currenthorrorhound,
		slurtle = checkslurtle,
		slurtleamount = currentslurtle,
		werepig = checkwerepig,
		werepigamount = currentwerepig,
		fruitdragon = checkfruitdragon,
		fruitdragonamount = currentfruitdragon,
		treeguard = checktreeguard,
		treeguardamount = currenttreeguard,
		spiderqueen = checkspiderqueen,
		spiderqueenamount = currentspiderqueen,
		varg = checkvarg,
		vargamount = currentvarg,
		koaelefant = checkkoaelefant,
		koaelefantamount = currentkoaelefant,
		monkey = checkmonkey,
		monkeyamount = currentmonkey,
		lightning = checklightning,
		birchnut = checkbirchnut,
		birchnutamount = currentbirchnut,
		rider = checkrider,
		rideramount = currentrider,
		fullsanity = checkfullsanity,
		fullsanityamount = currentfullsanity,
		fullhunger = checkfullhunger,
		fullhungeramount = currentfullhunger,
		pacifist = checkpacifist,
		pacifistamount = currentpacifist,

		--my additions
		spideramount = currentspider,
		spider_warrioramount = currentspider_warrior,
		houndamount = currenthound,
		beeamount = currentbee,
		frogamount = currentfrog,
		clockworkamount = currentclockwork,
		
		spider = checkspider,
		spider_warrior = checkspider_warrior,
		hound = checkhound,
		bee = checkbee,
		frog = checkfrog,
		clockwork = checkclockwork,
		eye_of_terror = checkeye_of_terror,
		twin_of_terror1 = checktwin_of_terror1,
		twin_of_terror2 = checktwin_of_terror2,
		twins_of_terror = checktwins_of_terror,

	}

	--ToDo fix this and replace the above copypasta with it
	--[[
	local tmp = {}
	for _, name in pairs(achievements_table) do
		local check_name = "check"..name
		tmp[check_name] = function (self, name) 
			local c = 0 
			if name then 
				c=1 
			end 
			self.inst[check_name]:set(c) --errors here
		end
		event_functions_table[name] = tmp[check_name]
	end

	for _, name in pairs(cave_achievements_table) do
		local check_name = "check"..name
		tmp[check_name] = function (self, name) local c = 0 if name then c=1 end self.inst[check_name]:set(c) end
		event_functions_table[name] = tmp[check_name]
	end

	for _, name in pairs(amount_table) do
		local current_name = "current"..name
		tmp[current_name] = function (self, name) self.inst[current_name]:set(name) end
		event_functions_table[name] = tmp[current_name]
	end
	]]--
	--[[
	for i, v in pairs(event_functions_table) do
		print(i, v)
	end
	]]--
	return event_functions_table
end
