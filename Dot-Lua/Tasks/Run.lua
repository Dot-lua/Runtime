return {
    Arguments = {
        "[File]",
        "--debugmode=[Mode: true, false]"
    },
    Execute = function(Args)
        local Path = require("Path")

        if not Args[1] then
            ProcessHelper.Fail("File not found!")
            return
        end

        local FilePos = Path.normalize(Args[1])

        Logger.Info("Loading file " .. FilePos)

        if not FilePos then
            ProcessHelper.Fail("File " .. Args[1] .. " not found!")
            return
        end
    end
}