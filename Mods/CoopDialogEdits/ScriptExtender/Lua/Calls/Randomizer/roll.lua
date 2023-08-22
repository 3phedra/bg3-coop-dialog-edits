Ext.Require("Utils/custom_std.lua")
function roll_for_dialog(characters)
  local roll_winner
  --TODO Add more methods
  for character in elementIterator(characters) do
    db_dialog_methods["RollResults"][character] = Random(20) + 1 + db_dialog_methods[character]["Modifier"] +
    db_dialog_methods[character]["FairnessMod"]
  end
  --Sort competitor table lowest to highest roll and pick the last entry as winner
  for character, roll_result in spairs(db_dialog_methods["RollResults"], function(t, a, b) return t[b] > t[a] end) do
    roll_winner = character
  end
  return roll_winner
end
