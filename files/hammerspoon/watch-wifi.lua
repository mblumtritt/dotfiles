function handleWifi(_watcher, _message, _interface)
	local net = hs.wifi.currentNetwork()
	if net == nil then
		hs.notify.show("WIFI", "", "Disconnected from network", "")
	else
		hs.notify.show("WIFI", net, "Connected to network", "")
	end
end

local wifiWatcher = hs.wifi.watcher.new(handleWifi)
wifiWatcher:start()
