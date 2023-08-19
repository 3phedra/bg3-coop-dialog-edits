Ext.Require("Queries/UI/notify.lua")

function dialog_started(dialog_UUID, dialog_ID)
  if IsSpellActive(GetHostCharacter(), "DialogPreferenceDisable") == 1 then
    return
  end

  local event_name = "dialog_started"
  local event_state = ""
  local event_operation = ""
  local event_args = ""
  local event_data = nil

  local character_distance_to_dialog
  --Get character that triggered dialog event

  --Filter out dialogs that do not involve the party
  if DialogGetInvolvedPlayer(dialog_ID, 1) ~= nil then
    local dialog_owner = DialogGetInvolvedPlayer(dialog_ID, 1)

    --if not check_if_target_is_vendor(dialog_target) and not check_if_target_is_special(dialog_target) then
    --Add all party characters to triggered dialog
    for character in elementIterator(db_party_all) do
      --Check if character about to be added to dialog isn't in another dialog
      if select(2, SpeakerGetDialog(character, 1)) == nil then
        event_state = "iterate: " .. character
        event_operation = "GetDistanceTo"
        event_args = dialog_owner .. ", " .. character
        event_data = GetDistanceTo(dialog_owner, character)

        print_log(event_name, event_state, event_operation, event_args, event_data)

        character_distance_to_dialog = GetDistanceTo(dialog_owner, character)

        event_state = "iterate: " .. character
        event_operation = "DialogAddActor"
        event_args = dialog_ID .. ", " .. character
        event_data = "..."

        print_log(event_name, event_state, event_operation, event_args, event_data)

        DialogAddActor(dialog_ID, character)

        --Osi.PROC_DialogAddSpeakingActor(dialog_ID, character)
      end
    end

    --TODO check if dialog was with a follower, if so do not notify
    if is_automated_dialog == 1 then
      notify_roll_result()
    end
  end

  event_state = "finished"
  event_operation = "return"
  event_args = "Success"
  event_data = true

  print_log(event_name, event_state, event_operation, event_args, event_data)

  return
end

function automated_dialog_started(dialog_UUID, dialog_ID)
  --TODO implement this
  if DialogGetInvolvedPlayer(dialog_ID, 1) ~= nil then
    is_automated_dialog = 1
    print("Dialog is an automated dialog.")

    --dialog_requested event is skipped in automated dialogs, but we need a party db
    for _, entry in pairs(Osi.DB_Players:Get(nil)) do
      table.insert(db_party_all, entry[1])
      if IsControlled(entry[1]) == 1 then
        table.insert(db_party_players, entry[1])
        db_userids[GetReservedUserID(entry[1])] = entry[1]
      end
    end

    dialog_started(dialog_UUID, dialog_ID)
  end
end

Ext.Utils.Print(string.format("[%s]: Dialog start event subscribed", mod_info.Name))
Ext.Utils.Print(string.format("[%s]: Automated dialog start event subscribed", mod_info.Name))
