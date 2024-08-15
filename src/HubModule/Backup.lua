-- Takes a snapshot backup of the entire game. --

local Settings = require(script.Settings)

local function RunRegularCheck(instance)
	local Children = instance:GetChildren()
	if #Children ~= 0 then
		local Folder = Instance.new("Folder")
		Folder.Name = instance.Name
		for _, item in next, Children do
			if item.Archivable then
				item:Clone().Parent = Folder
			end
		end
		Folder.Parent = script
	end
end

local function RunWhitelistedCheck(instance, whitelist)
	local Children = instance:GetChildren()
	local Folder = Instance.new("Folder")
	Folder.Name = instance.Name
	for _, item in next, instance:GetChildren() do
		if not table.find(whitelist, item.Name) and item.Archivable then
			item:Clone().Parent = Folder
		end
	end
	if #Folder:GetChildren() ~= 0 then
		Folder.Parent = script
	else
		Folder:Destroy()
	end
end

local Services = {
	["Workspace"] = function(service)
		local Children = service:GetChildren()
		local Folder = Instance.new("Folder")
		Folder.Name = "Workspace"
		for _, item in next, service:GetChildren() do
			if item:IsA("Terrain") then
			--[[
				local Folder2 = Instance.new("Folder")
				Folder2.Name = "Terrain"
				for _, item2 in next, item:GetChildren() do
					if item2.Archivable then
						item2:Clone().Parent = Folder2
					end
				end
				if #Folder2:GetChildren() ~= 0 then
					Folder2.Parent = script
				else
					Folder2:Destroy()
				end
			--]]
			elseif item.Archivable then
				item:Clone().Parent = Folder
			end
		end
		if #Folder:GetChildren() ~= 0 then
			Folder.Parent = script
		else
			Folder:Destroy()
		end
	end;
	["Players"] = function(service)
		local Children = service:GetChildren()
		local Folder = Instance.new("Folder")
		Folder.Name = "Players"
		for _, item in next, service:GetChildren() do
			if not item:IsA("Player") and item.Archivable then
				item:Clone().Parent = Folder
			end
		end
		if #Folder:GetChildren() ~= 0 then
			Folder.Parent = script
		else
			Folder:Destroy()
		end
	end;
	["Lighting"] = function(service)
		RunRegularCheck(service)
	end;
	["ReplicatedFirst"] = function(service)
		RunRegularCheck(service)
	end;
	["ReplicatedStorage"] = function(service)
		RunWhitelistedCheck(service, {
			"DefaultChatSystemChatEvents", -- Important CoreScript
			"\0"
		})
	end;
	["ServerScriptService"] = function(service)
		RunWhitelistedCheck(service, {
			"ChatServiceRunner", -- Important CoreScript
			"\0"
		})
	end;
	["ServerStorage"] = function(service)
		RunRegularCheck(service)
	end;
	["StarterGui"] = function(service)
		RunRegularCheck(service)
	end;
	["StarterPack"] = function(service)
		RunRegularCheck(service)
	end;
	["StarterPlayer"] = function(service)
		RunWhitelistedCheck(service, {
			"StarterCharacterScripts",
			"StarterPlayerScripts",
			"\0"
		})
		RunRegularCheck(service.StarterCharacterScripts)
		RunWhitelistedCheck(service.StarterPlayerScripts, { -- Important CoreScripts
			"BubbleChat",
			"ChatScript",
			"PlayerScriptsLoader",
			"RbxCharacterSounds",
			"PlayerModule",
			"\0"
		})
	end;
	["Teams"] = function(service)
		RunRegularCheck(service)
	end;
	["SoundService"] = function(service)
		RunRegularCheck(service)
	end;
	["Chat"] = function(service)
		RunWhitelistedCheck(service, { -- Important CoreScripts
			"ChatModules",
			"ClientChatModules",
			"ChatLocalization",
			"ChatServiceRunner",
			"BubbleChat",
			"ChatScript",
			"\0",
		})
	end;
	["LocalizationService"] = function(service)
		RunRegularCheck(service)
	end;
};


return function(Parameters)
	-- Begin loading service properties into Settings
--debug.profilebegin("Backup - ServiceProperties")
	for name, table in next, Settings.ServiceProperties do
		local pass, Service = pcall(function() return game:GetService(name) end)
		if pass then
			for property in next, table do
				xpcall(function()
					table[property] = Service[property]
				end, warn)
			end
		end
	end
--debug.profileend()


--debug.profilebegin("Backup - TerrainProperties")
	local Terrain = game:GetService("Workspace"):FindFirstChildWhichIsA("Terrain")
	local ColorProperties = {}
	local WaterProperties = {}
	for property in next, Settings.TerrainProperties.ColorProperties do
		xpcall(function()
			ColorProperties[property] = Terrain:GetMaterialColor(Enum.Material[property])
		end, warn)
	end
	Settings.TerrainProperties.ColorProperties = ColorProperties
	for property in next, Settings.TerrainProperties.WaterProperties do
		xpcall(function()
			WaterProperties[property] = Terrain[property]
		end, warn)
	end
	Settings.TerrainProperties.WaterProperties = WaterProperties
	if game:GetService("Workspace"):FindFirstChildOfClass("Terrain"):CountCells() ~= 0 then
		local Module = require(script.Parent.TerrainModule)
		local Region = Module:Save(false)
		Region.Parent = script
	end
--debug.profileend()


--debug.profilebegin("Backup - GameObjects")
	for name, Routine in next, Services do
		local pass, Service = pcall(function() return game:GetService(name) end) 
		if pass then
			xpcall(function()
				Routine(Service)
			end, warn)
		end
	end
--debug.profileend()
end;

-- EpicFazbear (c) 2021. --