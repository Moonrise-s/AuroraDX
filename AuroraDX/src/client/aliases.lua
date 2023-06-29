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
    x = screenW/2 - 100/2,
    y = screenH/2 - 100/2,
    w = 100,
    h = 100,
    atributte = testFunction,
    bgColor = {hover = {255, 255 ,255}, notHover = {255, 0, 0}, effect = 'none'},
    textColor = {hover = {0, 0, 0}, notHover = {255, 255, 255}, effect = 'none'},
    font = 'default'
})

b = createButton ({
    text = 'hello2',
    x =( screenW/2 - 100/2) + 110,
    y = screenH/2 - 100/2,
    w = 100,
    h = 100,
    atributte = testFunction,
    bgColor = {hover = {255, 255 ,255}, notHover = {25, 25, 25}, effect = 'Linear'},
    textColor = {hover = {0, 0, 0}, notHover = {255, 255, 255}, effect = 'none'},
    font = 'default'
})

c = createButton ({
    text = 'hello3',
    x =( screenW/2 - 100/2) + 220,
    y = screenH/2 - 100/2,
    w = 100,
    h = 100,
    atributte = testFunction,
    bgColor = {hover = {255, 255 ,255}, notHover = {255, 0, 0}, effect = 'none'},
    textColor = {hover = {0, 0, 0}, notHover = {255, 255, 255}, effect = 'InOutQuad'},
    font = 'default'
})

d = createButton ({
    text = 'hello4',
    x =( screenW/2 - 100/2) + 330,
    y = screenH/2 - 100/2,
    w = 100,
    h = 100,
    atributte = testFunction,
    bgColor = {hover = {255, 255 ,255}, notHover = {255, 0, 0}, effect = 'InOutElastic'},
    textColor = {hover = {0, 0, 0}, notHover = {255, 255, 255}, effect = 'none'},
    font = 'default'
})