function register_passive_spell(character)
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
  else
    AddPassive(character, "CoopDialogPassiveListenerOptIn")
    AddPassive(character, "CoopDialogPassivePreferenceDistance")
    AddPassive(character, "CoopDialogPassivePreferenceDisable")
  end
  return
end
