Ext.Require("Queries/Dialog/check_target.lua")

function determine_dialog_with_target(character_source,character_target)
	local target_available_dialogs = {}

	local chosen_dialog

	--Query all available dialogs with target character and add to table
	--TODO Take dialog owner into consideration

	for _,entry in pairs(Osi.DB_Dialogs:Get(character_target,nil)) do table.insert(target_available_dialogs,entry[2]) end


  local event_name = "determine_dialog_with_target"
  local event_state = "check_available_dialogs"
  local event_operation = "Osi.DB_Dialogs:Get"
  local event_args = character_target .. ", " .. "nil"
  local event_data = dump_table(target_available_dialogs)

  print_log(event_name, event_state, event_operation, event_args, event_data)

	--TODO Figure out how to pick the correct dialog. Picking the last in list for now
	if not check_if_target_is_special(character_target) then
		chosen_dialog = target_available_dialogs[#target_available_dialogs]
	else
		--TODO this is a major todo!
		--If target has more than 1 dialog option, prompt dialog starter to pass dialog leadership to the correct character
		Ext.Utils.PrintWarning("Target has more than 1 possible Dialog options:")
		--DB_Dialogs has a minimum of 2 and a maximum of 5 args, look into it

		for _,entry in pairs(Osi.DB_Dialogs:Get(character_target,nil)) do print(entry[1], entry[2], entry[3]) end

    event_state = "check_multiple"
    event_operation = "Osi.DB_Dialogs:Get"
    event_args = character_target .. ", " .. nil
    event_data = "unimplemented"
  
    print_log(event_name, event_state, event_operation, event_args, event_data)

		--TODO Ensure this prompt doesn't pop up all the bloody time on unresolved special dialog options
		--msg = GetDisplayName(character_target), " would like to speak to someone else. Do you want to pass the dialog on?"
		--OpenMessageBoxYesNo(character_source, msg)

		--TODO break here and let messagebox event handle the rest. Placehoders for now:
		chosen_dialog = target_available_dialogs[#target_available_dialogs]
	end

	return chosen_dialog
end
