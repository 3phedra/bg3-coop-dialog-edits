Ext.Require("Calls/CharacterOperations/reattach.lua")
function dialog_ended(dialog_UUID, dialog_ID)
  if HasActiveStatus(GetHostCharacter(), "DialogPreferenceDisable") == 1 then
    return
  end
  --Return a re-assigned follower to their original owner
  --Filter out dialogs that do not involve the party
  if DialogGetInvolvedPlayer(dialog_ID, 1) ~= nil then
    if was_follower_reassigned == 1 then
      attach_follower(userid_follower_attached, character_reassigned_follower_owner, character_reassigned_follower)
      was_follower_reassigned = 0
    end
    --Re-attach a detached player character to their original user
    if was_character_owner_reassigned == 1 then
      attach_character(userid_dlg_reassigned_owner, character_dlg_owner_reassigned)
      was_character_owner_reassigned = 0
    end
    cleanup()
    return
  end
end
Ext.Utils.Print(string.format("[%s]: Dialog end event subscribed", mod_info.Name))
