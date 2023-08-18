Ext.Require("Calls/Randomizer/roll.lua")
local function fairness_handler(character_dlg_roll_winner)

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
	if IsSpellActive(GetHostCharacter(), "DialogMethodRandom") then
		method = "random"
	elseif IsSpellActive(GetHostCharacter(), "DialogMethodVanilla") then
		method = "vanilla"
	elseif IsSpellActive(GetHostCharacter(), "DialogMethodInitiative") then
		method = "initiative"
	elseif IsSpellActive(GetHostCharacter(), "DialogMethodCharisma") then
		method = "charisma"
	end

	--Check if opt-in preference is set and opt-in table containts any characters at all
	if IsSpellActive(GetHostCharacter(), "DialogPreferenceOptIn") == 1 and db_characters_want_dialog[1] ~= nil then
		ask = true
		characters = db_characters_want_dialog
	end

	--Get dialog ownership winner
	if method ~= "vanilla" then
    character_dlg_roll_winner = roll_for_dialog(method,characters)
  else
    character_dlg_roll_winner = character_owner
  end

	fairness_handler(character_dlg_roll_winner)

	return character_dlg_roll_winner
end
