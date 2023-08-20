function detach_character(userid, character)
  local function_name = "detach_character"
  local function_operation = "called"
  local function_args = "userid, character"
  local function_data = userid .. "," .. character

  print_log(function_name, function_operation, function_args, function_data)

  --Store UserID for player character about to be detached from player
  userid_dlg_reassigned_owner = userid
  character_dlg_owner_reassigned = character

  function_operation = "SetOnStage"
  function_args = "character, 0"
  function_data = character .. "," .. 0

  print_log(function_name, function_operation, function_args, function_data)

  SetOnStage(character, 0)
  was_character_owner_reassigned = 1

  function_operation = "return"
  function_args = "userid_dlg_reassigned_owner, character_dlg_owner_reassigned, was_character_owner_reassigned"
  function_data = userid_dlg_reassigned_owner ..
  "," .. character_dlg_owner_reassigned .. "," .. was_character_owner_reassigned
  print_log(function_name, function_operation, function_args, function_data)

  return
end
