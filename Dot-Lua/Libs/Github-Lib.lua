local Lib = {}
local Json = require("json")
local PrettyJson = require("pretty-json")
local Http = require("coro-http")

local Repro = "https://api.github.com/repos/Dot-lua/Runtime/releases"

local FS = require('fs')
local Read, Write, ReadDir = FS.readFileSync, FS.writeFileSync, FS.readdirSync

function GetRemote()
    local WebRequest, WebBody
    local Running = true
    local Times = 0
    
    WebRequest, WebBody = Http.request("GET", Repro, {{"User-Agent", "Dot-Lua Runtime"}})

    local Decode = Json.decode(WebBody)

    _G.RemoteVersion = Decode[1].tag_name

    return Decode[1].tag_name
end

local function Correct(Data)
    if Data.NotCorrected then
        Data.NotCorrected = nil
        Data.GetRemote = true
        Data.LastGotten = require("discordia").Date():toSeconds()

        local Encoded = PrettyJson.stringify(Data, nil, 4)
        Write("./Config/VersionData.json", Encoded)
    end
end

function Lib.GetVersion()
    local FileData = Read("./Config/VersionData.json")
    local Decode = Json.decode(FileData)

    Correct(Decode)

    return Decode["Tag-Version"]
end

function Lib.IsEnabled()
    local FileData = Read("./Config/VersionData.json")
    local Decode = Json.decode(FileData)

    return Decode["GetRemote"]
end

function Lib.GetRemoteVersion()
    if RemoteVersion then
        return RemoteVersion
    else
        return GetRemote()
    end
end

function Lib.IsLatest()

    if not Lib.IsEnabled then return true end

    local ThisVersion = Lib.GetVersion()
    local ThatVersion = Lib.GetRemoteVersion()

    return ThisVersion == ThatVersion
end

return Lib