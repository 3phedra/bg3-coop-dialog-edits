Ext.Require("Utils/custom_std.lua")
function roll_for_dialog(characters)
  local winner
  --TODO Add more methods
  for character in elementIterator(characters) do
    db_dialog_methods["RollResults"][character] = Random(20) + 1 + db_dialog_methods[character]["Modifier"] +
    db_dialog_persist[character]["FairnessMod"]
  end
  local sorted_rolls = getKeysSortedByValue(db_dialog_methods["RollResults"], function(a, b) return a < b end)
  --Sort competitor table lowest to highest roll and pick the last entry as winner
  winner = sorted_rolls[#sorted_rolls]
  return winner
end
