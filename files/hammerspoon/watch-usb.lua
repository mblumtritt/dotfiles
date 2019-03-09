function handleUSB(data)
	if data["eventType"] == 'added' then
		local cmd = "usb-serials -s 00008020000C554C3432002E$"
		local output, status, _type, _rc = os.execute(cmd)
		if status == nil then
		else
			print("IPHONE")
		end
	end
end

local usbWatcher = hs.usb.watcher.new(handleUSB)
usbWatcher:start()
