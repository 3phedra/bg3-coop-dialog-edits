-- ##Helper functions
function has_value(tab, val)
  for index, value in ipairs(tab) do
    if value == val then
      return true
    end
  end
  return false
end

function spairs(t, order)
  local keys = {}

  for k in pairs(t) do keys[#keys + 1] = k end

  if order then
    table.sort(keys, function(a, b) return order(t, a, b) end)
  else
    table.sort(keys)
  end

  local i = 0
  return function()
    i = i + 1
    if keys[i] then
      return keys[i], t[keys[i]]
    end
  end
end

function sorted_pairs(table)
  return spairs(table, function(t, a, b) return t[b] < t[a] end)
end

function elementIterator(collection)
  local index = 0
  local count = #collection

  -- The closure function is returned

  return function()
    index = index + 1

    if index <= count
    then
      -- return the current element of the iterator
      return collection[index]
    end
  end
end

--## Random helper console commands
function printTable(t)
  local printTable_cache = {}
  local function sub_printTable(t, indent)
    if (printTable_cache[tostring(t)]) then
      Ext.Utils.PrintWarning(indent .. "*" .. tostring(t))
    else
      printTable_cache[tostring(t)] = true
      if (type(t) == "table") then
        for pos, val in pairs(t) do
          if (type(val) == "table") then
            Ext.Utils.PrintWarning(indent .. "[" .. pos .. "] => " .. tostring(t) .. " {")
            sub_printTable(val, indent .. string.rep(" ", string.len(pos) + 8))
            Ext.Utils.PrintWarning(indent .. string.rep(" ", string.len(pos) + 6) .. "}")
          elseif (type(val) == "string") then
            Ext.Utils.PrintWarning(indent .. "[" .. pos .. '] => "' .. val .. '"')
          else
            Ext.Utils.PrintWarning(indent .. "[" .. pos .. "] => " .. tostring(val))
          end
        end
      else
        Ext.Utils.PrintWarning(indent .. tostring(t))
      end
    end
  end

  if (type(t) == "table") then
    Ext.Utils.PrintWarning(tostring(t) .. " {")
    sub_printTable(t, "  ")
    Ext.Utils.PrintWarning("}")
  else
    sub_printTable(t, "  ")
  end
  Ext.Utils.PrintWarning("\n")
end

function dump_table(o)
  if type(o) == 'table' then
    local s = ''
    for k, v in pairs(o) do
      if type(k) ~= 'number' then k = '"' .. k .. '"' end
      s = s .. '[' .. k .. '] = ' .. dump_table(v) .. ','
    end
    return s .. ''
  else
    return tostring(o)
  end
end

function dump_table_inline(o)
  if type(o) == 'table' then
    local s = ''
    for k, v in pairs(o) do
      if type(k) ~= 'number' then k = '"' .. k .. '"' end
      s = s .. '[' .. k .. '] = ' .. dump_table(v) .. ','
    end
    return s .. ''
  else
    return tostring(o)
  end
end
