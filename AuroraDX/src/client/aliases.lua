screenW, screenH = guiGetScreenSize()

local button = import 'button'
-- local chechbox = import 'CheckBox UI'

function createButton (...)
    return button:create (...)
end

function testFunction ()
    return print ('a')
end

a = createButton ({
    text = 'hello',
    x = screenW/2 - 250/2,
    y = screenH/2 - 40/2,
    w = 250,
    h = 40,
    atributte = testFunction,
    bgColor = {hover = {255, 255 ,255}, notHover = {255, 0, 0}, effect = 'InOutElastic'},
    textColor = {hover = {0, 0, 0}, notHover = {255, 255, 255}, effect = 'none'},
    font = 'default'
})