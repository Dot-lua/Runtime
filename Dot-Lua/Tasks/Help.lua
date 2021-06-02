return {
    Arguments = {
        "[Command]"
    },
    Execute = function (Args)
    
        if Args[1] then

            local LowerCommand = string.lower(Args[1])

            if not Tasks[LowerCommand] then 
                ProcessHelper.Fail("The command '" .. Args[1] .. "' does not exist!")
                return
            end

            Logger.Info("Usage for: '" .. Args[1] .. "'")
            Logger.Info("'Dot-Lua " .. Args[1] .. " " .. table.concat(Tasks[LowerCommand].Arguments, " ") .. "'")

        else

            Logger.Error("You gave no or a unknown command to the runtime!")
            Logger.Error("Usage: `./Dot-Lua [Task] [Options]`")
            Logger.Error("You can use the following commands:")

            for i, v in pairs(Tasks) do
                Logger.Error("- " .. i .. " " .. table.concat(v.Arguments, " "))
            end

            ProcessHelper.Fail()

        end

    end
}