local caps_mode = hs.hotkey.modal.new()
local inputEnglish = "com.apple.keylayout.ABC"
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
  supportTitleArr = { 'iTerm2', 'Code', 'IntelliJ IDEA' }
  -- print( "input_source" )
  -- print( input_source )
 
  if ((input_source == input2SetKorean or input_source == inputHan390) and has_value(supportTitleArr,title)) then
    -- print("switch input and vim mode")
    hs.eventtap.keyStroke({}, 'right')
    -- hs.keycodes.currentSourceID(input_source == input2SetKorean and inputEnglish or inputGureumQwerty)
    hs.eventtap.keyStroke({}, 'escape')
  else
    vimSwitchMode:disable()
    hs.eventtap.keyStroke({'control'}, 'c')
    vimSwitchMode:enable()
  end
end)

-- https://johngrib.github.io/blog/2017/08/07/hammerspoon-tutorial-05/

