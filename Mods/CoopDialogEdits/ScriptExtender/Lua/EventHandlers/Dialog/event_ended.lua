Ext.Require("Calls/CharacterOperations/character_reassignments.lua")
function dialog_ended(dialog_UUID, dialog_ID)
  if HasActiveStatus(GetHostCharacter(), "DialogPreferenceDisable") == 1 then
    return
  end
  --Filter out dialogs that do not involve the party
  if DialogGetInvolvedPlayer(dialog_ID, 1) ~= nil then
    --Return a re-assigned follower to their original owner
    --TODO pass dialog_id to handle eventual simultaneous dialogs
    attach_follower()
    --Re-attach a detached player character to their original user
    attach_character()
    cleanup()
    return
  end
end
Ext.Utils.Print(string.format("[%s]: Dialog end event subscribed", mod_info.Name))
