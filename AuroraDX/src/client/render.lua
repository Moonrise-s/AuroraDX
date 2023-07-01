
-- local button = import 'button'
-- local list = import 'list'

local function render ()
    aurora.button:render ()
    -- list:render ()
end
addEventHandler ('onClientRender', root, render)