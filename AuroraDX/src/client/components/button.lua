
local component = 'button'

aurora.button = { }
aurora.button.elements = { }

local hover

function aurora.button:create (data)
    if (not self) then return error ('Error in argument #1. Define the object.') end
    if (self.elements[id]) then return error ('Button exists') end

    setmetatable (data, {__index = aurora.button})
    table_insert (aurora.button.elements, data)
    styleManager (component, data.style.type, #aurora.button.elements, data.w, data.h, unpack (data.style.args))
    
    if (#aurora.button.elements <= 1) then
        addEventHandler ('onClientClick', root, buttonClick)
    end

    return data
end

function aurora.button:destroy ()
    if (not self) then return error ('Error in argument #1. Define the object.') end
    if (hover == self) then hover = nil end
    for position, data in ipairs (aurora.button.elements) do
        if (data == self) then
            table_remove (aurora.button.elements, position)
            if (#aurora.button.elements <= 0) then
                removeEventHandler ('onClientClick', root, buttonClick)
            end
        end
    end
end

function aurora.button:isInside ()
    if (not isCursorShowing ()) then return end
    local cx, cy = getCursorPosition ()
    local x, y = (cx * screenW), (cy * screenH)
    return ((x >= self.x and x <= self.x + self.w) and (y >= self.y and y <= self.y + self.h))
end

local effects = {}

function aurora.button:interpolate (colors, id)

    if (colors.effect ~= 'none') then
        local type = self.textColor.hover == colors.hover and id..'text' or id..'bg'
        if (not effects[type]) then
            effects[type] = {
                status = {start = colors.notHover, final = colors.notHover, effect = colors.easing.type, time = colors.easing.time},
                tick = getTickCount (),
                state = false
            }
        end
        
        if (hover) then
            if (not effects[type].state) then
                effects[type].status = {start = colors.notHover, final = colors.hover, effect = colors.easing.type, time = colors.easing.time}
                effects[type].tick = getTickCount ()
                effects[type].state = true
            end
        else
            if (effects[type].state) then
                effects[type].status = {final = colors.notHover, start = colors.hover, effect = colors.easing.type, time = colors.easing.time}
                effects[type].tick = getTickCount ()
                effects[type].state = false
            end
        end
        
        local r, g, b = interpolateBetween (
            effects[type].status.start[1],
            effects[type].status.start[2],
            effects[type].status.start[3],
            effects[type].status.final[1],
            effects[type].status.final[2],
            effects[type].status.final[3],
            (getTickCount () - effects[type].tick) / effects[type].status.time,
            effects[type].effect or 'Linear'
        )
        return tocolor (r, g, b)
    end

    return (hover == self and tocolor (unpack (colors.hover)) or tocolor (unpack (colors.notHover)))
end

function aurora.button:render ()
    for position, self in ipairs (aurora.button.elements) do

        hover = nil
        if (self:isInside ()) then
            hover = self
        end

        styles[component].render[self.style.type] (
            self.x, self.y,
            self.w, self.h,
            position,
            self:interpolate (self.bgColor, position)
        )

        dxDrawText (
            self.text,
            self.x, self.y,
            self.w, self.h,
            self:interpolate (self.textColor, position),
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
