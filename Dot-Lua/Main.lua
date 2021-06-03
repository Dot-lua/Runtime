coroutine.wrap(function ()

    print()

    -- Path.resolve(args[0] .. "/../../../")

    local Args = args
    table.remove(Args, 0)
    table.remove(Args, 1)

    _G.WorkingOS = Args[1]
    table.remove(Args, 1)

    _G.GitLib = require("Github-Lib")
    _G.Logger = require("Logger")
    _G.ProcessHelper = require("ProcessHelper")
    _G.FS = require("fs")
    _G.Json = require("json")
    _G.Watch = require("discordia").Stopwatch()
    Watch:start()
    
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
    
    _G.Tasks = {
        run = require("./Tasks/Run.lua"),
        help = require("./Tasks/Help.lua")
    }
    
    if not Args[1] then
        Tasks.help.Execute(Args)
    else
        local Command = string.lower(Args[1])
        table.remove(Args, 1)

        if Tasks[Command] then
            Tasks[Command].Execute(Args)
        else
            ProcessHelper.Fail("Command '" .. Command .. "' does not exist!")
        end

    end
    
    print()
    
end)()
    