function get_table(DB, ...)
	--TODO Fix this total mess
	tabledata = printTable(Osi.DB:Get(nil))
	print(tabledata)

	return
end

function dummyfunc(var1, var2)
	print(var1)
	print(var2)
end

function rawcomps()
    local char = Ext.GetCharacter(GetHostCharacter())

    print(_D(char:GetAllRawComponents()))
end