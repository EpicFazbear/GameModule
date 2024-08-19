-- Game Module Template --

return function(CustomParameters)
	local Module = require(); -- HubModule (This needs to be filled in!)
	Module:LoadGame(script:GetChildren(), require(script.Settings), CustomParameters);
end;





--[[
	-- Brief Tutorial --

	Since the HubModule's Convert function was used, this GameModule should already be packaged and mostly ready for release.

	However, one thing to note is that when you load the module, you're basically loading the whole game into the server with 
	people still playing on that server, meaning that PlayerJoined scripts will not run for those people.
	To fix that, make sure you patch your game's scripts so that those PlayerJoined functions run for all the players in the server.

	Ex: Add the following to any of your applicable scripts:
	for _, player in next, game.Players:GetPlayers() do
		onPlayerJoined(player)
	end
	After that, you should be good to go!

	Always remember that you should always playtest and debug any additional compatibility issues your GameModule has
	before you release your module! That way, you can fix any errors that may break a script within your game!

	-- EpicFazbear --
--]]