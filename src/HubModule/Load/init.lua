-- Loads in the GameModule. --

return function(Folders, Settings, Parameters)
--debug.profilebegin("ServiceProperties")
	if Settings and Settings.ServiceProperties then
		for name, table in next, Settings.ServiceProperties do
			local pass, Service = pcall(function() return game:GetService(name) end)
			if pass then
				for property, value in next, table do
					xpcall(function()
						Service[property] = value
					end, warn)
				end
			end
		--[[
			if name == "Lighting" and _G.Adonis then -- Adonis Lighting Compatibility
				for property, value in next, table do
					xpcall(function()
						_G.Adonis.SetLighting(property, value)
					end, warn)
				end
			end
		--]]
		end
	end
--debug.profileend()


--debug.profilebegin("ReplicatedFirst")
	local Folder = Folders.ReplicatedFirst
	if typeof(Folder) == "Instance" then
		for _, Player in ipairs(game:GetService("Players"):GetPlayers()) do
			local LoaderScript = script.ReplicatedFirstLoader:Clone()
			for _, item in ipairs(Folder:GetChildren()) do
				local clone = item:Clone()
				if clone:IsA("Script") and not clone.Disabled then
					clone.Disabled = true
					local config = Instance.new("Configuration")
					config.Name = "EnableOnceLoaded"
					config.Parent = clone
				end
				for _, inst in ipairs(clone:GetDescendants()) do
					if inst:IsA("Script") and not inst.Disabled then
						inst.Disabled = true
						local config = Instance.new("Configuration")
						config.Name = "EnableOnceLoaded"
						config.Parent = inst
					end
				end
				clone.Parent = LoaderScript
			end

			local Container = Instance.new("ScreenGui")
			Container.ResetOnSpawn = false
			Container.Name = "SafeContainer"
			LoaderScript.Parent = Container
			LoaderScript.Disabled = false
			Container.Parent = Player:FindFirstChildOfClass("PlayerGui")
		end
	end
--debug.profileend()


--debug.profilebegin("TerrainProperties")
	if Settings and Settings.TerrainProperties then
		local Terrain = game:GetService("Workspace"):FindFirstChildWhichIsA("Terrain")
		for property, value in next, Settings.TerrainProperties.ColorProperties or {} do
			xpcall(function()
				Terrain:SetMaterialColor(Enum.Material[property], value)
			end, warn)
		end
		for property, value in next, Settings.TerrainProperties.WaterProperties or {} do
			xpcall(function()
				Terrain[property] = value
			end, warn)
		end
		if typeof(Settings.TerrainProperties.TerrainFunctions) == "function" then
			Settings.TerrainProperties.TerrainFunctions()
		end
	end
--debug.profileend()


--debug.profilebegin("LoadGame")
	local RanServices = {}
	local ChangedScripts = {}
	for Name, Child in next, Folders do
		if Child:IsA("Folder") then
			local Folder = Child:Clone()
			if Name == "StarterCharacterScripts" or Name == "StarterPlayerScripts" then
				for _, item in ipairs(Folder:GetChildren()) do
					item.Parent = game:GetService("StarterPlayer"):FindFirstChildOfClass(Name)
				end
			elseif Name == "Terrain" then
				for _, item in ipairs(Folder:GetChildren()) do
					item.Parent = game:GetService("Workspace"):FindFirstChildOfClass("Terrain")
				end
			end

			local pass, Service = pcall(function() return game:GetService(Name) end)
			if pass then
				if not table.find(RanServices, Name) then
					table.insert(RanServices, Name)

					if Name == "Workspace" or Name == "ServerScriptService" then
						for _, item in ipairs(Folder:GetDescendants()) do
							if item.ClassName == "Script" and not item.Disabled then
								item.Disabled = true
								table.insert(ChangedScripts, item)
								--local config = Instance.new("Configuration")
								--config.Name = "EnableOnceLoaded"
								--config.Parent = item
							end
						end
						for _, item in ipairs(Folder:GetChildren()) do
							item.Parent = Service
						end

					elseif Name == "StarterGui" then
						local ItemsToClone = {}
						for _, item in ipairs(Folder:GetChildren()) do
							item.Parent = Service
							if item:IsA("ScreenGui") and item.ResetOnSpawn == false then
								table.insert(ItemsToClone, item)
							end
						end
						for _, Player in ipairs(game:GetService("Players"):GetPlayers()) do
							local PlayerGui = Player:FindFirstChildOfClass("PlayerGui")
							if PlayerGui then
								for _, gui in pairs(ItemsToClone) do
									if gui and gui.Parent then
										gui:Clone().Parent = PlayerGui
									end
								end
							end
						end

					elseif Name == "StarterPlayer" then
						local item1 = Folder:FindFirstChild("StarterCharacterScripts")
						if item1 then
							for _, item in ipairs(item1:GetChildren()) do
								item.Parent = Service:FindFirstChildOfClass("StarterCharacterScripts")
							end
							item1:Destroy()
						end
						local item2 = Folder:FindFirstChild("StarterPlayerScripts")
						if item2 then
							for _, item in ipairs(item2:GetChildren()) do
								item.Parent = Service:FindFirstChildOfClass("StarterPlayerScripts")
							end
							item2:Destroy()
						end
						for _, item in ipairs(Folder:GetChildren()) do
							item.Parent = Service
						end

					elseif Name == "Teams" then
						local teams = {}
						for _, item in ipairs(Folder:GetChildren()) do
							item.Parent = Service
							if item:IsA("Team") and item.AutoAssignable then
								table.insert(teams, item)
							end
						end
						for index, player in ipairs(game:GetService("Players"):GetPlayers()) do
							local teamNumber = ((index-1) % #teams) + 1
							player.Team = teams[teamNumber]
						end

					elseif Name == "Chat" then
						-- TODO

					else
						for _, item in ipairs(Folder:GetChildren()) do
							item.Parent = Service
						end
					end
				else
					warn("\"".. tostring(Name) .."\" has been already loaded.. Ignoring additional reference.")
				end
			else
				warn("\"".. tostring(Name) .."\" is an invalid Service name.. Ignoring reference.")
			end
			Folder:Destroy()

		elseif Child:IsA("TerrainRegion") and (Name == "SavedTerrain" or Name == "Terrain") then -- SavedTerrain data
			local Module = require(script.Parent.Shared.TerrainSaveLoad)
			Module:Load(Child)
		elseif Name ~= "Settings" then -- Muted warning
			warn("\"".. tostring(Name) .."\" is not a folder instance.. Ignoring reference.")
		end
	end
--debug.profileend()


	--debug.profilebegin("StartScripts")
	for _, item in ipairs(ChangedScripts) do
		if item.Parent ~= nil then -- and item.ClassName == "Script" and item:FindFirstChild("EnableOnceLoaded")
			--item.EnableOnceLoaded:Destroy()
			item.Disabled = false
		end
	end
--debug.profileend()


--debug.profilebegin("PlayerProperties")
	for _, Player in ipairs(game:GetService("Players"):GetPlayers()) do
		if Settings and Settings.PlayerProperties then
			for property, value in next, Settings.PlayerProperties do
				xpcall(function()
					Player[property] = value
				end, warn)
			end
		end

		if Settings and Settings.ServiceProperties then
			local Pairs = { -- Pair properties: ["StarterPlayer"] = "Player" (This is needed because some properties are named differently)
				["AutoJumpEnabled"] = "AutoJumpEnabled";
				["LoadCharacterAppearance"] = "CanLoadCharacterAppearance";
				["CameraMaxZoomDistance"] = "CameraMaxZoomDistance";
				["CameraMinZoomDistance"] = "CameraMinZoomDistance";
				["CameraMode"] = "CameraMode";
				["DevCameraOcclusionMode"] = "DevCameraOcclusionMode";
				["DevComputerCameraMovementMode"] = "DevComputerCameraMode";
				["EnableMouseLockOption"] = "DevEnableMouseLock";
				["DevTouchCameraMovementMode"] = "DevTouchCameraMode";
				["HealthDisplayDistance"] = "HealthDisplayDistance";
				["NameDisplayDistance"] = "NameDisplayDistance";
				["DevComputerMovementMode"] = "DevComputerMovementMode";
				["DevTouchMovementMode"] = "DevTouchMovementMode";
			};
			for spval, plval in next, Pairs do
				xpcall(function()
					Player[plval] = Settings.ServiceProperties.StarterPlayer[spval]
				end, warn)
			end
		end

		local Folder
		if typeof(Folders.StarterPlayer) == "Instance" then
			Folder = Folders.StarterPlayer:FindFirstChild("StarterPlayerScripts")
		else
			Folder = Folders.StarterPlayerScripts
		end
		if typeof(Folder) == "Instance" then
			local LoaderScript = script.PlayerScriptsLoader:Clone()
			for _, item in ipairs(Folder:GetChildren()) do
				local clone = item:Clone()
				if clone:IsA("Script") and not clone.Disabled then
					clone.Disabled = true
					local config = Instance.new("Configuration")
					config.Name = "EnableOnceLoaded"
					config.Parent = clone
				end
				for _, inst in ipairs(clone:GetDescendants()) do
					if inst:IsA("Script") and not inst.Disabled then
						inst.Disabled = true
						local config = Instance.new("Configuration")
						config.Name = "EnableOnceLoaded"
						config.Parent = inst
					end
				end
				clone.Parent = LoaderScript
			end
			local Container = Instance.new("ScreenGui")
			Container.ResetOnSpawn = false
			Container.Name = "SafeContainer"
			LoaderScript.Parent = Container
			LoaderScript.Disabled = false
			Container.Parent = Player:FindFirstChildOfClass("PlayerGui")
		end
	end
--debug.profileend()
end;

-- EpicFazbear (c) 2019. --