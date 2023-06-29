
local button = {}
setmetatable (button, {__index = button})
button.elements = {}

local hover

function button:create (data)
    if (not self) then return error ('Error in argument #1. Define the object.') end
    if (self.elements[id]) then return error ('Button exists') end

    local datas = data

    setmetatable (datas, {__index = button})
    table_insert (button.elements, datas)

    if (#button.elements <= 1) then
        addEventHandler ('onClientClick', root, buttonClick)
    end

    return datas
end

function button:destroy ()
    if (not self) then return error ('Error in argument #1. Define the object.') end
    if (hover == self) then hover = nil end
    for position, data in ipairs (button.elements) do
        if (data == self) then
            table_remove (button.elements, position)
            if (#button.elements <= 0) then
                removeEventHandler ('onClientClick', root, buttonClick)
            end        
        end
    end
end

function button:isInside ()
    if (not isCursorShowing ()) then return end
    local cx, cy = getCursorPosition ()
    local x, y = (cx * screenW), (cy * screenH)
    return ((x >= self.x and x <= self.x + self.w) and (y >= self.y and y <= self.y + self.h))
end

local effects = {}

function button:interpolate (hover, colors, id)

    local type = self.textColor.hover == colors.hover and id..'text' or id..'bg'
    if (self ~= hover and effects[type]) then
        effects[type] = nil
    end

    local state = false
    if (hover and hover == self and colors.effect ~= 'none') then
        state = true
    end
    
    if (state) then
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

function button:render ()
    for position, self in ipairs (button.elements) do

        hover = nil
        if (self:isInside ()) then
            hover = self
        end

        dxDrawRectangle (
            self.x + 2, self.y + 2,
            self.w - 2, self.h - 4,
            self:interpolate (hover, self.bgColor, position)
        )

        dxDrawText (
            self.text,
            self.x + 2, self.y + 2,
            self.w - 2, self.h - 4,
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

export ('button', button)
