-- This script clears and resets everything that's client-sided. --

local Player = game:GetService("Players").LocalPlayer

local function ClearAllChildren(instance)
	for _, item in next, instance:GetChildren() do
		if item.Name ~= "\0" and item.Parent ~= nil then
			item:Destroy()
		end
	end
end

local function ClearChildrenWhitelist(instance, whitelist)
	for _, item in next, instance:GetChildren() do
		if not table.find(whitelist, item.Name) and item.Parent ~= nil then
			item:Destroy()
		end
	end
end

--debug.profilebegin("ClearClientItems - ".. Player.Name)
ClearAllChildren(game:GetService("Workspace").CurrentCamera)
for _, item in pairs(Player:GetChildren()) do
	xpcall(function()
		if item:IsA("Backpack") or item:IsA("StarterGear") then
			ClearAllChildren(item)
		elseif item:IsA("PlayerGui") then
			ClearChildrenWhitelist(item, { -- Important CoreGUIs
				"BubbleChat",
				"Chat",
				"ClientClearer",
				"Freecam",
				"ClientClearer",
				"PlayerScriptsLoader",
				"TouchGui",
				"\0"
			})
		elseif item:IsA("PlayerScripts") then
			ClearChildrenWhitelist(item, { -- Important CoreGUIs
				"BubbleChat",
				"ChatScript",
				"PlayerScriptsLoader",
				"RbxCharacterSounds",
				"PlayerModule",
				"\0"
			})
		elseif item.Name ~= "\0" then
			item:Destroy()
		end
	end, warn)
end
--debug.profileend()

--debug.profilebegin("ClearClientServices - ".. Player.Name)
local Services = {
	["Workspace"] = function(service)
		for _, item in pairs(service:GetChildren()) do
			if not item:IsA("Terrain") and item ~= service.CurrentCamera and item.Name ~= "\0" and item.Parent ~= nil then
				item:Destroy()
			end
		end
	end;
	["Players"] = function(service)
		for _, item in next, service:GetChildren() do
			if not item:IsA("Player") and item.Parent ~= nil then
				item:Destroy()
			end
		end
	end;
	["Lighting"] = function(service)
		ClearAllChildren(service)
	end;
	["ReplicatedFirst"] = function(service)
		ClearAllChildren(service)
	end;
	["ReplicatedStorage"] = function(service)
		ClearChildrenWhitelist(service, {
			"DefaultChatSystemChatEvents", -- Important CoreScript
			"\0"
		})
	end;
	["ServerScriptService"] = function(service)
		ClearChildrenWhitelist(service, {
			"ChatServiceRunner", -- Important CoreScript
			"\0"
		})
	end;
	["ServerStorage"] = function(service)
		ClearAllChildren(service)
	end;
	["StarterGui"] = function(service)
		ClearAllChildren(service)
	end;
	["StarterPack"] = function(service)
		ClearAllChildren(service)
	end;
	["StarterPlayer"] = function(service)
		ClearAllChildren(service.StarterCharacterScripts)
		ClearChildrenWhitelist(service.StarterPlayerScripts, { -- Important CoreScripts
			"BubbleChat",
			"ChatScript",
			"PlayerScriptsLoader",
			"RbxCharacterSounds",
			"PlayerModule",
			"\0"
		})
		for _, item in next, service:GetChildren() do
			if not item:IsA("StarterCharacterScripts") and not item:IsA("StarterPlayerScripts") and item.Name ~= "\0" and item.Name ~= "HumanoidDefaultAssets" and item.Parent ~= nil then
				item:Destroy()
			elseif item:IsA("StarterCharacterScripts") or item:IsA("StarterPlayerScripts") then
				item.Name = item.ClassName
			end
		end
	end;
	["Teams"] = function(service)
		ClearAllChildren(service)
	end;
	["SoundService"] = function(service)
		ClearAllChildren(service)
	end;
	["Chat"] = function(service)
		ClearChildrenWhitelist(service, { -- Important CoreScripts
			"ChatModules",
			"ClientChatModules",
			"ChatLocalization",
			"ChatServiceRunner",
			"BubbleChat",
			"ChatScript",
			"\0"
		})
	end;
	["LocalizationService"] = function(service)
		ClearAllChildren(service)
	end;
};

for name, Routine in next, Services do
	local pass, Service = pcall(function() return game:GetService(name) end) 
	if pass then
		xpcall(function()
			Service.Name = name
			Routine(Service)
		end, warn)
	end
end
--debug.profileend()

local StarterGui = game:GetService("StarterGui")
StarterGui:SetCoreGuiEnabled(Enum.CoreGuiType.All, true) -- Re-enable all CoreGuis
pcall(function()
	StarterGui:SetCore("PointsNotificationsActive", true)
end)
pcall(function()
	StarterGui:SetCore("BadgesNotificationsActive", true)
end)
pcall(function()
	StarterGui:SetCore("ResetButtonCallback", true)
end)
pcall(function()
	StarterGui:SetCore("ChatBarDisabled", false)
end)
pcall(function()
	StarterGui:SetCore("TopbarEnabled", true)
end)
pcall(function()
	StarterGui:SetCore("AvatarContextMenuEnabled", false)
end)
Player:GetMouse().Icon = "" -- Clear mouse icon
warn("Finished client-sided clearing! - ".. Player.Name)
wait() -- Just wait...
script:Destroy()

-- EpicFazbear (c) 2021. --