Ext.Require("Calls/Randomizer/roll.lua")

local function fairness_handler(characters, character_dlg_roll_winner)
  local function_name = "fairness_handler"
  local function_operation = "called"
  local function_args = "characters, character_dlg_roll_winner"
  local function_data = dump_table_inline(characters) .. "," .. character_dlg_roll_winner

  print_log(function_name, function_operation, function_args, function_data)

  function_operation = "compare"
  function_args = "db_count_dlg_roll_winner[%s] == nil", character_dlg_roll_winner
  function_data = db_count_dlg_roll_winner[character_dlg_roll_winner]
  function_result = db_count_dlg_roll_winner[character_dlg_roll_winner] == nil

  print_log(function_name, function_operation, function_args, function_data, function_result)

  --Initialize table entry for character if it hasn't been done yet
  if db_count_dlg_roll_winner[character_dlg_roll_winner] == nil then
    db_count_dlg_roll_winner[character_dlg_roll_winner] = 0
  end

  function_operation = "increment"
  function_args = "db_count_dlg_roll_winner[%s] + 1", character_dlg_roll_winner
  function_data = dump_table(db_count_dlg_roll_winner) .. "," .. character_dlg_roll_winner
  function_result = db_count_dlg_roll_winner[character_dlg_roll_winner] + 1

  print_log(function_name, function_operation, function_args, function_data, function_result)

  --Increment win count for character and reset fairness mod
  db_count_dlg_roll_winner[character_dlg_roll_winner] = db_count_dlg_roll_winner[character_dlg_roll_winner] + 1

  function_operation = "reset"
  function_args = "db_mod_dlg_roll_fairness[%s]", character_dlg_roll_winner
  function_data = dump_table(db_mod_dlg_roll_fairness) .. "," .. character_dlg_roll_winner
  function_result = db_mod_dlg_roll_fairness[character_dlg_roll_winner]

  print_log(function_name, function_operation, function_args, function_data, function_result)

  db_mod_dlg_roll_fairness[character_dlg_roll_winner] = 0

  function_operation = "iterate"
  function_args = "characters"
  function_data = dump_table(characters)

  print_log(function_name, function_operation, function_args, function_data)

  --Increase odds for players that miss out on multiple dialogs
  for character in elementIterator(characters) do
    function_operation = "compare"
    function_args = "character ~= character_dlg_roll_winner"
    function_data = character .. "," .. character_dlg_roll_winner
    function_result = character ~= character_dlg_roll_winner

    print_log(function_name, function_operation, function_args, function_data, function_result)
    if character ~= character_dlg_roll_winner then
      function_operation = "increment"
      function_args = "db_mod_dlg_roll_fairness[%s] + 2", character
      function_data = dump_table(db_mod_dlg_roll_fairness) .. "," .. character
      function_result = db_mod_dlg_roll_fairness[character] + 2

      print_log(function_name, function_operation, function_args, function_data, function_result)

      db_mod_dlg_roll_fairness[character] = db_mod_dlg_roll_fairness[character] + 2
    end
  end

  return
end

function determine_dialog_winner(characters, character_owner)
  local function_name = "determine_dialog_winner"
  local function_operation = "called"
  local function_args = "characters, character_owner"
  local function_data = dump_table_inline(characters) .. "," .. character_owner

  print_log(function_name, function_operation, function_args, function_data)

  --Fallback dialog ownership determination method is that dialog starter owns the dialog
  local method = "vanilla"
  local ask = false
  local character_dlg_roll_winner = character_owner

  function_operation = "compare"
  function_args = "HasActiveStatus(GetHostCharacter(), 'DialogMethodRandom')"
  function_data = GetHostCharacter() .. "," .. "DialogMethodRandom"
  function_result = HasActiveStatus(GetHostCharacter(), "DialogMethodRandom")

  print_log(function_name, function_operation, function_args, function_data, function_result)

  function_operation = "compare"
  function_args = "HasActiveStatus(GetHostCharacter(), 'DialogMethodVanilla')"
  function_data = GetHostCharacter() .. "," .. "DialogMethodVanilla"
  function_result = HasActiveStatus(GetHostCharacter(), "DialogMethodVanilla")

  print_log(function_name, function_operation, function_args, function_data, function_result)

  function_operation = "compare"
  function_args = "HasActiveStatus(GetHostCharacter(), 'DialogMethodInitiative')"
  function_data = GetHostCharacter() .. "," .. "DialogMethodInitiative"
  function_result = HasActiveStatus(GetHostCharacter(), "DialogMethodInitiative")

  print_log(function_name, function_operation, function_args, function_data, function_result)

  function_operation = "compare"
  function_args = "HasActiveStatus(GetHostCharacter(), 'DialogMethodCharisma')"
  function_data = GetHostCharacter() .. "," .. "DialogMethodCharisma"
  function_result = HasActiveStatus(GetHostCharacter(), "DialogMethodCharisma")

  print_log(function_name, function_operation, function_args, function_data, function_result)

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

  function_operation = "assign"
  function_args = "method"
  function_data = method

  print_log(function_name, function_operation, function_args, function_data)

  --Check if opt-in preference is set and opt-in table containts any characters at all

  function_operation = "compare"
  function_args =
  "HasActiveStatus(GetHostCharacter(), 'DialogPreferenceOptIn') == 1 and db_characters_want_dialog[1] ~= nil"
  function_data = GetHostCharacter() .. "," .. "DialogPreferenceOptIn" .. "," .. tostring(db_characters_want_dialog[1])
  function_result = HasActiveStatus(GetHostCharacter(), 'DialogPreferenceOptIn') == 1 and
      db_characters_want_dialog[1] ~= nil

  print_log(function_name, function_operation, function_args, function_data, function_result)

  if HasActiveStatus(GetHostCharacter(), "DialogPreferenceOptIn") == 1 and db_characters_want_dialog[1] ~= nil then
    ask = true
    characters = db_characters_want_dialog

    function_operation = "assign"
    function_args = "characters"
    function_data = dump_table(characters)

    print_log(function_name, function_operation, function_args, function_data)
  end

  --Get dialog ownership winner
  --TODO I really cant think today. Make this less of a mess.
  function_operation = "compare"
  function_args = "method ~= 'vanilla'"
  function_data = method
  function_result = method ~= "vanilla"

  print_log(function_name, function_operation, function_args, function_data, function_result)

  if method ~= "vanilla" then
    function_operation = "compare"
    function_args = "#db_characters_want_dialog > 1"
    function_data = dump_table(db_characters_want_dialog)
    function_result = #db_characters_want_dialog > 1

    print_log(function_name, function_operation, function_args, function_dat, function_result)

    function_operation = "compare"
    function_args = "ask"
    function_data = ask

    print_log(function_name, function_operation, function_args, function_data)

    if #db_characters_want_dialog > 1 then
      function_operation = "roll_for_dialog"
      function_args = "method, characters"
      function_data = method .. "," .. dump_table(characters)

      print_log(function_name, function_operation, function_args, function_data)

      character_dlg_roll_winner = roll_for_dialog(method, characters)

      function_operation = "assign"
      function_args = "character_dlg_roll_winner"
      function_data = character_dlg_roll_winner

      print_log(function_name, function_operation, function_args, function_data)
    elseif ask then
      character_dlg_roll_winner = characters[1]

      function_operation = "assign"
      function_args = "character_dlg_roll_winner"
      function_data = character_dlg_roll_winner

      print_log(function_name, function_operation, function_args, function_data)

      function_operation = "return"
      function_args = "character_dlg_roll_winner"
      function_data = character_dlg_roll_winner

      print_log(function_name, function_operation, function_args, function_data)

      return character_dlg_roll_winner
    else
      function_operation = "roll_for_dialog"
      function_args = "method, characters"
      function_data = method .. "," .. dump_table(characters)

      print_log(function_name, function_operation, function_args, function_data)

      character_dlg_roll_winner = roll_for_dialog(method, characters)

      function_operation = "assign"
      function_args = "character_dlg_roll_winner"
      function_data = character_dlg_roll_winner

      print_log(function_name, function_operation, function_args, function_data)
    end
  else
    character_dlg_roll_winner = character_owner

    function_operation = "assign"
    function_args = "character_dlg_roll_winner"
    function_data = character_dlg_roll_winner

    print_log(function_name, function_operation, function_args, function_data)

    function_operation = "return"
    function_args = "character_dlg_roll_winner"
    function_data = character_dlg_roll_winner

    print_log(function_name, function_operation, function_args, function_data)

    return character_dlg_roll_winner
  end

  function_operation = "fairness_handler"
  function_args = "characters, character_dlg_roll_winner"
  function_data = dump_table(characters) .. "," .. character_dlg_roll_winner

  print_log(function_name, function_operation, function_args, function_data)

  fairness_handler(characters, character_dlg_roll_winner)

  function_operation = "return"
  function_args = "character_dlg_roll_winner"
  function_data = character_dlg_roll_winner

  print_log(function_name, function_operation, function_args, function_data)

  return character_dlg_roll_winner
end
