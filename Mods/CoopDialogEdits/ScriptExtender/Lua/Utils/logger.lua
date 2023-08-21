function split_string(str)
  local str_table = {}
  for word in string.gmatch(tostring(str), '([^,]+)') do
    table.insert(str_table, word)
  end
  return str_table
end
function write_log(log)
  --TODO make this work properly
  --Ext.IO.SaveFile("test.txt", dump_table(log))
  return
end
function log_formatter(event, operation, args, data, result)
  event = string.format("[%s]", tostring(event))
  operation = string.format("   - Operation: %s", tostring(operation))
  args = string.format("       - Params: %s", tostring(args))
  local datatable = {}
  local resulttable = {}
  local data_table = split_string(data)
  for entry in elementIterator(data_table) do
    table.insert(datatable, string.format("           - data: [Type]: %s [data]: %s", type(entry), entry))
  end
  local result_table = split_string(result)
  for entry in elementIterator(result_table) do
    table.insert(resulttable, string.format("               - result: %s", entry))
  end
  local log_table = {}
  log_table["event"] = event
  log_table["operation"] = operation
  log_table["args"] = args
  log_table["data"] = datatable
  log_table["result"] = resulttable
  return log_table
end
function print_log(event, operation, args, data, result)
  if is_debug then
    local logdata = log_formatter(event, operation, args, data, result)
    Ext.Utils.Print(logdata["event"])
    Ext.Utils.Print(logdata["operation"])
    Ext.Utils.Print(logdata["args"])
    for data in elementIterator(logdata["data"]) do
      Ext.Utils.Print(data)
    end
    for result in elementIterator(logdata["result"]) do
      Ext.Utils.Print(result)
    end
    write_log(logdata)
  end
  return
end
