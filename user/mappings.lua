local awful = require('awful')
local gears = require('gears')
local hotkeys_popup = require('awful.hotkeys_popup')

local modkey = 'Mod4'
local terminal = 'alacritty'
local editor = os.getenv('EDITOR') or 'vim'

local M = {}

-- stylua: ignore start
M.globalkeys = gears.table.join(

  -- Awesome
  awful.key(
            { modkey, 'Control' }, 'r',
            awesome.restart,
            { description = 'reload awesome', group = 'awesome' }
            ),
  awful.key(
            { modkey, 'Shift' }, 'q',
            awesome.quit,
            { description = 'quit awesome', group = 'awesome' }
            ),
  awful.key(
            { modkey }, 's',
            hotkeys_popup.show_help,
            { description = 'show help', group = 'awesome' }
            ),

  -- Client
  awful.key(
            { modkey }, 'j',
            function() awful.client.focus.byidx(1) end,
            { description = 'focus next by index', group = 'client' }
            ),
  awful.key(
            { modkey }, 'k',
            function() awful.client.focus.byidx(-1) end,
            { description = 'focus previous by index', group = 'client' }
            ),
  awful.key(
            { modkey, 'Shift' }, 'j',
            function() awful.client.swap.byidx(1) end,
            { description = 'swap with next client by index', group = 'client' }
            ),
  awful.key(
            { modkey, 'Shift' }, 'k',
            function() awful.client.swap.byidx(-1) end,
            { description = 'swap with previous client by index', group = 'client' }
            ),
  awful.key(
            { modkey }, 'u',
            awful.client.urgent.jumpto,
            { description = 'jump to urgent client', group = 'client' }
            ),

  -- Layout manipulation
  awful.key(
            { modkey }, 'l',
            function() awful.tag.incmwfact(0.05) end,
            { description = 'increase master width factor', group = 'layout' }
            ),
  awful.key({ modkey }, 'h',
            function() awful.tag.incmwfact(-0.05) end,
            { description = 'decrease master width factor', group = 'layout' }
            ),
  awful.key(
            { modkey, 'Control' }, 'j',
            function() awful.client.incwfact(0.05) end,
            { description = 'increase master height factor', group = 'layout' }
            ),
  awful.key(
            { modkey, 'Control' }, 'k',
            function() awful.client.incwfact(-0.05) end,
            { description = 'decrease master height factor', group = 'layout' }
            ),
  awful.key(
            { modkey, 'Shift' }, 'h',
            function() awful.tag.incnmaster(1, nil, true) end,
            { description = 'increase the number of master clients', group = 'layout' }
            ),
  awful.key(
            { modkey, 'Shift' }, 'l',
            function() awful.tag.incnmaster(-1, nil, true) end,
            { description = 'decrease the number of master clients', group = 'layout' }
            ),
  awful.key(
            { modkey, 'Control' }, 'h',
            function() awful.tag.incncol(1, nil, true) end,
            { description = 'increase the number of columns', group = 'layout' }
            ),
  awful.key(
            { modkey, 'Control' }, 'l',
            function() awful.tag.incncol(-1, nil, true) end,
            { description = 'decrease the number of columns', group = 'layout' }
            ),
  awful.key(
            { modkey }, 'Tab',
            function() awful.layout.inc(1) end,
            { description = 'select next', group = 'layout' }
            ),
  awful.key(
            { modkey, 'Shift' }, 'Tab',
            function() awful.layout.inc(-1) end,
            { description = 'select previous', group = 'layout' }
            ),

  -- Screen focus
  awful.key(
            { modkey, 'Control' }, 'j',
            function() awful.screen.focus_relative(1) end,
            { description = 'focus the next screen', group = 'screen' }
            ),
  awful.key(
            { modkey, 'Control' }, 'k',
            function() awful.screen.focus_relative(-1) end,
            { description = 'focus the previous screen', group = 'screen' }
            ),

  -- Tag
  awful.key(
            { modkey }, 'Escape',
            awful.tag.history.restore,
            { description = 'go back', group = 'tag' }
            ),

  -- Applications
  awful.key(
            { modkey }, 'Return',
            function() awful.spawn(terminal) end,
            { description = 'terminal', group = 'Applications' }
            ),
  awful.key(
            { modkey }, 'p',
            function() awful.spawn('rofi -show drun') end,
            { description = 'rofi', group = 'Applications' }
            ),
  awful.key(
            { modkey }, 'b',
            function() awful.spawn('firefox') end,
            { description = 'firefox', group = 'Applications' }
            ),
  awful.key(
            { modkey }, 'd',
            function() awful.spawn('deezer') end,
            { description = 'deezer', group = 'Applications' }
            )
)

M.clientkeys = gears.table.join(
  awful.key(
            { modkey }, 'q',
            function(c) c:kill() end,
            { description = 'close', group = 'client' }
            ),
  awful.key(
            { modkey, 'Control' },
            'space',
            awful.client.floating.toggle,
            { description = 'toggle floating', group = 'client' }
            ),
  awful.key(
            { modkey, 'Control' }, 'Return',
            function(c) c:swap(awful.client.getmaster()) end,
            { description = 'move to master', group = 'client' }
            ),
  awful.key(
            { modkey }, 'm',
            function(c)
              c.maximized = not c.maximized
              c:raise()
            end,
            { description = '(un)maximize', group = 'client' }
            ),
  awful.key(
            { modkey }, 'f',
            function(c)
              c.fullscreen = not c.fullscreen
              c:raise()
            end,
            { description = 'toggle fullscreen', group = 'client' }
            )
)
-- stylua: ignore end

M.clientbuttons = gears.table.join(
  awful.button({}, 1, function(c)
    c:emit_signal('request::activate', 'mouse_click', { raise = true })
  end),
  awful.button({ modkey }, 1, function(c)
    c:emit_signal('request::activate', 'mouse_click', { raise = true })
    awful.mouse.client.move(c)
  end),
  awful.button({ modkey }, 3, function(c)
    c:emit_signal('request::activate', 'mouse_click', { raise = true })
    awful.mouse.client.resize(c)
  end)
)

for i = 1, 9 do
  M.globalkeys = gears.table.join(
    M.globalkeys,
    awful.key({ modkey }, '#' .. i + 9, function()
      local screen = awful.screen.focused()
      local tag = screen.tags[i]
      if tag then
        tag:view_only()
      end
    end, { description = 'view tag #' .. i, group = 'tag' }),
    awful.key({ modkey, 'Shift' }, '#' .. i + 9, function()
      if client.focus then
        local tag = client.focus.screen.tags[i]
        if tag then
          client.focus:move_to_tag(tag)
        end
      end
    end, { description = 'move focused client to tag #' .. i, group = 'tag' })
  )
end

root.keys(M.globalkeys)

return M
