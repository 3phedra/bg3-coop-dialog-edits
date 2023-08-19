function check_reassignment_requested(character_target, character_source)
  --Check if reassignment is needed at all
  --TODO Add more methods

  local event_name = "check_reassignment_requested"
  local event_state = "check_vanilla"
  local event_operation = "HasActiveStatus"
  local event_args = GetHostCharacter() .. ", " .. "DialogMethodVanilla"
  local event_data = HasActiveStatus(GetHostCharacter(), "DialogMethodVanilla")

  print_log(event_name, event_state, event_operation, event_args, event_data)

  if HasActiveStatus(GetHostCharacter(), "DialogMethodVanilla") == 1 then
    return false
  end

  event_name = "check_reassignment_requested"
  event_state = "check_camp"
  event_operation = "is_region_camp"
  event_args = nil
  event_data = is_region_camp

  print_log(event_name, event_state, event_operation, event_args, event_data)

  if is_region_camp == 1 then
    return false
  end

  event_name = "check_reassignment_requested"
  event_state = "check_camp"
  event_operation = "has_value"
  event_args = dump_table(db_camp_characters) .. ", " .. character_target
  event_data = has_value(db_camp_characters, character_target)

  print_log(event_name, event_state, event_operation, event_args, event_data)

  if has_value(db_camp_characters, character_target) then
    event_name = "check_reassignment_requested"
    event_state = "check_passive_follower"
    event_operation = "HasActiveStatus"
    event_args = GetHostCharacter() .. ", " .. "DialogPreferenceFollowers"
    event_data = HasActiveStatus(GetHostCharacter(), "DialogPreferenceFollowers")
  
    print_log(event_name, event_state, event_operation, event_args, event_data)

    if HasActiveStatus(GetHostCharacter(), "DialogPreferenceFollowers") == 0 then
      return false
    end
  end

  event_name = "check_reassignment_requested"
  event_state = "check_passive_opt_in_pref"
  event_operation = "HasActiveStatus"
  event_args = GetHostCharacter() .. ", " .. "DialogPreferenceOptIn"
  event_data = HasActiveStatus(GetHostCharacter(), "DialogPreferenceOptIn")

  print_log(event_name, event_state, event_operation, event_args, event_data)

  if HasActiveStatus(GetHostCharacter(), "DialogPreferenceOptIn") == 1 then
   
    for playercharacter in elementIterator(db_party_players) do
      event_name = "check_reassignment_requested"
      event_state = "opt_in_iterate"
      event_operation = "HasActiveStatus"
      event_args = playercharacter .. ", " .. "DialogListenerOptIn"
      event_data = HasActiveStatus(playercharacter, "DialogListenerOptIn")
    
      print_log(event_name, event_state, event_operation, event_args, event_data)
      
      if HasActiveStatus(playercharacter, "DialogListenerOptIn") == 1 then
          table.insert(db_characters_want_dialog, playercharacter)
      end
    end

    event_name = "check_reassignment_requested"
    event_state = "check_empty_after_iterate"
    event_operation = "is nil"
    event_args = "db_characters_want_dialog[1]"
    event_data = db_characters_want_dialog[1]
  
    print_log(event_name, event_state, event_operation, event_args, event_data)

    if db_characters_want_dialog[1] == nil then
      db_characters_want_dialog[1] = character_source
    end

  end

  if HasActiveStatus(GetHostCharacter(), "DialogMethodRandom") == 1 or HasActiveStatus(GetHostCharacter(), "DialogMethodCharisma") == 1 or HasActiveStatus(GetHostCharacter(), "DialogMethodInitiative") == 1 or db_characters_want_dialog[1] ~= nil then
    reassignment_requested = true
  else
    reassignment_requested = false
  end

  event_name = "check_reassignment_requested"
  event_state = "finished"
  event_operation = "return"
  event_args = "reassignment_requested"
  event_data = reassignment_requested

  print_log(event_name, event_state, event_operation, event_args, event_data)

  return reassignment_requested
end
