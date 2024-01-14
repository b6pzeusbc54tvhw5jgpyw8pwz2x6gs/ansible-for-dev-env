local caps_mode = hs.hotkey.modal.new()
local inputABC = "com.apple.keylayout.ABC"
local input2SetKorean = "com.apple.inputmethod.Korean.2SetKorean"
local inputGureumQwerty = "org.youknowone.inputmethod.Gureum.qwerty"
local inputHan390 = "org.youknowone.inputmethod.Gureum.han390"

local function has_value (tab, val)
    for index, value in ipairs(tab) do
        if value == val then
            return true
        end
    end
    return false
end

vimSwitchMode = hs.hotkey.bind({'control'}, 'c', function()
    -- print("in off_caps_mode")
    local win = hs.window.focusedWindow()
    local app = win:application()
    local title = app:title()

  -- print( "win:title: " .. win:title() )
  -- print( "path: " .. app:path() )
  -- print( "pid: " .. app:pid() )
  -- print( "title: " .. title )
    caps_mode:exit()

    local input_source = hs.keycodes.currentSourceID()
    supportTitleArr = { 'iTerm2', 'Code', 'IntelliJ IDEA', 'Obsidian' }
--   print(title)
--   print( input_source )

--   hs.eventtap.keyStroke({}, 'right')
    hs.eventtap.keyStroke({}, 'escape')
    if (input_source ~= inputABC and has_value(supportTitleArr,title)) then
        -- print("switch english!")
        hs.keycodes.currentSourceID(inputABC)
    -- else
    --     print("notthing")
    --     vimSwitchMode:disable()
    --     hs.eventtap.keyStroke({'control'}, 'c')
    --     vimSwitchMode:enable()
  end
end)

-- https://johngrib.github.io/blog/2017/08/07/hammerspoon-tutorial-05/
