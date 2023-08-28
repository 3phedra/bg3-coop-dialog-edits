function get_table(DB, ...)
  --TODO Fix this total mess
  tabledata = Ext.Dump(Osi.DB:Get(nil))
  print(tabledata)
  return
end
function rawcomps()
  local char = Ext.GetCharacter(GetHostCharacter())
  --Crashes. Dont do it :D
  print(_D(char:GetAllRawComponents()))
  return
end
function list_party()
  print(Ext.Dump(Osi.DB_Players:Get(nil)))
  return "test?"
end
function stage_party()
  Ext.Utils.PrintWarning("Dun goofed, have we?")
  for _, character in pairs(Osi.DB_Players:Get(nil)) do SetOnStage(character[1], 1) end
  return
end