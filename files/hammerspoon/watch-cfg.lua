function init_cfg_watch()
	for _, dir in pairs({ hs.configdir }) do
		hs.pathwatcher.new(dir, hs.reload):start()
	end
end

init_cfg_watch()
