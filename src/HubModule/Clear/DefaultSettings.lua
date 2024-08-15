-- This module sets every service property back to its official default state. --

return function()
	local Settings = require(script.Parent.Parent.Shared.Settings:Clone()) -- Just borrowing this module.. LAWL

--debug.profilebegin("ServiceProperties")
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
--debug.profileend()

--debug.profilebegin("PlayerProperties")
	for _, player in next, game:GetService("Players"):GetPlayers() do
		for property, value in next, Settings.PlayerProperties do
			xpcall(function()
				player[property] = value
			end, warn)
		end
		local StarterPlayer = Settings.ServiceProperties.StarterPlayer
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
				player[plval] = StarterPlayer[spval]
			end, warn)
		end
	end
--debug.profileend()

--debug.profilebegin("TerrainProperties")
	local Terrain = game:GetService("Workspace"):FindFirstChildWhichIsA("Terrain")
	for property, value in next, Settings.TerrainProperties.WaterProperties or {} do
		xpcall(function()
			Terrain[property] = value
		end, warn)
	end
	for property, value in next, Settings.TerrainProperties.ColorProperties or {} do
		xpcall(function()
			Terrain:SetMaterialColor(Enum.Material[property], value)
		end, warn)
	end
--debug.profileend()
end;

-- EpicFazbear (c) 2021. --