Ext.Require("Calls/Randomizer/roll.lua")
local function fairness_handler(winner)
  --Increment win count for character and reset fairness mod
  db_dialog_persist[winner]["WinCount"] = db_dialog_persist[winner]["WinCount"] + 1
  db_dialog_persist[winner]["FairnessMod"] = 0
  --Increase odds for players that miss out on multiple dialogs
  for character in elementIterator(db_party_struct["ActiveParty"]) do
    if character ~= winner then
      db_dialog_persist[character]["FairnessMod"] = db_dialog_persist[character]["FairnessMod"] + 2
    end
  end
  return
end
function determine_dialog_winner(target)
  local winner
  local competitors = deepcopy(db_party_struct["ActivePlayers"])
  local competitors_want = deepcopy(db_dialog_methods["CharactersWantDialog"])
  --Ensure target isn't part of roll in case it's a party follower
  if has_value(competitors, target) then
    table.remove(competitors, tablefind(competitors, target))
  end
  if has_value(competitors_want, target) then
    table.remove(competitors_want, tablefind(competitors_want, target))
  end
  if db_dialog_methods["DistancePreference"] then
    for character in elementIterator(competitors) do
      if db_party_struct[character]["Distance"] > 35.0 then
        if has_value(competitors_want, character) then
          table.remove(competitors, tablefind(competitors, character))
        end
        if has_value(competitors_want, character) then
          table.remove(competitors_want, tablefind(competitors_want, character))
        end
      end
    end
  end
  --Get dialog ownership winner
  if db_dialog_methods["RequestOptIn"] and #competitors_want > 1 then
    winner = roll_for_dialog(competitors_want)
    fairness_handler(winner)
  elseif db_dialog_methods["RequestOptIn"] and #competitors_want == 1 then
    winner = competitors_want[1]
  else
    winner = roll_for_dialog(competitors)
    fairness_handler(winner)
  end
  return winner
end
