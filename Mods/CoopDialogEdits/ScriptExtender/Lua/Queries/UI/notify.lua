function notify_roll_result()
  --Notify players of roll winner and their own result
  Ext.Utils.PrintError("Not implemented")
  for character in elementIterator(db_party_struct["PlayerCharacters"]) do
    for roller, roll_result in spairs(db_dialog_competitors, function(t, a, b) return t[b] > t[a] end) do
      roll_winner = roller
      win_roll = roll_result
      if roller == character then
        own_roll = roll_result
      end
    end
    --String building is expensive... maybe dont do this if performance ever gets critical
    --msg = ("Dialog leader: " .. roll_winner .. " rolled " .. win_roll .. ". You rolled " .. own_roll .. ".")
    --Notifications dont show during dialogs :( Probably custom UI needed
    --ShowNotification(character, msg)
    --Maybe ShowError(CHARACTER, STRING) ?
  end
  print("Roll won by " .. roll_winner .. " with " .. win_roll)
end
function notify_out_of_range(character)
  ShowNotification(character, "A dialog started out of listening range for party members.")
end
