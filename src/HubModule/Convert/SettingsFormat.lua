-- This module formats the Settings module and inputs all of the game's service properties for the user. --

local tostring = function(input, decimal)
	if typeof(input) ~= "number" then
		return tostring(input) -- Native function
	else -- We'll have to round our numbers..
		local dec = decimal or 3
		return tostring(math.floor(input * 10^dec + 0.5) / 10^dec)
	end
end

local function GetTerrainColorString(Name)
	local Color = game.Workspace.Terrain:GetMaterialColor(Enum.Material[Name])
	return "Color3.fromRGB(" .. tostring(Color.R*255,0) .. "," .. tostring(Color.G*255,0) .. "," .. tostring(Color.B*255,0) .. ")"
end

local function GetColorString(Color)
	return "Color3.fromRGB(" .. tostring(Color.R*255,0) .. "," .. tostring(Color.G*255,0) .. "," .. tostring(Color.B*255,0) .. ")"
end


return function()
	return "--[[\
	If your GameModule uses different property settings (e.g. the lighting is different or lower gravity), then it is recommended to set those properties here.\
	(You can also just set them in a script in Workspace or ServerScriptService)\
	If you remove an entire service's properties here, then they won't be changed at all when the GameModule gets loaded in.\
	You can also remove certain properties, and they'll not be changed when the GameModule is loaded in.\
	-- EpicFazbear\
--]]\
\
\
local WhitelistedServices = { -- Extra Whitelist Parameters --\
\
}; --[[\
	If you don't want any services in particular to be cleared when loading in the GameModule, put their names here. (e.g. \"Lighting\", \"ServerStorage\", \"Players\")\
	Players' data will still be kept, but their properties will change depending on the settings you make below.\
--]]\
\
\
local ServiceProperties = {\
	[\"Workspace\"] = {\
		Gravity = " .. tostring(game:GetService("Workspace").Gravity) .. "\
		,PrimaryPart = nil\
	};\
	[\"Players\"] = {\
		RespawnTime = " .. tostring(game:GetService("Players").RespawnTime) .. "\
		,CharacterAutoLoads = " .. tostring(game:GetService("Players").CharacterAutoLoads) .. "\
	};\
	[\"Lighting\"] = {\
		Ambient = " .. GetColorString(game:GetService("Lighting").Ambient) .. "\
		,Brightness = " .. tostring(game:GetService("Lighting").Brightness) .. "\
		,ColorShift_Bottom = " .. GetColorString(game:GetService("Lighting").ColorShift_Bottom) .. "\
		,ColorShift_Top = " .. GetColorString(game:GetService("Lighting").ColorShift_Top) .. "\
		,EnvironmentDiffuseScale = " .. tostring(game:GetService("Lighting").EnvironmentDiffuseScale) .. "\
		,EnvironmentSpecularScale = " .. tostring(game:GetService("Lighting").EnvironmentSpecularScale) .. "\
		,GlobalShadows = " .. tostring(game:GetService("Lighting").GlobalShadows) .. "\
--		,Outlines = " .. tostring(game:GetService("Lighting").Outlines) .. " -- Outlines is deprecated\
		,OutdoorAmbient = " .. GetColorString(game:GetService("Lighting").OutdoorAmbient) .. "\
--		,ShadowSoftness = " .. tostring(game:GetService("Lighting").ShadowSoftness) .. " -- This property only works in games with ShadowMap/Future Technology\
		,ClockTime = " .. tostring(game:GetService("Lighting").ClockTime) .. "\
		,GeographicLatitude = " .. tostring(game:GetService("Lighting").GeographicLatitude) .. "\
--		,TimeOfDay = " .. tostring(game:GetService("Lighting").TimeOfDay) .. " -- Same as ClockTime, but in a different format\
		,ExposureCompensation = " .. tostring(game:GetService("Lighting").ExposureCompensation) .. "\
		,FogColor = " .. GetColorString(game:GetService("Lighting").FogColor) .. "\
		,FogEnd = " .. tostring(game:GetService("Lighting").FogEnd) .. "\
		,FogStart = " .. tostring(game:GetService("Lighting").FogStart) .. "\
	};\
	[\"StarterGui\"] = {\
		ScreenOrientation = " .. tostring(game:GetService("StarterGui").ScreenOrientation) .. "\
--		,ShowDevelopmentGui = " .. tostring(game:GetService("StarterGui").ShowDevelopmentGui) .. "\
	};\
	[\"StarterPlayer\"] = {\
		HealthDisplayDistance = " .. tostring(game:GetService("StarterPlayer").HealthDisplayDistance) .. "\
		,NameDisplayDistance = " .. tostring(game:GetService("StarterPlayer").NameDisplayDistance) .. "\
		,CameraMaxZoomDistance = " .. tostring(game:GetService("StarterPlayer").CameraMaxZoomDistance) .. "\
		,CameraMinZoomDistance = " .. tostring(game:GetService("StarterPlayer").CameraMinZoomDistance) .. "\
		,CameraMode = " .. tostring(game:GetService("StarterPlayer").CameraMode) .. "\
		,DevCameraOcclusionMode = " .. tostring(game:GetService("StarterPlayer").DevCameraOcclusionMode) .. "\
		,DevComputerCameraMovementMode = " .. tostring(game:GetService("StarterPlayer").DevComputerCameraMovementMode) .. "\
		,DevTouchCameraMovementMode = " .. tostring(game:GetService("StarterPlayer").DevTouchCameraMovementMode) .. "\
		,AutoJumpEnabled = " .. tostring(game:GetService("StarterPlayer").AutoJumpEnabled) .. "\
		,CharacterJumpHeight = " .. tostring(game:GetService("StarterPlayer").CharacterJumpHeight) .. "\
		,CharacterJumpPower = " .. tostring(game:GetService("StarterPlayer").CharacterJumpPower) .. "\
		,CharacterUseJumpPower = " .. tostring(game:GetService("StarterPlayer").CharacterUseJumpPower) .. "\
		,CharacterMaxSlopeAngle = " .. tostring(game:GetService("StarterPlayer").CharacterMaxSlopeAngle) .. "\
		,CharacterWalkSpeed = " .. tostring(game:GetService("StarterPlayer").CharacterWalkSpeed) .. "\
		,LoadCharacterAppearance = " .. tostring(game:GetService("StarterPlayer").LoadCharacterAppearance) .. "\
		,UserEmotesEnabled = " .. tostring(game:GetService("StarterPlayer").UserEmotesEnabled) .. "\
		,DevComputerMovementMode = " .. tostring(game:GetService("StarterPlayer").DevComputerMovementMode) .. "\
		,DevTouchMovementMode = " .. tostring(game:GetService("StarterPlayer").DevTouchMovementMode) .. "\
		,EnableMouseLockOption = " .. tostring(game:GetService("StarterPlayer").EnableMouseLockOption) .. "\
	};\
	[\"SoundService\"] = {\
		AmbientReverb = " .. tostring(game:GetService("SoundService").AmbientReverb) .. "\
		,DistanceFactor = " .. tostring(game:GetService("SoundService").DistanceFactor) .. "\
		,DopplerScale = " .. tostring(game:GetService("SoundService").DopplerScale) .. "\
		,RespectFilteringEnabled = " .. tostring(game:GetService("SoundService").RespectFilteringEnabled) .. "\
		,RolloffScale = " .. tostring(game:GetService("SoundService").RolloffScale) .. "\
	};\
};\
\
\
local PlayerProperties = {\
--	CharacterAppearanceId = 000000;\
--	If you want all players to be a certain character, uncomment this part and replace the number with the character ID\
	ReplicationFocus = nil\
--	Sets the part to focus network replication around\
	,RespawnLocation = nil\
--	Sets a specific RespawnLocation part for all players to spawn at\
};\
\
\
local TerrainProperties = {\
--	CollisionGroupId = 0;\
--	CustomPhysicalProperties = PhysicalProperties.new(10, 0.5, 0.5);\
	[\"WaterProperties\"] = {\
		WaterColor = " .. GetColorString(game:GetService("Workspace").Terrain.WaterColor) .. "\
		,WaterReflectance = " .. tostring(game:GetService("Workspace").Terrain.WaterReflectance) .. "\
		,WaterTransparency = " .. tostring(game:GetService("Workspace").Terrain.WaterTransparency) .. "\
		,WaterWaveSize = " .. tostring(game:GetService("Workspace").Terrain.WaterWaveSize) .. "\
		,WaterWaveSpeed = " .. tostring(game:GetService("Workspace").Terrain.WaterWaveSpeed) .. "\
	};\
	[\"ColorProperties\"] = { -- Colors of the terrain (if your GameModule requires it; otherwise just leave as default)\
		Asphalt = " .. GetTerrainColorString("Asphalt") .. "\
		,Basalt = " .. GetTerrainColorString("Basalt") .. "\
		,Brick = " .. GetTerrainColorString("Brick") .. "\
		,Cobblestone = " .. GetTerrainColorString("Cobblestone") .. "\
		,Concrete = " .. GetTerrainColorString("Concrete") .. "\
		,CrackedLava = " .. GetTerrainColorString("CrackedLava") .. "\
		,Glacier = " .. GetTerrainColorString("Glacier") .. "\
		,Grass = " .. GetTerrainColorString("Grass") .. "\
		,Ground = " .. GetTerrainColorString("Ground") .. "\
		,Ice = " .. GetTerrainColorString("Ice") .. "\
		,LeafyGrass = " .. GetTerrainColorString("LeafyGrass") .. "\
		,Limestone = " .. GetTerrainColorString("Limestone") .. "\
		,Mud = " .. GetTerrainColorString("Mud") .. "\
		,Pavement = " .. GetTerrainColorString("Pavement") .. "\
		,Rock = " .. GetTerrainColorString("Rock") .. "\
		,Salt = " .. GetTerrainColorString("Salt") .. "\
		,Sand = " .. GetTerrainColorString("Sand") .. "\
		,Sandstone = " .. GetTerrainColorString("Sandstone") .. "\
		,Slate = " .. GetTerrainColorString("Slate") .. "\
		,Snow = " .. GetTerrainColorString("Snow") .. "\
		,WoodPlanks = " .. GetTerrainColorString("WoodPlanks") .. "\
	};\
--[[\
	[\"TerrainFunctions\"] = function()\
--		If you want to directly run terrain functions (such as Terrain:FillRegion or loading saved TerrainRegions), you can uncomment this block and put them here.\
	end;\
--]]\
};\
\
\
return {\
	PlayerProperties = PlayerProperties;\
	ServiceProperties = ServiceProperties;\
	TerrainProperties = TerrainProperties;\
	WhitelistedServices = WhitelistedServices;\
};"
end;

-- EpicFazbear (c) 2021. --