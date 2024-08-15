-- Custom Pcall function for error handling. --

return function(routine)
	if typeof(routine) == "function" then
		local successful, message = pcall(routine) -- (xpcall)
		if successful == false then
			--warn(message)
			warn(debug.traceback(tostring(message) .. "\n[Stack Begin]", 2) .. "[Stack End]")
		end
		return successful, message
	else
		error("Input for Pcall was not a function!")
	end
end;

-- EpicFazbear (c) 2022 ROFL --