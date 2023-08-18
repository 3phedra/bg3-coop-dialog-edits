Ext.Require("Calls/Randomizer/roll.lua")

function determine_dialog_winner(characters,character_owner)
	--Fallback dialog ownership determination method is that dialog starter owns the dialog
	local method = "owner_owns"

	--TODO Add more methods
	if IsSpellActive(GetHostCharacter(), "COOPDIALOGRANDOM") then
		method = "random_roll"
	end

	print("Dialog leadership roll method is " .. method)
	--Get dialog ownership winner
	if method ~= "owner_owns" then
	    character_dlg_roll_winner = roll_for_dialog(method,characters)
    else
        character_dlg_roll_winner = character_owner
    end

    if db_count_dlg_roll_winner[character_dlg_roll_winner] == nil then
        db_count_dlg_roll_winner[character_dlg_roll_winner] = 0
    end

    db_count_dlg_roll_winner[character_dlg_roll_winner] = db_count_dlg_roll_winner[character_dlg_roll_winner] + 1

    for character in elementIterator(characters) do
        if character ~= character_dlg_roll_winner then
            db_mod_dlg_roll_fairness[character] = db_mod_dlg_roll_fairness[character] + 2
        else
            db_mod_dlg_roll_fairness[character] = 0
        end
    end

	return character_dlg_roll_winner
end
