require('windowing')
-- require('watch-cfg')
-- require('watch-wifi')
-- require('watch-usb')

hs.loadSpoon("DeepLTranslate")
spoon.DeepLTranslate:bindHotkeys({
  translate = { { "ctrl", "alt", "cmd" }, "E" },
})

hs.dockicon.hide()
