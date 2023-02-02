require "components/eventfunctions"
require "components/helperfunctions"

require "components/achievement_list"

--Todo remove unneccessary comments

--Basics
local function findprefab(list,prefab)
    for index,value in pairs(list) do
        if value == prefab then
            return true
        end
    end
end

local function findindex(list,prefab)
    for index,value in pairs(list) do
        if value == prefab then
            return index
        end
    end
end

local function copylist(list)
	local tmp = {}
	for index,value in pairs(list) do
		table.insert(tmp,list[index])
	end
	return tmp
end

local allachivevent = Class(function(self, inst)
    self.inst = inst
    
    for i, name in pairs(achievements_table) do
        self[name] = false
    end

    for i, name in pairs(cave_achievements_table) do
        self[name] = false
    end

    for i, name in pairs(amount_table) do
        self[name] = 0
    end

    self.eatlist = copylist(foodmenu)
	self.giantPlantList = copylist(giantPlantList)
    
end,
nil,
meta_event_table()
)

function allachivevent:OnSave()  
    local data = {eatlist = self.eatlist, giantPlantList = self.giantPlantList}
    
    for _, name in pairs(achievements_table) do
        data[name] = self[name]
    end

    for _, name in pairs(cave_achievements_table) do
        data[name] = self[name]
    end

    for _, name in pairs(amount_table) do
        data[name] = self[name]
    end
    
    return data
end
function allachivevent:OnLoad(data)
    for achieve, value in pairs(data) do
        self[achieve] = value
    end
    self.eatlist = data.eatlist or copylist(foodmenu)
    self.giantPlantList = data.giantPlantList or copylist(giantPlantList)
end

--Grant Reward
function allachivevent:seffc(inst, tag)
    SpawnPrefab("seffc").entity:SetParent(inst.entity)
    local strname = STRINGS.ACHIEVEMENTS[tag].name
    local strinfo = STRINGS.ACHIEVEMENTS[tag].info
	if _G.NOTIFICATION then
		TheNet:Announce(inst:GetDisplayName().."   "..strinfo..STRINGS.GUI["space"]..STRINGS.GUI["complA"]..strname..STRINGS.GUI["br2"])
	end
	inst.components.talker:Say(STRINGS.GUI["br1"]..strname..STRINGS.GUI["br2"].."\n"..STRINGS.GUI["obt"]..allachiv_coinget[tag]..STRINGS.GUI["points"])
	
	if _G.NOAWARDS ~= true then
		inst.components.allachivcoin:coinDoDelta(allachiv_coinget[tag])
		inst.components.talker:Say(STRINGS.GUI["br1"]..strname..STRINGS.GUI["br2"].."\n"..STRINGS.GUI["obt"]..allachiv_coinget[tag]..STRINGS.GUI["points"])
	else
		inst.components.talker:Say(STRINGS.GUI["br1"]..strname..STRINGS.GUI["br2"])
	end
end

function allachivevent:intogamefn(inst)
    inst:DoTaskInTime(3, function()
        if self.intogame ~= true then
            self.intogame = true
            if inst:GetDisplayName() ~= nil and AchievementData[inst:GetDisplayName()] ~= nil then
                --print("LOAD")
                local achievements = AchievementData[inst:GetDisplayName()]
                
                for _, name in pairs(achievements_table) do
                    self[name] = achievements[name]
                end
                for _, name in pairs(cave_achievements_table) do
                    self[name] = achievements[name]
                end
                for _, name in pairs(amount_table) do
                    self[name] = achievements[name]
                end
                
                self.eatlist = achievements["eatlist"]
                self.giantPlantList = achievements["giantPlantList"]
                
                
                inst.components.allachivcoin.coinamount  = achievements["totalstar"]
                AchievementData[inst:GetDisplayName()] = nil
            else
                self:seffc(inst, "intogame")
                
                if self.all ~= true then
                    inst:DoTaskInTime(2, function()
						if _G.STARTGEAR_CONFIG == "fight" then 
							local item = SpawnPrefab("spear")				  
                            inst.components.inventory:GiveItem(item, nil, inst:GetPosition())
                            item = SpawnPrefab("armorwood")
                            inst.components.inventory:GiveItem(item, nil, inst:GetPosition())
							item = SpawnPrefab("boomerang")
                            inst.components.inventory:GiveItem(item, nil, inst:GetPosition())
						end
						if _G.STARTGEAR_CONFIG == "survive" then
							local item = SpawnPrefab("axe")
                            inst.components.inventory:GiveItem(item, nil, inst:GetPosition())
							item = SpawnPrefab("bonestew")				  
                            inst.components.inventory:GiveItem(item, nil, inst:GetPosition())
                            item = SpawnPrefab("backpack_blueprint")
                            inst.components.inventory:GiveItem(item, nil, inst:GetPosition())
							item = SpawnPrefab("bedroll_furry")
                            inst.components.inventory:GiveItem(item, nil, inst:GetPosition())
							item = SpawnPrefab("torch")
                            inst.components.inventory:GiveItem(item, nil, inst:GetPosition())
						end												
                    end)
                end
            end
        end
		if(_G.CAVES_CONFIG == false) then
            
            for _, name in pairs(cave_achievements_table) do
                self[name] = true
            end

			table.remove(self.eatlist,findindex(self.eatlist,"unagi"))
		end
        
        inst:DoTaskInTime(1, function()
			if inst.prefab == "wickerbottom" then
				self.sleeptent = true
				self.sleeptentamount = 12
				self.sleepsiesta = true
				self.sleepsiestaamount = 12
			end
			if inst.prefab == "wanda" then
				self.tooyoung = true
				self.rot = true
			end
			--Meatatarian case -> remove the veggie dishes from the eatlist.
			if inst.prefab == "wathgrithr" then
				self:updateMeatatarianFoodList()
			end
			-- Veggie case -> remove all meat dishes
			if inst.prefab == "wurt" then
				self:updateVeggieFoodList()
				self.eatmonsterlasagna = allachiv_eventdata["eatmonsterlasagna"]
				self.eatmonsterlasagna = true
				self.eatturkeyamount = allachiv_eventdata["eatturkey"]
				self.eatturkey = true
				self.eatpepperamount = allachiv_eventdata["eatpepper"]
				self.eatpepper = true
				self.eatbaconamount = allachiv_eventdata["eatbacon"]
				self.eatbacon = true
				self.eatmoleamount = allachiv_eventdata["eatmole"]
				self.eatmole = true
				self.eatfishamount = allachiv_eventdata["eatfish"]
				self.eatfish = true
			end
		end)
    end)
end

--Todo replace the achievement logic with state machine

local function counting_logic(inst, achievement, amount)
    local achiv = inst.components.allachivevent
    local amount = amount or achievement.."amount"
    achiv[amount] = achiv[amount] + 1
    if achiv[amount] >= allachiv_eventdata[achievement] then
        achiv[achievement] = true
        achiv:seffc(inst, achievement)
    end
end

--Eat Achievement
function allachivevent:eatfn(inst)
	inst:ListenForEvent("oneat", function(inst, data)
		if inst:GetDisplayName() ~= data.feeder:GetDisplayName() and data.feeder.components.allachivevent.feedplayer ~= true and findprefab(foodmenu, data.food.prefab) then
			data.feeder.components.allachivevent.feedplayeramount = data.feeder.components.allachivevent.feedplayeramount + 1
			if data.feeder.components.allachivevent.feedplayeramount >= allachiv_eventdata["feedplayer"] then
				data.feeder.components.allachivevent.feedplayer = true
				data.feeder.components.allachivevent:seffc(data.feeder, "feedplayer")
			end
		end
		-- singleplayer addition to feed other player achievement
		if self.feedplayer ~= true and table.getn(_G.AllPlayers) == 1 and data.food.prefab == "monsterlasagna" then
			self.feedplayeramount = self.feedplayeramount + 0.5
			if self.feedplayeramount >= allachiv_eventdata["feedplayer"] then
				self.feedplayer = true
				self:seffc(inst, "feedplayer")
			end
		end

		local food = data.food

		if self.firsteat ~= true then
			self.firsteat = true
			self:seffc(inst, "firsteat")
		end

		--Eat 100
		if self.supereat ~= true then
            counting_logic(inst, "supereat")
		end

		if self.eatmonsterlasagna ~= true and food.prefab == "monsterlasagna" then
            counting_logic(inst, "eatmonsterlasagna")
		end

		if inst.components.temperature.current <= 0 and inst.components.health.currenthealth > 0 
        and findprefab(heatfood, food.prefab) and self.eathot ~= true and self.eattemp ~= true then
            self.eattemp = true
            counting_logic(inst, "eathot")
			inst:DoTaskInTime(5, function() self.eattemp = false end)
		end

		if inst.components.temperature.current >= 70 and inst.components.health.currenthealth > 0 
        and findprefab(coldfood, food.prefab) and self.eatcold ~= true and self.eattemp ~= true then
            self.eattemp = true
            counting_logic(inst, "eatcold")
			inst:DoTaskInTime(5, function() self.eattemp = false end)
		end
		
		if self.eatfish ~= true and food.prefab == "fishsticks" then
            counting_logic(inst, "eatfish")
		end

		if self.eatturkey ~= true and food.prefab == "turkeydinner" then
            counting_logic(inst, "eatturkey")
		end
		
		if self.eatpepper ~= true and food.prefab == "pepperpopper" then
            counting_logic(inst, "eatpepper")
		end
		
		if self.eatbacon ~= true and food.prefab == "baconeggs" then
            counting_logic(inst, "eatbacon")
		end
		
		if self.eatmole ~= true and (food.prefab == "guacamole" or food.prefab == "bunnystew") then
            counting_logic(inst, "eatmole")
		end

		--All Crockpot Food
		if self.alldiet ~= true then
			if findprefab(self.eatlist,food.prefab) then
				self.eatall = self.eatall + 1
				table.remove(self.eatlist,findindex(self.eatlist,food.prefab))
				currenteatlist(self,self.eatlist)
				if next(self.eatlist) == nil then
					self.eatall = 40
					self.alldiet = true
					self:seffc(inst, "alldiet")
				end
			end
		end 
	end)
end

function allachivevent:updateMeatatarianFoodList()
	for index,value in pairs(veggie) do
		if findprefab(self.eatlist,value) then
			table.remove(self.eatlist,findindex(self.eatlist,value))
			self.eatall = self.eatall + 1
		end
	end
	currenteatlist(self,self.eatlist)
end

function allachivevent:updateVeggieFoodList()
	for index,value in pairs(meats) do
		if findprefab(self.eatlist,value) then
			table.remove(self.eatlist,findindex(self.eatlist,value))
			self.eatall = self.eatall + 1
		end
	end
	currenteatlist(self,self.eatlist)
end

local function check_in_inventory(inst, prefab)
    local items = inst.components.inventory:FindItems(function(item) return item.prefab==prefab end)
    local count = 0
    for i, item in ipairs(items) do
        count = count + (item.components.stackable ~= nil and item.components.stackable:StackSize() or 1)
    end
    return count
end

local function count_in_inventory(inst, prefab, achievement, count_var)
    local achiv = inst.components.allachivevent
    local count_var = count_var or achievement.."s"
    if achiv[achievement] ~= true then
        achiv[count_var] = check_in_inventory(inst, prefab)
        if(achiv[count_var] >= allachiv_eventdata[achievement]) then
            achiv[achievement] = true
            achiv:seffc(inst, achievement)
        end
    end
end

--Have in inventory
function allachivevent:onhavefn(inst)
	inst:DoPeriodicTask(5, function()
        count_in_inventory(inst, "greengem", "emerald")
        count_in_inventory(inst, "yellowgem", "citrin")
        count_in_inventory(inst, "orangegem", "amber")
        count_in_inventory(inst, "cave_banana_cooked", "banana")
        count_in_inventory(inst, "moonrocknugget", "moonrock")
        count_in_inventory(inst, "mosquito", "mosquito")
        count_in_inventory(inst, "bathbomb", "bathbomb", "bathbombamount")

		-- Glossamer Saddle - saddle_race
		if self.saddle ~= true then
			local item = inst.components.inventory:FindItem(function(item) return item.prefab=="saddle_race" end)
			if(item ~= nil) then
				self.saddles = 1
				self.saddle = true
				self:seffc(inst, "saddle")
			end
		end

		if self.spore ~= true then
			local countgreen = check_in_inventory(inst, "spore_small")
			local countred = check_in_inventory(inst, "spore_medium")
			local countblue = check_in_inventory(inst, "spore_tall")
			self.spores = math.min(countgreen, countred, countblue)
			if(countgreen >= allachiv_eventdata["spore"] and countred >= allachiv_eventdata["spore"] and countblue >= allachiv_eventdata["spore"]) then
				self.spore = true
				self:seffc(inst, "spore")
			end
		end
		-- Blueprints (string.match(str, "blueprint"))
		if self.blueprint ~= true then
			local items = inst.components.inventory:FindItems(function(item) return string.match(item.prefab, "blueprint?") == "blueprint" end)
			local count = 0
			for i, item in ipairs(items) do
				count = count + (item.components.stackable ~= nil and item.components.stackable:StackSize() or 1)
			end
			self.blueprints = count
			if(count >= allachiv_eventdata["blueprint"]) then
				self.blueprint = true
				self:seffc(inst, "blueprint")
			end
		end
		-- All boatpieces - steeringwheel_item, mast_item, anchor_item, oar, boat_item
		if self.boat ~= true then
			local itemWheel = inst.components.inventory:FindItem(function(item) return item.prefab=="steeringwheel_item" end)
			local itemMast = inst.components.inventory:FindItem(function(item) return item.prefab=="mast_item" end)
			local itemAnchor = inst.components.inventory:FindItem(function(item) return item.prefab=="anchor_item" end)
			local itemOar = inst.components.inventory:FindItem(function(item) return item.prefab=="oar" end)
			local itemBoat = inst.components.inventory:FindItem(function(item) return item.prefab=="boat_item" end)
			local count = 0
			if itemWheel ~= nil then count = count + 1 end
			if itemMast ~= nil then count = count + 1 end
			if itemAnchor ~= nil then count = count + 1 end
			if itemOar ~= nil then count = count + 1 end
			if itemBoat ~= nil then count = count + 1 end
			self.boats = count
			if(count >= 5) then
				self.boat = true
				self:seffc(inst, "boat")
			end
		end

		-- Gnomes - trinket_4 and trinket_13
		if self.gnome ~= true then
			local items = inst.components.inventory:FindItems(function(item) return item.prefab=="trinket_4" or item.prefab=="trinket_13" end)
			local count = 0
			for i, item in ipairs(items) do
				count = count + (item.components.stackable ~= nil and item.components.stackable:StackSize() or 1)
			end
			self.gnomes = count
			if(count >= allachiv_eventdata["gnome"]) then
				self.gnome = true
				self:seffc(inst, "gnome")
			end
		end
		
        
	end)
end

--Movement
function allachivevent:onwalkfn(inst)
    inst:DoPeriodicTask(1, function()
        if inst:HasTag("playerghost") then return end
		if self.pacifist ~= true then
            counting_logic(inst, "pacifist")
		end
        if inst.components.locomotor.wantstomoveforward then
            --Walk or Ride
			if inst.components.rider ~= nil and inst.components.rider:IsRiding() and inst.components.rider.mount ~= nil and inst.components.rider.mount.prefab == "beefalo" then
				if self.rider ~= true then
                    counting_logic(inst, "rider")
				end
			else
				if self.walkalot ~= true then
                    counting_logic(inst, "walkalot", "walktime")
				end
			end
            
        else
            --Stop
            if self.stopalot ~= true then
                counting_logic(inst, "stopalot", "stoptime")
            end
        end
    end)
end
--Death
function allachivevent:onkilled(inst)
    inst:ListenForEvent("death", function(inst, data)
        local attacker = inst.components.combat.lastattacker
        --Cave Earthquake
        if attacker and attacker.prefab and attacker:IsValid() and self.tooyoung ~= true then
            if attacker.prefab == "flint"
            or attacker.prefab == "rocks"
            or attacker.prefab == "redgem"
            or attacker.prefab == "bluegem"
            or attacker.prefab == "goldnugget"
            or attacker.prefab == "nitre"
            or attacker.prefab == "marble" then
                inst:DoTaskInTime(2, function()
                    self.tooyoung = true
                    self:seffc(inst, "tooyoung")
                end)
            end
        end
        --Die 10 times
        if self.deathalot ~= true then
            counting_logic(inst, "deathalot")
        end
        --Charlie
        if data and data.cause and data.cause == "NIL" and self.noob ~= true then
            inst:DoTaskInTime(2, function()
                self.noob = true
                self:seffc(inst, "noob")
            end)
        end
        --Rose
        if data and data.cause and (data.cause == "flower" or (TheWorld.state.issummer and data.cause == "cactus") or (TheWorld.state.issummer and data.cause == "oasis_cactus") or data.cause == "hedgehound") and self.rose ~= true then
            inst:DoTaskInTime(2, function()
                self.rose = true
                self:seffc(inst, "rose")
            end)
        end
        --Spore Cloud
        if data and data.cause and data.cause == "sporecloud" and self.rot ~= true then
            inst:DoTaskInTime(2, function()
                self.rot = true
                self:seffc(inst, "rot")
            end)
        end
        --Electrocuted
        -- if data and data.cause and data.cause == "lightning" and self.black ~= true then
            -- inst:DoTaskInTime(2, function()
                -- self.black = true
                -- self.blacktile = "thunder"
                -- self:seffc(inst, "black")
            -- end)
        -- end
    end)
end


function allachivevent:sanitycheck(inst)
    inst:DoPeriodicTask(1, function()
        if inst.components.sanity.current <= inst.components.sanity.max*0.10 and self.nosanity ~= true and inst.components.health.currenthealth > 0 then
            counting_logic(inst, "nosanity", "nosanitytime")
        end
		if inst.components.sanity.current >= inst.components.sanity.max*0.95 and self.fullsanity ~= true and inst.components.health.currenthealth > 0 then
            counting_logic(inst, "fullsanity")
        end
    end)
end

function allachivevent:hungercheck(inst)
    inst:DoPeriodicTask(1, function()
		if inst.components.hunger.current >= inst.components.hunger.max*0.95 and self.fullhunger ~= true and inst.components.health.currenthealth > 0 then
            counting_logic(inst, "fullhunger")
        end
    end)
end

--Killing

--Todo clean up the functions that require passing in the victim

local function bosskill_logic(victim, check_for_prefab, achievement)
    if victim and victim.prefab == check_for_prefab then
        local pos = Vector3(victim.Transform:GetWorldPosition())
        local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
        for k,v in pairs(ents) do
            if v:HasTag("player") then
                if v.components.allachivevent[achievement] ~= true then
                    v.components.allachivevent[achievement] = true
                    v.components.allachivevent:seffc(v, achievement)
                end
            end
        end
    end
end

local function mobkill_logic(victim, achievement)
    local pos = Vector3(victim.Transform:GetWorldPosition())
    local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
    for k,v in pairs(ents) do
        if v:HasTag("player") then
            if not v.components.allachivevent[achievement] then
                counting_logic(v, achievement)
            end
        end
    end
end

local function check_for_seasonal_boss(victim, boss)
    local pos = Vector3(victim.Transform:GetWorldPosition())
    local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
    for k,v in pairs(ents) do
        if v:HasTag("player") then
            if v.components.allachivevent[boss] ~= true then
                v.components.allachivevent[boss] = true
            end
            if v.components.allachivevent.bossautumn and v.components.allachivevent.bossantlion and v.components.allachivevent.bossspring and v.components.allachivevent.bosswinter and v.components.allachivevent.king ~= true then
                v.components.allachivevent.king = true
                v.components.allachivevent:seffc(v, "king")
            end
        end
    end
end

function allachivevent:onkilledother(inst)
    inst:ListenForEvent("killed", function(inst, data)
        local victim = data.victim

        bosskill_logic(victim, "glommer", "sick")
        
        if victim and victim.prefab == "chester" and self.coldblood ~= true then
            self.coldblood = true
            self:seffc(inst, "coldblood")
        end
		
		if victim and victim.prefab == "hutch" and victim.components.amorphous:GetCurrentForm() == "FUGU" and self.hutch ~= true then 
            self.hutch = true
            self:seffc(inst, "hutch")
        end
        
        if victim and victim.prefab == "tentacle_pillar" and self.hentai ~= true then
            local single = true
            local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 15)
            for k,v in pairs(ents) do
                if (v:HasTag("player") or v.prefab == "bunnyman" or v.prefab == "hutch" or v.prefab == "rocky" or v.prefab == "pigman") and v ~= inst then
                    single = false
                end
            end
            if single == true then
                counting_logic(inst, "hentai")
            end
        end
        
        if victim and victim.prefab == "tentacle" and self.snake ~= true then
            counting_logic(inst, "snake")
        end
        
        if victim and victim.prefab == "little_walrus" then
            mobkill_logic(victim, "weetusk")
        end
        
		if victim and victim.prefab == "mossling" then
            mobkill_logic(victim, "mossling")
        end
    
		if victim and victim.prefab == "lightninggoat" and victim:HasTag("charged") == true then
            mobkill_logic(victim, "goatperd")
        end

		if victim and victim.prefab == "beefalo" and victim:HasTag("scarytoprey") == true then
            mobkill_logic(victim, "butcher")
        end

		if victim and victim.prefab == "mutatedhound" then
            mobkill_logic(victim, "horrorhound")
        end

		if victim and (victim.prefab == "slurtle" or victim.prefab == "snurtle") then
			mobkill_logic(victim, "slurtle")
        end

		if victim and (victim.prefab == "moonpig" or (victim.prefab == "pigman" and victim.components.werebeast:IsInWereState())) then
			mobkill_logic(victim, "werepig")
        end

        --[[
		if victim and victim.prefab == "fruitdragon" and victim._is_ripe then
			mobkill_logic(victim, "fruitdragon")
        end
        ]]--

		if victim and victim.prefab == "leif" or victim.prefab == "leif_sparse" then
			mobkill_logic(victim, "treeguard")
        end

		if victim and victim.prefab == "spiderqueen" then
			mobkill_logic(victim, "spiderqueen")
        end

		if victim and (victim.prefab == "spider" 
		or victim.prefab == "spider_warrior" 
		or victim.prefab == "spider_hider" 
		or victim.prefab == "spider_dropper" 
		or victim.prefab == "spider_healer" 
		or victim.prefab == "spider_water" 
		or victim.prefab == "spider_moon" 
		or victim.prefab == "spider_spitter" 
		or victim.prefab == "webber") then
			mobkill_logic(victim, "spider")
        end

		if victim and (victim.prefab == "spider_warrior" 
		or victim.prefab == "spider_hider" 
		or victim.prefab == "spider_dropper" 
		or victim.prefab == "spider_healer" 
		or victim.prefab == "spider_water" 
		or victim.prefab == "spider_moon" 
		or victim.prefab == "spider_spitter") then
			mobkill_logic(victim, "spider_warrior")
        end

		if victim and (victim.prefab == "hound" or victim.prefab == "firehound" or victim.prefab == "icehound" or victim.prefab == "worm" or victim.prefab == "hedgehound") then
			mobkill_logic(victim, "hound")
        end

		if victim and (victim.prefab == "killerbee" or victim.prefab == "beeguard") then
			mobkill_logic(victim, "bee")
        end

		if victim and victim.prefab == "frog" then
			mobkill_logic(victim, "frog")
        end

		if victim and (victim.prefab == "knight" or victim.prefab == "bishop" or victim.prefab == "rook" or victim.prefab == "knight_nightmare" or victim.prefab == "bishop_nightmare" or victim.prefab == "rook_nightmare")then
			mobkill_logic(victim, "clockwork")
        end

         bosskill_logic(victim, "eyeofterror", "eye_of_terror")

        if victim and victim.prefab == "twinofterror1" then
			local pos = Vector3(victim.Transform:GetWorldPosition())
			local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
			for k,v in pairs(ents) do
				if v:HasTag("player") then
					if v.components.allachivevent.twin_of_terror1 ~= true then
						v.components.allachivevent.twin_of_terror1 = true
					end
                    if v.components.allachivevent.twin_of_terror1 and v.components.allachivevent.twin_of_terror2 and v.components.allachivevent.twins_of_terror ~= true then
						v.components.allachivevent.twins_of_terror = true
						v.components.allachivevent:seffc(v, "twins_of_terror")
					end
				end
			end
        end
        if victim and victim.prefab == "twinofterror2" then
			local pos = Vector3(victim.Transform:GetWorldPosition())
			local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
			for k,v in pairs(ents) do
				if v:HasTag("player") then
					if v.components.allachivevent.twin_of_terror2 ~= true then
						v.components.allachivevent.twin_of_terror2 = true
					end
                    if v.components.allachivevent.twin_of_terror1 and v.components.allachivevent.twin_of_terror2 and v.components.allachivevent.twins_of_terror ~= true then
						v.components.allachivevent.twins_of_terror = true
						v.components.allachivevent:seffc(v, "twins_of_terror")
					end
				end
			end
        end

		if victim and victim.prefab == "warg" then
			mobkill_logic(victim, "varg")
        end

		if victim and victim.prefab == "koalefant_summer" or victim.prefab == "koalefant_winter" then
			mobkill_logic(victim, "koaelefant")
        end

		if victim and victim.prefab == "monkey" then
			mobkill_logic(victim, "monkey")
        end

        --Krampus
		--[[
        if victim and victim.prefab == "krampus" then
            local pos = Vector3(victim.Transform:GetWorldPosition())
            inst:DoTaskInTime(.1, function()
                local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 3)
                for k,v in pairs(ents) do
                    if v.prefab == "krampus_sack"
                    and v.components.inventoryitem.owner == nil
                    and v.components.ksmark.mark == false then
                        v.components.ksmark.mark = true
                        if self.luck ~= true then
                            self.luck = true
                            self:seffc(inst, "luck")
                        end
                    end
                end
            end)
        end
		--]]

        --Klaus
        if victim and victim.prefab == "klaus" then
            local pos = Vector3(victim.Transform:GetWorldPosition())
            inst:DoTaskInTime(1, function()
                local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 5)
                for k,v in pairs(ents) do
                    if v.prefab == "klaussackkey"
                    and v.components.inventoryitem.owner == nil
                    and v.components.ksmark.mark == false then
                        v.components.ksmark.mark = true
                        ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
                        for k,v in pairs(ents) do
                            if v:HasTag("player") then
                                if v.components.allachivevent.santa ~= true then
                                    v.components.allachivevent.santa = true
                                    v.components.allachivevent:seffc(v, "santa")
                                end
                            end
                        end
                    end
                end
            end)
        end
        --Shadow Chess
        if victim and (victim.prefab == "shadow_knight" or victim.prefab == "shadow_rook" or victim.prefab == "shadow_bishop") and victim.level == 3 then
            local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
            inst:DoTaskInTime(2, function()
                for k,v in pairs(ents) do
                    if v:HasTag("player") then
                        if v.components.allachivevent.knight ~= true and victim.prefab == "shadow_knight" then
                            v.components.allachivevent.knight = true
                            v.components.allachivevent:seffc(v, "knight")
                        end
                        if v.components.allachivevent.bishop ~= true and victim.prefab == "shadow_bishop" then
                            v.components.allachivevent.bishop = true
                            v.components.allachivevent:seffc(v, "bishop")
                        end
                        if v.components.allachivevent.rook ~= true and victim.prefab == "shadow_rook" then
                            v.components.allachivevent.rook = true
                            v.components.allachivevent:seffc(v, "rook")
                        end
                    end
                end
                --local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 5)
                --for k,v in pairs(ents) do
                    --if v.prefab == "shadowheart"
                    --and v.components.inventoryitem.owner == nil
                    --and v.components.ksmark.mark == false then
                        --v.components.ksmark.mark = true
                        --ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 30)
                        --for k,v in pairs(ents) do
                            --if v:HasTag("player") then
                                --if v.components.allachivevent.knight ~= true and victim.prefab == "shadow_knight" then
                                    --v.components.allachivevent.knight = true
                                    --v.components.allachivevent:seffc(v, "knight")
                                --end
                                --if v.components.allachivevent.bishop ~= true and victim.prefab == "shadow_bishop" then
                                    --v.components.allachivevent.bishop = true
                                    --v.components.allachivevent:seffc(v, "bishop")
                                --end
                                --if v.components.allachivevent.rook ~= true and victim.prefab == "shadow_rook" then
                                    --v.components.allachivevent.rook = true
                                    --v.components.allachivevent:seffc(v, "rook")
                                --end
                            --end
                        --end
                    --end
                --end
            end)
        end
        --Ewecus
        if victim and victim.prefab == "spat" and self.black ~= true then
            local single = true
            local pos = Vector3(victim.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 15)
            for k,v in pairs(ents) do
                if v:HasTag("player") and v ~= inst then
                    single = false
                end
            end
            if single == true then
                self.black = true
                self.blacktile = "spat"
                self:seffc(inst, "black")
            end
        end

        bosskill_logic(victim, "toadstool_dark", "rigid")
        bosskill_logic(victim, "stalker_atrium", "ancient")
        bosskill_logic(victim, "minotaur", "minotaur")
        bosskill_logic(victim, "dragonfly", "dragonfly")
        bosskill_logic(victim, "malbatross", "malbatross")
        bosskill_logic(victim, "crabking", "crabking")
        bosskill_logic(victim, "beequeen", "queen")
        
        --Season Bosses
        if victim and victim.prefab == "deerclops" then
			check_for_seasonal_boss(victim, "bosswinter")
        end

        if victim and victim.prefab == "moose" then
			check_for_seasonal_boss(victim, "bossspring")
        end

        if victim and victim.prefab == "antlion" then
            check_for_seasonal_boss(victim, "bossantlion")
        end

        if victim and victim.prefab == "bearger" then
            check_for_seasonal_boss(victim, "bossautumn")
        end

    end)
end

--Lightning Listener
function allachivevent:lightningListener(inst)
    inst:ListenForEvent("healthdelta", function(inst, data)
        if self.lightning ~= true and data.cause == "lightning" then
			self.lightning = true
			self:seffc(inst, "lightning")
		end
    end)
end

function allachivevent:drownListener(inst)
    inst:ListenForEvent("on_washed_ashore", function(inst, data)
        if self.drown ~= true then
			self.drown = true
			self:seffc(inst, "drown")
		end
    end)
end

function allachivevent:wakeupListener(inst)
    inst:ListenForEvent("wakeup", function(inst, data)
        if self.sleeptent ~= true and data == "tent" then
            counting_logic(inst, "sleeptent")
		end
		
		if self.sleepsiesta ~= true and data == "siestahut" then
            counting_logic(inst, "sleepsiesta")
		end
    end)
end

function allachivevent:burnorfreezeorsleep(inst)
    inst:ListenForEvent("onignite", function(inst)
        if self.burn ~= true then
            self.burn = true
            self:seffc(inst, "burn")
        end
    end)
    inst:ListenForEvent("freeze", function(inst)
        if self.freeze ~= true then
            self.freeze = true
            self:seffc(inst, "freeze")
        end
    end)
	inst:ListenForEvent("knockedout", function(inst)
		if self.sleep ~= true then
			self.sleep = true
			self:seffc(inst, "sleep")
		end
	end)
end

--BeFriend
function allachivevent:makefriend(inst)
    function inst.components.leader:AddFollower(follower)
        if self.followers[follower] == nil and follower.components.follower ~= nil then
            local achiv = inst.components.allachivevent

            if follower.prefab == "pigman" and achiv.pigfriend ~= true then
                counting_logic(inst, "pigfriend")
            end
            
            if follower.prefab == "bunnyman" and achiv.friendbunny ~= true then
                counting_logic(inst, "friendbunny")
            end
            
            if follower.prefab == "catcoon" and achiv.friendcat ~= true then
                counting_logic(inst, "friendcat")
            end

            if (follower.prefab == "spider" or 
				follower.prefab == "spider_dropper" or 
				follower.prefab == "spider_warrior" or 
				follower.prefab == "spider_hider" or 
				follower.prefab == "spider_spitter") and achiv.friendspider ~= true then
                counting_logic(inst, "friendspider")
            end
            
            if follower.prefab == "mandrake_active" and achiv.evil ~= true and not TheWorld.components.worldstate.data.isday then
                counting_logic(inst, "evil")
            end
            --TallBirb
            if follower.prefab == "smallbird" and achiv.birdclop ~= true then
                achiv.birdclop = true
                achiv:seffc(inst, "birdclop")
            end
            --RockLobster
            if follower.prefab == "rocky" and achiv.rocklob ~= true then
                counting_logic(inst, "rocklob")
            end

            self.followers[follower] = true
            self.numfollowers = self.numfollowers + 1
            follower.components.follower:SetLeader(self.inst)
            follower:PushEvent("startfollowing", { leader = self.inst })

            if not follower.components.follower.keepdeadleader then
                self.inst:ListenForEvent("death", self._onfollowerdied, follower)
            end

            self.inst:ListenForEvent("onremove", self._onfollowerremoved, follower)

            if self.inst:HasTag("player") and follower.prefab ~= nil then
                ProfileStatsAdd("befriend_"..follower.prefab)
            end
        end
    end
end

function allachivevent:onhook(inst)
    inst:ListenForEvent("fishingstrain", function()
        if self.fishmaster ~= true then
            counting_logic(inst, "fishmaster")
        end
    end)
end

--Pick
function allachivevent:onpick(inst)
    inst:ListenForEvent("picksomething", function(inst, data)
        if data.object and data.object.components.pickable and not data.object.components.trader then
			if (data.object.prefab == "flower_evil" or data.object.prefab == "flower_withered") and self.evilflower ~= true then
                counting_logic(inst, "evilflower")
			end
            if self.pickmaster ~= true or self.pickappren ~= true then
                if self.pickappren ~= true then
                    counting_logic(inst, "pickappren", "pickamount")
                else
                    counting_logic(inst, "pickmaster", "pickamount")
                end
            end
        end
    end)
end

--Chop
function allachivevent:chopper(inst)
    inst:ListenForEvent("finishedwork", function(inst, data)
		if self.birchnut ~= true and data.target and data.target.prefab == "deciduoustree" and data.target.monster then
            counting_logic(inst, "birchnut")
		end
        if data.target and data.target:HasTag("tree") then
            if self.chopmaster ~= true or self.chopappren ~= true then
                if self.chopappren ~= true then
                    counting_logic(inst, "chopappren", "chopamount")
                else
                    counting_logic(inst, "chopmaster", "chopamount")
                end
            end
        end
    end)
end



--Mine
function allachivevent:miner(inst)
    inst:ListenForEvent("finishedwork", function(inst, data)
        if data.target and (data.target:HasTag("boulder") or 
							data.target:HasTag("statue") or 
							findprefab(rocklist, data.target.prefab)) then
            if self.minemaster ~= true or self.mineappren ~= true then
                if self.mineappren ~= true then
                    counting_logic(inst, "mineappren", "mineamount")
                else
                    counting_logic(inst, "minemaster", "mineamount")
                end
            end
        end
    end)
end

--Revive
function allachivevent:respawn(inst)
    inst:ListenForEvent("respawnfromghost", function(inst, data)
		--singleplayer addition to messiah
		if data and data.source and data.source.prefab == "amulet" and table.getn(_G.AllPlayers) == 1 and self.messiah ~= true then
            inst:DoTaskInTime(5, counting_logic(inst, "messiah"))
        end
        if data and data.user and data.user.components.allachivevent then
            local allachivevent = data.user.components.allachivevent
            if allachivevent.messiah ~= true then
                counting_logic(inst, "messiah")
            end
        end
        if data and data.source and data.source.prefab == "resurrectionstatue" and self.secondchance ~= true then
            inst:DoTaskInTime(2, function()
                self.secondchance = true
                self:seffc(inst, "secondchance")
            end)
        end
		if data and data.source and data.source.prefab == "amulet" and self.reviveamulet ~= true then
            inst:DoTaskInTime(2, counting_logic(inst, "reviveamulet"))
        end
    end)
end
--Age and SuperStar
function allachivevent:ontimepass(inst)
    inst:DoPeriodicTask(5, function(inst)
        --Age
        if self.longage ~= true or self.oldage ~= true then
            if self.all ~= true then
                self.age = math.ceil(inst.components.age:GetAge() / TUNING.TOTAL_DAY_TIME)
            else
                self.age = math.ceil(inst.components.age:GetAge() / TUNING.TOTAL_DAY_TIME) - self.agereset + 1
            end
            if self.age >= allachiv_eventdata["longage"] and self.longage ~= true then
                self.longage = true
                self:seffc(inst, "longage")
            end
            if self.age >= allachiv_eventdata["oldage"] and self.oldage ~= true then
                self.oldage = true
                self:seffc(inst,"oldage")
            end
        end
        --Critters
        if self.pet ~= true then
            if inst.components.leader:IsBeingFollowedBy("critter_lamb") or
               inst.components.leader:IsBeingFollowedBy("critter_puppy") or
               inst.components.leader:IsBeingFollowedBy("critter_kitten") or
               inst.components.leader:IsBeingFollowedBy("critter_perdling") or
               inst.components.leader:IsBeingFollowedBy("critter_dragonling") or
               inst.components.leader:IsBeingFollowedBy("critter_glomling") or
               inst.components.leader:IsBeingFollowedBy("critter_eyeofterror") or
               inst.components.leader:IsBeingFollowedBy("critter_lunarmothling") then
                self.pet = true
                self:seffc(inst, "pet")
            end
        end
		--Lavae
		if self.lavae ~= true then 
			local tooth = inst.components.inventory:FindItem(function(item) return item.prefab=="lavae_tooth" end)
			if tooth and tooth.components.leader:IsBeingFollowedBy("lavae_pet") then
				self.lavae = true
				self:seffc(inst, "lavae")
			end
		end
		--Music Hutch
		if self.musichutch ~= true then
			local bowl = inst.components.inventory:FindItem(function(item) return item.prefab=="hutch_fishbowl" end)
			local hutch = nil
			if bowl then 
				hutch = TheSim:FindFirstEntityWithTag("hutch")
			end
			if bowl and hutch and hutch.components.amorphous:GetCurrentForm() == "MUSIC" then
				self.musichutch = true
				self:seffc(inst, "musichutch")
			end
		end
		--Shadow Chester
		--[[
		if self.shadowchester ~= true then
			local eyebone = inst.components.inventory:FindItem(function(item) return item.prefab=="chester_eyebone" end)
			local chester = nil
			if eyebone then 
				chester = TheSim:FindFirstEntityWithTag("chester")
			end
			if eyebone and chester and chester.ChesterState == "SHADOW" then
				self.shadowchester = true
				self:seffc(inst, "shadowchester")
			end
		end
		--Snow Chester
		if self.snowchester ~= true then
			local eyebone = inst.components.inventory:FindItem(function(item) return item.prefab=="chester_eyebone" end)
			local chester = nil
			if eyebone then 
				chester = TheSim:FindFirstEntityWithTag("chester")
			end
			if eyebone and chester and chester.ChesterState == "SNOW" then
				self.snowchester = true
				self:seffc(inst, "snowchester")
			end
		end		
		--]]
        --Super Star
        if self.superstar ~= true then
            self.starspent = inst.components.allachivcoin.starsspent
            --Star
            self.starspent = self.starspent - self.starreset
            if self.starspent >= allachiv_eventdata["superstar"] then
                self.starspent = allachiv_eventdata["superstar"]
                self.superstar = true
                self:seffc(inst,"superstar")
            end
        end
        --Give Achievements
        if inst.components.allachivcoin.fireflylightup > 0 and self.noob ~= true then
            self.noob = true
            self:seffc(inst,"noob")
        end
        if inst.components.allachivcoin.firebody == true and self.firebody ~= true then
            self.firebody = true
            self:seffc(inst,"firebody")
        end
        if inst.components.allachivcoin.firebody == true and self.eatcold ~= true then
            self.eatcold = true
            self:seffc(inst,"eatcold")
        end
        if inst.components.allachivcoin.icebody == true and self.icebody ~= true then
            self.icebody = true
            self:seffc(inst,"icebody")
        end
        if inst.components.allachivcoin.icebody == true and self.eathot ~= true then
            self.eathot = true
            self:seffc(inst,"eathot")
        end
        if inst.components.allachivcoin.nomoist == true and self.moistbody ~= true then
            self.moistbody = true
            self:seffc(inst,"moistbody")
        end
        if inst.components.allachivcoin.sanityregenamount >= 25 and self.nosanity ~= true then
            self.nosanity = true
            self:seffc(inst,"nosanity")
        end
        if inst.components.allachivcoin.healthregenamount >= 25 and self.hutch ~= true then
            self.hutch = true
            self:seffc(inst,"hutch")
        end
        if inst.components.allachivcoin.healthregenamount >= 25 and self.rose ~= true then
            self.rose = true
            self:seffc(inst,"rose")
        end
        if inst.components.allachivcoin.healthregenamount >= 25 and self.tooyoung ~= true then
            self.tooyoung = true
            self:seffc(inst,"tooyoung")
        end
        if self.knowledgeamount >= 1 and self.knowledge ~= true then
            self.knowledge = true
            self:seffc(inst,"knowledge")
        end
    end)
end

--Craft
function allachivevent:onbuild(inst)
    inst:ListenForEvent("consumeingredients", function(inst)
        if self.buildmaster ~= true or self.buildappren ~= true then
            if self.buildappren ~= true then
                counting_logic(inst, "buildappren", "buildamount")
            else
                counting_logic(inst, "buildmaster", "buildamount")
            end
        end
    end)
end

--Plant
function allachivevent:onplant(inst)
    inst:ListenForEvent("deployitem", function(inst,data)
        if (
		data.prefab == "pinecone" or 
		data.prefab == "twiggy_nut" or 
		data.prefab == "dug_berrybush" or
		data.prefab == "dug_berrybush_jucy" or 
		data.prefab == "dug_grass" or 
		data.prefab == "dug_marsh_bush" or 	
		data.prefab == "dug_sapling" or 	
		data.prefab == "dug_berrybush2" or 	
		data.prefab == "dug_rock_avocado_bush" or 	
		data.prefab == "dug_sapling_moon" or 			
		data.prefab == "acorn") and 
		self.nature ~= true then
            counting_logic(inst, "nature")
        end
    end)
end

local function hitother_logic(inst, data, achievement, amount)
    local achiv = inst.components.allachivevent
    local amount = amount or achievement.."amount"
    if data.damage and data.damage >= 0 then
        achiv[amount] = math.ceil(achiv[amount] + data.damage)
    end
    if achiv[amount] >= allachiv_eventdata[achievement] then
        achiv[amount] = allachiv_eventdata[achievement]
        achiv[achievement] = true
        achiv:seffc(inst, achievement)
    end
end

--Tank
function allachivevent:onattacked(inst)
    inst:ListenForEvent("attacked", function(inst, data)
		if self.dmgnodmg ~= true then
			self.dmgnodmgamount = 0
		end
		if self.roses ~= true and data.attacker and (data.attacker.prefab == "flower" or (TheWorld.state.issummer and data.attacker.prefab == "cactus") or (TheWorld.state.issummer and data.attacker.prefab == "oasis_cactus")) then
            counting_logic(inst, "roses")
		end
        if self.tank ~= true then
            hitother_logic(inst, data, "tank", "attackeddamage")
        end
    end)
end

--Damage
function allachivevent:hitother(inst)
    inst:ListenForEvent("onhitother", function(inst, data)
		if self.pacifist ~= true and data.damage and data.damage >= 0 then
			self.pacifistamount = 0
		end
		if self.dmgnodmg ~= true then
            hitother_logic(inst, data, "dmgnodmg")
        end
		if self.bullkelp ~= true and data.weapon and (data.weapon.prefab == "bullkelp_root" or data.weapon.prefab == "whip") then
			hitother_logic(inst, data, "bullkelp")
		end
        if self.angry ~= true then
            hitother_logic(inst, data, "angry")
        end
    end)
end

--Freeze/Overheat
function allachivevent:ontemperature(inst)
    inst:DoPeriodicTask(1, function()
        if inst.components.temperature.current <= 0
        and self.icebody ~= true
        and inst.components.health.currenthealth > 0 then
            counting_logic(inst, "icebody", "icetime")
        end
    end)
    inst:DoPeriodicTask(1, function()
        if inst.components.temperature.current >= 70
        and self.firebody ~= true
        and inst.components.health.currenthealth > 0 then
            counting_logic(inst, "firebody", "firetime")
        end
    end)
end

--Live in Cave
function allachivevent:incave(inst)
    inst:DoPeriodicTask(1, function()
        if TheWorld:HasTag("cave") and inst:HasTag("playerghost") ~= true
        and self.caveage ~= true then
            counting_logic(inst, "caveage", "cavetime")
        end
    end)
end

--Starving
function allachivevent:onhunger(inst)
    inst:DoPeriodicTask(1, function()
        if inst.components.hunger.current <= 0
        and self.starve ~= true
        and inst.components.health.currenthealth > 0 then
            counting_logic(inst, "starve", "starvetime")
        end
    end)
end

--Full Wet
function allachivevent:moist(inst)
	inst:DoPeriodicTask(1, function()
		if self.moistbody ~= true and inst.components.moisture.moisture == 100 then
            counting_logic(inst, "moistbody", "moisttime")
		end
	end)
end

--Learn Blueprint
function allachivevent:onlearn(inst)
    inst:ListenForEvent("learnrecipe", function(inst,data)
		if(data.recipe == nil) then return end
        local blueprint_str = data.recipe
        if blueprint_str:sub(-9):lower() == "blueprint" then
            blueprint_str = blueprint_str:sub(1,-11)
        end
        if blueprint_str == "ruinsrelic_table" or 
           blueprint_str == "ruinsrelic_chair" or 
           blueprint_str == "ruinsrelic_vase" or
           blueprint_str == "ruinsrelic_plate" or
           blueprint_str == "ruinsrelic_bowl" or
           blueprint_str == "ruinsrelic_chipbowl" then
            self.knowledgeamount = self.knowledgeamount + 1
            if self.knowledge ~= true then
                self.knowledge = true
                self:seffc(inst, "knowledge")
            end
        end
    end)
end

--Do Emotes
function allachivevent:doemote(inst)
    inst:ListenForEvent("emote", function()
        if self.dance ~= true then
            local single = true
            local pos = Vector3(inst.Transform:GetWorldPosition())
            local ents = TheSim:FindEntities(pos.x,pos.y,pos.z, 15)
            for k,v in pairs(ents) do
                if v:HasTag("player") and v ~= inst then
                    single = false
                end
				--singleplayer addition
				if v.prefab == "resurrectionstatue" and table.getn(_G.AllPlayers) == 1 then
                    single = false
                end
            end
            if single == false then
                counting_logic(inst, "dance")
            end
        end
    end)
end

function allachivevent:onequip(inst)
	inst:ListenForEvent("equip", function(inst,data)
	if findprefab(self.giantPlantList,data.item.prefab) then
		table.remove(self.giantPlantList,findindex(self.giantPlantList,data.item.prefab))
		currentgiantPlantList(self,self.giantPlantList)
		self.giantPlants = self.giantPlants + 1
		if next(self.giantPlantList) == nil then
			self.giantPlants = 14
			self.allgiantPlants = true
			self:seffc(inst, "allgiantPlants")
		end
	end
	end)
end

--Teleport
local function teleport_logic(inst)
    if inst.components.allachivevent.teleport ~= true then
        counting_logic(inst, "teleport")
    end
end

function allachivevent:onteleport(inst)
    inst:ListenForEvent("wormholetravel", teleport_logic(inst))
    inst:ListenForEvent("soulhop", teleport_logic(inst))
    inst:ListenForEvent("townportalteleport", teleport_logic(inst))
end

function allachivevent:onreroll(inst)
    inst:ListenForEvent("ms_playerreroll", function(inst, displayName)
				local name = ""
				if(inst:GetDisplayName() == nil) then 
					name = displayName
				else
					name = inst:GetDisplayName()
				end
                local SaveAchieve = {}
                for name, _ in pairs(achievements_table) do
                    SaveAchieve[name] = self[name] or false
                end
                for name, _ in pairs(cave_achievements_table) do
                    SaveAchieve[name] = self[name] or false
                end
                for name, _ in pairs(amount_table) do
                    SaveAchieve[name] = self[name] or 0
                end

                SaveAchieve["eatlist"] = self.eatlist or copylist(foodmenu)
                SaveAchieve["giantPlantList"] = self.giantPlantList or copylist(giantPlantList)

                SaveAchieve["totalstar"] = inst.components.allachivcoin.coinamount + math.ceil(inst.components.allachivcoin.starsspent)
				AchievementData[name] = SaveAchieve
                --print("SAVED")
    end)
end
--Init
function allachivevent:Init(inst)
	if _G.SYSTEM_CONFIG == "both" or _G.SYSTEM_CONFIG == "achieve" then
		inst:DoTaskInTime(.1, function()
			self:intogamefn(inst)
			self:eatfn(inst)
			self:onhavefn(inst)
			self:onwalkfn(inst)
			self:onkilled(inst)
			self:onkilledother(inst)
			self:wakeupListener(inst)
			self:drownListener(inst)
			self:lightningListener(inst)
			self:burnorfreezeorsleep(inst)
			self:makefriend(inst)
			self:onhook(inst)
			self:onpick(inst)
			self:chopper(inst)
			self:incave(inst)
			self:miner(inst)
			self:respawn(inst)
			self:ontimepass(inst)
			self:onbuild(inst)
			self:onattacked(inst)
			self:hitother(inst)
			self:sanitycheck(inst)
			self:hungercheck(inst)
			self:ontemperature(inst)
			self:onhunger(inst)
			self:moist(inst)
			self:allget(inst)
			self:onplant(inst)
			self:onlearn(inst)
			self:doemote(inst)
			self:onteleport(inst)
			self:onreroll(inst)
			self:onequip(inst)
		end)
	end

    --inst.components.combat.damagemultiplier = inst.components.combat.damagemultiplier or 1
end

--only for debug purposes
-- AllPlayers[1].components.allachivcoin.coinamount = 200
-- AllPlayers[1].components.allachivevent:grantAll(AllPlayers[1])
-- AllPlayers[1]:ApplyScale("grow",2)

function allachivevent:giveCoins(playerName, coinAmount)
	local inst = getInstForPlayerName(playerName)
	if(inst) then
		inst.components.allachivcoin.coinamount = inst.components.allachivcoin.coinamount + coinAmount
	end
end

function allachivevent:grantAll(inst)
    for name, _ in pairs(achievements_table) do
        self[name] = true
    end
    for name, _ in pairs(cave_achievements_table) do
        self[name] = true
    end
end

--All Star
function allachivevent:allget(inst)
    if self.all ~= true then
        inst:DoPeriodicTask(1, function()
            if self.all ~= true then
                local all_gotten = true
                for _, name in pairs(achievements_table) do
                    if not self[name] then
                        all_gotten = false
                        break
                    end
                end
                for _, name in pairs(cave_achievements_table) do
                    if not self[name] then
                        all_gotten = false
                        break
                    end
                end
                
                if all_gotten then
                    self.all = true
                    inst:DoTaskInTime(2.5, function()
                        self:seffc(inst, "all")
                        inst:DoTaskInTime(.3, function()
                            inst.sg:GoToState("mime")
                            if not inst.components.locomotor.wantstomoveforward then inst.sg:AddStateTag("busy") end
                            for i=1, 25 do
                                inst:DoTaskInTime(i/25*3, function()
                                    local pos = Vector3(inst.Transform:GetWorldPosition())
                                    SpawnPrefab("explode_firecrackers").Transform:SetPosition(pos.x+math.random(-3,3), pos.y, pos.z+math.random(-3,3))
                                end)
                            end
                        end)
                        --print(self.runcount, _G._G.PLAYS_CONFIG)
                        if self.runcount < _G.PLAYS_CONFIG then
                            self.runcount = self.runcount + 1

                            for i, name in pairs(achievements_table) do
                                self[name] = false
                            end
                            for i, name in pairs(cave_achievements_table) do
                                self[name] = false
                            end
                            for i, name in pairs(amount_table) do
                                self[name] = 0
                            end

                            self.eatlist = copylist(foodmenu)
                            self.giantPlantList = copylist(giantPlantList)
                            self:updateMeatatarianFoodList()

                            self.starreset = inst.components.allachivcoin.starsspent
                            self.agereset = math.ceil(inst.components.age:GetAge() / TUNING.TOTAL_DAY_TIME)
                            self:intogamefn(inst)
                        end
                    end)
                end
            end
        end)
    end
end


return allachivevent
