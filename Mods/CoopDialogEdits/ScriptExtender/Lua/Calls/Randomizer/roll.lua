Ext.Require("Utils/custom_std.lua")

function roll_for_dialog(method, characters)
  local roll_winner

  local event_name = "roll_for_dialog"
  local event_state = "run"
  local event_operation = ""
  local event_args = nil
  local event_data = nil

  print_log(event_name, event_state, event_operation, event_args, event_data)

  --TODO Add more methods
  if method == "random" then
    --Add all dialog competitors and their respective random roll to a table
    for character in elementIterator(characters) do
      if db_mod_dlg_roll_fairness[character] == nil then
        db_mod_dlg_roll_fairness[character] = 0
      end
      --db_dialog_competitors.insert(Random(20) + 1,character)
      --TODO check how to utilize RequestPassiveRoll or RequestPassiveRollVersusSkill
      db_dialog_competitors[character] = Random(20) + 1 + db_mod_dlg_roll_fairness[character]
      
      event_state = "roll_method_random"
      event_operation = "iterate: " .. character .. " Random"
      event_args = 20 .. " + 1 + " .. db_mod_dlg_roll_fairness[character]
      event_data = db_dialog_competitors[character]
    
      print_log(event_name, event_state, event_operation, event_args, event_data)
    end
  elseif method == "charisma" then
    for character in elementIterator(characters) do
      event_state = "roll_method_charisma"
      event_operation = "GetAbility"
      event_args = character .. ", " .. " Charisma"
      event_data = GetAbility(character, "Charisma")
    
      print_log(event_name, event_state, event_operation, event_args, event_data)

      local modifier = GetAbility(character, "Charisma")
      modifier = (-10 + modifier) / 2
      db_dialog_competitors[character] = Random(20) + 1 + modifier + db_mod_dlg_roll_fairness[character]

      event_state = "roll_method_charisma"
      event_operation = "iterate: " .. character .. " Random"
      event_args = 20 .. " + 1 + " .. modifier .. " + " .. db_mod_dlg_roll_fairness[character]
      event_data = db_dialog_competitors[character]
    
      print_log(event_name, event_state, event_operation, event_args, event_data)
    end
  elseif method == "initiative" then
    for character in elementIterator(characters) do
      event_state = "roll_method_initiative"
      event_operation = "GetAbility"
      event_args = character .. ", " .. " Initiative"
      event_data = GetAbility(character, "Initiative")
    
      print_log(event_name, event_state, event_operation, event_args, event_data)

      local modifier = GetAbility(character, "Initiative")
      modifier = (-10 + modifier) / 2
      db_dialog_competitors[character] = Random(20) + 1 + modifier + db_mod_dlg_roll_fairness[character]

      event_state = "roll_method_initiative"
      event_operation = "iterate: " .. character .. " Random"
      event_args = 20 .. " + 1 + " .. modifier .. " + " .. db_mod_dlg_roll_fairness[character]
      event_data = db_dialog_competitors[character]
    
      print_log(event_name, event_state, event_operation, event_args, event_data)
    end
  elseif method == "vanilla" then
    print("Why was this code reached???")
  end

  --Sort competitor table lowest to highest roll and pick the last entry as winner
  for character, roll_result in spairs(db_dialog_competitors, function(t, a, b) return t[b] > t[a] end) do
    roll_winner = character
  end

  event_state = "sort_for_winner"
  event_operation = "spairs"
  event_args = "db_dialog_competitors, function(t, a, b) return t[b] > t[a]"
  event_data = roll_winner

  print_log(event_name, event_state, event_operation, event_args, event_data)

  event_state = "finished"
  event_operation = "return"
  event_args = "return"
  event_data = roll_winner

  print_log(event_name, event_state, event_operation, event_args, event_data)

  return roll_winner
end
