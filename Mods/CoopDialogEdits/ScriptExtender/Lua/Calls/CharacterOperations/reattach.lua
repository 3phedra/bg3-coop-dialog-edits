function attach_character(userid, character)
  local function_name = "attach_character"
  local function_operation = "called"
  local function_args = "userid, character"
  local function_data = userid .. "," .. character

  print_log(function_name, function_operation, function_args, function_data)

  function_operation = "SetOnStage"
  function_args = "character, 1"
  function_data = character .. "," .. 1

  print_log(function_name, function_operation, function_args, function_data)

  SetOnStage(character, 1)

  function_operation = "return"
  function_args = nil
  function_data = nil
  print_log(function_name, function_operation, function_args, function_data)

  return

  --MakePlayer(character)
  --Make sure character is assigned to correct user (shouldn't be necessary but for safety)
  --AssignToUser(userid,character)
  --Force making character controlled again
  --MakePlayerActive(character)
end

function attach_follower(userid, character_target, follower)
  local function_name = "attach_follower"
  local function_operation = "called"
  local function_args = "userid, character_target, follower"
  local function_data = userid .. "," .. character_target .. "," .. follower

  print_log(function_name, function_operation, function_args, function_data)

  function_operation = "AssignToUser"
  function_args = "userid, follower"
  function_data = userid .. "," ..

      print_log(function_name, function_operation, function_args, function_data)

  AssignToUser(userid, follower)

  function_operation = "AttachToPartyGroup"
  function_args = "follower, character_target"
  function_data = follower .. "," .. character_target

  print_log(function_name, function_operation, function_args, function_data)

  AttachToPartyGroup(follower, character_target)

  function_operation = "return"
  function_args = nil
  function_data = nil
  print_log(function_name, function_operation, function_args, function_data)
end
