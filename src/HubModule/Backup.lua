-- Takes a snapshot backup of the entire game. --

local Settings = script.Parent.Shared.Settings:Clone()
Settings.Parent = script
Settings = require(script.Settings)

local function RunRegularCheck(instance)
	local Children = instance:GetChildren()
	if #Children ~= 0 then
		local Folder = Instance.new("Folder")
		Folder.Name = instance.Name
		for _, item in next, Children do
			if item.Archivable and item.Name ~= "\0" then
				item:Clone().Parent = Folder
			end
		end
		Folder.Parent = script
	end
end

local function RunWhitelistedCheck(instance, whitelist)
	local Children = instance:GetChildren()
	if #Children ~= 0 then
		local Folder = Instance.new("Folder")
		Folder.Name = instance.Name
		for _, item in next, Children do
			if not table.find(whitelist, item.Name) and item.Archivable and item.Name ~= "\0" then
				item:Clone().Parent = Folder
			end
		end
		Folder.Parent = script
	end
end

local Services = {
	["Workspace"] = function(service)
		local Children = service:GetChildren()
		local Folder = Instance.new("Folder")
		Folder.Name = "Workspace"
		for _, item in next, Children do
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
		for _, item in next, Children do
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
		RunWhitelistedCheck(service, { -- Ignore chat script
			"DefaultChatSystemChatEvents"
		})
	end;
	["ServerScriptService"] = function(service)
		RunWhitelistedCheck(service, { -- Ignore chat script
			"ChatServiceRunner"
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
		RunWhitelistedCheck(service, { -- Ignore core folders
			"StarterCharacterScripts",
			"StarterPlayerScripts"
		})
		RunRegularCheck(service.StarterCharacterScripts)
		RunWhitelistedCheck(service.StarterPlayerScripts, { -- Ignore chat scripts
			"BubbleChat",
			"ChatScript",
			"PlayerScriptsLoader",
			"RbxCharacterSounds",
			"PlayerModule"
		})
	end;
	["Teams"] = function(service)
		RunRegularCheck(service)
	end;
	["SoundService"] = function(service)
		RunRegularCheck(service)
	end;
	["Chat"] = function(service)
		RunWhitelistedCheck(service, { -- Ignore chat scripts
			"ChatModules",
			"ClientChatModules",
			"ChatLocalization",
			"ChatServiceRunner",
			"BubbleChat",
			"ChatScript"
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
		local Module = require(script.Parent.Shared.TerrainSaveLoad)
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