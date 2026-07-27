local utils = require("utils")

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
-- Move window [p]osition to left [h] and right [l]
local windowSequenceHotkey = utils.sequenceHotkey(hyper, "p")
windowSequenceHotkey.add("h", utils.rectangleAction("previous-display"))
windowSequenceHotkey.add("l", utils.rectangleAction("next-display"))
-- make window half of the screen left/right
windowSequenceHotkey.add("h", utils.rectangleAction("left-half"), {"shift"})
windowSequenceHotkey.add("l", utils.rectangleAction("right-half"), {"shift"})
-- Window [p]osition [m]aximize
windowSequenceHotkey.add("m", utils.rectangleAction("maximize"))
-- Window [p]osition [s]wap frontmost windows
windowSequenceHotkey.add("s", utils.swapWindowsBetweenScreens)
