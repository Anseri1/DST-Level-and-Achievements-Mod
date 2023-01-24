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

function currenteatlist(self,eatlist) self.inst.currenteatlist:set(arrayToString(eatlist)) end
function currentgiantPlantList(self,giantPlantList) self.inst.currentgiantPlantList:set(arrayToString(giantPlantList)) end

function meta_event_table()
	local event_functions_table = {
		eatlist = currenteatlist,
		giantPlantList = currentgiantPlantList,
	}
	for _, name in pairs(achievements_table) do
		local check_name = "check"..name
		local current_name = "current"..name
		event_functions_table[current_name] = function (self, name) self.inst[current_name]:set(name) end
		event_functions_table[check_name] = function (self, name) local c = 0 if name then c=1 end self.inst[check_name]:set(c) end
	end

	for _, name in pairs(cave_achievements_table) do
		local check_name = "check"..name
		local current_name = "current"..name
		event_functions_table[current_name] = function (self, name) self.inst[current_name]:set(name) end
		event_functions_table[check_name] = function (self, name) local c = 0 if name then c=1 end self.inst[check_name]:set(c) end
	end

	for _, name in pairs(amount_table) do
		local current_name = "current"..name
		event_functions_table[current_name] = function (self, name) self.inst[current_name]:set(name) end
	end
	for i, v in pairs(event_functions_table) do
		print(i, v)
	end
	return event_functions_table
end

