-- Clears everything from all of the Services. --

local function ClearAllChildren(instance)
	for _, item in next, instance:GetChildren() do
		if item.Name ~= "\0" then
			item:Destroy()
		end
	end
end

local function ClearChildrenWhitelist(instance, whitelist)
	for _, item in next, instance:GetChildren() do
		if not table.find(whitelist, item.Name) then
			item:Destroy()
		end
	end
end

local Services = {
	["Workspace"] = function(service)
		for _, item in pairs(service:GetChildren()) do
			if item:IsA("Terrain") then
				item.Name = "Terrain"
				item:Clear()
--				ClearAllChildren(item)
			elseif item.Name ~= "\0" and item.Name ~= "Camera" then
				item:Destroy()
			end
		end
	end;
	["Players"] = function(service)
		for _, player in next, service:GetChildren() do
			if player:IsA("Player") then
				player.Neutral = true
				player.Team = nil
				player.TeamColor = BrickColor.White()
				xpcall(function()
					for _, item in pairs(player:GetChildren()) do
						if item:IsA("Backpack") or item:IsA("StarterGear") then
							item.Name = item.ClassName
							ClearAllChildren(item)
						elseif item:IsA("PlayerGui") then
							item.Name = item.ClassName
							ClearChildrenWhitelist(item, { -- Important CoreGUIs
								"ChatInstallVerifier",
								"Freecam",
								"\0"
							})
						elseif item.Name ~= "\0" then
							item:Destroy()
						end
					end
				end, warn)
				local clone = script.ClientClearer:Clone()
				clone.Disabled = false
				clone.Parent = player.PlayerGui
			else
				player:Destroy()
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
			if not item:IsA("StarterCharacterScripts") and not item:IsA("StarterPlayerScripts") and item.Name ~= "\0" and item.Name ~= "HumanoidDefaultAssets" then
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

return function(WhitelistedServices, Parameters)
	if WhitelistedServices == true then -- Ran if the clear function is used as a standalone
		require(script.DefaultSettings)(Parameters)
		-- I forgot what this was supposed to do lul.
		WhitelistedServices = {}
	end
--debug.profilebegin("ClearFunction")
	for name, Routine in next, Services do
		if not table.find(WhitelistedServices, name) then
			local pass, Service = pcall(function() return game:GetService(name) end) 
			if pass then
				xpcall(function()
					Service.Name = name
					Routine(Service)
				end, warn)
			end
		end
	end
--debug.profileend()
end;

-- EpicFazbear (c) 2019. --