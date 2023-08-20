Ext.Require("Queries/UI/notify.lua")

function dialog_started(dialog_UUID, dialog_ID)
  if HasActiveStatus(GetHostCharacter(), "DialogPreferenceDisable") == 1 then
    return
  end

  local function_name = "dialog_started"
  local function_operation = "triggered"
  local function_args = "dialog_UUID, dialog_ID"
  local function_data = dialog_UUID .. "," .. dialog_ID

  print_log(function_name, function_operation, function_args, function_data)

  local character_distance_to_dialog
  --Get character that triggered dialog event

  function_operation = "compare"
  function_args = "DialogGetInvolvedPlayer(dialog_ID, 1) ~= nil"
  function_data = dialog_ID .. "," .. DialogGetInvolvedPlayer(dialog_ID, 1)
  function_result = DialogGetInvolvedPlayer(dialog_ID, 1) ~= nil

  print_log(function_name, function_operation, function_args, function_data, function_result)

  --Filter out dialogs that do not involve the party
  if DialogGetInvolvedPlayer(dialog_ID, 1) ~= nil then
    local dialog_owner = DialogGetInvolvedPlayer(dialog_ID, 1)

    function_operation = "assign"
    function_args = "dialog_owner"
    function_data = dialog_owner

    print_log(function_name, function_operation, function_args, function_data)

    --if not check_if_target_is_vendor(dialog_target) and not check_if_target_is_special(dialog_target) then
    --Add all party characters to triggered dialog

    function_operation = "iterate"
    function_args = "db_party_all"
    function_data = dump_table(db_party_all)

    print_log(function_name, function_operation, function_args, function_data)

    for character in elementIterator(db_party_all) do
      --Check if character about to be added to dialog isn't in another dialog
      function_operation = "compare"
      function_args = "select(2, SpeakerGetDialog(character, 1)) == nil"
      function_data = character .. "," .. tostring(select(2, SpeakerGetDialog(character, 1)))
      function_result = select(2, SpeakerGetDialog(character, 1)) == nil

      print_log(function_name, function_operation, function_args, function_data, function_result)

      if select(2, SpeakerGetDialog(character, 1)) == nil then
        function_operation = "GetDistanceTo"
        function_args = "dialog_owner, character"
        function_data = dialog_owner .. "," .. character
        function_result = GetDistanceTo(dialog_owner, character)

        print_log(function_name, function_operation, function_args, function_data)

        character_distance_to_dialog = GetDistanceTo(dialog_owner, character)

        function_operation = "assign"
        function_args = "character_distance_to_dialog"
        function_data = character_distance_to_dialog

        print_log(function_name, function_operation, function_args, function_data)

        function_operation = "DialogAddActor"
        function_args = "dialog_ID, character"
        function_data = dialog_ID .. "," .. character

        print_log(function_name, function_operation, function_args, function_data)

        DialogAddActor(dialog_ID, character)

        --Osi.PROC_DialogAddSpeakingActor(dialog_ID, character)
      end
    end

    --TODO check if dialog was with a follower, if so do not notify
    function_operation = "compare"
    function_args = "is_automated_dialog ~= 1"
    function_data = is_automated_dialog
    function_result = is_automated_dialog ~= 1

    print_log(function_name, function_operation, function_args, function_data, function_result)

    if is_automated_dialog ~= 1 then
      function_operation = "notify_roll_result"
      function_args = nil
      function_data = nil

      print_log(function_name, function_operation, function_args, function_data)

      -- notify_roll_result()
    end
  end

  function_operation = "return"
  function_args = nil
  function_data = nil

  print_log(function_name, function_operation, function_args, function_data)

  endTime = Ext.Utils.MonotonicTime()
  print("Dialog injection took: " .. tostring(endTime - startTime) .. " ms")

  return
end

function automated_dialog_started(dialog_UUID, dialog_ID)
  if HasActiveStatus(GetHostCharacter(), "DialogPreferenceDisable") == 1 then
    return
  end
  --TODO implement this
  local function_name = "automated_dialog_started"
  local function_operation = "triggered"
  local function_args = "dialog_UUID, dialog_ID"
  local function_data = dialog_UUID .. "," .. dialog_ID

  print_log(function_name, function_operation, function_args, function_data)

  function_operation = "compare"
  function_args = "DialogGetInvolvedPlayer(dialog_ID, 1) ~= nil"
  function_data = dialog_ID .. "," .. DialogGetInvolvedPlayer(dialog_ID, 1)
  function_result = DialogGetInvolvedPlayer(dialog_ID, 1) ~= nil

  print_log(function_name, function_operation, function_args, function_data, function_result)

  if DialogGetInvolvedPlayer(dialog_ID, 1) ~= nil then
    is_automated_dialog = 1

    function_operation = "assign"
    function_args = "is_automated_dialog"
    function_data = 1

    print_log(function_name, function_operation, function_args, function_data)

    function_operation = "iterate"
    function_args = "Osi.DB_Players:Get(nil)"
    function_data = dump_table(Osi.DB_Players:Get(nil))

    print_log(function_name, function_operation, function_args, function_data)

    --dialog_requested event is skipped in automated dialogs, but we need a party db
    for _, entry in pairs(Osi.DB_Players:Get(nil)) do
      table.insert(db_party_all, entry[1])

      function_operation = "assign"
      function_args = "db_party_all"
      function_data = entry[1]

      print_log(function_name, function_operation, function_args, function_data)

      function_operation = "compare"
      function_args = "IsControlled(%s) == 1", entry[1]
      function_data = entry[1]
      function_result = IsControlled(entry[1]) == 1

      print_log(function_name, function_operation, function_args, function_data, function_result)

      if IsControlled(entry[1]) == 1 then
        table.insert(db_party_players, entry[1])

        function_operation = "assign"
        function_args = "db_party_players"
        function_data = entry[1]

        print_log(function_name, function_operation, function_args, function_data)

        db_userids[GetReservedUserID(entry[1])] = entry[1]

        function_operation = "assign"
        function_args = "db_userids[%s]", GetReservedUserID(entry[1])
        function_data = entry[1]

        print_log(function_name, function_operation, function_args, function_data)
      end
    end

    function_operation = "dialog_started"
    function_args = "dialog_UUID, dialog_ID"
    function_data = dialog_UUID .. "," .. dialog_ID

    print_log(function_name, function_operation, function_args, function_data)

    dialog_started(dialog_UUID, dialog_ID)

    function_operation = "return"
    function_args = nil
    function_data = tostring(Ext.Utils.MonotonicTime() - startTime) .. "ms"

    print_log(function_name, function_operation, function_args, function_data)

    return
  end
end

Ext.Utils.Print(string.format("[%s]: Dialog start event subscribed", mod_info.Name))
Ext.Utils.Print(string.format("[%s]: Automated dialog start event subscribed", mod_info.Name))
