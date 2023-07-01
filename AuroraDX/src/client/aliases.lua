
-- local button = import 'button'
-- local list = import 'list'

function createButton (...)
    return aurora.button:create (...)
end

-- function createList (...)
--     return list:create (...)
-- end

function testFunction ()
    return print 'Brochei'
end

a = createButton ({
    text = 'hello',
    x = screenW/2 - 240/2,
    y = screenH/2 - 45/2,
    w = 240,
    h = 45,
    atributte = testFunction,
    style = {type = 'rounded', args = {5}}, -- Rounded, Circle
    bgColor = {hover = {255, 255 ,255}, notHover = {255, 0, 0}, easing = {type = 'InOutQuad', time = 500}},
    textColor = {hover = {0, 0, 0}, notHover = {255, 255, 255}, easing = {type = 'InOutQuad', time = 500}},
    font = 'default'
})