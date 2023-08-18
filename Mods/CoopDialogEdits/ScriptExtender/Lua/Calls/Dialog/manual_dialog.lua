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

  table.insert(dialog_listener, chosen_owner)

  local table_index = 1

  for character in elementIterator(db_party_all) do
    if character ~= nil and character ~= chosen_owner and character ~= character_target then
      table.insert(dialog_listener, character)
    end
  end

  for i = #dialog_listener + 1, 5 do
    dialog_listener[i] = nulluser
  end

  --Initiate determined dialog with dialog target and new dialog owner in speaker slot 1, add party in other slots and fill remaining slots with a null user
  --Will still trigger dialog_started event function, but the function shouldn't have to do anything.
  StartDialog_Internal(chosen_dialog, 0, character_target, dialog_listener[1], dialog_listener[2], dialog_listener[3],
    dialog_listener[4], dialog_listener[5], 23232)

  return
end
