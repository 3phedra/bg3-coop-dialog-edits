Ext.Require("Utils/custom_std.lua")

function roll_for_dialog(method, characters)
  local function_name = "roll_for_dialog"
  local function_operation = "called"
  local function_args = "method, characters"
  local function_data = method .. "," .. dump_table_inline(characters)

  print_log(function_name, function_operation, function_args, function_data)

  local roll_winner

  --TODO Add more methods
  function_operation = "compare"
  function_args = "method == 'random'"
  function_data = method
  function_result = method == "random"

  print_log(function_name, function_operation, function_args, function_data, function_result)

  function_operation = "compare"
  function_args = "method == 'charisma'"
  function_data = method
  function_result = method == "charisma"

  print_log(function_name, function_operation, function_args, function_data, function_result)

  function_operation = "compare"
  function_args = "method == 'initiative'"
  function_data = method
  function_result = method == "initiative"

  print_log(function_name, function_operation, function_args, function_data, function_result)

  if method == "random" then
    --Add all dialog competitors and their respective random roll to a table
    function_operation = "iterate"
    function_args = "characters"
    function_data = dump_table(characters)

    print_log(function_name, function_operation, function_args, function_data)

    for character in elementIterator(characters) do
      function_operation = "compare"
      function_args = "db_mod_dlg_roll_fairness[%s] == nil", character
      function_data = db_mod_dlg_roll_fairness[character]
      function_result = db_mod_dlg_roll_fairness[character] == nil

      print_log(function_name, function_operation, function_args, function_data, function_result)

      if db_mod_dlg_roll_fairness[character] == nil then
        db_mod_dlg_roll_fairness[character] = 0

        function_operation = "assign "
        function_args = "db_mod_dlg_roll_fairness[%s]", character
        function_data = 0

        print_log(function_name, function_operation, function_args, function_data)
      end
      --db_dialog_competitors.insert(Random(20) + 1,character)
      --TODO check how to utilize RequestPassiveRoll or RequestPassiveRollVersusSkill

      function_operation = "random"
      function_args = "Random"
      function_data = 20

      print_log(function_name, function_operation, function_args, function_data)

      db_dialog_competitors[character] = Random(20) + 1 + db_mod_dlg_roll_fairness[character]

      function_operation = "assign "
      function_args = "db_dialog_competitors[%s]", character
      function_data = db_dialog_competitors[character]

      print_log(function_name, function_operation, function_args, function_data)
    end
  elseif method == "charisma" then
    function_operation = "iterate"
    function_args = "characters"
    function_data = dump_table(characters)

    print_log(function_name, function_operation, function_args, function_data)

    for character in elementIterator(characters) do
      function_operation = "GetAbility"
      function_args = "character, 'Charisma'"
      function_data = character .. "," .. 'Charisma'
      function_result = GetAbility(character, "Charisma")

      print_log(function_name, function_operation, function_args, function_data, function_result)

      local modifier = GetAbility(character, "Charisma")

      modifier = (-10 + modifier) / 2

      function_operation = "assign"
      function_args = "modifier"
      function_data = modifier

      print_log(function_name, function_operation, function_args, function_data)

      function_operation = "random"
      function_args = "Random"
      function_data = 20

      print_log(function_name, function_operation, function_args, function_data)

      db_dialog_competitors[character] = Random(20) + 1 + modifier + db_mod_dlg_roll_fairness[character]

      function_operation = "assign"
      function_args = "db_dialog_competitors[%s]", character
      function_data = db_dialog_competitors[character]

      print_log(function_name, function_operation, function_args, function_data)
    end
  elseif method == "initiative" then
    function_operation = "iterate"
    function_args = "characters"
    function_data = dump_table(characters)

    print_log(function_name, function_operation, function_args, function_data)

    for character in elementIterator(characters) do
      function_operation = "GetAbility"
      function_args = "character, 'initiative'"
      function_data = character .. "," .. 'initiative'
      function_result = GetAbility(character, "Charisma")

      print_log(function_name, function_operation, function_args, function_data, function_result)

      local modifier = GetAbility(character, "initiative")

      modifier = (-10 + modifier) / 2

      function_operation = "assign"
      function_args = "modifier"
      function_data = modifier

      print_log(function_name, function_operation, function_args, function_data)

      function_operation = "random"
      function_args = "Random"
      function_data = 20

      print_log(function_name, function_operation, function_args, function_data)

      db_dialog_competitors[character] = Random(20) + 1 + modifier + db_mod_dlg_roll_fairness[character]

      function_operation = "assign"
      function_args = "db_dialog_competitors[%s]", character
      function_data = db_dialog_competitors[character]

      print_log(function_name, function_operation, function_args, function_data)
    end
  elseif method == "vanilla" then
    print("Why was this code reached???")
  end

  function_operation = "sort"
  function_args = "db_dialog_competitors"
  function_data = dump_table(db_dialog_competitors)

  print_log(function_name, function_operation, function_args, function_data)

  --Sort competitor table lowest to highest roll and pick the last entry as winner
  for character, roll_result in spairs(db_dialog_competitors, function(t, a, b) return t[b] > t[a] end) do
    roll_winner = character
  end

  function_operation = "return"
  function_args = "roll_winner"
  function_data = roll_winner

  print_log(function_name, function_operation, function_args, function_data)

  return roll_winner
end
