<h1 style="margin-bottom: 0px">GameModule</h1><h4 style="margin-top: 0px; margin-bottom: 20px">(Rojo Implementation)</h2>
This project has not been maintained since 2022, and has only been ported to Rojo for archival purposes.

This project builds a .rbxm file of a folder containing two modules: the HubModule and TemplateModule. If you intend on uploading either module, make sure to rename them to "MainModule" before continuing.

Here are some documentation I wrote for functions that can be run directly on the HubModule:
```
-- Module Functions --
Module:Help() -- Prints this message out
Module:LoadGame(Folders, Settings, CustomParameters) -- Loads in a GameModule (Strictly requires a GameModule template)
Module:LoadPack(ModuleId, Destination) -- Unpacks in a table module containing instances into a destination (Default is game.Lighting)
Module:ClearAll(CustomParameters) -- Clears all services and resets all properties
Module:Backup(CustomParameters) -- If no current backup already exists, creates a snapshot of everything in the game and saves it into a backup for the server
Module:Restore(CustomParameters) -- If a current backup exists for the server, clears everything out and loads in everything from the snapshot backup
Module:LoadOnly(Folders, CustomParameters) -- Loads only the GameModule without clearing out anything, nor setting any service properties
Module:Convert(CustomParameters) -- For use in Roblox Studio's command bar; Converts a place into a GameModule, and inserts the module into TestService
-- Custom Parameters --
NoRespawn (boolean) - Will not respawn players if TRUE
ReverseWhitelist (boolean) - If TRUE, Services listed in WhitelistedServices and ServiceList will only be processed
ServiceList (table) - A list of Services to ignore or to specify in the Whitelist
```
As for the TemplateModule, it only returns a single function (with optional CustomParameters) that will load the game saved inside the module.