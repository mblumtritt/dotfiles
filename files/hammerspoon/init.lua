require('windowing')
require('watch-wifi')
require('watch-cfg')
-- require('watch-usb')

local clippy = hs.loadSpoon("ClipboardTool")
clippy:bindHotkeys(
	{
		toggle_clipboard = { { "cmd", "shift" }, "v" },
		show_clipboard = { { "cmd", "shift" }, "c" },
		clear_last_item = { { "cmd", "shift" }, "x" },
	}
)
clippy.show_in_menubar = false
clippy.paste_on_select = true
clippy:start()

hs.dockicon.hide()
