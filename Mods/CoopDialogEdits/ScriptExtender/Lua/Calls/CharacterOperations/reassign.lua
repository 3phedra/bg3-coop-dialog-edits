function reassign_follower(userid_new, userid_old, character_target)
  local function_name = "reassign_follower"
  local function_operation = "called"
  local function_args = "userid_new, userid_old, character_target"
  local function_data = userid_new .. "," .. userid_old .. "," .. character_target

  print_log(function_name, function_operation, function_args, function_data)

  --Store the follower UUID and original follower owner for restoration
  userid_reassigned_follower_owner = userid_old
  character_reassigned_follower = character_target
  character_reassigned_follower_owner = db_userids[userid_old]
  --Temporarily assign follower to new owner for dialog

  function_operation = "AssignToUser"
  function_args = "userid_new, character_target"
  function_data = userid_new .. "," .. character_target

  print_log(function_name, function_operation, function_args, function_data)

  AssignToUser(userid_new, character_target)

  function_operation = "return"
  function_args = "userid_reassigned_follower_owner, character_reassigned_follower, character_reassigned_follower_owner"
  function_data = userid_reassigned_follower_owner ..
  "," .. character_reassigned_follower .. "," .. character_reassigned_follower_owner
  print_log(function_name, function_operation, function_args, function_data)

  return
end
