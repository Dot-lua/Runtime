local Lib = {}
local Json = require("json")
local PrettyJson = require("pretty-json")
local Http = require("coro-http")

local Repro = "https://api.github.com/repos/Dot-lua/Runtime/releases"

local FS = require('fs')
local Read, Write, ReadDir, Exists = FS.readFileSync, FS.writeFileSync, FS.readdirSync, FS.existsSync

local RawData = Read(RuntimePath .. "Config/VersionData.json")
local VersionData = Json.decode(RawData)

if VersionData.NotCorrected then
    VersionData.NotCorrected = nil
    VersionData.GetRemote = true
    VersionData.LastGotten = require("discordia").Date():toSeconds()

    local EncodedVersionData = PrettyJson.stringify(VersionData, nil, 4)
    Write(RuntimePath .. "Config/VersionData.json", EncodedVersionData)
end

local function GetRemote()
    local WebRequest, WebBody
    local Running = true
    local Times = 0
    
    WebRequest, WebBody = Http.request("GET", Repro, {{"User-Agent", "Dot-Lua Runtime"}})

    local Decode = Json.decode(WebBody)

    _G.RemoteVersion = Decode[1].tag_name

    return Decode[1].tag_name
end

function Lib.GetVersion()
    return VersionData["Tag-Version"]
end

function Lib.IsEnabled()
    return VersionData["GetRemote"]
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