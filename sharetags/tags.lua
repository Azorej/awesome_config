-- Grab environment we need
local capi =
{
    screen = screen,
    tag = tag,
    awesome = awesome,
    client = client
}

local type = type
local pairs = pairs
local ipairs = ipairs
local table = table
local awful      = require("awful")
local tag = require("awful.tag")

capi.tag.add_signal("property::shared_number")

local tags = { mt = {}, list = {} }
tags.list = {}

function tags.update()
    tags.list = {}
    local unnumbered_tags = {}
    for s = 1, screen.count() do
        for _, v in ipairs(tag.gettags(s)) do
            if tag.getproperty(v, "shared_number") then
                table.insert(tags.list, v)
            else
                table.insert(unnumbered_tags, v)
            end
        end
    end

    table.sort(tags.list, function (v1, v2)
        return tag.getproperty(v1, "shared_number") < tag.getproperty(v2, "shared_number")
    end)

    local idx = 1
    for _, v in ipairs(unnumbered_tags) do
        while tags.list[idx] do
            if tag.getproperty(tags.list[idx], "shared_number") ~= idx then
                break
            end
            idx = idx + 1
        end
        table.insert(tags.list, idx, v)
        tag.setproperty(v, "shared_number", idx)
    end
end

function tags.get_by_shared_number(num)
    for _, v in ipairs(tags.list) do
        if tag.getproperty(v, "shared_number") == num then
            return v
        end
    end
    return nil
end

return setmetatable(tags, tags.mt)

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80

