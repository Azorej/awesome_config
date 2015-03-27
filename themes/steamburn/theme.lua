
--[[
                                     
     Steamburn Awesome WM config 3.0 
     github.com/copycat-killer       
                                     
--]]

theme                               = {}

themes_dir                          = os.getenv("HOME") .. "/.config/awesome/themes/steamburn"
theme.wallpaper                     = themes_dir .. "/wall.png"

theme.font                          = "Tamsyn 10.5"
theme.fg_normal                     = "#e2ccb0"
theme.fg_focus                      = "#d88166"
theme.fg_urgent                     = "#CC9393"
theme.bg_normal                     = "#140c0b"
theme.bg_focus                      = "#140c0b"
theme.bg_urgent                     = "#2a1f1e"
theme.border_width                  = 1
theme.border_normal                 = "#302627"
theme.border_focus                  = "#c2745b"
theme.border_marked                 = "#CC9393"
theme.taglist_fg_focus              = "#d88166"
theme.tasklist_bg_focus             = "#140c0b"
theme.tasklist_fg_focus             = "#d88166"
theme.menu_height                   = "16"
theme.menu_width                    = "140"
theme.widget_bg                     = themes_dir .. "/icons/widget_bg.png"
theme.disk                          = themes_dir .. "/icons/disk.png"

theme.layout_tile                   = themes_dir .. "/icons/tile.png"
theme.layout_tilegaps               = themes_dir .. "/icons/tilegaps.png"
theme.layout_tileleft               = themes_dir .. "/icons/tileleft.png"
theme.layout_tilebottom             = themes_dir .. "/icons/tilebottom.png"
theme.layout_tiletop                = themes_dir .. "/icons/tiletop.png"
theme.layout_fairv                  = themes_dir .. "/icons/fairv.png"
theme.layout_fairh                  = themes_dir .. "/icons/fairh.png"
theme.layout_spiral                 = themes_dir .. "/icons/spiral.png"
theme.layout_dwindle                = themes_dir .. "/icons/dwindle.png"
theme.layout_max                    = themes_dir .. "/icons/max.png"
theme.layout_fullscreen             = themes_dir .. "/icons/fullscreen.png"
theme.layout_magnifier              = themes_dir .. "/icons/magnifier.png"
theme.layout_floating               = themes_dir .. "/icons/floating.png"

theme.submenu_icon                  = themes_dir .. "/icons/submenu.png"
theme.taglist_squares_sel           = themes_dir .. "/icons/square_sel.png"
theme.taglist_squares_unsel         = themes_dir .. "/icons/square_unsel.png"

theme.tasklist_disable_icon         = true
theme.tasklist_floating             = ""
theme.tasklist_maximized_horizontal = ""
theme.tasklist_maximized_vertical   = ""

return theme
