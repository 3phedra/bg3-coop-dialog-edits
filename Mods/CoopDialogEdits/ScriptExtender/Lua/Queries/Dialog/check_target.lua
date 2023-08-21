function check_if_target_is_vendor(character_target)
  local function_name = "check_if_target_is_vendor"
  local function_operation = "called"
  local function_args = "character_target"
  local function_data = character_target

  print_log(function_name, function_operation, function_args, function_data)

  --TODO find a query that shows if target is vendor
  --If all else fails, populate a new DB with RequestTrade event targets so that only the first dialog locks the whole party

  function_operation = "return"
  function_args = nil
  function_data = false

  print_log(function_name, function_operation, function_args, function_data)

  return false
end

function check_if_target_is_special(character_target)
  local function_name = "check_if_target_is_special"
  local function_operation = "called"
  local function_args = "character_target"
  local function_data = character_target

  print_log(function_name, function_operation, function_args, function_data)

  --TODO find queries that determine whether target shouldn't be re-assignable outside of being vendors
  --TODO if target has more than one dialog, check if these target a particular party member

  local target_available_dialogs = {}


  function_operation = "iterate"
  function_args = "Osi.DB_Dialogs:Get(character_target,nil,nil)"
  function_data = dump_table(Osi.DB_Dialogs:Get(character_target, nil, nil))

  print_log(function_name, function_operation, function_args, function_data)

  for _, entry in pairs(Osi.DB_Dialogs:Get(character_target, nil, nil)) do
    table.insert(target_available_dialogs,
      entry[1])
  end

  function_operation = "assign"
  function_args = "target_available_dialogs"
  function_data = dump_table(target_available_dialogs)

  print_log(function_name, function_operation, function_args, function_data)

  function_operation = "compare"
  function_args = "#target_available_dialogs > 1"
  function_data = dump_table(target_available_dialogs)
  function_result = tostring(#target_available_dialogs > 1)

  print_log(function_name, function_operation, function_args, function_data, function_result)

  if #target_available_dialogs > 1 then
    function_operation = "return"
    function_args = nil
    function_data = false

    print_log(function_name, function_operation, function_args, function_data)

    return true
  else
    function_operation = "return"
    function_args = nil
    function_data = false

    print_log(function_name, function_operation, function_args, function_data)

    return false
  end
end
