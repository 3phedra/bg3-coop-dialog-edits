function dump_log()
  Ext.Utils.Print("\nDialog ended with party data:")
  Ext.Dump(db_party_struct)
  Ext.Utils.Print("\nDialog ended with dialog data:")
  Ext.Dump(db_dialog_struct)
  Ext.Utils.Print("\nDialog ended with dialog method data:")
  Ext.Dump(db_dialog_methods)
  Ext.Utils.Print("\nDialog ended with dialog persist data:")
  Ext.Dump(db_dialog_persist)
  --local log = Ext.IO.LoadFile("DialogEnd.log")
  --Ext.Dump probably isnt appropriate here, check bg3se for what to actually use
  --local log = Ext.Dump(db_party_struct) + Ext.Dump(db_dialog_struct) + Ext.Dump(db_dialog_methods) + Ext.Dump(db_dialog_persist)
  --Ext.IO.SaveFile("DialogEnd.log", log)
end
