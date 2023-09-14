Ext.Require("Utils/runtime_vars.lua")
Ext.Require("Utils/logger.lua")
function get_mod_info()
  --May only work on  Devel se
  mod_info = Ext.Mod.GetMod("f1fedded-83d3-4895-817d-156c90221206").Info
end

if pcall(get_mod_info) then
  Ext.Utils.Print(string.format("[%s]: Dialog injector initializing. [%s]", mod_info.Name, Ext.IsClient() and "CLIENT" or "SERVER"))
else
  Ext.Utils.Print(string.format("Dialog injector initializing."))
end

Ext.Utils.Print(string.format("[%s]: Dialog injector initializing. [%s]", mod_info.Name,
  Ext.IsClient() and "CLIENT" or "SERVER"))
skip_register = false
if not skip_register then
  Ext.Require("EventHandlers/Dialog/event_request.lua")
  Ext.Require("EventHandlers/Dialog/event_started.lua")
  Ext.Require("EventHandlers/Dialog/event_ended.lua")
  Ext.Require("EventHandlers/Dialog/event_trade.lua")
  Ext.Require("EventHandlers/Game/event_save_loaded.lua")
  Ext.Require("EventHandlers/Game/event_status_applied.lua")

  Ext.Osiris.RegisterListener("SavegameLoaded", 0, "after", savegame_loaded)
  Ext.Osiris.RegisterListener("DialogStartRequested", 2, "before", dialog_requested)
  Ext.Osiris.RegisterListener("DialogStarted", 2, "before", dialog_started)
  Ext.Osiris.RegisterListener("DialogEnded", 2, "after", dialog_ended)
  --Automated dialogs are rather annoying
  Ext.Osiris.RegisterListener("AutomatedDialogStarted", 2, "before", automated_dialog_started)
  Ext.Osiris.RegisterListener("AutomatedDialogEnded", 2, "after", dialog_ended)
  Ext.Osiris.RegisterListener("RequestTrade", 4, "after", trade_request)

  Ext.Osiris.RegisterListener("StatusApplied", 4, "after", status_applied)
  Ext.Osiris.RegisterListener("StatusRemoved", 4, "after", status_removed)

  Ext.Utils.PrintWarning("All dialog scripts ready.")
  
end
--TODO check if BG3SE runs with some sort of debug flag.
--For now it's so debuggy that debugginess is hardcoded still.
is_debug = false

if is_debug then
  Ext.Require("Utils/custom_std.lua")
  Ext.Require("Utils/osiris_helper.lua")
  Ext.Require("EventHandlers/Game/message_boxes.lua")
  Ext.Osiris.RegisterListener("MessageBoxChoiceClosed", 3, "after", messagebox_closed)
  Ext.RegisterConsoleCommand("PrintTable", Ext.Dump)
  Ext.RegisterConsoleCommand("ElementIterator", elementIterator)
  Ext.RegisterConsoleCommand("SortedPairs", sorted_pairs)
  Ext.RegisterConsoleCommand("TableHasValue", has_value)
  Ext.RegisterConsoleCommand("PrintParty", list_party)
  Ext.RegisterConsoleCommand("StageParty", stage_party)
  Ext.Events.ResetCompleted:Subscribe(print("Test"))
  --Ext.Utils.GenerateIdeHelpers()
end




