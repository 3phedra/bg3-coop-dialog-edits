Ext.Require("Queries/Party/populate_tables.lua")
Ext.Require("Calls/Spells/toggle_passives.lua")
function savegame_loaded()
  populate_onload()
  for character in elementIterator(db_party_struct["Camp"]) do
    register_main_toggle(character)
  end
  if HasActiveStatus(GetHostCharacter(), "DialogMainToggle") == 1 then
      register_roll_toggle()
  end
  return
end
Ext.Utils.Print(string.format("[%s]: Savegame load event subscribed", mod_info.Name))
