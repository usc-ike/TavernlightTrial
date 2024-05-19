
local Q7UIButton = nil
local Q7JumpBtn = nil
local Q7Window = nil

local PADDINGX = 10
local PADDINGYTOP = 30
local PADDINGYBOT = 10

local btnWidth = 0
local btnHeight = 0
local windowWidth = 0
local windowHeight = 0
local moveInterval = -10

local updateButton = true

-- Adds a module button to open up the window in addition to iniitalizing crucial variables
function init()
  Q7UIButton = modules.client_topmenu.addLeftGameButton('Q7UIButton', tr('Q7'), '/images/topbuttons/hotkeys', toggle)
  Q7Window = g_ui.displayUI('Q7')
  Q7JumpBtn = Q7Window:getChildById('jumpBtn')
  windowWidth = Q7Window:getWidth()
  windowHeight = Q7Window:getHeight()
  btnWidth = Q7JumpBtn:getWidth()
  btnHeight = Q7JumpBtn:getHeight()
  Q7Window:setVisible(false)      
  resetPosition()
end

-- Destroys the module on termination
function terminate()
    updateButton = false
  if Q7Window then
    Q7Window:destroy()
  end
  if Q7UIButton then
    Q7UIButton:destroy()
  end
end

-- Sets the visibility status of the window
function toggle()
  if not Q7Window:isVisible() then
    show()
  else
    hide()
  end
end

--Shows the window and sets a flag to enable the self-scheduling of the updatePosition Event
function show()
    if not g_game.isOnline() then
      return
    end
    Q7Window:show()
    Q7Window:raise()
    Q7Window:focus()
    resetPosition()
    updateButton = true
    updatePosition()
end

-- Hides the window and sets a flag to disable the self-scheduling of the updatePosition event
function hide()
    updateButton = false
    Q7Window:hide()
end

-- Sets the button position to the right of the window while randomizing the Y coordinate
function resetPosition()
  local windowPos = Q7Window:getPosition()
  local posY = math.random(PADDINGYTOP, windowHeight - btnHeight - PADDINGYBOT)
  -- print(string.format('x: %d, y:%d', windowPos.x + windowWidth - btnWidth - PADDINGX, windowPos.y + posY))
  Q7JumpBtn:setPosition({x=windowPos.x + windowWidth - btnWidth - PADDINGX, y=windowPos.y + posY})
end

-- Moves the button by moveInterval pixels to the left every 70 frames and schedule to call itself. 
function updatePosition()
  -- We dont want the update to run in the background while the window is closed.
  if not updateButton then
    return
  end
  local windowPos = Q7Window:getPosition()
  local currentPosition = Q7JumpBtn:getPosition()
  currentPosition.x = currentPosition.x + moveInterval
  if currentPosition.x <= windowPos.x + PADDINGX then
    resetPosition()
  else
    Q7JumpBtn:setPosition(currentPosition)
  end
  scheduleEvent(updatePosition, 70)
end

-- Gets fired every time the button gets clicked.
function onBtnClick()
  resetPosition()
end