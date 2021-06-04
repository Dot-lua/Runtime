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
        Logger.Info("Exstension: '" .. (Extension or "") .. "'")
        Logger.Info("Exists: " .. tostring(CorrectExtension))
        
        if not Exists or not Extension then
            ProcessHelper.Fail("'" .. FileBase .. "' is not a valid DUA archive!")
            return
        end

        ProcessId = require("RandomString")(10)

        print()

        Logger.Info("Starting process with id: " .. ProcessId)

        FS.mkdirSync("./Cache/Processes/")
        FS.mkdirSync("./Cache/Processes/" .. ProcessId .. "/")
        FS.mkdirSync("./Cache/Processes/" .. ProcessId .. "/Archives/")
        FS.mkdirSync("./Cache/Processes/" .. ProcessId .. "/Running/")
        FS.mkdirSync("./Cache/Processes/" .. ProcessId .. "/Resources/")
        FS.mkdirSync("./Cache/Processes/" .. ProcessId .. "/UnpackCache/")

        print()
        
        local CommandWindows = "PowerShell -NoProfile -ExecutionPolicy unrestricted -File ./Scripts/Loaders/DuaLoader.ps1 " .. ProcessId .. " " .. FilePos .. " " .. FileBase
        local CommandMac = "sh ./Scripts/Loaders/DuaLoader.sh " .. ProcessId .. " " .. FilePos .. " " .. FileBase

        local Handle

        if WorkingOS == "Windows" then
            Handle = io.popen(CommandWindows)
        elseif WorkingOS == "Mac" then
            --FS.chmodSync(CommandMac, 744)
            Handle = io.popen(CommandMac)
        end

        for Line in Handle:lines() do
            Logger.Info(Line)
        end

        FS.renameSync(
            "./Cache/Processes/" .. ProcessId .. "/UnpackCache/resources/",
            "./Cache/Processes/" .. ProcessId .. "/Resources/"
        )

        FS.renameSync(
            "./Cache/Processes/" .. ProcessId .. "/UnpackCache/package.info.lua",
            "./Cache/Processes/" .. ProcessId .. "/Running/package.info.lua"
        )

        local DirFiles = FS.readdirSync("./Cache/Processes/" .. ProcessId .. "/UnpackCache/")

        for i, v in pairs(DirFiles) do
            FS.renameSync(
                "./Cache/Processes/" .. ProcessId .. "/UnpackCache/" .. v,
                "./Cache/Processes/" .. ProcessId .. "/Running/" .. v
            )
        end

        local ProcessInfo = require("../Cache/Processes/" .. ProcessId .. "/Running/package.info.lua")

        _G.Import = require("Runtime/Import")

        Import(ProcessInfo.Entrypoints.Main)



    end
}