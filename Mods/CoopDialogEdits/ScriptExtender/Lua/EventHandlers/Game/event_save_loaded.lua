Ext.Require("Queries/Party/populate_tables.lua")
Ext.Require("Calls/Spells/add_passives.lua")

function savegame_loaded()
  
  local function_name = "savegame_loaded"
  local function_operation = "called"
  local function_args = nil
  local function_data = nil

  print_log(function_name, function_operation, function_args, function_data)

  function_operation = "populate_onload"
  function_args = nil
  function_data = nil

  print_log(function_name, function_operation, function_args, function_data)

  populate_onload()

  function_operation = "iterate"
  function_args = "db_camp_characters"
  function_data = dump_table(db_camp_characters)

  print_log(function_name, function_operation, function_args, function_data)

  for character in elementIterator(db_camp_characters) do
    function_operation = "register_passive_spell"
    function_args = "character"
    function_data = character

    print_log(function_name, function_operation, function_args, function_data)

    register_passive_spell(character)
  end

  function_operation = "return"
  function_args = nil
  function_data = nil

  print_log(function_name, function_operation, function_args, function_data)

  return
end

Ext.Utils.Print(string.format("[%s]: Savegame load event subscribed", mod_info.Name))
