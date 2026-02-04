-- Hyper key definition (Ctrl+Option+Shift)
-- Check karabiner "Change caps_lock to right shift+ctrl+option." rule
local hyper = {"ctrl", "alt", "shift"}

-- Function to focus or launch application
local function focusOrLaunch(appName)
    return function()
        local app = hs.application.find(appName)
        if app then
            app:activate()
        else
            hs.application.launchOrFocus(appName)
        end
    end
end

-- Application switching with Meh key
hs.hotkey.bind(hyper, "j", focusOrLaunch("iTerm"))
hs.hotkey.bind(hyper, "k", focusOrLaunch("PyCharm"))
hs.hotkey.bind(hyper, "l", focusOrLaunch("Google Chrome"))
hs.hotkey.bind(hyper, ";", focusOrLaunch("Slack"))