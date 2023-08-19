function split_string(str)
  local str_table = {}

  for word in string.gmatch(str, '([^,]+)') do
    table.insert(str_table, word)
  end
  return str_table
end

function print_log(event, state, operation, args, data)

  if not is_debug then
    return
  end

  if not event == nil then
    assemble_table(event, state, operation, args, data)
  end


  Ext.Utils.Print(string.format("[%s] [%s]", event, state))
  Ext.Utils.Print(string.format("   - Operation: %s()", operation))
  Ext.Utils.Print(string.format("       - Args: (%s)", args))
  if args ~= nil then
    local metadata_table = split_string(args)
    for entry in elementIterator(metadata_table) do
      --TODO Properly determine type
      Ext.Utils.Print(string.format("           - Metadata: [Type]: %s [Target]: %s", type(entry), entry))
    end
  end
  if data ~= nil then
    Ext.Utils.Print(string.format("               - Data: %s", data))
  end
  Ext.Utils.Print(string.format("\n"))
end

function assemble_table(event, state, operation, args, data)

  event_table = {}

  event_table[event] = {}

  event_table[event][state] = {}
  event_table[event][state][operation] = {}
  event_table[event][state][operation]["args"] = args
  event_table[event][state][operation]["data"] = data
  
  return 

end