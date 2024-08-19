-- A Change Log of relatively recent changes made to the Module Hub. --

local ChangeLog = [[
	~~~ Here's an change/update log! ~~~

	August 18th, 2024 Update (1.2-github-release) -----
	~	Released the whole module (including the template) as a Rojo project on GitHub!
	~	Cleaned up some code and comments for the release
	~	Clarified the PREFACE in the LICENSE module

	July 26th, 2022 Update (1.2-indev-1) -----
	~	Added the custom Pcall module to replace all pcall and xpcall functions (xpcall cannot handle yielding anyways)
		~	(Still need to implement them into the code)

	July 25th, ((2022)) Update (1.2-indev-0) -----
		*It's been over a year since the last update...*
	~	Made the DECISION to make this MainModule licensed under GNU LGPLv3.
		~	This basically allows developers to make their own improvements to this project, under the guideline that their work must stay open-sourced.
	~	Also removed most of the Developed and remastered comments at the bottom of every submodule
	~	Removed most of the ROFL's at the bottom for more professionality (May add it back for the lolz in the future xD)
	~	I'm gonna work more on the module in the near-future, especially to fix the bugs related to loading GameModules..

	July 24th, 2021 Update (1.1.1) -----
	~	Updated the Clear module a bit, but most notably:
	~	The ClientClearer script will now clear every service in case a localscript happened to create client-sided Instances outside of the CurrentCamera.

	May 7th, 2021 Update (1.1) -----
	~	Removed (commented out) the calls to _G.Adonis.SetLighting since those calls were no longer really necessary (in my viewpoint).
	~	Added TerrainRegion saving (using Crazyman's method) for both the Convert and Backup methods. (Load already supported loading TerrainRegion this way).
	~	FINALLY ADDED CustomParameters! A new submodule has been scripted that acts as a parser for any kind of parameters that are ever called.
		~	(This will improve the MainModule's flexibility and amount of possible direct-use cases!)


	APRIL FOOLS UPDATE!!!1111 (1.0) -----
	~	Changed the order of how the Load module loads the game in, this is to compensate for PlayerScripts and ReplicatedFirst scripts breaking.
		~	PlayerScripts would sometimes (rarely) break because the game hasn't fully loaded server-side yet, so it'll now load after the game fully loads.
		~	ReplicatedFirst will stay loading before the game loads.
	~	Added proper support for ReplicatedFirst scripts.
	~	The Convert function no longer requires you to manually paste in a string into the Settings module; it turns out you can actually edit .Source from the Command Bar..
]];

-- Removes the new-line at the end..
ChangeLog = string.sub(ChangeLog, 1, #ChangeLog - 1);

warn(ChangeLog);
return ChangeLog;

-- EpicFazbear (c) 2022. --