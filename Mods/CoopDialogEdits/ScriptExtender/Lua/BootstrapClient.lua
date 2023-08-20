mod_info = Ext.Utils.GetModInfo(ModuleUUID)
Ext.Utils.Print(string.format("[%s]: Dialog injector initializing. [%s]", mod_info.Name,
  Ext.IsClient() and "CLIENT" or "SERVER"))
Ext.Utils.Print(string.format("[%s]: Nothing to initialize. This is a server-sided mod, lol. [%s]", mod_info.Name,
  Ext.IsClient() and "CLIENT" or "SERVER"))
--Keeping it that way should technically not require BG3SE for clients
--if it weren't for mod hashing or whatever BG3 does.
