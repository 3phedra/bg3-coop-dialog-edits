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
  local event_name = "dialog_requested"
  local event_state = ""
  local event_operation = ""
  local event_args = nil
  local event_data = nil


  if IsSpellActive(GetHostCharacter(), "DialogPreferenceDisable") == 1 then
    Ext.Utils.PrintWarning(string.format("[%s][%s]: Dialog requested, but mod disabled ingame.", mod_info.Name,
      event_state))
    return
  end

  event_state = "initialize"
  event_operation = "populate_dialog_metadata"
  event_args = character_target .. ", " .. character_source
  event_data = "..."

  print_log(event_name, event_state, event_operation, event_args, event_data)

  populate_dialog_metadata(character_target, character_source)



  --Check if workaround needed for target character in case they're a follower currently in party
  if userid_dlg_targetowner ~= userid_dlg_owner and not has_value(db_party_players, character_dlg_target) and has_value(db_party_all, character_dlg_target) then
    --Temporarily re-assign party follower to dialog requester to facilitate dialog
    userid_follower_attached = userid_dlg_targetowner
    character_follower_attached = db_userids[userid_dlg_targetowner]

    event_state = "target_in_party"
    event_operation = "reassign_follower"
    event_args = character_target .. ", " .. character_source
    event_data = "..."

    print_log(event_name, event_state, event_operation, event_args, event_data)

    reassign_follower(userid_dlg_owner, userid_dlg_targetowner, character_dlg_target)

    was_follower_reassigned = 1

  end

  --Check if any passives are toggled for dialog ownership rolling and if so, roll the owner
  if check_reassignment_requested(character_dlg_target, character_dlg_owner) then
    --Check if dialog target isn't a vendor or otherwise special (maybe companions?), as that would be annoying
    if not check_if_target_is_vendor(character_dlg_target) and not check_if_target_is_special(character_dlg_target) then

      event_state = "check_reassignment_requested"
      event_operation = "determine_dialog_winner"
      event_args = dump_table_inline(db_party_players) .. ", " .. character_source
      event_data = "..."
  
      print_log(event_name, event_state, event_operation, event_args, event_data)

      character_dlg_new = determine_dialog_winner(db_party_players, character_source)

      --If dialog roll winner is not the character who started the dialog, detach dialog starter and re-initiate dialog for the winner
      if character_dlg_new ~= character_dlg_owner then

        event_state = "check_reassignment_requested"
        event_operation = "detach_character"
        event_args = userid_dlg_owner .. ", " .. character_dlg_owner
        event_data = "..."
    
        print_log(event_name, event_state, event_operation, event_args, event_data)

        detach_character(userid_dlg_owner, character_dlg_owner)

        event_state = "check_reassignment_requested"
        event_operation = "manual_restart_dialog"
        event_args = character_dlg_new .. ", " .. character_dlg_target
        event_data = "..."
    
        print_log(event_name, event_state, event_operation, event_args, event_data)

        manual_restart_dialog(character_dlg_new, character_dlg_target)

      end

      --TODO if check_if_target_is_special() returns true, dialog with target will become impossible. Fix it below.
    elseif not check_if_target_is_vendor(character_target) and check_if_target_is_special(character_target) then
      --TODO target is special. Move logic here.

      event_state = "check_if_target_is_special"
      event_operation = "unimplemented"
      event_args = character_target
      event_data = nil
    
      print_log(event_name, event_state, event_operation, event_args, event_data)

      OpenMessageBox(character_source,
        "DEBUG: This dialog is determined to be special, but handling is not implemented. Proceding without rolls.")
    else
      print("Target appears to be a vendor (dafuq??)")
    end
  end

  event_state = "finished"
  event_operation = "return"
  event_args = "Success"
  event_data = true

  print_log(event_name, event_state, event_operation, event_args, event_data)

  return
end

Ext.Utils.Print(string.format("[%s]: Dialog request event subscribed", mod_info.Name))
