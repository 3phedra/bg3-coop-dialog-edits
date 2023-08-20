function populate_dialog_metadata(character_target, character_source)
  local function_name = "populate_dialog_metadata"
  local function_operation = "called"
  local function_args = "character_source, character_target"
  local function_data = character_source .. "," .. character_target

  print_log(function_name, function_operation, function_args, function_data)

  --Add all and controlled party members respectively

  --TODO db_party_all can be expanded to contain UserID, IsControlled, Region and Distance data
  --but probably not much performance to be gained.

  --If distance preference is toggled, populate dbs only with characters within earshot

  function_operation = "compare"
  function_args = "HasActiveStatus(GetHostCharacter(), 'DialogPreferenceDistance') ~= 1"
  function_data = GetHostCharacter() .. "," .. "DialogPreferenceDistance"
  function_result = HasActiveStatus(GetHostCharacter(), "DialogPreferenceDistance") ~= 1

  print_log(function_name, function_operation, function_args, function_data, function_result)

  if HasActiveStatus(GetHostCharacter(), "DialogPreferenceDistance") ~= 1 then
    function_operation = "iterate"
    function_args = "Osi.DB_Players:Get(nil)"
    function_data = dump_table(Osi.DB_Players:Get(nil))

    print_log(function_name, function_operation, function_args, function_data)

    for _, character in pairs(Osi.DB_Players:Get(nil)) do
      table.insert(db_party_all, character[1])

      function_operation = "assign"
      function_args = "db_party_all"
      function_data = character[1]

      print_log(function_name, function_operation, function_args, function_data)

      function_operation = "compare"
      function_args = "IsControlled(%s) == 1", character[1]
      function_data = character[1]
      function_result = IsControlled(character[1]) == 1

      print_log(function_name, function_operation, function_args, function_data, function_result)

      if IsControlled(character[1]) == 1 then
        table.insert(db_party_players, character[1])

        function_operation = "assign"
        function_args = "db_party_players"
        function_data = character[1]

        print_log(function_name, function_operation, function_args, function_data)

        db_userids[GetReservedUserID(character[1])] = character[1]

        function_operation = "assign"
        function_args = "db_userids[%s]", GetReservedUserID(character[1])
        function_data = character[1]

        print_log(function_name, function_operation, function_args, function_data)
      end
    end
  else
    function_operation = "iterate"
    function_args = "Osi.DB_Players:Get(nil)"
    function_data = dump_table(Osi.DB_Players:Get(nil))

    print_log(function_name, function_operation, function_args, function_data)

    for _, character in pairs(Osi.DB_Players:Get(nil)) do
      function_operation = "compare"
      function_args =
      "GetDistanceTo(character_target, character[1]) <= 35.0 and GetRegion(character[1]) == GetRegion(character_source)"
      function_data = character_target ..
      "," ..
      character[1] ..
      "," ..
      GetDistanceTo(character_target, character[1]) ..
      "," .. GetRegion(character[1]) .. "," .. GetRegion(character_source)
      function_result = GetDistanceTo(character_target, character[1]) <= 35.0 and
      GetRegion(character[1]) == GetRegion(character_source)

      print_log(function_name, function_operation, function_args, function_data, function_result)

      if GetDistanceTo(character_target, character[1]) <= 35.0 and GetRegion(character[1]) == GetRegion(character_source) then
        table.insert(db_party_all, character[1])

        function_operation = "assign"
        function_args = "db_party_all"
        function_data = character[1]

        print_log(function_name, function_operation, function_args, function_data)

        function_operation = "compare"
        function_args = "IsControlled(%s) == 1", character[1]
        function_data = character[1]
        function_result = IsControlled(character[1]) == 1

        print_log(function_name, function_operation, function_args, function_data, function_result)

        if IsControlled(character[1]) == 1 then
          table.insert(db_party_players, character[1])

          function_operation = "assign"
          function_args = "db_party_players"
          function_data = character[1]

          print_log(function_name, function_operation, function_args, function_data)

          db_userids[GetReservedUserID(character[1])] = character[1]

          function_operation = "assign"
          function_args = "db_userids[%s]", GetReservedUserID(character[1])
          function_data = character[1]

          print_log(function_name, function_operation, function_args, function_data)
        end
      end
    end
  end

  function_operation = "iterate"
  function_args = "Osi.DB_PartOfTheTeam:Get(nil))"
  function_data = dump_table(Osi.DB_PartOfTheTeam:Get(nil))

  print_log(function_name, function_operation, function_args, function_data)
  --Add all camp followers to a table
  for _, entry in pairs(Osi.DB_PartOfTheTeam:Get(nil)) do
    table.insert(db_camp_characters, entry[1])

    function_operation = "assign"
    function_args = "db_camp_characters"
    function_data = entry[1]

    print_log(function_name, function_operation, function_args, function_data)
  end

  function_operation = "GetRegion"
  function_args = "character_target"
  function_data = character_target

  print_log(function_name, function_operation, function_args, function_data)

  region_dlg = GetRegion(character_target)

  function_operation = "assign"
  function_args = "region_dlg"
  function_data = region_dlg

  print_log(function_name, function_operation, function_args, function_data)

  --TODO check what this even returns and if something better than "camp" can be used

  function_operation = "compare"
  function_args = "string.find(region_dlg, 'camp')"
  function_data = region_dlg .. "," .. "camp"
  function_result = string.find(region_dlg, "camp")

  print_log(function_name, function_operation, function_args, function_data, function_result)

  if string.find(region_dlg, "camp") then
    --Take into consideration whether the dialog region is the camp area
    is_region_camp = 1

    function_operation = "assign"
    function_args = "is_region_camp"
    function_data = 1

    print_log(function_name, function_operation, function_args, function_data)
  end


  --Store dialog starter character UserID
  userid_dlg_owner = GetReservedUserID(character_source)

  function_operation = "assign"
  function_args = "userid_dlg_owner"
  function_data = userid_dlg_owner

  print_log(function_name, function_operation, function_args, function_data)

  character_dlg_owner = character_source

  function_operation = "assign"
  function_args = "character_dlg_owner"
  function_data = character_dlg_owner

  print_log(function_name, function_operation, function_args, function_data)

  --Store dialog target character UserID
  userid_dlg_targetowner = GetReservedUserID(character_target)

  function_operation = "assign"
  function_args = "userid_dlg_targetowner"
  function_data = userid_dlg_targetowner

  print_log(function_name, function_operation, function_args, function_data)

  character_dlg_target = character_target

  function_operation = "assign"
  function_args = "character_dlg_target"
  function_data = character_dlg_target

  print_log(function_name, function_operation, function_args, function_data)

  function_operation = "return"
  function_args = nil
  function_data = nil

  print_log(function_name, function_operation, function_args, function_data)

  return
end
