Ext.Require("Calls/CharacterOperations/reassign.lua")
Ext.Require("Calls/CharacterOperations/detach.lua")

Ext.Require("Calls/Randomizer/rollmethods.lua")
Ext.Require("Calls/Randomizer/getwinner.lua")

Ext.Require("Calls/Dialog/manual_dialog.lua")

Ext.Require("Queries/Dialog/check_target.lua")
Ext.Require("Queries/Party/populate_tables.lua")

Ext.Require("Utils/custom_std.lua")

--## Osiris event handlers
function dialog_requested(character_target, character_source)
  if HasActiveStatus(GetHostCharacter(), "DialogPreferenceDisable") == 1 then
    return
  end

  local function_name = "dialog_requested"
  local function_operation = "triggered"
  local function_args = "character_target, character_source"
  local function_data = character_target .. "," .. character_source

  print_log(function_name, function_operation, function_args, function_data)

  function_operation = "compare"
  function_args = "HasActiveStatus(GetHostCharacter(), 'DialogPreferenceDisable') == 1"
  function_data = GetHostCharacter() .. "," .. "DialogPreferenceDisable"
  function_result = HasActiveStatus(GetHostCharacter(), "DialogPreferenceDisable") == 1

  print_log(function_name, function_operation, function_args, function_data, function_result)

  if HasActiveStatus(GetHostCharacter(), "DialogPreferenceDisable") == 1 then
    Ext.Utils.PrintWarning(string.format("[%s][%s]: Dialog requested, but mod disabled ingame.", mod_info.Name,
      function_state))
    return
  end

  function_operation = "populate_dialog_metadata"
  function_args = "character_target, character_source"
  function_data = character_target .. "," .. character_source

  print_log(function_name, function_operation, function_args, function_data)

  populate_dialog_metadata(character_target, character_source)

  function_operation = "compare"
  function_args =
  "userid_dlg_targetowner ~= userid_dlg_owner and not has_value(db_party_players, character_dlg_target) and has_value(db_party_all, character_dlg_target)"
  function_data = userid_dlg_targetowner ..
  "," ..
  userid_dlg_owner ..
  "," .. character_dlg_target .. "," .. dump_table(db_party_players) .. "," .. dump_table(db_party_all)
  function_result = userid_dlg_targetowner ~= userid_dlg_owner and not has_value(db_party_players, character_dlg_target) and
  has_value(db_party_all, character_dlg_target)

  print_log(function_name, function_operation, function_args, function_data, function_result)

  --Check if workaround needed for target character in case they're a follower currently in party
  if userid_dlg_targetowner ~= userid_dlg_owner and not has_value(db_party_players, character_dlg_target) and has_value(db_party_all, character_dlg_target) then
    --Temporarily re-assign party follower to dialog requester to facilitate dialog
    userid_follower_attached = userid_dlg_targetowner

    function_operation = "assign"
    function_args = "userid_follower_attached"
    function_data = userid_dlg_targetowner

    print_log(function_name, function_operation, function_args, function_data)

    character_follower_attached = db_userids[userid_dlg_targetowner]

    function_operation = "assign"
    function_args = "character_follower_attached"
    function_data = db_userids[userid_dlg_targetowner]

    print_log(function_name, function_operation, function_args, function_data)

    function_operation = "reassign_follower"
    function_args = "userid_dlg_owner, userid_dlg_targetowner, character_dlg_target"
    function_data = userid_dlg_owner .. "," .. userid_dlg_targetowner .. "," .. character_dlg_target

    print_log(function_name, function_operation, function_args, function_data)

    reassign_follower(userid_dlg_owner, userid_dlg_targetowner, character_dlg_target)

    was_follower_reassigned = 1

    function_operation = "assign"
    function_args = "was_follower_reassigned"
    function_data = 1

    print_log(function_name, function_operation, function_args, function_data)
  end

  function_operation = "check_reassignment_requested"
  function_args = "character_dlg_target, character_dlg_owner"
  function_data = character_dlg_target .. "," .. character_dlg_owner

  print_log(function_name, function_operation, function_args, function_data)

  function_operation = "compare"
  function_args = "check_reassignment_requested(character_dlg_target, character_dlg_owner)"
  function_data = character_dlg_target .. "," .. character_dlg_owner
  function_result = check_reassignment_requested(character_dlg_target, character_dlg_owner)

  print_log(function_name, function_operation, function_args, function_data, function_result)

  --Check if any passives are toggled for dialog ownership rolling and if so, roll the owner
  if check_reassignment_requested(character_dlg_target, character_dlg_owner) then
    --Check if dialog target isn't a vendor or otherwise special (maybe companions?), as that would be annoying
    function_operation = "check_if_target_is_vendor"
    function_args = "character_dlg_target"
    function_data = character_dlg_target

    print_log(function_name, function_operation, function_args, function_data)

    function_operation = "check_if_target_is_special"
    function_args = "character_dlg_target"
    function_data = character_dlg_target

    print_log(function_name, function_operation, function_args, function_data)

    function_operation = "compare"
    function_args =
    "check_if_target_is_vendor(character_dlg_target) and not check_if_target_is_special(character_dlg_target)"
    function_data = character_dlg_target
    function_result = check_if_target_is_vendor(character_dlg_target) and
    not check_if_target_is_special(character_dlg_target)

    print_log(function_name, function_operation, function_args, function_data, function_result)

    if not check_if_target_is_vendor(character_dlg_target) and not check_if_target_is_special(character_dlg_target) then
      function_operation = "determine_dialog_winner"
      function_args = "db_party_players, character_source"
      function_data = dump_table_inline(db_party_players) .. "," .. character_source

      print_log(function_name, function_operation, function_args, function_data)

      character_dlg_new = determine_dialog_winner(db_party_players, character_source)

      function_operation = "assign"
      function_args = "character_dlg_new"
      function_data = character_dlg_new

      print_log(function_name, function_operation, function_args, function_data)

      --If dialog roll winner is not the character who started the dialog, detach dialog starter and re-initiate dialog for the winner

      function_operation = "compare"
      function_args = "character_dlg_new ~= character_dlg_owner"
      function_data = character_dlg_new .. "," .. character_dlg_owner
      function_result = character_dlg_new ~= character_dlg_owner

      print_log(function_name, function_operation, function_args, function_data, function_result)

      if character_dlg_new ~= character_dlg_owner then
        function_operation = "detach_character"
        function_args = "userid_dlg_owner, character_dlg_owner"
        function_data = userid_dlg_owner .. "," .. character_dlg_owner

        print_log(function_name, function_operation, function_args, function_data)

        detach_character(userid_dlg_owner, character_dlg_owner)

        function_operation = "manual_restart_dialog"
        function_args = "character_dlg_new, character_dlg_target"
        function_data = character_dlg_new .. "," .. character_dlg_target

        print_log(function_name, function_operation, function_args, function_data)

        manual_restart_dialog(character_dlg_new, character_dlg_target)
      end

      --TODO if check_if_target_is_special() returns true, dialog with target will become impossible. Fix it below.
    elseif not check_if_target_is_vendor(character_target) and check_if_target_is_special(character_target) then
      --TODO target is special. Move logic here.

      print_log(function_name, function_state, function_operation, function_args, function_data)

      OpenMessageBox(character_source,
        "DEBUG: This dialog is determined to be special, but handling is not implemented. Proceding without rolls.")
    else
      print("Target appears to be a vendor (dafuq??)")
    end
  end

  function_operation = "return"
  function_args = nil
  function_data = nil

  print_log(function_name, function_operation, function_args, function_data)

  return
end

Ext.Utils.Print(string.format("[%s]: Dialog request event subscribed", mod_info.Name))
