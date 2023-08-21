function register_passive_spell(character)
  local function_name = "populate_onload"
  local function_operation = "called"
  local function_args = nil
  local function_data = nil

  print_log(function_name, function_operation, function_args, function_data)
  
  --TODO Make any passive default to on? Probably not.
  --AddBoosts(GetHostCharacter(), "", "", "")

  --TODO add only when no dialog passive found
  --TODO make an opt-out
  --TODO make CoopDialogPassivePreferenceDisable client sided
  --TODO make distance preference client sided
  --TODO implement UI interaction methods
    --TODO Check how the engine handles dialog leaders being removed

  function_operation = "compare"
  function_args = "character == character_host"
  function_data = character .. ", " .. "character_host"
  function_result = character == character_host

  print_log(function_name, function_operation, function_args, function_data)

  if character == character_host then

    function_operation = "AddPassive"
    function_args = "character, 'CoopDialogPassiveMethodVanilla'"
    function_data = character .. ", " .. "CoopDialogPassiveMethodVanilla"
  
    print_log(function_name, function_operation, function_args, function_data)

    AddPassive(character, "CoopDialogPassiveMethodVanilla")

    function_operation = "AddPassive"
    function_args = "character, 'CoopDialogPassiveMethodRandom'"
    function_data = character .. ", " .. "CoopDialogPassiveMethodRandom"
  
    print_log(function_name, function_operation, function_args, function_data)

    AddPassive(character, "CoopDialogPassiveMethodRandom")

    function_operation = "AddPassive"
    function_args = "character, 'CoopDialogPassiveMethodInitiative'"
    function_data = character .. ", " .. "CoopDialogPassiveMethodInitiative"
  
    print_log(function_name, function_operation, function_args, function_data)

    AddPassive(character, "CoopDialogPassiveMethodInitiative")

    function_operation = "AddPassive"
    function_args = "character, 'CoopDialogPassiveMethodCharisma'"
    function_data = character .. ", " .. "CoopDialogPassiveMethodCharisma"
  
    print_log(function_name, function_operation, function_args, function_data)

    AddPassive(character, "CoopDialogPassivePreferenceFollowers")

    function_operation = "AddPassive"
    function_args = "character, 'CoopDialogPassivePreferenceFollowers'"
    function_data = character .. ", " .. "CoopDialogPassiveMethodCharisma"
  
    print_log(function_name, function_operation, function_args, function_data)

    AddPassive(character, "CoopDialogPassivePreferenceFollowers")

    function_operation = "AddPassive"
    function_args = "character, 'CoopDialogPassivePreferenceOptIn'"
    function_data = character .. ", " .. "CoopDialogPassivePreferenceOptIn"
  
    print_log(function_name, function_operation, function_args, function_data)

    AddPassive(character, "CoopDialogPassivePreferenceOptIn")

    function_operation = "AddPassive"
    function_args = "character, 'CoopDialogPassivePreferenceDistance'"
    function_data = character .. ", " .. "CoopDialogPassivePreferenceDistance"
  
    print_log(function_name, function_operation, function_args, function_data)

    AddPassive(character, "CoopDialogPassivePreferenceDistance")

    function_operation = "AddPassive"
    function_args = "character, 'CoopDialogPassiveListenerOptIn'"
    function_data = character .. ", " .. "CoopDialogPassiveListenerOptIn"
  
    print_log(function_name, function_operation, function_args, function_data)

    AddPassive(character, "CoopDialogPassiveListenerOptIn")

    function_operation = "AddPassive"
    function_args = "character, 'CoopDialogPassivePreferenceDisable'"
    function_data = character .. ", " .. "CoopDialogPassivePreferenceDisable"
  
    print_log(function_name, function_operation, function_args, function_data)

    AddPassive(character, "CoopDialogPassivePreferenceDisable")

  else

    function_operation = "AddPassive"
    function_args = "character, 'CoopDialogPassiveListenerOptIn'"
    function_data = character .. ", " .. "CoopDialogPassiveListenerOptIn"
  
    print_log(function_name, function_operation, function_args, function_data)

    AddPassive(character, "CoopDialogPassiveListenerOptIn")
  end

  function_operation = "return"
  function_args = nil
  function_data = nil

  print_log(function_name, function_operation, function_args, function_data)
  return
end
