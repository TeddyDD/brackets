local memoize = require("memoize")
local function brackets(n)
  local arr = {}
  local function brackets_impl(left, right, str)
    if ((left == right) and (right == 0)) then
      table.insert(arr, str)
    end
    if (left > 0) then
      brackets_impl((left - 1), (right + 1), (str .. "["))
    end
    if (right > 0) then
      return brackets_impl(left, (right - 1), (str .. "]"))
    end
  end
  brackets_impl(n, 0, "")
  return arr
end
local n = n
if (#arg == 1) then
  n = tonumber(arg[1])
else
  n = 10
end
for _, b in pairs(brackets(n)) do
  print(b)
end
return nil
