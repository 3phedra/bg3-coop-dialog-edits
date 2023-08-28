function dump_log()
  Ext.Print("\nDialog ended with party data: \n")
  Ext.Dump(db_party_struct)

  Ext.Print("\nDialog ended with dialog method data: \n")
  Ext.Dump(db_dialog_methods)

  local log = Ext.IO.LoadFile("DialogEnd.log")
  --Ext.Dump probably isnt appropriate here, check bg3se for what to actually use
  log = log + Ext.Dump(db_party_struct) + Ext.Dump(db_dialog_methods)

  Ext.IO.SaveFile("DialogEnd.log", log)
end
