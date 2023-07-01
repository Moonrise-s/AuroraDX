
aurora.svg = { }

function aurora.svg:create (w, h, rx)
    local raw = string_format([[
        <svg width='%s' height='%s' >
            <rect rx='%s' width='%s' height='%s' fill='#FFFFFF' />
        </svg>
    ]], w, h, rx, w, h)
    return svgCreate (w, h, raw)
end