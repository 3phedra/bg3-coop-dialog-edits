function unlock_party_from_trade(trader1, trader2, trademode, var)
  local function_name = "unlock_party_from_trade"
  local function_operation = "called"
  local function_args = "trader1, trader2, trademode, var"
  local function_data = trader1 .. "," .. trader2 .. "," .. trademode .. "," .. var

  print_log(function_name, function_operation, function_args, function_data)

  --TODO look into what vars return
  --TODO Find out how to rip rest of party from dialog maybe DialogRequestStop(GUIDSTRING) or DialogRequestStopForDialog(DIALOGRESOURCE, GUIDSTRING)
  --This probably wont work:
  function_operation = "iterate"
  function_args = "db_party_all"
  function_data = dump_table(db_party_all)

  print_log(function_name, function_operation, function_args, function_data)

  for character in elementIterator(db_party_all) do
    function_operation = "compare"
    function_args = "character ~= trader1"
    function_data = character .. "," .. trader1
    function_result = character ~= trader1

    print_log(function_name, function_operation, function_args, function_data, function_result)

    if character ~= trader1 then
      character_dialog = select(2, SpeakerGetDialog(character, 1))

      function_operation = "DialogRequestStopForDialog"
      function_args = "character_dialog, character"
      function_data = character_dialog .. "," .. character

      print_log(function_name, function_operation, function_args, function_data)

      DialogRequestStopForDialog(character_dialog, character)
    end
  end

  function_operation = "return"
  function_args = nil
  function_data = nil
  print_log(function_name, function_operation, function_args, function_data)
end

function defer_dialog_from_messagebox(var1, var2)
  local function_name = "defer_dialog_from_messagebox"
  local function_operation = "called"
  local function_args = "var1, var2, trademode, var"
  local function_data = var1 .. "," .. var2

  print_log(function_name, function_operation, function_args, function_data)

  return
  --TODO major todo
end
