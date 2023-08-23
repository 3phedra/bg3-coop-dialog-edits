Ext.Require("Calls/Randomizer/roll.lua")
local function fairness_handler(winner)
  --Increment win count for character and reset fairness mod
  db_dialog_methods[winner]["WinCount"] = db_dialog_methods[winner]["WinCount"] + 1
  db_dialog_methods[winner]["FairnessMod"] = 0
  --Increase odds for players that miss out on multiple dialogs
  for character in elementIterator(db_party_struct["ActiveParty"]) do
    if character ~= winner then
      db_dialog_methods[character]["FairnessMod"] = db_dialog_methods[character]["FairnessMod"] + 2
    end
  end
  return
end
function determine_dialog_winner(target)
  local winner
  local competitors = db_party_struct["ActiveParty"]
  local competitors_want = db_dialog_methods["CharactersWantDialog"]
  table.remove(competitors, tablefind(competitors, target))
  table.remove(competitors_want, tablefind(competitors_want, target))
  --Get dialog ownership winner
  if db_dialog_methods["Method"] ~= "vanilla" then
    if db_dialog_methods["RequestOptIn"] and #competitors_want > 1 then
      winner = roll_for_dialog(competitors_want)
      fairness_handler(winner)
    elseif db_dialog_methods["RequestOptIn"] and #competitors_want == 1 then
      winner = competitors_want[1]
    else
      winner = roll_for_dialog(competitors)
      fairness_handler(winner)
    end
  else
    winner = db_party_struct["DialogOwner"]
  end
  return winner
end
