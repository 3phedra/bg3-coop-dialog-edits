function register_passive_spell()
  local function_name = "detach_character"
  local function_operation = "called"
  print_log(function_name, function_operation)
  
  --TODO What do the args mean?
  AddBoosts(GetHostCharacter(), "", "", "")
  --TODO add only when no dialog passive found
  AddPassive(GetHostCharacter(), "CoopDialogPassiveMethodVanilla")
end
