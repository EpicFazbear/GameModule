-- HubModule --
-- Check the ChangeLog module for information about past updates.
-- Check the LICENSE module for more information about this HubModule's licensing.

local Module = {};
local Parser = require(script.Parameters)
local BackupExists = false

local function ConvertToTable(array)
	local table = {}
	for _, item in next, array do
		if typeof(item) == "Instance" then
			table[item.Name] = item
		end
	end
	return table
end;


function Module:LoadGame(Folders, Settings, CustomParameters)
	assert(Settings.ServiceProperties, "This GameModule is outdated; If you own this module, merge your module with the new template. (Sorry!)")
	local Parameters = Parser(CustomParameters)
	if not BackupExists then
		Module:Backup() -- Redundant, but safe
	end
local oldtick = tick()
	game:GetService("Players").CharacterAutoLoads = false
	require(script.Clear)(Settings.WhitelistedServices, Parameters)
	wait() -- Wait to prevent any errors caused by any clears during loading..
	require(script.Load)(ConvertToTable(Folders), Settings, Parameters)
	game:GetService("Players").CharacterAutoLoads = Settings.Players and Settings.Players.CharacterAutoLoads or true
	if Parameters.NoRespawn ~= true then
		for _, player in pairs(game:GetService("Players"):GetPlayers()) do
			spawn(function()
				player:LoadCharacter()
			end)
		end
	end
warn("GameModule loaded in ".. tick() - oldtick .." seconds.")
end;


function Module:LoadPack(ModuleId, Destination, CustomParameters)
	--local Parameters = Parser(CustomParameters)
	local Module = require(ModuleId)
	assert(typeof(Module == "table"), "Given module doesn't return a table!")
	if Destination then
		assert(typeof(Destination == "Instance"), "Invalid destination type!")
	end
	for int, item in next, Module do
		if typeof(item) == "Instance" then
			item:Clone().Parent = Destination or game:GetService("Lighting")
		else
			warn("Item \"".. tostring(int) .."\" isn't an Instance!")
		end
	end
end;


function Module:ClearAll(CustomParameters)
	local Parameters = Parser(CustomParameters)
	require(script.Clear)(true, Parameters);
end;


function Module:Backup(CustomParameters)
	if BackupExists then error("A backup already exists for this server.") return end
	local Parameters = Parser(CustomParameters)
local oldtick = tick()
	require(script.Backup)(Parameters)
	BackupExists = true
warn("Backup created in ".. tick() - oldtick .." seconds.")
end;


function Module:Restore(CustomParameters)
	if not BackupExists then error("No backup exists for this server.") return end
	local Parameters = Parser(CustomParameters)
local oldtick = tick()
	Module:LoadGame(script.Backup:GetChildren(), require(script.Backup.Settings), Parameters)
	if Parameters.NoRespawn ~= true then
		for _, player in pairs(game:GetService("Players"):GetPlayers()) do
			spawn(function()
				player:LoadCharacter()
			end)
		end
	end
warn("Backup restored in ".. tick() - oldtick .." seconds.")
end;


function Module:LoadOnly(Folders, CustomParameters)
	local Parameters = Parser(CustomParameters)
local oldtick = tick()
	require(script.Load)(Folders, nil, Parameters)
warn("LoadOnly GameModule loaded in ".. tick() - oldtick .." seconds.")
end;


function Module:Convert(CustomParameters)
	local Parameters = Parser(CustomParameters)
local oldtick = tick()
	require(script.Convert)(Parameters)
warn("Successfuly converted place into a GameModule in ".. tick() - oldtick .." seconds.")
end;


function Module:Help()
	warn(
		"~~~ Documentation ~~~"..
		"\n"..
		"-- Module Functions --"..
		"\n\nModule.Help() - Prints this message out"..
		"\nModule:LoadGame(Folders, Settings, CustomParameters) - Loads in a GameModule (Strictly requires a GameModule template)"..
		"\nModule:LoadPack(ModuleId, Destination) - Unpacks in a table module containing instances into a destination (Default is game.Lighting)"..
		"\nModule:ClearAll(CustomParameters) - Clears all services and resets all properties"..
		"\nModule:Backup(CustomParameters) - If no current backup already exists, creates a snapshot of everything in the game and saves it into a backup for the server"..
		"\nModule:Restore(CustomParameters) - If a current backup exists for the server, clears everything out and loads in everything from the snapshot backup"..
		"\nModule:LoadOnly(Folders, CustomParameters) - Loads only the GameModule without clearing out anything, nor setting any service properties"..
		"\nModule:Convert(CustomParameters) - For use in Roblox Studio's Command Bar; Converts a place into a GameModule, and inserts the module into TestService"..
		"\n"..
		"\n-- Custom Parameters --"..
		"\nNoRespawn (boolean) - Will not respawn players if TRUE"..
		"\nReverseWhitelist (boolean) - If TRUE, Services listed in WhitelistedServices and ServiceList will only be processed"..
		"\nServiceList (table) - A list of Services to ignore or to specify in the Whitelist"
	)
end;


-- Module.Debug = script;

return setmetatable(Module, {
	__index = function()
		Module:Help() -- Self-help
		error("Invalid call to module.")
	end;
	__newindex = function()
		error("Module is read-only.")
	end;
	__metatable = "Protected Module.";
});


-- Copyright (c) 2019-2024 EpicFazbear / Fazsune. --