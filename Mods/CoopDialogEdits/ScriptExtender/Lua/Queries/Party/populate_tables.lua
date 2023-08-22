function populate_onload()
  db_party_struct["Camp"] = {}
  --Add all camp followers to a table (includes players)
  for _, entry in pairs(Osi.DB_PartOfTheTeam:Get(nil)) do
    table.insert(db_party_struct["Camp"], entry[1])
  end
  character_host = GetHostCharacter()
  return
end
function populate_dialog_metadata(character_target, character_source, dialog_ID)
  db_party_struct["DialogID"] = dialog_ID
  db_party_struct["DialogOwner"] = character_source
  db_party_struct["PlayerCharacters"] = {}
  db_party_struct["ActiveParty"] = {}
  db_party_struct["Region"] = GetRegion(character_target)
  --TODO still todo check if in camp:
  db_party_struct["RegionIsCamp"] = false
  for _, character in pairs(Osi.DB_PartOfTheTeam:Get(nil)) do
    --BG3SE probably contains info for all of these but for now
    db_party_struct[character]["IsPlayer"] = IsControlled(character[1])
    db_party_struct[character]["UserID"] = GetReservedUserID(character[1])
    db_party_struct[character]["Distance"] = GetDistanceTo(character_target, character[1])
    db_party_struct[character]["Region"] = GetRegion(character[1])
    table.insert(db_party_struct["PlayerCharacters"], character)
  end
  --Todo change this to a struct character flag
  for _, character in pairs(Osi.Db_Players:Get(nil)) do
    table.insert(db_party_struct["ActiveParty"], character)
  end
end
function populate_preference_table(characters)
  db_dialog_methods["CharactersWantDialog"] = {}
  db_dialog_methods["RollResults"] = {}
  db_dialog_methods["method"] = "vanilla"
  if HasActiveStatus(GetHostCharacter(), "DialogMethodVanilla") then
    db_dialog_methods["Method"] = "vanilla"
    db_dialog_methods["Modifier"] = "Nullify"
  elseif HasActiveStatus(GetHostCharacter(), "DialogMethodRandom") then
    db_dialog_methods["Method"] = "random"
    db_dialog_methods["Modifier"] = "Nullify"
  elseif HasActiveStatus(GetHostCharacter(), "DialogMethodCharisma") then
    db_dialog_methods["Method"] = "charisma"
    db_dialog_methods["Modifier"] = "Charisma"
  elseif HasActiveStatus(GetHostCharacter(), "DialogMethodInitiative") then
    db_dialog_methods["Method"] = "initiative"
    db_dialog_methods["Modifier"] = "initiative"
  end
  if HasActiveStatus(GetHostCharacter(), "DialogPreferenceOptIn") == 1 and db_characters_want_dialog[1] ~= nil then
    db_dialog_methods["RequestOptIn"] = true
  end
  if HasActiveStatus(GetHostCharacter(), "FollowerPreference") == 1 then
    db_dialog_methods["FollowerPreference"] = true
  end
  for character in elementIterator(characters) do
    if db_dialog_methods["Modifier"] ~= nil and not db_dialog_methods["Modifier"] == "Nullify" then
      --TODO round down
      db_dialog_methods[character]["Modifier"] = (-10 + GetAbility(character, db_dialog_methods["Modifier"])) / 2
    else
      db_dialog_methods[character]["Modifier"] = 0
    end
    if HasActiveStatus(character, "DialogListenerOptIn") == 1 then
      table.insert(db_dialog_methods["CharactersWantDialog"], character)
    end
    if db_dialog_methods[character]["FairnessMod"] == nil then
      db_dialog_methods[character]["FairnessMod"] = 0
    end
    if db_dialog_methods[character]["WinCount"] == nil then
      db_dialog_methods[character]["WinCount"] = 0
    end
  end
  if db_dialog_methods["RequestOptIn"] and db_dialog_methods["CharactersWantDialog"] < 1 then
    db_dialog_methods["method"] = "vanilla"
  end
end
