-- Parses CustomParameters that are called from the main require. --

--[[
	{"ReverseWhitelist","NoRespawn"}
	{ReverseWhitelist=true, NoRespawn=true, ServiceList={"Workspace","Lighting"}}
	"ReverseWhitelist=true; NoRespawn=true;ServiceList=Workspace,Lighting"
	(Must use ; to separate string parameters)
	(Must use , when defining a parameter with multiple possible values)
--]]

local DataTypes = {
	NoRespawn = "boolean";
	ReverseWhitelist = "boolean";
	ServiceList = "table";
}

local function DataParser(Key, Value)
	if typeof(Key) == "number" then
		if DataTypes[Value] ~= nil then
			return DataTypes[Value](true)
		end
	elseif typeof(Key) == "string" then
		if DataTypes[Key] ~= nil then
			return DataTypes[Key](Value)
		end
	end
end

local function TableType(Table) -- https://devforum.roblox.com/t/checking-for-mixed-table/200344/9
	local array = 0
	local total = 0
	for _ in ipairs(Table) do array += 1 end
	for _ in pairs(Table) do total += 1 end
	if array + total == 0 then return "Empty"
	elseif array == total then return "Array"
	elseif array == 0 then return "Dictionary"
	else return "MixedTable" end
end


return function(Parameters)
	if Parameters == nil or Parameters == false then return {} end
	local ParseData = {}
	if typeof(Parameters) == "table" then
		for _, Data in ipairs(Parameters) do -- Look through table for numerated values, and convert them to key-value pairs
			ParseData[Data] = true
		end
	--[[
		for Key, Value in next, Parameters do
			local Assign, Return = DataParser(Key, Value)
			if Assign ~= nil and Return ~= nil then
				ParseData[Assign] = Return
			end
		end
	--]]
	elseif typeof(Parameters) == "string" then
		Parameters = string.gsub(Parameters, "%s+", "")
		local StringData = string.split(Parameters, ";")
		for _, Data in next, StringData do
			local Pair = string.split(Data, "=")
			if #Pair == 1 and DataTypes[Pair[1]] == "boolean" then
				ParseData[Pair[1]] = true
			elseif DataTypes[Pair[1]] == "boolean" then
				ParseData[Pair[1]] = (Pair[2] == "true")
			elseif DataTypes[Pair[1]] == "number" then
				ParseData[Pair[1]] = tonumber(Pair[2])
			elseif DataTypes[Pair[1]] == "table" then
				local Values = string.split(Pair[2], ",")
				ParseData[Pair[1]] = Values
			--else ParseData[Pair[1]] = Pair[2]
			end
		end
	end
	return ParseData
end;

-- EpicFazbear (c) 2021. --