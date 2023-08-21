Ext.Require("Queries/Dialog/check_target.lua")

function determine_dialog_with_target(character_source, character_target)
  local function_name = "determine_dialog_with_target"
  local function_operation = "called"
  local function_args = "character_source, character_target"
  local function_data = character_source .. "," .. character_target

  print_log(function_name, function_operation, function_args, function_data)

  local target_available_dialogs = {}

  local chosen_dialog

  --Query all available dialogs with target character and add to table
  --TODO Take dialog owner into consideration

  function_operation = "iterate"
  function_args = "Osi.DB_Dialogs:Get(character_target,nil)"
  function_data = dump_table(Osi.DB_Dialogs:Get(character_target, nil))

  print_log(function_name, function_operation, function_args, function_data)

  for _, entry in pairs(Osi.DB_Dialogs:Get(character_target, nil)) do table.insert(target_available_dialogs, entry[2]) end

  function_operation = "assign"
  function_args = "target_available_dialogs"
  function_data = dump_table(target_available_dialogs)

  print_log(function_name, function_operation, function_args, function_data)

  function_operation = "compare"
  function_args = "not check_if_target_is_special(character_target)"
  function_data = character_target
  function_result = tostring(not check_if_target_is_special(character_target))

  print_log(function_name, function_operation, function_args, function_data, function_result)

  --TODO Figure out how to pick the correct dialog. Picking the last in list for now
  if not check_if_target_is_special(character_target) then
    chosen_dialog = target_available_dialogs[#target_available_dialogs]

    function_operation = "assign"
    function_args = "chosen_dialog"
    function_data = chosen_dialog

    print_log(function_name, function_operation, function_args, function_data)
  else
    --TODO this is a major todo!
    --If target has more than 1 dialog option, prompt dialog starter to pass dialog leadership to the correct character
    Ext.Utils.PrintWarning("Target has more than 1 possible Dialog options:")
    --DB_Dialogs has a minimum of 2 and a maximum of 5 args, look into it

    for _, entry in pairs(Osi.DB_Dialogs:Get(character_target, nil)) do print(entry[1], entry[2], entry[3]) end

    print_log(function_name, function_state, function_operation, function_args, function_data)

    --TODO Ensure this prompt doesn't pop up all the bloody time on unresolved special dialog options
    --msg = GetDisplayName(character_target), " would like to speak to someone else. Do you want to pass the dialog on?"
    --OpenMessageBoxYesNo(character_source, msg)

    --TODO break here and let messagebox event handle the rest. Placehoders for now:
    chosen_dialog = target_available_dialogs[#target_available_dialogs]
  end

  function_operation = "return"
  function_args = "chosen_dialog"
  function_data = chosen_dialog

  print_log(function_name, function_operation, function_args, function_data)

  return chosen_dialog
end
