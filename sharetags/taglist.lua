-- Grab environment we need
local capi =
{ 
    screen = screen,
    awesome = awesome,
    client = client
}

local type = type
local pairs = pairs
local ipairs = ipairs
local table = table
local awful      = require("awful")
local wibox      = require("wibox")
local common = require("awful.widget.common")
local util = require("awful.util")
local tag = require("awful.tag")
local beautiful = require("beautiful")
local surface = require("gears.surface")
local tags = require("sharetags.tags")

--- Taglist widget module for awful
-- awful.widget.taglist
local taglist = { mt = {} }

local function taglist_label(t, args)
    if not args then args = {} end
    local theme = beautiful.get()
    local fg_focus = args.fg_focus or theme.taglist_fg_focus or theme.fg_focus
    local bg_focus = args.bg_focus or theme.taglist_bg_focus or theme.bg_focus
    local fg_urgent = args.fg_urgent or theme.taglist_fg_urgent or theme.fg_urgent
    local bg_urgent = args.bg_urgent or theme.taglist_bg_urgent or theme.bg_urgent
    local bg_occupied = args.bg_occupied or theme.taglist_bg_occupied
    local fg_occupied = args.fg_occupied or theme.taglist_fg_occupied
    local bg_empty = args.bg_empty or theme.taglist_bg_empty
    local fg_empty = args.fg_empty or theme.taglist_fg_empty
    local taglist_squares_sel = args.squares_sel or theme.taglist_squares_sel
    local taglist_squares_unsel = args.squares_unsel or theme.taglist_squares_unsel
    local taglist_squares_sel_empty = args.squares_sel_empty or theme.taglist_squares_sel_empty
    local taglist_squares_unsel_empty = args.squares_unsel_empty or theme.taglist_squares_unsel_empty
    local taglist_squares_resize = theme.taglist_squares_resize or args.squares_resize or "true"
    local taglist_disable_icon = args.taglist_disable_icon or theme.taglist_disable_icon or false
    local font = args.font or theme.taglist_font or theme.font or ""
    local text = "<span font_desc='"..font.."'>"
    local sel = capi.client.focus
    local bg_color = nil
    local fg_color = nil
    local bg_image
    local icon
    local bg_resize = false
    local is_selected = false
    local cls = t:clients()
    if sel then
        if taglist_squares_sel then
            -- Check that the selected clients is tagged with 't'.
            local seltags = sel:tags()
            for _, v in ipairs(seltags) do
                if v == t then
                    bg_image = taglist_squares_sel
                    bg_resize = taglist_squares_resize == "true"
                    is_selected = true
                    break
                end
            end
        end
    end
    if #cls == 0 and t.selected and taglist_squares_sel_empty then
        bg_image = taglist_squares_sel_empty
        bg_resize = taglist_squares_resize == "true"
    elseif not is_selected then
        if #cls > 0 then
            if taglist_squares_unsel then
                bg_image = taglist_squares_unsel
                bg_resize = taglist_squares_resize == "true"
            end
            if bg_occupied then bg_color = bg_occupied end
            if fg_occupied then fg_color = fg_occupied end
        else
            if taglist_squares_unsel_empty then
                bg_image = taglist_squares_unsel_empty
                bg_resize = taglist_squares_resize == "true"
            end
            if bg_empty then bg_color = bg_empty end
            if fg_empty then fg_color = fg_empty end
        end
        for k, c in pairs(cls) do
            if c.urgent then
                if bg_urgent then bg_color = bg_urgent end
                if fg_urgent then fg_color = fg_urgent end
                break
            end
        end
    end
    if t.selected then
        bg_color = bg_focus
        fg_color = fg_focus
    end
    if not tag.getproperty(t, "icon_only") then
        if fg_color then
            text = text .. "<span color='"..util.color_strip_alpha(fg_color).."'>" ..
                tostring(tag.getproperty(t, "shared_number")) .. " " ..
                (util.escape(t.name) or "") .. "</span>"
        else
            text = text .. tostring(tag.getproperty(t, "shared_number")) .. " " .. (util.escape(t.name) or "")
        end
    end
    text = text .. "</span>"
    if not taglist_disable_icon then
        if tag.geticon(t) and type(tag.geticon(t)) == "image" then
            icon = tag.geticon(t)
        elseif tag.geticon(t) then
            icon = surface.load(tag.geticon(t))
        end
    end

    return text, bg_color, bg_image, not taglist_disable_icon and icon or nil
end

local function taglist_update(w, buttons, label, data, objects)
    -- update the widgets, creating them if needed
    w:reset()

    tags.update()

    for i, o in ipairs(tags.list) do
        local cache = data[o]
        local ib, tb, bgb, m, l
        if cache then
            ib = cache.ib
            tb = cache.tb
            bgb = cache.bgb
            m   = cache.m
        else
            ib = wibox.widget.imagebox()
            tb = wibox.widget.textbox()
            bgb = wibox.widget.background()
            m = wibox.layout.margin(tb, 4, 4)
            l = wibox.layout.fixed.horizontal()

            -- All of this is added in a fixed widget
            l:fill_space(true)
            l:add(ib)
            l:add(m)

            -- And all of this gets a background
            bgb:set_widget(l)

            bgb:buttons(common.create_buttons(buttons, o))

            data[o] = {
                ib = ib,
                tb = tb,
                bgb = bgb,
                m   = m
            }
        end

        local text, bg, bg_image, icon = taglist_label(o)
        -- The text might be invalid, so use pcall
        if not pcall(tb.set_markup, tb, text) then
            tb:set_markup("<i>&lt;Invalid text&gt;</i>")
        end
        bgb:set_bg(bg)
        if type(bg_image) == "function" then
            bg_image = bg_image(tb,o,m,tags.list,i)
        end
        bgb:set_bgimage(bg_image)
        ib:set_image(icon)
        w:add(bgb)
   end
end

function taglist.new(screen, filter, buttons, style, base_widget)
    return awful.widget.taglist(screen, filter, buttons, style, taglist_update, base_widget)
end

function taglist.mt:__call(...)
    return taglist.new(...)
end

return setmetatable(taglist, taglist.mt)

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
