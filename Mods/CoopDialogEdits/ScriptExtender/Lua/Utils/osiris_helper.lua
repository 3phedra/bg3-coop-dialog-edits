function get_table(DB, ...)
	--TODO Fix this total mess
	tabledata = printTable(Osi.DB:Get(nil))
	print(tabledata)

	return
end

function dummyfunc(var1, var2)
	print(var1)
	print(var2)
	return
end

function rawcomps()
	local char = Ext.GetCharacter(GetHostCharacter())
	--Crashes. Dont do it :D
	print(_D(char:GetAllRawComponents()))
	return
end

function list_party()
	print(printTable(Osi.DB_Players:Get(nil)))
	return
end

function stage_party()
	Ext.Utils.PrintWarning("Dun goofed, have we?")
	for _, character in pairs(Osi.DB_Players:Get(nil)) do SetOnStage(character[1], 1) end
	return
end

function roll_stats()
	Ext.Utils.PrintWarning("\nRoll stats:")
	print(printTable(db_count_dlg_roll_winner))
	Ext.Utils.PrintWarning("\nCurrent fairness mods:")
	print(printTable(db_mod_dlg_roll_fairness))
	return
end

function query_dialogs(target)
	--TODO still have to find out how to get special character based dialogs
	Ext.Utils.PrintWarning("Singular dialog entries:")
	print(printTable(Osi.DB_Dialogs:Get(target, nil)))
	Ext.Utils.PrintWarning("Two dialog entries:")
	print(printTable(Osi.DB_Dialogs:Get(target, nil, nil)))
	Ext.Utils.PrintWarning("Three dialog entries:")
	print(printTable(Osi.DB_Dialogs:Get(target, nil, nil, nil)))
end

function bug_fixer(bug)
	--TODO use BG3SE's JSON for this. I suck at lua. Or maybe it works?
	--bug_db = {1 = {"Stuck unstaged", stage_party}, 2 = {"Dummy", dummyfunc}}
	bug_db = {}
	if bug == nil then
		Ext.Utils.PrintWarning("Bug DB contains:")
		print(printTable(b))
	else
		bug_db[bug][2]()
	end
	return
end
