local checkbox = {}
checkbox.elements = {}
local hover

function checkbox:create(data)
    if not self then
        return error('Argument #1 is NULL. Define the object.')
    end
    
    if self.elements[id] then
        return error('Checkbox already exists.')
    end
    
    local datas = data
    
    setmetatable(datas, { __index = checkbox })
    table.insert(checkbox.elements, datas)
    
    if #checkbox.elements == 1 then
        addEventHandler('onClientClick', root, checkboxClick)
    end
    
    return datas
end

function checkbox:destroy()
    if not self then
        return error('Argument #1 is NULL. Define the object.')
    end
    
    if hover == self then
        hover = nil
    end
    
    for position, data in ipairs(checkbox.elements) do
        if data == self then
            table.remove(checkbox.elements, position)
            if #checkbox.elements == 0 then
                removeEventHandler('onClientClick', root, checkboxClick)
            end
            break
        end
    end
end

function checkbox:isInside()
    if not isCursorShowing() then
        return false
    end
    
    local cx, cy = getCursorPosition()
    local x, y = cx * screenW, cy * screenH
    
    return (x >= self.x and x <= self.x + self.w) and (y >= self.y and y <= self.y + self.h)
end

function checkbox:render()
    for position, self in ipairs(checkbox.elements) do
        hover = nil
        if self:isInside() then
            hover = self
        end
        
        dxDrawRectangle(
        self.x, self.y,
        self.w, self.h,
        tocolor(unpack(self.checkbox.checked and self.checkbox.checkColor or self.checkbox.uncheckColor))
    )
    end
end

function checkboxClick(button, state, x, y)
    if button == 'left' and state == 'down' then
        for index, chkbox in ipairs(checkbox.elements) do
            if chkbox and chkbox:isInside() then
                chkbox.checkbox.checked = not chkbox.checkbox.checked
            end
        end
    end
end

export('checkbox', checkbox)
