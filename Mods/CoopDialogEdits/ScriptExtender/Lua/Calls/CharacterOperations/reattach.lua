function attach_character(userid, character)
  SetOnStage(character, 1)

  local event_name = "attach_character"
  local event_state = "called"
  local event_operation = "SetOnStage"
  local event_args = character .. ", " .. 1
  local event_data = "..."

  print_log(event_name, event_state, event_operation, event_args, event_data)

  return

  --MakePlayer(character)
  --Make sure character is assigned to correct user (shouldn't be necessary but for safety)
  --AssignToUser(userid,character)
  --Force making character controlled again
  --MakePlayerActive(character)
end

function attach_follower(userid, character_target, follower)
  AssignToUser(userid, follower)

  local event_name = "attach_follower"
  local event_state = "run"
  local event_operation = "AssignToUser"
  local event_args = userid .. ", " .. follower
  local event_data = "..."

  print_log(event_name, event_state, event_operation, event_args, event_data)

  AttachToPartyGroup(follower, character_target)

  event_state = "run"
  event_operation = "AttachToPartyGroup"
  event_args = follower .. ", " .. character_target
  event_data = "..."

  print_log(event_name, event_state, event_operation, event_args, event_data)
end
