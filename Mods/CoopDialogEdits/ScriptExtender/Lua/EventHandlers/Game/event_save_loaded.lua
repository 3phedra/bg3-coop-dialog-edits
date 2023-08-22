Ext.Require("Queries/Party/populate_tables.lua")
Ext.Require("Calls/Spells/add_passives.lua")
function savegame_loaded()
  populate_onload()
  for character in elementIterator(db_party_struct["Camp"]) do
    register_passive_spell(character)
  end
  return
end
Ext.Utils.Print(string.format("[%s]: Savegame load event subscribed", mod_info.Name))
