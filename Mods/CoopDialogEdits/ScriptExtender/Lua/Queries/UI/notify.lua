function notify_roll_result()
  --Notify players of roll winner and their own result
  local function_name = "determine_dialog_with_target"
  local function_operation = "called"
  local function_args = nil
  local function_data = nil

  print_log(function_name, function_operation, function_args, function_data)

  Ext.Utils.PrintError("Not implemented")

  for character in elementIterator(db_party_players) do
    for roller, roll_result in spairs(db_dialog_competitors, function(t, a, b) return t[b] > t[a] end) do
      roll_winner = roller
      win_roll = roll_result
      if roller == character then
        own_roll = roll_result
      end
    end
    --String building is expensive... maybe dont do this if performance ever gets critical
    --msg = ("Dialog leader: " .. roll_winner .. " rolled " .. win_roll .. ". You rolled " .. own_roll .. ".")
    --ShowNotification(character, msg)
  end
  print("Roll won by " .. roll_winner .. " with " .. win_roll)
end
