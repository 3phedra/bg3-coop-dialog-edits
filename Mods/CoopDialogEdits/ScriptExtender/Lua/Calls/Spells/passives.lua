function register_passive_spell()
  local event_name = "dialog_ended"
  local event_state = ""
  local event_operation = ""
  local event_args = nil
  local event_data = nil
  
  --TODO What do the args mean?
  AddBoosts(GetHostCharacter(), "", "", "")
  --TODO add only when no dialog passive found
  AddPassive(GetHostCharacter(), "CoopDialogPassiveMethodVanilla")
end
