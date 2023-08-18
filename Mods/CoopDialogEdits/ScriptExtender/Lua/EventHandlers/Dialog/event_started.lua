Ext.Require("Queries/UI/notify.lua")

function dialog_started(dialog_UUID, dialog_ID)
	if IsSpellActive(GetHostCharacter(), "DialogPreferenceDisable") == 1 then
		return
	end

	local character_distance_to_dialog
	--Get character that triggered dialog event

    --Filter out dialogs that do not involve the party
    if DialogGetInvolvedPlayer(dialog_ID,1) ~= nil then
        local dialog_owner = DialogGetInvolvedPlayer(dialog_ID,1)

        --if not check_if_target_is_vendor(dialog_target) and not check_if_target_is_special(dialog_target) then
            --Add all party characters to triggered dialog
        for character in elementIterator(db_party_all) do
            --Check if character about to be added to dialog isn't in another dialog
            if select(2,SpeakerGetDialog(character, 1)) == nil then
                character_distance_to_dialog = GetDistanceTo(dialog_owner, character)
                DialogAddActor(dialog_ID, character)
                --Osi.PROC_DialogAddSpeakingActor(dialog_ID, character)
            end
        end

        --TODO check if dialog was with a follower, if so do not notify
        if is_automated_dialog == 1 then
            notify_roll_result()
        end
    end

	return
end

function automated_dialog_started(dialog_UUID, dialog_ID)
    --TODO implement this
    if DialogGetInvolvedPlayer(dialog_ID,1) ~= nil then
        is_automated_dialog = 1
        print("Dialog is an automated dialog.")

        --dialog_requested event is skipped in automated dialogs, but we need a party db
        for _,entry in pairs(Osi.DB_Players:Get(nil)) do
            table.insert(db_party_all, entry[1])
            if IsControlled(entry[1]) == 1 then
                table.insert(db_party_players, entry[1])
                db_userids[GetReservedUserID(entry[1])] = entry[1]
            end
        end

        dialog_started(dialog_UUID, dialog_ID)
    end
end

Ext.Utils.PrintWarning("Dialog start handler initialized.")
