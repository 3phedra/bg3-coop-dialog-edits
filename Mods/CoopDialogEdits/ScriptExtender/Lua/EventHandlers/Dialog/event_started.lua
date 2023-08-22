Ext.Require("Queries/UI/notify.lua")
function dialog_started(dialog_UUID, dialog_ID)
  if HasActiveStatus(GetHostCharacter(), "DialogPreferenceDisable") == 1 then
    return
  end
  local character_distance_to_dialog
  --Get character that triggered dialog event
  --Filter out dialogs that do not involve the party
  if DialogGetInvolvedPlayer(dialog_ID, 1) ~= nil then
    --Some dialogs, such as crime dialogs start without a request and without being automated. Populate DBs.
    if db_party_struct["ActiveParty"][1] == nil then
      startTime = Ext.Utils.MonotonicTime()
      populate_dialog_metadata(DialogGetInvolvedNPC(dialog_ID, 1), DialogGetInvolvedPlayer(dialog_ID, 1))
    end
    --if not check_if_target_is_vendor(dialog_target) and not check_if_target_is_special(dialog_target) then
    --Add all party characters to triggered dialog
    for character in elementIterator(db_party_struct["ActiveParty"]) do
      --Check if character about to be added to dialog isn't in another dialog
      if select(2, SpeakerGetDialog(character, 1)) == nil then
        --Check if distance was toggled and if so, check distance to target
        if db_dialog_methods["RequestOptIn"] then
          if db_party_struct[character]["Distance"] <= 35.0 then
            DialogAddActor(dialog_ID, character)
          end
        else
          DialogAddActor(dialog_ID, character)
        end
        --Osi.PROC_DialogAddSpeakingActor(dialog_ID, character)
      end
    end
    --TODO check if dialog was with a follower, if so do not notify
    if is_automated_dialog ~= 1 then
      -- notify_roll_result()
    end
    endTime = Ext.Utils.MonotonicTime()
    Ext.Utils.Print("Dialog injection took: " .. tostring(endTime - startTime) .. " ms")
  end
  return
end
function automated_dialog_started(dialog_UUID, dialog_ID)
  if HasActiveStatus(GetHostCharacter(), "DialogPreferenceDisable") == 1 then
    return
  end
  if DialogGetInvolvedPlayer(dialog_ID, 1) ~= nil then
    is_automated_dialog = 1
    dialog_started(dialog_UUID, dialog_ID)
    return
  end
end
Ext.Utils.Print(string.format("[%s]: Dialog start event subscribed", mod_info.Name))
Ext.Utils.Print(string.format("[%s]: Automated dialog start event subscribed", mod_info.Name))
