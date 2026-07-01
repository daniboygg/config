-- Auxiliary functions used by init.lua

local M = {}

-- Function to focus or launch application
function M.focusOrLaunch(appName)
    return function()
        local app = hs.application.find(appName)
        if app then
            app:activate()
        else
            hs.application.launchOrFocus(appName)
        end
    end
end

-- Keyboard layout switching (plain layouts only, e.g. U.S. / U.S. International)
function M.cycleKeyboardLayout()
    local names = hs.keycodes.layouts()

    if #names == 0 then
        hs.alert.show("No keyboard layouts found")
        return
    end

    -- Find the current layout, then step to the next one. The modulo wraps
    -- the last layout back to the first: at index N of N, (N % N) + 1 == 1.
    local current = hs.keycodes.currentLayout()
    local index = 0
    for i, name in ipairs(names) do
        if name == current then
            index = i
            break
        end
    end
    local nextIndex = (index % #names) + 1

    if hs.keycodes.setLayout(names[nextIndex]) then
        hs.alert.show(names[nextIndex], 0.5)
    else
        hs.alert.show("Could not switch to " .. names[nextIndex])
    end
end

function M.sequenceHotkey(mods, key)
    local timeoutSeconds = 2
    local modal = hs.hotkey.modal.new(mods, key)
    local sequence = {}
    local timer = nil

    local function stopTimer()
        if timer then
            timer:stop()
            timer = nil
        end
    end

    function sequence.exit()
        stopTimer()
        modal:exit()
        return sequence
    end

    function sequence.add(secondKey, action, secondMods)
        modal:bind(secondMods or {}, secondKey, function()
            action()
            sequence.exit()
        end)
        return sequence
    end

    function sequence.cancel(secondKey, secondMods)
        modal:bind(secondMods or {}, secondKey, function()
            sequence.exit()
        end)
        return sequence
    end

    function modal:entered()
        stopTimer()

        timer = hs.timer.doAfter(timeoutSeconds, function()
            sequence.exit()
        end)
    end

    function modal:exited()
        stopTimer()
    end

    sequence.cancel("escape")

    return sequence
end

function M.rectangleAction(name)
    return function()
        hs.task.new("/usr/bin/open", nil, {"-g", "rectangle://execute-action?name=" .. name}):start()
    end
end

return M

