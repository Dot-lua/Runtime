local Logger = require("Logger")

return {
    Arguments = {
        "[File]",
        "--debugmode=[Mode: true, false]"
    },
    Execute = function(Args)
        local Path = require("Path")
        local Split = require("Split")

        if not Args[1] then
            ProcessHelper.Fail("File not found!")
            return
        end

        _G.ProcessId = require("RandomString")(10)

        --print()

        Logger.Info("Starting process with id: " .. ProcessId)
        _G.ProcessPath = RuntimePath .. "Cache/Processes/" .. ProcessId .. "/"

        FS.mkdirSync(RuntimePath .. "Cache/Processes/")
        FS.mkdirSync(RuntimePath .. "Cache/Processes/" .. ProcessId .. "/")
        FS.mkdirSync(RuntimePath .. "Cache/Processes/" .. ProcessId .. "/Archives/")
        FS.mkdirSync(RuntimePath .. "Cache/Processes/" .. ProcessId .. "/Running/")
        FS.mkdirSync(RuntimePath .. "Cache/Processes/" .. ProcessId .. "/Resources/")
        FS.mkdirSync(RuntimePath .. "Cache/Processes/" .. ProcessId .. "/UnpackCache/")

        --print()

        _G.LoadedPackages = {}
        
        _G.Import = require("Runtime/Import")
        _G.LoadPackage = require("Runtime/LoadPackage")
        _G.LoadInternal = require("Runtime/LoadInternal")

        LoadPackage(Args[1], false, true)

        
        local MainEntry = Import(ProcessInfo.Entrypoints.Main)

        if not MainEntry then
            ProcessHelper.Fail("The main entry of " .. ProcessInfo.ID .. " '" .. ProcessInfo.Entrypoints.Main .. "' was not found!")
            process:exit(1)
        end

        local EntryWorked, EntryError = pcall(function()
            MainEntry.OnInitialize()
        end)

        if not EntryWorked then

            local ParseStepOne = Split(EntryError, "\\")

            table.remove(ParseStepOne, 1)
            table.remove(ParseStepOne, 1)
            table.remove(ParseStepOne, 1)

            local ParseStepTwo = ParseStepOne[#ParseStepOne]    
            table.remove(ParseStepOne, #ParseStepOne)
            local TwoParsed = Split(ParseStepTwo, ":")

            print()
            Logger.Error("Error at: '" .. table.concat(ParseStepOne, ".") .. "." .. TwoParsed[1] .. "' line: " .. TwoParsed[2])
            ProcessHelper.Fail(string.sub(TwoParsed[3], 2))

            process:exit(1)
        else
            ProcessHelper.Complete()
        end
        



    end
}