function split_string(str)
  local str_table = {}

  for word in string.gmatch(tostring(str), '([^,]+)') do
    table.insert(str_table, word)
  end
  return str_table
end

function print_log(event, operation, args, data, result)
  if not is_debug then
    return
  end

  Ext.Utils.Print(string.format("[%s]", event))

  if operation ~= nil then
    Ext.Utils.Print(string.format("   - Operation: %s", operation))
  end

  if args ~= nil then
    Ext.Utils.Print(string.format("       - Params: %s", args))
  end

  if data ~= nil then
    local metaresult_table = split_string(data)
    for entry in elementIterator(metaresult_table) do
      --TODO Properly determine type
      Ext.Utils.Print(string.format("           - data: [Type]: %s [data]: %s", type(entry), entry))
    end
  end
  if result ~= nil then
    local metaresult_table = split_string(result)
    for entry in elementIterator(metaresult_table) do
      Ext.Utils.Print(string.format("               - result: %s", result))
    end
  end
  Ext.Utils.Print(string.format("\n"))
end
