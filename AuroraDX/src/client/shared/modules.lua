
local modules = { }

function export (module, func)
    if (modules[module]) then return error ('1') end
    modules[module] = func
end

function import (module)
    if (not modules[module]) then return error ('2') end
    return modules[module]
end