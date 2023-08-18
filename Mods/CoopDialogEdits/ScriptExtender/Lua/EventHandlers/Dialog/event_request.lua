Ext.Require("Calls/CharacterOperations/reassign.lua")
Ext.Require("Calls/CharacterOperations/detach.lua")

Ext.Require("Calls/Randomizer/rollmethods.lua")
Ext.Require("Calls/Randomizer/getwinner.lua")

Ext.Require("Calls/Dialog/manual_dialog.lua")

Ext.Require("Queries/Dialog/check_target.lua")

Ext.Require("Utils/custom_std.lua")

--## Osiris event handlers
function dialog_requested(character_target,character_source)
	--Populate a table with only currently controlled (active) characters in party and another with all characters in party
	for _,entry in pairs(Osi.DB_Players:Get(nil)) do
		table.insert(db_party_all, entry[1])
		if IsControlled(entry[1]) == 1 then
			table.insert(db_party_players, entry[1])
			db_userids[GetReservedUserID(entry[1])] = entry[1]
		end
	end

	for _,entry in pairs(Osi.DB_PartOfTheTeam:Get(nil)) do
		table.insert(db_camp_characters, entry[1])
	end

	--Store dialog starter character UserID
	userid_dlg_owner = GetReservedUserID(character_source)
	character_dlg_owner = character_source

	--Store dialog target character UserID
	userid_dlg_targetowner = GetReservedUserID(character_target)
	character_dlg_target = character_target

	--Check if workaround needed for target character in case they're a follower currently in party
    if userid_dlg_targetowner ~= userid_dlg_owner and not has_value(db_party_players,character_dlg_target) and has_value(db_party_all,character_dlg_target) then
        --Temporarily re-assign party follower to dialog requester to facilitate dialog
		--BUG: Needs to be userid, not character:

		userid_follower_attached = userid_dlg_targetowner
        character_follower_attached = db_userids[userid_dlg_targetowner]

        reassign_follower(userid_dlg_owner,userid_dlg_targetowner,character_dlg_target)
		was_follower_reassigned = 1
    end
	--Check if any passives are toggled for dialog ownership rolling and if so, roll the owner

	if check_reassignment_requested(character_dlg_target) then
		--Check if dialog target isn't a vendor or otherwise special (maybe companions?), as that would be annoying
		if not check_if_target_is_vendor(character_dlg_target) and not check_if_target_is_special(character_dlg_target) then
			character_dlg_new = determine_dialog_winner(db_party_players,character_source)

			--If dialog roll winner is not the character who started the dialog, detach dialog starter and re-initiate dialog for the winner
			if character_dlg_new ~= character_dlg_owner then
				detach_character(userid_dlg_owner,character_dlg_owner)
				manual_restart_dialog(character_dlg_new,character_dlg_target)
			end

		--TODO if check_if_target_is_special() returns true, dialog with target will become impossible. Fix it below.
		elseif not check_if_target_is_vendor(character_target) and check_if_target_is_special(character_target) then
			--TODO target is special. Move logic here.
			Ext.Utils.PrintWarning("Unimplemented!")
			print("Unimplemented!")
			OpenMessageBox(character_source, "DEBUG: This dialog is determined to be special, but handling is not implemented. Proceding without rolls.")
        else
            print("Target appears to be a vendor (dafuq??)")
		end
	end
	return
end

Ext.Utils.PrintWarning("Dialog request handler initialized.")