local String = require('Classes.System.String')
local DisplayObject = require('Classes.System.DisplayObject')

local ComponentRenderer = require('Classes.Renderer.ComponentRenderer')

local PrepareRenderer = {}

function PrepareRenderer:draw(wave)
  local pickerGroup = display.newGroup() 
  pickerGroup.header = display.newImageRect(pickerGroup, 'Assets/ClassIcons/Header.png', 90, 86)
  pickerGroup.header:addEventListener('touch', function(event) 
    if event.phase == 'ended' then
      if pickerGroup.pickerScroll.isVisible then
        pickerGroup.header.xScale, pickerGroup.header.yScale = 1, 1
      else
        pickerGroup.header.xScale, pickerGroup.header.yScale = 0.75, 0.75
      end
      pickerGroup.pickerScroll.isVisible = not pickerGroup.pickerScroll.isVisible and true or false
      return true
    end
  end)
  pickerGroup.pickerScroll = display.newGroup()

  local classesFileName = 'Contents/Guardians/GuardianSet.txt'
  local classesPath = system.pathForFile(classesFileName)
  local classesFile, err = io.open(classesPath, 'r')
  if not classesFile then
    -- LOG CLASS FILE NOT FOUND
  else
    local index = 1
    pickerGroup.pickerScroll.classSet = {}
    for line in classesFile:lines() do
      line = String:filterLetters(line)
      pickerGroup.pickerScroll.classSet[line] = display.newImageRect(pickerGroup.pickerScroll, 'Assets/ClassIcons/' .. line .. '.png', 60, 60)
      pickerGroup.pickerScroll.classSet[line].y = (pickerGroup.pickerScroll.classSet[line].height / 2) + ((index - 1) * (pickerGroup.pickerScroll.classSet[line].height + 20))
      pickerGroup.pickerScroll.classSet[line]:addEventListener('touch', function(event) 
        if event.phase == 'ended' then
          wave.parent.guardianManager:new(wave, line)
        end
        return true
      end)
      pickerGroup:insert(pickerGroup.pickerScroll)
      index = index + 1
    end
    pickerGroup.pickerScroll.y = pickerGroup.header.y + pickerGroup.header.height / 2 + 25
    pickerGroup.pickerScroll.isVisible = false
  end 

  -- BUTTON FOR GOING TO BATTLE
  local btn_Battle = ComponentRenderer:renderButton('Assets/Buttons/Btn_Battle.png', { 
    filename_clicked = 'Assets/Buttons/Btn_BattleClicked.png',
    width = 86, 
    height = 86
  })
  btn_Battle.x = display.contentWidth - btn_Battle.width / 2 - 25 
  btn_Battle.y = (btn_Battle.height / 2 + 25) * 2 + 40
  btn_Battle:addEventListener('touch', function(event)
    if event.phase == 'ended' then
      pickerGroup.isVisible = false
      btn_Battle.isVisible = false
      wave:battle()
    end
    return true
  end)
  table.insert(DisplayObject.displayObjectSet, btn_Battle)

  pickerGroup.x = pickerGroup.header.width / 2 + 25
  pickerGroup.y = pickerGroup.header.height / 2 + 25
  table.insert(DisplayObject.displayObjectSet, pickerGroup)
end

return PrepareRenderer