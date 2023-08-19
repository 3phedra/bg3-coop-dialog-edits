Ext.Require("Calls/CharacterOperations/reattach.lua")

function dialog_ended(dialog_UUID, dialog_ID)
  --Return a re-assigned follower to their original owner
  --Filter out dialogs that do not involve the party
  local event_name = "dialog_ended"
  local event_state = ""
  local event_operation = ""
  local event_args = nil
  local event_data = nil

  if DialogGetInvolvedPlayer(dialog_ID, 1) ~= nil then
    if was_follower_reassigned == 1 then
      attach_follower(userid_follower_attached, character_reassigned_follower_owner, character_reassigned_follower)
      was_follower_reassigned = 0

      event_state = "cleanup"
      event_operation = "attach_follower"
      event_args = userid_follower_attached .. ", " .. character_reassigned_follower_owner .. ", " .. character_reassigned_follower
      event_data = "..."
    
      print_log(event_name, event_state, event_operation, event_args, event_data)
    end

    --Re-attach a detached player character to their original user
    if was_character_owner_reassigned == 1 then
      attach_character(userid_dlg_reassigned_owner, character_dlg_owner_reassigned)
      was_character_owner_reassigned = 0

      event_state = "cleanup"
      event_operation = "attach_character"
      event_args = userid_dlg_reassigned_owner .. ", " .. character_dlg_owner_reassigned
      event_data = "..."
    
      print_log(event_name, event_state, event_operation, event_args, event_data)
    end

    cleanup()

    event_state = "cleanup"
    event_operation = "cleanup"
    event_args = nil
    event_data = "..."

    print_log(event_name, event_state, event_operation, event_args, event_data)

    event_state = "finished"
    event_operation = "return"
    event_args = "Success"
    event_data = true
  
    print_log(event_name, event_state, event_operation, event_args, event_data)

    return
  end
end

Ext.Utils.Print(string.format("[%s]: Dialog end event subscribed", mod_info.Name))
