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
  db_party_struct["DialogTarget"] = character_target
  db_party_struct["PlayerCharacters"] = {}
  db_party_struct["ActiveParty"] = {}
  db_party_struct["Region"] = GetRegion(character_target)
  --TODO still todo check if in camp:
  db_party_struct["RegionIsCamp"] = false
  db_party_struct["Camp"] = {}
  db_party_struct["ActivePartyInRange"] = {}
  db_party_struct["UserID"] = {}
  db_party_struct["Followers"] = {}
  for _, character in pairs(Osi.DB_PartOfTheTeam:Get(nil)) do
    --BG3SE probably contains info for all of these but for now
    character = character[1]
    db_party_struct[character] = {}
    db_party_struct[character]["IsPlayer"] = IsControlled(character)
    db_party_struct[character]["UserID"] = GetReservedUserID(character)
    db_party_struct[character]["Distance"] = GetDistanceTo(character_target, character)
    db_party_struct[character]["Region"] = GetRegion(character)
    db_party_struct[character]["WasDetached"] = false
    table.insert(db_party_struct["Camp"], character)
    if IsControlled(character) == 1 then
      table.insert(db_party_struct["PlayerCharacters"], character)
      db_party_struct[db_party_struct[character]["UserID"]] = character
    else
      table.insert(db_party_struct["Followers"], character)
    end
  end
  --Todo change this to a struct character flag
  for _, character in pairs(Osi.Db_Players:Get(nil)) do
    table.insert(db_party_struct["ActiveParty"], character[1])
  end
  for character in elementIterator(db_party_struct["ActiveParty"]) do
    if db_party_struct[character]["Distance"] <= 35.0 then
      table.insert(db_party_struct["ActivePartyInRange"], character)
    end
  end
end
function populate_preference_table()
  db_dialog_methods["CharactersWantDialog"] = {}
  db_dialog_methods["CharactersWantDialogInRange"] = {}
  db_dialog_methods["RollResults"] = {}
  db_dialog_methods["Method"] = "vanilla"
  db_dialog_methods["RequestOptIn"] = false
  db_dialog_methods["FollowerPreference"] = false
  db_dialog_methods["DistancePreference"] = false
  if HasActiveStatus(GetHostCharacter(), "DialogMethodVanilla") == 1 then
    db_dialog_methods["Method"] = "vanilla"
    db_dialog_methods["Modifier"] = "Nullify"
  elseif HasActiveStatus(GetHostCharacter(), "DialogMethodRandom") == 1 then
    db_dialog_methods["Method"] = "random"
    db_dialog_methods["Modifier"] = "Nullify"
  elseif HasActiveStatus(GetHostCharacter(), "DialogMethodCharisma") == 1 then
    db_dialog_methods["Method"] = "charisma"
    db_dialog_methods["Modifier"] = "Charisma"
  elseif HasActiveStatus(GetHostCharacter(), "DialogMethodInitiative") == 1 then
    db_dialog_methods["Method"] = "initiative"
    db_dialog_methods["Modifier"] = "Initiative"
  end
  if HasActiveStatus(GetHostCharacter(), "DialogPreferenceFollowers") == 1 then
    db_dialog_methods["FollowerPreference"] = true
  end
  for character in elementIterator(db_party_struct["ActiveParty"]) do
    db_dialog_methods[character] = {}
    if db_dialog_methods["Modifier"] ~= nil and not db_dialog_methods["Modifier"] == "Nullify" then
      --TODO round down
      db_dialog_methods[character]["Modifier"] = (-10 + GetAbility(character, db_dialog_methods["Modifier"])) / 2
    else
      db_dialog_methods[character]["Modifier"] = 0
    end
    if HasActiveStatus(character, "DialogListenerOptIn") == 1 then
      table.insert(db_dialog_methods["CharactersWantDialog"], character)
      if db_party_struct[character]["Distance"] <= 35.0 then
        table.insert(db_dialog_methods["CharactersWantDialogInRange"], character)
      end
    end
    if db_dialog_methods[character]["FairnessMod"] == nil then
      db_dialog_methods[character]["FairnessMod"] = 0
    end
    if db_dialog_methods[character]["WinCount"] == nil then
      db_dialog_methods[character]["WinCount"] = 0
    end
  end
  if HasActiveStatus(GetHostCharacter(), "DialogPreferenceDistance") == 1 then
    db_dialog_methods["DistancePreference"] = true
    db_dialog_methods["CharactersWantDialog"] = db_dialog_methods["CharactersWantDialogInRange"]
  end
  if HasActiveStatus(GetHostCharacter(), "DialogPreferenceOptIn") == 1 and #db_dialog_methods["CharactersWantDialog"] > 0 then
    db_dialog_methods["RequestOptIn"] = true
  elseif HasActiveStatus(GetHostCharacter(), "DialogPreferenceOptIn") == 1 and #db_dialog_methods["CharactersWantDialog"] < 1 then
    db_dialog_methods["Method"] = "vanilla"
  end
end
