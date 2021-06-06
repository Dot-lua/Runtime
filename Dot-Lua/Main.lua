coroutine.wrap(function ()

    print()

    -- Path.resolve(args[0] .. "/../../../")

    local Args = args
    table.remove(Args, 0)
    table.remove(Args, 1)

    _G.WorkingOS = Args[1]
    table.remove(Args, 1)

    
    
    local Watch = require("discordia").Stopwatch()
    Watch:start()

    
    local PathLibrary = require("path")
    
    local Logger = require("Logger")
    _G.ProcessHelper = require("ProcessHelper")(Watch)
    _G.FS = require("fs")
    _G.Json = require("json")
    local Read, Write, ReadDir, Exists = FS.readFileSync, FS.writeFileSync, FS.readdirSync, FS.existsSync
    local OpenGui = true

    

    if WorkingOS == "Windows" then
        _G.RuntimePath = PathLibrary.resolve(args[0] .. "/../../../")
    end
    
    Write(_G.process.env.appdata .. "\\Dot-Lua.RuntimePath", RuntimePath)

    local RawDevData = Read(RuntimePath .. "Config/Development.json")
    local DevData = Json.decode(RawDevData)
    _G.ShowDebug = DevData.Debug
    local GitLib = require("Github-Lib")

    Logger.Debug(RuntimePath)
    
    for i, v in pairs(Args) do
        if string.lower(v) == "-nogui" then
            OpenGui = false
        end
    end

    if OpenGui then
        if WorkingOS == "Windows" then

        end
    end
    
    if GitLib.IsEnabled() then
        if not GitLib.IsLatest() then
            Logger.Warn("You are running an older version of the Dot-Lua Runtime!")
            Logger.Warn("Update it! - View how to do so at http://Dotter.cubicinc.ga/update")
            Logger.Warn("Your version: " .. GitLib.GetVersion() .. " Remote version: " .. GitLib.GetRemoteVersion())
        else
            Logger.Info("Starting Runtime!")
            Logger.Info("Running version " .. GitLib.GetVersion())
        end
    else
        Logger.Warn("The runtime is currently configurated to not get the remote version!")
        Logger.Warn("You can ignore this if you know about this")
    end

    print()
    
    _G.RuntimeCommandsTasks = {
        run = require("./Tasks/Run.lua"),
        help = require("./Tasks/Help.lua")
    }
    
    if not Args[1] then
        RuntimeCommandsTasks.help.Execute(Args)
    else
        local Command = string.lower(Args[1])
        table.remove(Args, 1)

        if RuntimeCommandsTasks[Command] then
            RuntimeCommandsTasks[Command].Execute(Args)
        else
            ProcessHelper.Fail("Command '" .. Command .. "' does not exist!")
        end

    end
    
    print()

    
end)()
    