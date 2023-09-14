Ext.Require("Queries/Dialog/check_target.lua")
function determine_dialog_with_target(character_source, character_target)
  local target_available_dialogs = {}
  local chosen_dialog
  --Query all available dialogs with target character and add to table
  --TODO Take dialog owner into consideration
  --Todo this doesnt work for "S_Player_Jaheira_91b6b200-7d00-4d62-8dc9-99e8339dfa1a" ??
  --UUID "HAV_Jaheira_a8318e4c-7e39-4f4f-1610-a9d3e7a1c1c8"
  for _, entry in pairs(Osi.DB_Dialogs:Get(character_target, nil, nil)) do table.insert(target_available_dialogs, entry[2]) end
  --TODO Figure out how to pick the correct dialog. Picking the last in list for now
  if not check_if_target_is_special(character_target) then
    chosen_dialog = target_available_dialogs[#target_available_dialogs]
  else
    --TODO this is a major todo!
    --If target has more than 1 dialog option, prompt dialog starter to pass dialog leadership to the correct character
    Ext.Utils.PrintWarning("Target has more than 1 possible Dialog options:")
    --DB_Dialogs has a minimum of 2 and a maximum of 5 args, look into it
    for _, entry in pairs(Osi.DB_Dialogs:Get(character_target, nil)) do print(entry[1], entry[2], entry[3]) end
    --TODO Ensure this prompt doesn't pop up all the bloody time on unresolved special dialog options
    --msg = GetDisplayName(character_target), " would like to speak to someone else. Do you want to pass the dialog on?"
    --OpenMessageBoxYesNo(character_source, msg)
    --TODO break here and let messagebox event handle the rest. Placehoders for now:
    chosen_dialog = target_available_dialogs[#target_available_dialogs]
  end
  return chosen_dialog
end
