function check_if_target_is_vendor(character_target)
	--TODO find a query that shows if target is vendor
	--If all else fails, populate a new DB with RequestTrade event targets so that only the first dialog locks the whole party
	return false
end

function check_if_target_is_special(character_target)
	--TODO find queries that determine whether target shouldn't be re-assignable outside of being vendors
	--TODO if target has more than one dialog, check if these target a particular party member
	local target_available_dialogs = {}
	for _,entry in pairs(Osi.DB_Dialogs:Get(character_target,nil,nil)) do table.insert(target_available_dialogs,entry[1]) end

	if #target_available_dialogs > 1 then
		return true
	else
		return false
	end
end
