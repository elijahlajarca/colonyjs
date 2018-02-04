local ComponentRenderer = require('Classes.Renderer.ComponentRenderer')
local Game = require('Classes.System.Game')

local composer = require( "composer" )

local scene = composer.newScene()

-- create()
function scene:create( event )

  local sceneGroup = self.view
  -- Code here runs when the scene is first created but has not yet appeared on screen

  local placeholder = display.newText('Upgrade tree with start game: DISABLED', display.contentCenterX, display.contentCenterY-100, native.systemFont, 24)
  sceneGroup:insert(placeholder)

  local btn_StartGame = ComponentRenderer:renderButton('Assets/Buttons/Btn_Play.png', {
    filename_clicked = 'Assets/Buttons/Btn_PlayClicked.png',
    width = 400,
    height = 86,
  })
  btn_StartGame.x = display.contentCenterX
  btn_StartGame.y = (display.contentHeight - btn_StartGame.height / 2) - 325
  btn_StartGame:addEventListener('touch', function(event)
    if event.phase == 'ended' then
      composer.gotoScene('Classes.Scenes.BattleProper')
    end
  end)
  sceneGroup:insert(btn_StartGame)

  local btn_ChangeLooks = ComponentRenderer:renderButton('Assets/Buttons/Btn_Style.png', {
    filename_clicked = 'Assets/Buttons/Btn_StyleClicked.png',
    width = 400,
    height = 86,
  })
  btn_ChangeLooks.x = display.contentCenterX
  btn_ChangeLooks.y = (display.contentHeight - btn_ChangeLooks.height / 2) - 75
  btn_ChangeLooks:addEventListener('touch', function(event)
    if event.phase == 'ended' then
      composer.gotoScene('Classes.Scenes.StyleChange')
    end
  end)
  sceneGroup:insert(btn_ChangeLooks)
  
  local btn_Back = ComponentRenderer:renderButton('Assets/Buttons/Btn_Back.png', {
	filename_clicked = 'Assets/Buttons/Btn_BackClicked.png',
	width = 400,
	height = 86,
  })
  btn_Back.x = display.contentCenterX
  btn_Back.y = (display.contentHeight - btn_Back.height / 2) - 75
  transition.to(btn_Back, {time = 0, alpha = 0})
  
  local btn_Upgrades = ComponentRenderer:renderButton('Assets/Buttons/Btn_Upgrades.png', {
    filename_clicked = 'Assets/Buttons/Btn_UpgradesClicked.png',
    width = 400,
    height = 86,
  })
  btn_Upgrades.x = display.contentCenterX
  btn_Upgrades.y = (display.contentHeight - btn_Upgrades.height / 2) - 200
  btn_Upgrades:addEventListener('touch', function(event)
    if event.phase == 'ended' then
	  placeholder.text = 'Upgrade tree with start game: ENABLED'
	  btn_Back:addEventListener('touch', function(event)
		if event.phase == 'ended' then
			placeholder.text = 'Upgrade tree with start game: DISABLED'
			transition.to(btn_Back, {time = 250, alpha = 0})
			transition.to(btn_StartGame, {
				time = 250, 
				delay = 250, 
				alpha = 1.0, 
				x = display.contentCenterX, 
				y = (display.contentHeight - btn_StartGame.height / 2) - 325
			})
			transition.to(btn_Upgrades, {
				time = 250, 
				delay = 250, 
				alpha = 1.0, 
				x = display.contentCenterX, 
				y = (display.contentHeight - btn_Upgrades.height / 2) - 200
			})
			transition.to(btn_ChangeLooks, {
				time = 250, 
				delay = 250, 
				alpha = 1.0, 
				x = display.contentCenterX, 
				y = (display.contentHeight - btn_ChangeLooks.height / 2) - 75
			})
			
		end
      end)
	  
	  transition.to(btn_Back, {time = 250, delay = 200, alpha = 1.0})
	  transition.to(btn_StartGame, {time = 250, alpha = 0, x = display.contentCenterX, y = display.contentHeight})
	  transition.to(btn_Upgrades, {time = 250, alpha = 0, x = display.contentCenterX, y = display.contentHeight + 100})
	  transition.to(btn_ChangeLooks, {time = 250, alpha = 0, x = display.contentCenterX, y = display.contentHeight + 200})
	  
	end
  end)
  sceneGroup:insert(btn_Upgrades)
end


-- show()
function scene:show( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
    -- Code here runs when the scene is still off screen (but is about to come on screen)
    Game.sceneActivated = 'Upgrade tree'

  elseif ( phase == "did" ) then
    -- Code here runs when the scene is entirely on screen

  end
end

-- hide()
function scene:hide( event )

  local sceneGroup = self.view
  local phase = event.phase

  if ( phase == "will" ) then
    -- Code here runs when the scene is on screen (but is about to go off screen)

  elseif ( phase == "did" ) then
    -- Code here runs immediately after the scene goes entirely off screen

  end
end

-- destroy()
function scene:destroy( event )

  local sceneGroup = self.view
  -- Code here runs prior to the removal of scene's view

end

scene:addEventListener( "create", scene )
scene:addEventListener( "show", scene )
scene:addEventListener( "hide", scene )
scene:addEventListener( "destroy", scene )
-- -----------------------------------------------------------------------------------

return scene
