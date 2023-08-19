Ext.Require("Calls/Randomizer/roll.lua")

local function fairness_handler(characters, character_dlg_roll_winner)

  local event_name = "fairness_handler"

  

  --Initialize table entry for character if it hasn't been done yet
  if db_count_dlg_roll_winner[character_dlg_roll_winner] == nil then
    db_count_dlg_roll_winner[character_dlg_roll_winner] = 0
  end

  local event_state = "increment_db"
  local event_operation = "db_count_dlg_roll_winner[character_dlg_roll_winner] + 1"
  local event_args = character_dlg_roll_winner
  local event_data = db_count_dlg_roll_winner[character_dlg_roll_winner]

  print_log(event_name, event_state, event_operation, event_args, event_data)

  --Increment win count for character and reset fairness mod
  db_count_dlg_roll_winner[character_dlg_roll_winner] = db_count_dlg_roll_winner[character_dlg_roll_winner] + 1
  db_mod_dlg_roll_fairness[character_dlg_roll_winner] = 0

  --Increase odds for players that miss out on multiple dialogs
  for character in elementIterator(characters) do
    if character ~= character_dlg_roll_winner then
      db_mod_dlg_roll_fairness[character] = db_mod_dlg_roll_fairness[character] + 2
    end

    local event_state = "increment_db"
    local event_operation = "db_mod_dlg_roll_fairness[character] + 2"
    local event_args = character
    local event_data = db_mod_dlg_roll_fairness[character]
  
    print_log(event_name, event_state, event_operation, event_args, event_data)
  end

  return
end

function determine_dialog_winner(characters, character_owner)
  --Fallback dialog ownership determination method is that dialog starter owns the dialog
  local method = "vanilla"
  local ask = false
  local character_dlg_roll_winner = character_owner

  local event_name = "determine_dialog_winner"

  local event_state = "check"
  local event_operation = "HasActiveStatus"
  local event_args = GetHostCharacter() .. ", " .. "DialogMethodRandom"
  local event_data = HasActiveStatus(GetHostCharacter(), "DialogMethodRandom")

  print_log(event_name, event_state, event_operation, event_args, event_data)

  event_state = "check"
  event_operation = "HasActiveStatus"
  event_args = GetHostCharacter() .. ", " .. "DialogMethodVanilla"
  event_data = HasActiveStatus(GetHostCharacter(), "DialogMethodVanilla")

  print_log(event_name, event_state, event_operation, event_args, event_data)

  event_state = "check"
  event_operation = "HasActiveStatus"
  event_args = GetHostCharacter() .. ", " .. "DialogMethodInitiative"
  event_data = HasActiveStatus(GetHostCharacter(), "DialogMethodInitiative")

  print_log(event_name, event_state, event_operation, event_args, event_data)

  event_state = "check"
  event_operation = "HasActiveStatus"
  event_args = GetHostCharacter() .. ", " .. "DialogMethodCharisma"
  event_data = HasActiveStatus(GetHostCharacter(), "DialogMethodCharisma")

  print_log(event_name, event_state, event_operation, event_args, event_data)

  --TODO make toggles host exclusive
  if HasActiveStatus(GetHostCharacter(), "DialogMethodRandom") then
    method = "random"
  elseif HasActiveStatus(GetHostCharacter(), "DialogMethodVanilla") then
    method = "vanilla"
  elseif HasActiveStatus(GetHostCharacter(), "DialogMethodInitiative") then
    method = "initiative"
  elseif HasActiveStatus(GetHostCharacter(), "DialogMethodCharisma") then
    method = "charisma"
  end

  event_state = "check"
  event_operation = "HasActiveStatus"
  event_args = GetHostCharacter() .. ", " .. "DialogPreferenceOptIn"
  event_data = HasActiveStatus(GetHostCharacter(), "DialogPreferenceOptIn")

  print_log(event_name, event_state, event_operation, event_args, event_data)

  event_state = "check"
  event_operation = "is nil"
  event_args = "db_characters_want_dialog[1]"
  event_data = db_characters_want_dialog[1]

  print_log(event_name, event_state, event_operation, event_args, event_data)

  --Check if opt-in preference is set and opt-in table containts any characters at all
  if HasActiveStatus(GetHostCharacter(), "DialogPreferenceOptIn") == 1 and db_characters_want_dialog[1] ~= nil then
    ask = true
    characters = db_characters_want_dialog
  end

  --Get dialog ownership winner
  --TODO I really cant think today. Make this less of a mess.
  if method ~= "vanilla" then
    if #db_characters_want_dialog > 1 then

      event_state = "roll"
      event_operation = "roll_for_dialog"
      event_args = method .. ", " .. dump_table_inline(characters)
      event_data = "..."
    
      print_log(event_name, event_state, event_operation, event_args, event_data)

      character_dlg_roll_winner = roll_for_dialog(method, characters)



    elseif ask then

      character_dlg_roll_winner = characters[1]

      event_state = "roll"
      event_operation = "return_single_opted_in"
      event_args = "return"
      event_data = character_dlg_roll_winner
    
      print_log(event_name, event_state, event_operation, event_args, event_data)

      return character_dlg_roll_winner

    else

      event_state = "roll"
      event_operation = "roll_for_dialog"
      event_args = method .. ", " .. dump_table_inline(characters)
      event_data = "..."
    
      print_log(event_name, event_state, event_operation, event_args, event_data)

      character_dlg_roll_winner = roll_for_dialog(method, characters)

    end

  else

    character_dlg_roll_winner = character_owner

    event_state = "roll"
    event_operation = "vanilla_method_return"
    event_args = "return"
    event_data = character_dlg_roll_winner
  
    print_log(event_name, event_state, event_operation, event_args, event_data)

    return character_dlg_roll_winner
  end

  fairness_handler(characters, character_dlg_roll_winner)

  return character_dlg_roll_winner
end
