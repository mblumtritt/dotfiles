hs.window.animationDuration = 0 -- disable animation

local pos_focusedWindow = function (fn)
	local win = hs.window.focusedWindow()
	local max = win:screen():frame()
	local f = win:frame()
	f.x = max.x
	f.y = max.y
	f.w = max.w
	f.h = max.h
	fn(f, max)
	win:setFrame(f)
end

local pos_hor_center = function(f, max, part)
	local space = max.w / part
	f.x = max.x + space
	f.w = max.w - 2 * space
end

local pos_vert_center = function(f, max, part)
	local space = max.h / part
	f.y = max.y + space
	f.h = max.h - 2 * space
end

local pos_center_mid = function(f, max)
	pos_hor_center(f, max, 10)
	pos_vert_center(f, max, 10)
end

local pos_center_big = function(f, max)
	pos_hor_center(f, max, 8)
end

local pos_center_small = function(f, max)
	pos_hor_center(f, max, 5)
end

local pos_center_min = function(f, max)
	pos_hor_center(f, max, 3)
end

local pos_left = function(f, max)
	f.w = max.w / 2
end

local pos_right = function(f, max)
	f.w = max.w / 2
	f.x = max.x + f.w
end

local pos_up = function(f, max)
	f.h = max.h / 2
end

local pos_down = function(f, max)
	f.h = max.h / 2
	f.y = max.y + f.h
end

local hyper = {"cmd", "alt", "ctrl"}

hs.hotkey.bind(hyper, "-", function() pos_focusedWindow(pos_center_big) end)
hs.hotkey.bind(hyper, ".", function() pos_focusedWindow(pos_center_small) end)
hs.hotkey.bind(hyper, "m", function() pos_focusedWindow(pos_center_min) end)
hs.hotkey.bind(hyper, ",", function() pos_focusedWindow(pos_center_mid) end)
hs.hotkey.bind(hyper, "Left", function() pos_focusedWindow(pos_left) end)
hs.hotkey.bind(hyper, "Right", function() pos_focusedWindow(pos_right) end)
hs.hotkey.bind(hyper, "Up", function() pos_focusedWindow(pos_up) end)
hs.hotkey.bind(hyper, "Down", function() pos_focusedWindow(pos_down) end)
