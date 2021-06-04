return function(Path)
    local Split = require("Split")

    local PathSplitted = Split(Path, ".")
    
    for i, v in pairs(PathSplitted) do print(i, v) end

end