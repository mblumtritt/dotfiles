function handleWifi(watcher, message, interface)
	local net = hs.wifi.currentNetwork()
	if net == nil then
		hs.notify.show("WIFI", "", "Disconnected from network", "")
	else
		hs.notify.show("WIFI", net, "Connected to network", "")
	end
end

wifiwatcher = hs.wifi.watcher.new(handleWifi)
wifiwatcher:start()
