function check_reassignment_requested(character_target, character_source)
  --Check if reassignment is needed at all
  --TODO Add more methods
  if HasActiveStatus(GetHostCharacter(), "DialogMethodVanilla") == 1 then
    return false
  end

  if is_region_camp == 1 then
    return false
  end

  if has_value(db_camp_characters, character_target) then
    if HasActiveStatus(GetHostCharacter(), "DialogPreferenceFollowers") == 0 then
      return false
    end
  end

  if HasActiveStatus(GetHostCharacter(), "DialogPreferenceOptIn") == 1 then
    for playercharacter in elementIterator(db_party_players) do
      if HasActiveStatus(playercharacter, "DialogListenerOptIn") == 1 then
        table.insert(db_characters_want_dialog, playercharacter)
      end
    end
    if db_characters_want_dialog[1] == nil then
      db_characters_want_dialog[1] = character_source
    end
  end

  if HasActiveStatus(GetHostCharacter(), "DialogMethodRandom") == 1 or HasActiveStatus(GetHostCharacter(), "DialogMethodCharisma") == 1 or HasActiveStatus(GetHostCharacter(), "DialogMethodInitiative") == 1 or db_characters_want_dialog[1] ~= nil then
    reassignment_requested = true
  else
    reassignment_requested = false
  end

  return reassignment_requested
end
