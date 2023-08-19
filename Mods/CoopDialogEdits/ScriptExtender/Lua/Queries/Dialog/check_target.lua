function check_if_target_is_vendor(character_target)
  local event_name = "check_if_target_is_vendor"
  local event_state = "return"
  local event_operation = "unimplemented"
  local event_args = nil
  local event_data = false

  print_log(event_name, event_state, event_operation, event_args, event_data)
	--TODO find a query that shows if target is vendor
	--If all else fails, populate a new DB with RequestTrade event targets so that only the first dialog locks the whole party
	return false
end

function check_if_target_is_special(character_target)
	--TODO find queries that determine whether target shouldn't be re-assignable outside of being vendors
	--TODO if target has more than one dialog, check if these target a particular party member
	local target_available_dialogs = {}

	for _,entry in pairs(Osi.DB_Dialogs:Get(character_target,nil,nil)) do table.insert(target_available_dialogs,entry[1]) end

  local event_name = "check_if_target_is_special"
  local event_state = "query_db"
  local event_operation = "Osi.DB_Dialogs:Get"
  local event_args = character_target .. ", " .. "nil" .. ", " .. "nil"
  local event_data = dump_table(target_available_dialogs)

  print_log(event_name, event_state, event_operation, event_args, event_data)

  event_name = "check_if_target_is_special"
  event_state = "check_available_dialogs"
  event_operation = "is > 1"
  event_args = "#target_available_dialogs"
  event_data = #target_available_dialogs

  print_log(event_name, event_state, event_operation, event_args, event_data)

	if #target_available_dialogs > 1 then
		return true
	else
		return false
	end
end
