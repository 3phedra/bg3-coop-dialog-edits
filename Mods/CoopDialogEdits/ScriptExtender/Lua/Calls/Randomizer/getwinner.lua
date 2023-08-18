Ext.Require("Calls/Randomizer/roll.lua")

local function fairness_handler(characters,character_dlg_roll_winner)

	--Initialize table entry for character if it hasn't been done yet
  if db_count_dlg_roll_winner[character_dlg_roll_winner] == nil then
    db_count_dlg_roll_winner[character_dlg_roll_winner] = 0
  end

	--Increment win count for character and reset fairness mod
  db_count_dlg_roll_winner[character_dlg_roll_winner] = db_count_dlg_roll_winner[character_dlg_roll_winner] + 1
	db_mod_dlg_roll_fairness[character_dlg_roll_winner] = 0

	--Increase odds for players that miss out on multiple dialogs
  for character in elementIterator(characters) do
    if character ~= character_dlg_roll_winner then
      db_mod_dlg_roll_fairness[character] = db_mod_dlg_roll_fairness[character] + 2
    end
  end

return
end

function determine_dialog_winner(characters,character_owner)
	--Fallback dialog ownership determination method is that dialog starter owns the dialog
	local method = "vanilla"
	local ask = false
	local character_dlg_roll_winner = character_owner

	--TODO make toggles host exclusive
	if HasActiveStatus(GetHostCharacter(), "DialogMethodRandom") then
		method = "random"
	elseif HasActiveStatus(GetHostCharacter(), "DialogMethodVanilla") then
		method = "vanilla"
	elseif HasActiveStatus(GetHostCharacter(), "DialogMethodInitiative") then
		method = "initiative"
	elseif HasActiveStatus(GetHostCharacter(), "DialogMethodCharisma") then
		method = "charisma"
	end

	--Check if opt-in preference is set and opt-in table containts any characters at all
	if HasActiveStatus(GetHostCharacter(), "DialogPreferenceOptIn") == 1 and db_characters_want_dialog[1] ~= nil then
		ask = true
		characters = db_characters_want_dialog
	end

	--Get dialog ownership winner
	--TODO I really cant think today. Make this less of a mess.
	if method ~= "vanilla" then
	    if #db_characters_want_dialog > 1 then
            character_dlg_roll_winner = roll_for_dialog(method,characters)
        elseif ask then
            character_dlg_roll_winner = characters[1]
            return character_dlg_roll_winner
        else
            character_dlg_roll_winner = roll_for_dialog(method,characters)
        end
    else
        character_dlg_roll_winner = character_owner
        return character_dlg_roll_winner
    end

	fairness_handler(characters, character_dlg_roll_winner)

	return character_dlg_roll_winner
end
