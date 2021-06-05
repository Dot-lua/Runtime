return function(PackagePath, Log, IsMain)

    local Path = require("path")
    local Logger = require("Logger")

    local FilePos = Path.resolve(PackagePath)
    local FileBase = Path.basename(FilePos)
    local Extension = Path.extname(FileBase)
    local Exists = FS.existsSync(FilePos)

    if Log then
        local CorrectExtension = Extension == ".dua"

        Logger.Info("Trying to load file " .. FilePos)
        Logger.Info("File name is: " .. FileBase)
        Logger.Info("Is Correct Extension: " .. tostring(CorrectExtension))
        Logger.Info("Extension: '" .. (Extension or "") .. "'")
        Logger.Info("Exists: " .. tostring(Exists))
        
    end

    if not Exists or not Extension then
        ProcessHelper.Fail("'" .. FileBase .. "' is not a valid DUA archive!")
        process:exit(1)
    end

    local MalformedRuntimePath = string.sub(RuntimePath, 1, #RuntimePath - 1)

    --print(RuntimePath)
    --print(MalformedRuntimePath)
    
    local CommandWindows = "PowerShell -NoProfile -ExecutionPolicy unrestricted -File " .. RuntimePath .. "Scripts/Loaders/DuaLoader.ps1 \"" .. MalformedRuntimePath .. "\"" .. " " .. ProcessId .. " " .. FilePos .. " " .. FileBase
    local CommandMac = "sh " .. RuntimePath .. "Scripts/Loaders/DuaLoader.sh " .. ProcessId .. " " .. FilePos .. " " .. FileBase

    local Handle

    if WorkingOS == "Windows" then
        Handle = io.popen(CommandWindows)
    elseif WorkingOS == "Mac" then
        Handle = io.popen(CommandMac)
    end

    for Line in Handle:lines() do
        Logger.Info(Line)
    end

    local ResDirExists = FS.existsSync(ProcessPath .. "UnpackCache/resources/")

    if ResDirExists then
        local ResDir = FS.readdirSync(ProcessPath .. "UnpackCache/resources/")

        for i, v in pairs(ResDir) do
            FS.renameSync(
                ProcessPath .. "UnpackCache/resources/" .. v,
                ProcessPath .. "/Resources/" .. v
            )
        end

        FS.rmdirSync(ProcessPath .. "UnpackCache/resources/" )
    end

    --[[
    FS.renameSync(
        ProcessPath .. "UnpackCache/package.info.lua",
        ProcessPath .. "Running/package.info.lua"
    )
    ]]

    local PackageInfo = require("require")("")(ProcessPath .. "UnpackCache/package.info.lua")

    LoadedPackages[PackageInfo.ID] = PackageInfo

    FS.unlinkSync(ProcessPath .. "UnpackCache/package.info.lua")

    if IsMain then
        _G.ProcessInfo = PackageInfo
    end

    local DirFiles = FS.readdirSync(ProcessPath .. "UnpackCache/")

    for i, v in pairs(DirFiles) do
        FS.renameSync(
            ProcessPath .. "UnpackCache/" .. v,
            ProcessPath .. "Running/" .. v
        )
    end
end