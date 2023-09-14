Ext.Require("Queries/Party/populate_tables.lua")
Ext.Require("Calls/Spells/toggle_passives.lua")
function add_roll_toggles_to_characters()
  populate_onload()
  for character in elementIterator(db_party_struct["Camp"]) do
    register_passive_spells(character)
  end
  return
end

function remove_roll_toggles_from_characters(full_wipe)
  populate_onload()
  for character in elementIterator(db_party_struct["Camp"]) do
    deregister_passive_spells(character, full_wipe)
  end
  return
end

function status_applied(character, status_name, _, _)
  if status_name == "DialogMainToggle" then
    populate_onload()
    register_roll_toggle()

  elseif status_name == "DialogRollToggle" then
    populate_onload()
    --register_passive_spells(character)
    Ext.Utils.PrintError("Random Dialog rolling is currently broken! Larian changed stuff >:C")
  end
end

function status_removed(character, status_name, _, _)
  if status_name == "DialogMainToggle" then
    populate_onload()
    remove_roll_toggles_from_characters(true)
  elseif status_name == "DialogRollToggle" then
    populate_onload()
    deregister_passive_spells(character, false)
  end
end

Ext.Utils.Print(string.format("[%s]: Savegame load event subscribed", mod_info.Name))
