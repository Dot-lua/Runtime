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

        local FilePos = Path.resolve(Args[1])
        local FileBase = Path.basename(FilePos)
        local Extension = Path.extname(FileBase)
        local Exists = FS.existsSync(FilePos)
        

        local CorrectExtension = Extension == ".dua"

        Logger.Info("Trying to load file " .. FilePos)
        Logger.Info("File name is: " .. FileBase)
        Logger.Info("Is Correct Extension: " .. tostring(CorrectExtension))
        Logger.Info("Exists: " .. tostring(CorrectExtension))
        
        if not Exists or not Extension then
            ProcessHelper.Fail("'" .. FileBase .. "' is not a valid DUA archive!")
            return
        end

        ProcessId = require("RandomString")(10)

        Logger.Info("Starting process with id: " .. ProcessId)

        FS.mkdirSync("./Cache/Processes/")
        FS.mkdirSync("./Cache/Processes/" .. ProcessId .. "/")
        FS.mkdirSync("./Cache/Processes/" .. ProcessId .. "/Archives/")
        FS.mkdirSync("./Cache/Processes/" .. ProcessId .. "/Running/")
        FS.mkdirSync("./Cache/Processes/" .. ProcessId .. "/Resources/")
        FS.mkdirSync("./Cache/Processes/" .. ProcessId .. "/UnpackCache/")
        
        
    end
}