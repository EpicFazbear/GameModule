--[[
	If your GameModule uses different property settings (e.g. the lighting is different or lower gravity),
		then it is recommended to set those properties here. (You can also just set them in a script in Workspace or ServerScriptService)
	If you remove an entire service's properties here, then they won't be changed at all when the GameModule gets loaded in.
	You can also remove certain properties, and they'll not be changed when the GameModule is loaded in.
	-- EpicFazbear
--]]


local WhitelistedServices = { -- Extra Whitelist Parameters --

}; --[[
	If you don't want any services in particular to be cleared when loading in the GameModule, put their names here. (e.g. "Lighting", "ServerStorage", "Players")
	Players' data will still be kept, but their properties will change depending on the settings you make below.
--]]


local ServiceProperties = {
	["Workspace"] = {
		Gravity = 196.2
		,PrimaryPart = nil
	};
	["Players"] = {
		RespawnTime = 5
		,CharacterAutoLoads = true
	};
	["Lighting"] = {
		Ambient = Color3.fromRGB(128,128,128)
		,Brightness = 2
		,ColorShift_Bottom = Color3.fromRGB(0,0,0)
		,ColorShift_Top = Color3.fromRGB(0,0,0)
		,EnvironmentDiffuseScale = 0
		,EnvironmentSpecularScale = 0
		,GlobalShadows = true
--		,Outlines = false -- Outlines is deprecated
		,OutdoorAmbient = Color3.fromRGB(128,128,128)
--		,ShadowSoftness = 0.5 -- This property only works in games with ShadowMap/Future Technology
		,ClockTime = 14
		,GeographicLatitude = 41.733
--		,TimeOfDay = "14:00:00" -- Same as ClockTime, but in a different format
		,ExposureCompensation = 0
		,FogColor = Color3.fromRGB(191,191,191)
		,FogEnd = 100000
		,FogStart = 0
	};
	["StarterGui"] = {
		ScreenOrientation = Enum.ScreenOrientation.LandscapeSensor
--		,ShowDevelopmentGui = false
	};
	["StarterPlayer"] = {
		HealthDisplayDistance = 100
		,NameDisplayDistance = 100
		,CameraMaxZoomDistance = 400
		,CameraMinZoomDistance = 0.5
		,CameraMode = Enum.CameraMode.Classic
		,DevCameraOcclusionMode = Enum.DevCameraOcclusionMode.Zoom
		,DevComputerCameraMovementMode = Enum.DevComputerCameraMovementMode.UserChoice
		,DevTouchCameraMovementMode = Enum.DevTouchCameraMovementMode.UserChoice
		,AutoJumpEnabled = false
		,CharacterJumpHeight = 7.2
		,CharacterJumpPower = 50
		,CharacterUseJumpPower = true
		,CharacterMaxSlopeAngle = 89
		,CharacterWalkSpeed = 16
		,LoadCharacterAppearance = true
		,UserEmotesEnabled = true
		,DevComputerMovementMode = Enum.DevComputerMovementMode.UserChoice
		,DevTouchMovementMode = Enum.DevTouchMovementMode.UserChoice
		,EnableMouseLockOption = true
	};
	["SoundService"] = {
		AmbientReverb = Enum.ReverbType.NoReverb
		,DistanceFactor = 3.333
		,DopplerScale = 1
		,RespectFilteringEnabled = false
		,RolloffScale = 1
	};
};


local PlayerProperties = {
--	CharacterAppearanceId = 000000;
--	If you want all players to be a certain character, uncomment this part and replace the number with the character ID
	ReplicationFocus = nil
--	Sets the part to focus network replication around
	,RespawnLocation = nil
--	Sets specific spawnlocation part for all players to spawn at
};


local TerrainProperties = {
--	CollisionGroupId = 0;
--	CustomPhysicalProperties = PhysicalProperties.new(10, 0.5, 0.5);
	["WaterProperties"] = {
		WaterColor = Color3.fromRGB(12, 84, 91)
		,WaterReflectance = 1
		,WaterTransparency = 0.3
		,WaterWaveSize = 0.15
		,WaterWaveSpeed = 10
	};
	["ColorProperties"] = { -- Colors of the terrain (if your GameModule requires, if not then just leave it as default)
		Asphalt = Color3.fromRGB(115, 123, 107)
		,Basalt = Color3.fromRGB(30, 30, 37)
		,Brick = Color3.fromRGB(138, 86, 62)
		,Cobblestone = Color3.fromRGB(132, 123, 90)
		,Concrete = Color3.fromRGB(127, 102, 63)
		,CrackedLava = Color3.fromRGB(232, 156, 74)
		,Glacier = Color3.fromRGB(101, 176, 234)
		,Grass = Color3.fromRGB(106, 127, 63)
		,Ground = Color3.fromRGB(102, 92, 59)
		,Ice = Color3.fromRGB(129, 194, 224)
		,LeafyGrass = Color3.fromRGB(115, 132, 74)
		,Limestone = Color3.fromRGB(206, 173, 148)
		,Mud = Color3.fromRGB(58, 46, 36)
		,Pavement = Color3.fromRGB(148, 148, 140)
		,Rock = Color3.fromRGB(102, 108, 111)
		,Salt = Color3.fromRGB(198, 189, 181)
		,Sand = Color3.fromRGB(143, 126, 95)
		,Sandstone = Color3.fromRGB(137, 90, 71)
		,Slate = Color3.fromRGB(63, 127, 107)
		,Snow = Color3.fromRGB(195, 199, 218)
		,WoodPlanks = Color3.fromRGB(139, 109, 79)
	};
--[[
	["TerrainFunctions"] = function()
--		If you want to directly run terrain functions (such as Terrain:FillRegion or loading saved TerrainRegions), you can uncomment this block and put them here.
	end;
--]]
};


return {
	PlayerProperties = PlayerProperties;
	ServiceProperties = ServiceProperties;
	TerrainProperties = TerrainProperties;
	WhitelistedServices = WhitelistedServices;
};