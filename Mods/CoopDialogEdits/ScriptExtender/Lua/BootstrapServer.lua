Ext.Require("Utils/runtime_vars.lua")
Ext.Require("Utils/osiris_helper.lua")

Ext.Require("EventHandlers/Dialog/event_request.lua")
Ext.Require("EventHandlers/Dialog/event_started.lua")
Ext.Require("EventHandlers/Dialog/event_ended.lua")

Ext.Osiris.RegisterListener("DialogStartRequested",2,"before", dialog_requested)
Ext.Osiris.RegisterListener("DialogStarted",2,"before",dialog_started)
Ext.Osiris.RegisterListener("AutomatedDialogStarted",2,"before",automated_dialog_started)
Ext.Osiris.RegisterListener("DialogEnded",2,"after",dialog_ended)
Ext.Osiris.RegisterListener("AutomatedDialogEnded",2,"after",dialog_ended)

Ext.Osiris.RegisterListener("MessageBoxChoiceClosed",2,"after",dummyfunc)

Ext.Utils.PrintWarning("Co-op dialog scripts ready.")

