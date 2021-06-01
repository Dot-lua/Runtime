
--[[
	Hello there, reader of this file.
	i just want to note to you:
	i reworked the discordia logger from
	https://github.com/SinisterRectus/Discordia/blob/master/libs/utils/Logger.lua
	-- Thanks
]]

local date = os.date
local format = string.format
local stdout = _G.process.stdout.handle

local BLACK   = 30
local RED     = 31
local GREEN   = 32
local YELLOW  = 33
local BLUE    = 34
local MAGENTA = 35
local CYAN    = 36
local WHITE   = 37

local config = {
	{'PROCESS FAILED', RED},
	{'PROCESS COMPLETE', GREEN},
}

local ProcessHelper = {}

do -- parse config
	local bold = 1
	for _, v in ipairs(config) do
		v[2] = format('\27[%i;%im%s\27[0m', bold, v[2], v[1])
	end
end


function ProcessHelper.Log(level, msg, ...)

	local tag = config[level]
	if not tag then return end

    msg = msg or ""

	msg = format(msg, ...)

	Watch:stop()

	local d = date("%Y-%m-%d %H:%M:%S")
	stdout:write(format('%s %s %s\n', tag[2], Watch:getTime():toString(), msg))

	return msg

end

function ProcessHelper.Fail(Msg, ...)
	ProcessHelper.Log(1, Msg, ... or "")
end

function ProcessHelper.Complete(Msg, ...)
	ProcessHelper.Log(2, Msg, ... or "")
end

return ProcessHelper