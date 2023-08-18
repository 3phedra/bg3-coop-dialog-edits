Ext.Require("Queries/Dialog/fetch_dialogs.lua")

function manual_restart_dialog(character_source,character_target)
	--Small hack to manually initiate a new dialog from Osiris

	local dialog_listener = {}
	local nulluser = "NULL_00000000-0000-0000-0000-000000000000"
	local chosen_dialog
	local chosen_owner

	--TODO change this to match chosen_dialog
	chosen_owner = character_source

	chosen_dialog = determine_dialog_with_target(character_source,character_target)

	table.insert(dialog_listener,chosen_owner)

	--TODO Make this more elegant lol
	if db_party_all[1] ~= nil and db_party_all[1] ~= chosen_owner and db_party_all[1] ~= character_target then
		table.insert(dialog_listener,db_party_all[1])
	else
		table.insert(dialog_listener,nulluser)
	end
	if db_party_all[2] ~= nil and db_party_all[2] ~= chosen_owner and db_party_all[2] ~= character_target then
		table.insert(dialog_listener,db_party_all[2])
	else
		table.insert(dialog_listener,nulluser)
	end
	if db_party_all[3] ~= nil and db_party_all[3] ~= chosen_owner and db_party_all[3] ~= character_target then
		table.insert(dialog_listener,db_party_all[3])
	else
		table.insert(dialog_listener,nulluser)
	end
	if db_party_all[4] ~= nil and db_party_all[4] ~= chosen_owner and db_party_all[4] ~= character_target then
		table.insert(dialog_listener,db_party_all[4])
	else
		table.insert(dialog_listener,nulluser)
	end
	if db_party_all[5] ~= nil and db_party_all[5] ~= chosen_owner and db_party_all[5] ~= character_target then
		table.insert(dialog_listener,db_party_all[5])
	else
		table.insert(dialog_listener,nulluser)
	end
	--Initiate determined dialog with dialog target and new dialog owner in speaker slot 1, add party in other slots and fill remaining slots with a null user
	--TODO 1 and 23232 should be OUT values, not inputs, check if it matters at all
	--Will still trigger dialog_started event function, but the function shouldn't have to do anything further.
	StartDialog_Internal(chosen_dialog, 0, character_target, dialog_listener[1], dialog_listener[2], dialog_listener[3], dialog_listener[4], dialog_listener[5], 23232)
	--

	return
end
