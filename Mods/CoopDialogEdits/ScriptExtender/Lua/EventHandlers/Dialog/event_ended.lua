Ext.Require("Calls/CharacterOperations/reattach.lua")

function dialog_ended(dialog_UUID, dialog_ID)
  if HasActiveStatus(GetHostCharacter(), "DialogPreferenceDisable") == 1 then
    return
  end

  --Return a re-assigned follower to their original owner
  --Filter out dialogs that do not involve the party
  local function_name = "dialog_ended"
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
    function_operation = "compare"
    function_args = "was_follower_reassigned == 1"
    function_data = was_follower_reassigned
    function_result = was_follower_reassigned == 1

    print_log(function_name, function_operation, function_args, function_data, function_result)

    if was_follower_reassigned == 1 then
      function_operation = "attach_follower"
      function_args = "userid_follower_attached, character_reassigned_follower_owner, character_reassigned_follower"
      function_data = userid_follower_attached ..
      "," .. character_reassigned_follower_owner .. "," .. character_reassigned_follower

      print_log(function_name, function_operation, function_args, function_data)

      attach_follower(userid_follower_attached, character_reassigned_follower_owner, character_reassigned_follower)
      was_follower_reassigned = 0

      function_operation = "assign"
      function_args = "was_follower_reassigned"
      function_data = 0

      print_log(function_name, function_operation, function_args, function_data)
    end

    --Re-attach a detached player character to their original user
    function_operation = "compare"
    function_args = "was_character_owner_reassigned == 1"
    function_data = was_character_owner_reassigned
    function_result = was_character_owner_reassigned == 1

    print_log(function_name, function_operation, function_args, function_data, function_result)

    if was_character_owner_reassigned == 1 then
      function_operation = "attach_character"
      function_args = "userid_dlg_reassigned_owner, character_dlg_owner_reassigned"
      function_data = userid_dlg_reassigned_owner .. "," .. character_dlg_owner_reassigned

      print_log(function_name, function_operation, function_args, function_data)

      attach_character(userid_dlg_reassigned_owner, character_dlg_owner_reassigned)

      was_character_owner_reassigned = 0

      function_operation = "assign"
      function_args = "was_character_owner_reassigned"
      function_data = 0

      print_log(function_name, function_operation, function_args, function_data)
    end

    function_operation = "cleanup"
    function_args = ""
    function_data = nil

    print_log(function_name, function_operation, function_args, function_data)

    cleanup()

    function_operation = "return"
    function_args = ""
    function_data = nil

    print_log(function_name, function_operation, function_args, function_data)

    return
  end
end

Ext.Utils.Print(string.format("[%s]: Dialog end event subscribed", mod_info.Name))
