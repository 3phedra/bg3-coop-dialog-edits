Ext.Require("Queries/Dialog/fetch_dialogs.lua")
function manual_restart_dialog(character_source, character_target)
  --Small hack to manually initiate a new dialog from Osiris
  local dialog_listener = {}
  local nulluser = "NULL_00000000-0000-0000-0000-000000000000"
  local chosen_dialog
  --TODO change this to match chosen_dialog
  chosen_dialog = determine_dialog_with_target(character_source, character_target)
  table.insert(dialog_listener, character_source)
  for character in elementIterator(db_party_struct["ActiveParty"]) do
    if character ~= nil and character ~= character_source and character ~= character_target then
      if db_party_struct[character]["WasDetached"] then
        attach_character()
        --Sleeping does appear to do Osiris some good...For now and for good measure
        sleep(100)
      end
      if db_dialog_methods["DistancePreference"] then
        if db_party_struct[character]["Distance"] <= 35.0 then
          table.insert(dialog_listener, character)
        end
      else
        table.insert(dialog_listener, character)
      end
    end
  end
  for i = #dialog_listener + 1, 5 do
    dialog_listener[i] = nulluser
  end
  db_dialog_struct["RestartArgs"] = {chosen_dialog, character_target, dialog_listener[1], dialog_listener[2], dialog_listener[3],
  dialog_listener[4], dialog_listener[5]}
  --Initiate determined dialog with dialog target and new dialog owner in speaker slot 1, add party in other slots and fill remaining slots with a null user
  --Will still trigger dialog_started event function, but the function shouldn't have to do anything.
  Osi.QRY_StartDialog(chosen_dialog, character_target, dialog_listener[1], dialog_listener[2], dialog_listener[3],
  dialog_listener[4], dialog_listener[5])
  return
end