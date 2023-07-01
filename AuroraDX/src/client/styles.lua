
aurora.styles = { }

styles = {
    button = {
        create = {
            rounded = function (position, w, h, rx)
                aurora.styles['rounded - '..position] = aurora.svg:create (w, h, rx)
            end,
    
            circle = function (position, w, h)
                aurora.styles['circle - '..position] = aurora.svg:create (w, h, (2 * math.pi) * (math.min (w, h) / 2))
            end
        },

        render = {
            rounded = function (x, y, w, h, position, color, ...)
                dxSetBlendMode ('add')
                dxDrawImage (x, y, w, h, aurora.styles['rounded - '..position], 0, 0, 0, color, ...)
                dxSetBlendMode ('blend')
            end,
            
            circle = function (x, y, w, h, position, color, ...)
                dxSetBlendMode ('add')
                dxDrawImage (x, y, w, h, aurora.styles['circle - '..position], 0, 0, 0, color, ...)
                dxSetBlendMode ('blend')
            end,
            
            default = function (x, y, w, h, position, color, ...)
                dxDrawRectangle (x, y, w, h, color, ...)
            end
        }
    }
}

function styleManager (component, style, ...)
    if (not style and styles[component]) then return error ('Argument #1. Define the style.') end
    if (style == 'default') then return end
    return styles[component].create[style] (...)
end