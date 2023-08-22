Ext.Require("Utils/custom_std.lua")
function roll_for_dialog(method, characters)
  local roll_winner
  local db_dialog_competitors = {}
  --TODO Add more methods
  if method == "random" then
    --Add all dialog competitors and their respective random roll to a table
    for character in elementIterator(characters) do
      --db_dialog_competitors.insert(Random(20) + 1,character)
      --TODO check how to utilize RequestPassiveRoll or RequestPassiveRollVersusSkill
      db_dialog_competitors[character] = Random(20) + 1 + db_dialog_methods[character]["FairnessMod"]
    end
  elseif method == "charisma" or method == "initiative" then
    for character in elementIterator(characters) do
      db_dialog_competitors[character] = Random(20) + 1 + db_dialog_methods[character]["Modifier"] +
      db_dialog_methods[character]["FairnessMod"]
    end
  end
  --Sort competitor table lowest to highest roll and pick the last entry as winner
  for character, roll_result in spairs(db_dialog_competitors, function(t, a, b) return t[b] > t[a] end) do
    roll_winner = character
  end
  return roll_winner
end
