Ext.Require("Calls/CharacterOperations/character_reassignments.lua")
function dialog_ended(dialog_UUID, dialog_ID)
  if HasActiveStatus(GetHostCharacter(), "DialogMainToggle") == 0 then
    return
  end
  --Filter out dialogs that do not involve the party
  if DialogGetInvolvedPlayer(dialog_ID, 1) ~= nil and db_party_struct["ActiveParty"] ~= nil then
    --TODO pass dialog_id to handle eventual simultaneous dialogs
    if is_debug then
      dump_log()
    end
    attach_character()
    attach_follower()
    cleanup()
  end
  return
end
Ext.Utils.Print(string.format("[%s]: Dialog end event subscribed", mod_info.Name))