Ext.Require("Utils/runtime_vars.lua")

Ext.Require("EventHandlers/Dialog/event_request.lua")
Ext.Require("EventHandlers/Dialog/event_started.lua")
Ext.Require("EventHandlers/Dialog/event_ended.lua")

Ext.Osiris.RegisterListener("DialogStartRequested", 2, "before", dialog_requested)
Ext.Osiris.RegisterListener("DialogStarted", 2, "before", dialog_started)
Ext.Osiris.RegisterListener("AutomatedDialogStarted", 2, "before", automated_dialog_started)
Ext.Osiris.RegisterListener("DialogEnded", 2, "after", dialog_ended)
Ext.Osiris.RegisterListener("AutomatedDialogEnded", 2, "after", dialog_ended)

Ext.Utils.PrintWarning("Dialog scripts ready.")

--TODO check if BG3SE runs with some sort of debug flag.
--For now it's so debuggy that debugginess is hardcoded still.
local is_debug = true

if debug then
  Ext.Require("Utils/custom_std.lua")
  Ext.Require("Utils/osiris_helper.lua")
  Ext.Osiris.RegisterListener("MessageBoxChoiceClosed", 2, "after", dummyfunc)

  Ext.RegisterConsoleCommand("PrintTable", printTable)
  Ext.RegisterConsoleCommand("ElementIterator", elementIterator)
  Ext.RegisterConsoleCommand("SortedPairs", sorted_pairs)
  Ext.RegisterConsoleCommand("TableHasValue", has_value)
  Ext.RegisterConsoleCommand("PrintParty", list_party)
  Ext.RegisterConsoleCommand("StageParty", stage_party)
  Ext.RegisterConsoleCommand("RollWinners", roll_stats)
  Ext.RegisterConsoleCommand("GetDialogs", query_dialogs)
  --Scope creep
  Ext.RegisterConsoleCommand("TheCommonBugFixer", fix_bug)
end
