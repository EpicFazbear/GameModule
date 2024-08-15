-- This script loads all PlayerScripts into the client. --

local Player = game:GetService("Players").LocalPlayer

--debug.profilebegin("PlayerScriptsLoad - ".. Player.Name)
wait() -- Wait because the script was just parented to the player and Parents may be locked for a brief second
for _, item in pairs(script:GetChildren()) do
	xpcall(function()
		item.Parent = Player:FindFirstChildOfClass("PlayerScripts")
		if item:IsA("Script") and item:FindFirstChild("EnableOnceLoaded") then
			item.Disabled = false
			item.EnableOnceLoaded:Destroy()
		end
		for _, inst in pairs(item:GetDescendants()) do
			if inst:IsA("Script") and inst:FindFirstChild("EnableOnceLoaded") then
				inst.Disabled = false
				inst.EnableOnceLoaded:Destroy()
			end
		end
	end, warn)
end
--debug.profileend()

warn("Finished loading PlayerScripts! - ".. Player.Name)
script.Parent:Destroy()

-- EpicFazbear (c) 2021. --