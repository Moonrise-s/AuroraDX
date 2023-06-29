
screenW, screenH = guiGetScreenSize()

_dxDrawText = dxDrawText
function dxDrawText (text, x, y, w, h, ...)
    return _dxDrawText (text, x, y, x + w, y + h, ...)
end
