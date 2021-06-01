return {
    Execute = function (Args)
    
        Logger.Error("You gave no or a unknown command to the runtime!")
        Logger.Error("Usage: `./Dot-Lua [Task] [Options]`")
        Logger.Error("You can use the following commands:")

        for i, v in pairs(Tasks) do
            Logger.Error("- " .. i)
        end

        ProcessHelper.Fail()

    end
}