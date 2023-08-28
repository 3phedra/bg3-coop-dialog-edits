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
function getKeysSortedByValue(tbl, sortFunction)
  local keys = {}
  for key in pairs(tbl) do
    table.insert(keys, key)
  end
  table.sort(keys, function(a, b)
    return sortFunction(tbl[a], tbl[b])
  end)
  return keys
end
function tablefind(tab, el)
  for index, value in pairs(tab) do
    if value == el then
      return index
    end
  end
end
function inttobool(val)
  if val == 1 then
    return true
  elseif val == 0 then
    return false
  else
    Ext.Utils.PrintError("Tried to convert " .. val .. " into bool.")
    return nil
  end
end
function deepcopy(orig)
  local orig_type = type(orig)
  local copy
  if orig_type == 'table' then
      copy = {}
      for orig_key, orig_value in next, orig, nil do
          copy[deepcopy(orig_key)] = deepcopy(orig_value)
      end
      setmetatable(copy, deepcopy(getmetatable(orig)))
  else -- number, string, boolean, etc
      copy = orig
  end
  return copy
end