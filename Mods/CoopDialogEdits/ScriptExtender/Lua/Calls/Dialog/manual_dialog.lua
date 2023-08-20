Ext.Require("Queries/Dialog/fetch_dialogs.lua")

function manual_restart_dialog(character_source, character_target)
  local function_name = "manual_restart_dialog"
  local function_operation = "called"
  local function_args = "character_source, character_target"
  local function_data = character_source .. "," .. character_target

  print_log(function_name, function_operation, function_args, function_data)

  --Small hack to manually initiate a new dialog from Osiris

  local dialog_listener = {}
  local nulluser = "NULL_00000000-0000-0000-0000-000000000000"
  local chosen_dialog
  local chosen_owner

  --TODO change this to match chosen_dialog
  chosen_owner = character_source

  function_operation = "determine_dialog_with_target"
  function_args = "character_source, character_target"
  function_data = character_source .. "," .. character_target

  print_log(function_name, function_operation, function_args, function_data)

  chosen_dialog = determine_dialog_with_target(character_source, character_target)

  function_operation = "assign"
  function_args = "chosen_dialog"
  function_data = chosen_dialog

  print_log(function_name, function_operation, function_args, function_data)

  table.insert(dialog_listener, chosen_owner)

  local table_index = 1

  function_operation = "iterate"
  function_args = "db_party_all"
  function_data = dump_table(db_party_all)

  print_log(function_name, function_operation, function_args, function_data)

  for character in elementIterator(db_party_all) do
    function_operation = "compare"
    function_args = "character ~= nil and character ~= chosen_owner and character ~= character_target"
    function_data = character .. "," .. chosen_owner .. "," .. character_target
    function_result = character ~= nil and character ~= chosen_owner and character ~= character_target

    print_log(function_name, function_operation, function_args, function_data, function_result)

    if character ~= nil and character ~= chosen_owner and character ~= character_target then
      table.insert(dialog_listener, character)

      function_operation = "insert"
      function_args = "dialog_listener"
      function_data = character

      print_log(function_name, function_operation, function_args, function_data)
    end
  end

  function_operation = "iterate"
  function_args = "#dialog_listener + 1, 5"
  function_data = dump_table(dialog_listener)

  print_log(function_name, function_operation, function_args, function_data)

  for i = #dialog_listener + 1, 5 do
    dialog_listener[i] = nulluser

    function_operation = "insert"
    function_args = "dialog_listener[%s]", i
    function_data = nulluser

    print_log(function_name, function_operation, function_args, function_data)
  end

  function_operation = "StartDialog_Internal"
  function_args =
  "chosen_dialog, 0, character_target, dialog_listener[1], dialog_listener[2], dialog_listener[3], dialog_listener[4], dialog_listener[5], 23232"
  function_data = chosen_dialog ..
  "," ..
  0 ..
  "," ..
  character_target ..
  "," ..
  dialog_listener[1] ..
  "," ..
  dialog_listener[2] ..
  "," .. dialog_listener[3] .. "," .. dialog_listener[4] .. "," .. dialog_listener[5] .. "," .. 23232

  print_log(function_name, function_operation, function_args, function_data)

  --Initiate determined dialog with dialog target and new dialog owner in speaker slot 1, add party in other slots and fill remaining slots with a null user
  --Will still trigger dialog_started event function, but the function shouldn't have to do anything.
  StartDialog_Internal(chosen_dialog, 0, character_target, dialog_listener[1], dialog_listener[2], dialog_listener[3],
    dialog_listener[4], dialog_listener[5], 23232)

  return
end
