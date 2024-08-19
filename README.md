# GameModule
### (Rojo Implementation)

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
Module:Convert(CustomParameters) -- For use in Roblox Studio's Command Bar; Converts a place into a GameModule, and inserts the module into TestService
-- Custom Parameters --
NoRespawn (boolean) - Will not respawn players if TRUE
ReverseWhitelist (boolean) - If TRUE, Services listed in WhitelistedServices and ServiceList will only be processed
ServiceList (table) - A list of Services to ignore or to specify in the Whitelist
```

As for the TemplateModule, it only returns a single function (with optional CustomParameters) that will load the game saved inside the module.


# Example Modules
These modules *will* replace everything in a running server or Studio instance. Only test them in a controlled environment.

These are also connected to the [original upload of the HubModule](https://www.roblox.com/library/4918828123/Main-Module-Hub), so please note that any new changes made from this GitHub repository won't be reflected in the examples.

- `require(5235974706)() -- Bowling Alley (by blXhd)`
- `require(6337523729)() -- Egg Hunt 2013 (by ROBLOX Staff, CloneTrooper1019)`
- `require(4472855895)() -- Frost Nova (by Django136)`
- `require(7178502542)() -- Nintendo Minigames (by BMJ44)`