-- Game Module Template --

return function(CustomParameters)
	local Module = require(); -- HubModule (This needs to be filled in!)
	Module:LoadGame(script:GetChildren(), require(script.Settings), CustomParameters);
end; -- Usage: require(ModuleID)() -- (ModuleID is the ID of your own module that you uploaded)





--[[
	---- An Update on the Tutorial ----

	Hey there scripter! This is just to let you know that I made a very fast shortcut that will automatically pack everything
	in your Studio session into a neat MainModule placed into TestService.

	All you need to do is run this require function:

		require(HUB_ID):Convert()

	Do not worry, it is just the same module used at the top to load the whole game, but instead it just saves everything into a module.

	Please note however that you should still playtest your games to ensure no bugs occur during playtime.
	The issue I stated below about PlayerJoined scripts still occur, so make sure you're patching the game's scripts before exporting!




	-- Brief Tutorial --
	*To make your own GameModule, follow my brief tutorial below!*

	It's mostly just straightforward, but basically what your doing is porting an existing game into this module.
	Put each object in Explorer from it's service to the corresponding folder. If that folder doesn't exist in the module,
	make a new folder with the exact same name and it should work.

	For StarterPlayer, you can put in folders named StarterCharacterScripts or StarterPlayerScripts into the module
	if you need to.

	One thing to note is that when you load the module, you're basically loading the whole game into the server with 
	people still playing on that server, meaning PlayerJoined scripts will not run for those people.
	To fix that, make sure you patch your game's scripts so that those PlayerJoined functions run for all the
	players that are in the server.

	Ex: Add the following to any of your applicable scripts:
	for _, player in next, game.Players:GetPlayers() do
		onPlayerJoined(player)
	end
	After that, you should be good to go!

	Always remember that you should always playtest and debug any compatibility problems your GameModule has
	before you release your module! That way you can fix any errors that may break a script within your game!

	-- EpicFazbear --
--]]