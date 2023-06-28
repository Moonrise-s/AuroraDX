
local table_insert = table.insert
local table_remove = table.remove

local screenW, screenH = guiGetScreenSize()

local button = {}
setmetatable (button, {__index = button})
button.elements = {}

local hover

function button:create (data)
    if (not self) then return error ('Argument #1 is NULL. Define the object.') end
    if (self.elements[id]) then return error ('Button exists') end

    local datas = data or {text = '', x = 0, y = 0, w = 0, h = 0, atributte = function () return end, bgColor = {notHover = tocolor (255, 0, 0), hover = tocolor (255, 255, 255)}, textColor = {notHover = tocolor (0, 0, 0), hover = tocolor (255, 0, 0)}, font = 'default' }

    if (#self.elements <= 0) then
        addEventHandler ('onClientRender', root, buttonRender)
        addEventHandler ('onClientClick', root, buttonClick)
    end

    setmetatable (datas, {__index = button})
    table_insert (button.elements, datas)

    return datas
end

function button:destroy ()
    if (not self) then return error ('Argument #1 is NULL. Define the object.') end
    if (hover == self) then hover = nil end
    for position, data in ipairs (button.elements) do
        if (data == self) then
            table_remove (button.elements, position)
            if (#button.elements <= 0) then
                removeEventHandler ('onClientRender', root, buttonRender)
                removeEventHandler ('onClientClick', root, buttonClick)
            end
        end
    end
end

function button:isInside (x, y)
    if (not isCursorShowing ()) then return end
    local cx, cy = getCursorPosition ()
    local x, y = x or (cx * screenW), y or (cy * screenH)
    return ((x >= self.x and x <= self.x + self.w) and (y >= self.y and y <= self.y + self.h))
end

local effects = {}

function button:interpolate (hover, colors, id)

    local type = self.textColor.hover == colors.hover and id..'text' or id..'bg'
    if (self ~= hover and effects[type]) then
        effects[type] = nil
    end

    if (hover and hover == self and colors.effect ~= 'none') then
        if (not effects[type]) then
            effects[type] = {
                status = {start = colors.notHover, final = colors.hover, effect = colors.effect},
                tick = getTickCount ()
            }
        end
     
        local progress = (getTickCount () - effects[type].tick) / 800

        local r, g, b = interpolateBetween (
            effects[type].status.start[1],
            effects[type].status.start[2],
            effects[type].status.start[3],
            effects[type].status.final[1],
            effects[type].status.final[2],
            effects[type].status.final[3],
            progress,
            effects[type].effect or 'Linear'
        )

        return tocolor (r, g, b)
    end
    return (hover == self and tocolor (unpack (colors.hover)) or tocolor (unpack (colors.notHover)))
end

function buttonRender ()
    for position, self in ipairs (button.elements) do

        hover = nil
        if (self:isInside (mx, my)) then
            hover = self
        end

        dxDrawRectangle (
            self.x, self.y,
            self.w, self.h,
            self:interpolate (hover, self.bgColor, position)
        )

        dxDrawText (
            self.text,
            self.x, self.y,
            self.x + self.w, self.y + self.h,
            self:interpolate (hover, self.textColor, position),
            1, self.font,
            'center', 'center'
        )

    end
end

function buttonClick (b, s, x, y)
    if (b == 'left' and s == 'down') then
        if (hover) then
            return hover:atributte ()
        end
    end
end

function testFunction ()
    a:destroy ()
    return givePlayerMoney (1000), print 'Você recebeu $1000'
end

a = button:create ({
    id = 'box',
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

b = button:create ({
    id = 'box2',
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

c = button:create ({
    id = 'box3',
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

d = button:create ({
    id = 'box4',
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