-- Converts a Studio place into a Game Module in TestService. --
-- This module must be run at script-identity level 4 (from the Command Bar) in order to work. --

local Folders = {}

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
		--Folder.Parent = script.TemplateModule
		table.insert(Folders, Folder)
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
		--Folder.Parent = script.TemplateModule
		table.insert(Folders, Folder)
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
			elseif item.Name ~= "Camera" and item.Archivable then
				item:Clone().Parent = Folder
			end
		end
		if #Folder:GetChildren() ~= 0 then
			--Folder.Parent = script.TemplateModule
			table.insert(Folders, Folder)
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
			--Folder.Parent = script.TemplateModule
			table.insert(Folders, Folder)
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
			"ChatScript"
		})
	end;
	["Teams"] = function(service)
		RunRegularCheck(service)
	end;
	["SoundService"] = function(service)
		RunRegularCheck(service)
	end;
	["Chat"] = function(service)
		RunRegularCheck(service)
	--[[
		RunWhitelistedCheck(service, { -- Ignore chat scripts
			"ChatModules",
			"ClientChatModules",
			"ChatLocalization",
			"ChatServiceRunner",
			"BubbleChat",
			"ChatScript"
		})
	--]]
	end;
	["LocalizationService"] = function(service)
		RunRegularCheck(service)
	end;
};


return function(Parameters)
	local Template = script.TemplateModule:Clone()
	Template.Name = "MainModule"
	local Settings = Instance.new("ModuleScript")
	Settings.Name = "Settings"
	Settings.Parent = Template
	xpcall(function()
		Settings.Source = require(script.SettingsFormat)()
	end, function()
		Template:Destroy()
		Settings:Destroy()
		error("The Convert function can only be ran from the Command Bar! (Level 4)")
	end)

	for name, Routine in next, Services do
		local pass, Service = pcall(function() return game:GetService(name) end) 
		if pass then
			xpcall(function()
				Routine(Service)
			end, warn)
		end
	end

	if game:GetService("Workspace"):FindFirstChildOfClass("Terrain"):CountCells() ~= 0 then
		local Module = require(script.Parent.TerrainModule)
		local Region = Module:Save(false)
		Region.Parent = Template
	end

	for _, folder in next, Folders do
		folder.Parent = Template
	end
	Folders = {}
	Template.Parent = game:GetService("TestService")
end;

-- EpicFazbear (c) 2021. --