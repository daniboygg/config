local utils = require("functions")

-- Hyper key definition (Ctrl+Option+Shift)
-- Check karabiner "Change caps_lock to right shift+ctrl+option." rule
local hyper = {"ctrl", "alt", "shift"}

-- ##########################################
-- ### Application switching with Meh key ###
-- ##########################################
hs.hotkey.bind(hyper, "j", utils.focusOrLaunch("iTerm"))
hs.hotkey.bind(hyper, "k", utils.focusOrLaunch("PyCharm"))
hs.hotkey.bind(hyper, "l", utils.focusOrLaunch("Google Chrome"))
hs.hotkey.bind(hyper, ";", utils.focusOrLaunch("Slack"))
-- Change [i]nput layout keyboard
hs.hotkey.bind(hyper, "i", utils.cycleKeyboardLayout)
