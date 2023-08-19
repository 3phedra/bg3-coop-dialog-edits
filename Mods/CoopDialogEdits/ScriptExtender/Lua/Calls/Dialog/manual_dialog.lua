Ext.Require("Queries/Dialog/fetch_dialogs.lua")

function manual_restart_dialog(character_source, character_target)
  --Small hack to manually initiate a new dialog from Osiris

  local dialog_listener = {}
  local nulluser = "NULL_00000000-0000-0000-0000-000000000000"
  local chosen_dialog
  local chosen_owner

  --TODO change this to match chosen_dialog
  chosen_owner = character_source

  chosen_dialog = determine_dialog_with_target(character_source, character_target)

  local event_name = "manual_restart_dialog"
  local event_state = "prepare"
  local event_operation = "determine_dialog_with_target"
  local event_args = character_source .. ", " .. character_target
  local event_data = chosen_dialog

  print_log(event_name, event_state, event_operation, event_args, event_data)

  table.insert(dialog_listener, chosen_owner)

  local table_index = 1

  for character in elementIterator(db_party_all) do
    
    if character ~= nil and character ~= chosen_owner and character ~= character_target then
      table.insert(dialog_listener, character)
    end
    
    event_state = "iterate: " .. character
    event_operation = "add_party"
    event_args = character
    event_data = dump_table(dialog_listener)
  
    print_log(event_name, event_state, event_operation, event_args, event_data)
  end

  for i = #dialog_listener + 1, 5 do
    dialog_listener[i] = nulluser

    event_state = "iterate: " .. i
    event_operation = "fill_empty"
    event_args = dialog_listener[i]
    event_data = nulluser
  
    print_log(event_name, event_state, event_operation, event_args, event_data)
  end

  --Initiate determined dialog with dialog target and new dialog owner in speaker slot 1, add party in other slots and fill remaining slots with a null user
  --Will still trigger dialog_started event function, but the function shouldn't have to do anything.
  StartDialog_Internal(chosen_dialog, 0, character_target, dialog_listener[1], dialog_listener[2], dialog_listener[3],
    dialog_listener[4], dialog_listener[5], 23232)

  event_state = "run"
  event_operation = "StartDialog_Internal"
  event_args = chosen_dialog .. ", " .. 0 .. ", " .. character_target .. ", " .. dialog_listener[1] .. ", " .. dialog_listener[2] .. ", " .. dialog_listener[3] .. ", " .. dialog_listener[4] .. ", " .. dialog_listener[5] .. ", " .. ", " .. 23232
  event_data = "..."

  print_log(event_name, event_state, event_operation, event_args, event_data)

  return
end
