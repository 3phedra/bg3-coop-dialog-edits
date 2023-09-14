function register_main_toggle(character)
  if string.sub(character, -36) == character_host then
    AddPassive(character, "CoopDialogMainToggle")
  end
end

function register_roll_toggle()
  populate_onload()
  for character in elementIterator(db_party_struct["Camp"]) do
    AddPassive(character, "CoopDialogRollToggle")
  end
end

function register_passive_spells(character)
  --TODO Make any passive default to on? Probably not.
  --AddBoosts(GetHostCharacter(), "", "", "")
  --TODO add only when no dialog passive found
  --TODO make an opt-out
  --TODO make CoopDialogPassivePreferenceDisable client sided
  --TODO make distance preference client sided
  --TODO implement UI interaction methods
  --TODO Check how the engine handles dialog leaders being removed
  --TODO I have a suspicion adding passives via txt can brick saves

  if string.sub(character, -36) == character_host then

    AddPassive(character, "CoopDialogPassiveMethodVanilla")
    AddPassive(character, "CoopDialogPassiveMethodRandom")
    AddPassive(character, "CoopDialogPassiveMethodCharisma")
    AddPassive(character, "CoopDialogPassiveMethodInitiative")
    AddPassive(character, "CoopDialogPassivePreferenceFollowers")
    AddPassive(character, "CoopDialogPassivePreferenceOptIn")
    AddPassive(character, "CoopDialogPassiveListenerOptIn")
    AddPassive(character, "CoopDialogPassivePreferenceDistance")
    AddPassive(character, "CoopDialogPassivePreferenceDisable")
    ApplyStatus(character, "DialogMethodVanilla", 100,-1)

  else
    AddPassive(character, "CoopDialogPassiveListenerOptIn")
    AddPassive(character, "CoopDialogPassivePreferenceDistance")
    AddPassive(character, "CoopDialogPassivePreferenceDisable")
  end
  return
end

function deregister_passive_spells(character, full_wipe)
  RemovePassive(character, "CoopDialogPassiveMethodVanilla")
  RemovePassive(character, "CoopDialogPassiveMethodRandom")
  RemovePassive(character, "CoopDialogPassiveMethodCharisma")
  RemovePassive(character, "CoopDialogPassiveMethodInitiative")
  RemovePassive(character, "CoopDialogPassivePreferenceFollowers")
  RemovePassive(character, "CoopDialogPassivePreferenceOptIn")
  RemovePassive(character, "CoopDialogPassiveListenerOptIn")
  RemovePassive(character, "CoopDialogPassivePreferenceDistance")
  RemovePassive(character, "CoopDialogPassivePreferenceDisable")
  RemoveStatus(character, "DialogPreferenceDisable")
  RemoveStatus(character, "DialogListenerOptIn")
  RemoveStatus(character, "DialogMethodVanilla")
  RemoveStatus(character, "DialogMethodRandom")
  RemoveStatus(character, "DialogMethodInitiative")
  RemoveStatus(character, "DialogMethodCharisma")
  RemoveStatus(character, "DialogPreferenceFollowers")
  RemoveStatus(character, "DialogPreferenceOptIn")
  RemoveStatus(character, "DialogPreferenceDistance")
  if full_wipe then
    RemovePassive(character, "CoopDialogMainToggle")
    RemovePassive(character, "CoopDialogRollToggle")
  end
  return
end
