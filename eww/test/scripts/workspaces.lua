#!/usr/bin/env lua

function Trim(s)
  return (string.gsub(s, "^%s*(.-)%s*$", "%1"))
end

aw = io.popen("hyprctl monitors | grep active | sed 's/()/(1)/g' | sort | awk 'NR>1{print $1}' RS='(' FS=')'")
local active_workspace = aw:read("*a")
aw:close()

local ew = io.popen("hyprctl workspaces | grep ID | sed 's/()/(1)/g' | sort | awk 'NR>1{print $1}' RS='(' FS=')'")
local existing_workspaces = ew:read("*a")
ew:close()

local box = '(box :orientation "v" :spacing 1 :space-evenly "true" '

for i = 1, #existing_workspaces do
    local c = existing_workspaces:sub(i,i)
    if c ~= "\n" then
        local btn = '(button :class "inactive" :onclick "hyprctl dispatch workspace '..c..'" "a")'
        box = box .. btn
    elseif tonumber(c) == tonumber(active_workspace) then
        local btn = '(button :class "active" :onclick "hyprctl dispatch workspace '..c..' " "a")'
        box = box .. btn
    end
end

box = box .. ")"

print(box)
