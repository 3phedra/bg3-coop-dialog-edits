function detach_character(userid, character) 
  --Store UserID for player character about to be detached from player
  userid_dlg_reassigned_owner = userid
  character_dlg_owner_reassigned = character

  SetOnStage(character, 0)
  was_character_owner_reassigned = 1

  local event_name = "detach_character"
  local event_state = "run"
  local event_operation = "SetOnStage"
  local event_args = character .. ", " .. 0
  local event_data = "..."

  print_log(event_name, event_state, event_operation, event_args, event_data)

  return
end
