Ext.Require("Calls/CharacterOperations/character_reassignments.lua")
Ext.Require("Calls/Randomizer/rollmethods.lua")
Ext.Require("Calls/Randomizer/getwinner.lua")
Ext.Require("Calls/Dialog/manual_dialog.lua")
Ext.Require("Queries/Dialog/check_target.lua")
Ext.Require("Queries/Party/populate_tables.lua")
Ext.Require("Utils/custom_std.lua")
--## Osiris event handlers
function dialog_requested(character_target, character_source)
  startTime = Ext.Utils.MonotonicTime()
  if HasActiveStatus(GetHostCharacter(), "DialogPreferenceDisable") == 1 then
    return
  end
  populate_dialog_metadata(character_target, character_source)
  --Check if workaround needed for target character in case they're a follower currently in party
  if db_party_struct[character_target]["UserID"] ~= db_party_struct[character_source]["UserID"] and not db_party_struct[character_target]["IsPlayer"] and db_party_struct[character_target] ~= nil then
    --Temporarily re-assign party follower to dialog requester to facilitate dialog
    reassign_follower(db_party_struct[character_source]["UserID"], character_target)
  end
  --Check if any passives are toggled for dialog ownership rolling and if so, roll the owner
  if check_reassignment_requested(character_target, character_source) then
    --Check if dialog target isn't a vendor or otherwise special (maybe companions?), as that would be annoying
    if not check_if_target_is_vendor(character_target) and not check_if_target_is_special(character_target) then
      db_party_struct["DialogOwner"] = determine_dialog_winner(db_party_struct["PlayerCharacters"], character_source)
      --If dialog roll winner is not the character who started the dialog, detach dialog starter and re-initiate dialog for the winner
      if db_party_struct["DialogOwner"] ~= character_source then
        detach_character(character_source)
        manual_restart_dialog(db_party_struct["DialogOwner"], character_target)
      end
      --TODO if check_if_target_is_special() returns true, dialog with target will become impossible. Fix it below.
    elseif not check_if_target_is_vendor(character_target) and check_if_target_is_special(character_target) then
      --TODO target is special. Move logic here.
      OpenMessageBox(character_source,
        "DEBUG: This dialog is determined to be special, but handling is not implemented. Proceding without rolls.")
    else
      print("Target appears to be a vendor (dafuq??)")
    end
  end
  return
end
Ext.Utils.Print(string.format("[%s]: Dialog request event subscribed", mod_info.Name))
