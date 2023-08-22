Ext.Require("Calls/Randomizer/roll.lua")
local function fairness_handler(characters, character_winner)
  --Increment win count for character and reset fairness mod
  db_dialog_methods[character_winner]["WinCount"] = db_dialog_methods[character_winner]["WinCount"] + 1
  db_dialog_methods[character_winner]["FairnessMod"] = 0
  --Increase odds for players that miss out on multiple dialogs
  for character in elementIterator(characters) do
    if character ~= character_winner then
      db_dialog_methods[character]["FairnessMod"] = db_dialog_methods[character]["FairnessMod"] + 2
    end
  end
  return
end
function determine_dialog_winner(characters, character_owner)
  populate_preference_table(characters)
  local character_dlg_roll_winner = character_owner
  --Get dialog ownership winner
  if db_dialog_methods["Method"] ~= "vanilla" then
    if db_dialog_methods["RequestOptIn"] and #db_dialog_methods["CharactersWantDialog"] > 1 then
      character_dlg_roll_winner = roll_for_dialog(db_dialog_methods["CharactersWantDialog"])
    elseif db_dialog_methods["RequestOptIn"] and #db_dialog_methods["CharactersWantDialog"] == 1 then
      character_dlg_roll_winner = db_dialog_methods["CharactersWantDialog"][1]
    else
      character_dlg_roll_winner = roll_for_dialog(characters)
    end
  else
    character_dlg_roll_winner = characters[1]
    return character_dlg_roll_winner
  end
  fairness_handler(characters, character_dlg_roll_winner)
  return character_dlg_roll_winner
end
