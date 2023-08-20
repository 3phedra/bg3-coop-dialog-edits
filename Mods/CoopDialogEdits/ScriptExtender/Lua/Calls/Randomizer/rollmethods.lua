function check_reassignment_requested(character_target, character_source)
  local function_name = "check_reassignment_requested"
  local function_operation = "called"
  local function_args = "characters, character_source"
  local function_data = character_target .. "," .. character_source

  print_log(function_name, function_operation, function_args, function_data)

  --Check if reassignment is needed at all
  --TODO Add more methods

  function_operation = "compare"
  function_args = "HasActiveStatus(GetHostCharacter(), 'DialogMethodVanilla') == 1"
  function_data = GetHostCharacter() .. "," .. "DialogMethodVanilla"
  function_result = HasActiveStatus(GetHostCharacter(), "DialogMethodVanilla") == 1

  print_log(function_name, function_operation, function_args, function_data, function_result)

  if HasActiveStatus(GetHostCharacter(), "DialogMethodVanilla") == 1 then
    function_operation = "return"
    function_args = nil
    function_data = false

    print_log(function_name, function_operation, function_args, function_data)

    return false
  end

  function_operation = "compare"
  function_args = "is_region_camp == 1"
  function_data = is_region_camp
  function_result = is_region_camp == 1

  print_log(function_name, function_operation, function_args, function_data, function_result)

  if is_region_camp == 1 then
    function_operation = "return"
    function_args = nil
    function_data = false

    print_log(function_name, function_operation, function_args, function_data)
    return false
  end

  function_operation = "compare"
  function_args = "has_value(db_camp_characters, character_target)"
  function_data = dump_table(db_camp_characters) .. "," .. character_target
  function_result = has_value(db_camp_characters, character_target)

  print_log(function_name, function_operation, function_args, function_data, function_result)

  if has_value(db_camp_characters, character_target) then
    function_operation = "compare"
    function_args = "HasActiveStatus(GetHostCharacter(), 'DialogPreferenceFollowers') == 0"
    function_data = GetHostCharacter() .. "," .. "DialogPreferenceFollowers"
    function_result = HasActiveStatus(GetHostCharacter(), "DialogPreferenceFollowers") == 0

    print_log(function_name, function_operation, function_args, function_data, function_result)

    if HasActiveStatus(GetHostCharacter(), "DialogPreferenceFollowers") == 0 then
      function_operation = "return"
      function_args = nil
      function_data = false

      print_log(function_name, function_operation, function_args, function_data)

      return false
    end
  end

  function_operation = "compare"
  function_args = "HasActiveStatus(GetHostCharacter(), 'DialogPreferenceOptIn') == 1"
  function_data = GetHostCharacter() .. "," .. "DialogPreferenceOptIn"
  function_result = HasActiveStatus(GetHostCharacter(), "DialogPreferenceOptIn") == 1

  print_log(function_name, function_operation, function_args, function_data, function_result)

  if HasActiveStatus(GetHostCharacter(), "DialogPreferenceOptIn") == 1 then
    function_operation = "iterate"
    function_args = "db_party_players"
    function_data = dump_table(db_party_players)

    print_log(function_name, function_operation, function_args, function_data)

    for playercharacter in elementIterator(db_party_players) do
      function_operation = "compare"
      function_args = "HasActiveStatus(playercharacter, 'DialogListenerOptIn') == 1"
      function_data = playercharacter .. "," .. "DialogListenerOptIn"
      function_result = HasActiveStatus(GetHostCharacter(), "DialogListenerOptIn") == 1

      print_log(function_name, function_operation, function_args, function_data, function_result)

      if HasActiveStatus(playercharacter, "DialogListenerOptIn") == 1 then
        table.insert(db_characters_want_dialog, playercharacter)

        function_operation = "assign"
        function_args = "db_characters_want_dialog"
        function_data = playercharacter

        print_log(function_name, function_operation, function_args, function_data)
      end
    end

    function_operation = "compare"
    function_args = "db_characters_want_dialog[1] == nil"
    function_data = db_characters_want_dialog[1]
    function_result = db_characters_want_dialog[1] == nil

    print_log(function_name, function_operation, function_args, function_data, function_result)

    if db_characters_want_dialog[1] == nil then
      db_characters_want_dialog[1] = character_source

      function_operation = "assign"
      function_args = "db_characters_want_dialog[1]"
      function_data = db_characters_want_dialog[1]

      print_log(function_name, function_operation, function_args, function_data)
    end
  end

  function_operation = "compare"
  function_args =
  "HasActiveStatus(GetHostCharacter(), 'DialogMethodRandom') == 1 or HasActiveStatus(GetHostCharacter(), 'DialogMethodCharisma') == 1 or HasActiveStatus(GetHostCharacter(), 'DialogMethodInitiative') == 1 or db_characters_want_dialog[1] ~= nil"
  function_data = GetHostCharacter() ..
  "," ..
  "DialogMethodRandom" ..
  "," .. "DialogMethodCharisma" .. "," .. "DialogMethodInitiative" .. "," .. tostring(db_characters_want_dialog[1])
  function_result = HasActiveStatus(GetHostCharacter(), "DialogMethodRandom") == 1 or
  HasActiveStatus(GetHostCharacter(), "DialogMethodCharisma") == 1 or
  HasActiveStatus(GetHostCharacter(), "DialogMethodInitiative") == 1 or db_characters_want_dialog[1] ~= nil

  print_log(function_name, function_operation, function_args, function_data, function_result)

  if HasActiveStatus(GetHostCharacter(), "DialogMethodRandom") == 1 or HasActiveStatus(GetHostCharacter(), "DialogMethodCharisma") == 1 or HasActiveStatus(GetHostCharacter(), "DialogMethodInitiative") == 1 or db_characters_want_dialog[1] ~= nil then
    reassignment_requested = true

    function_operation = "assign"
    function_args = "reassignment_requested"
    function_data = true

    print_log(function_name, function_operation, function_args, function_data)
  else
    reassignment_requested = false

    function_operation = "assign"
    function_args = "reassignment_requested"
    function_data = false

    print_log(function_name, function_operation, function_args, function_data)
  end

  print_log(event_name, event_state, event_operation, event_args, event_data)

  function_operation = "return"
  function_args = "reassignment_requested"
  function_data = reassignment_requested

  print_log(function_name, function_operation, function_args, function_data)

  return reassignment_requested
end
