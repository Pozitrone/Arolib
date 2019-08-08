-- wget -f 'https://raw.githubusercontent.com/Pozitrone/Base-Control/master/AroLib.lua' /home/arolib.lua

-- import these functions using
-- arolib = require("arolib")

-- run using
-- arolib.function()

---------------------------------------

-- Imports

local term = require("term")
local component = require("component")
local sides = require("sides")
local colors = require("colors")
local event = require("event")

-- Components

local gpu = component.gpu
local rs = component.redstone

-- Colors

local red = 0xFF0000
local blue = 0x0000FF
local green = 0x0FF00
local white = 0xFFFFFF
local black = 0x000000
local yellow = 0xFFFF00
local orange = 0xFFAA00

-- Functions

local arolib = {}

function arolib.help()
    print("tps(): number - calculates TPS")
    print("farmsControl(): void - outputs redstone in the front if TPS > 15")
    print("colortps(tps: number): void - prints out tps in a color")
    print("help() - shows this list")
end


function arolib.tps() -- TPS function by Nex4rius

    local function time()
        local f = io.open("/tmp/TPS","w")
        f:write("Woof!")
        f:close()
        return(require("filesystem").lastModified("/tmp/TPS"))
    end

    local realTimeOld = time()
    os.sleep(1)
    ticks = 20000 / (time() - realTimeOld)
    if ticks > 20 then
        return 20
    else
        return ticks
    end
end


function arolib.farmsControl() -- Outputs redstone from the back, when tps > 15, else stops the signal. Checks every 10 seconds.
    while true do
        local tps = tps()
        if tps > 15 then
            print("TPS status nominal, farms running.")
            colortps(tps)
            rs.setOutput(sides.back, 15)
        else
            print("TPS are too low, farm are not running!")
            colortps(tps)
            rs.setOutput(sides.back, 0)
        end
        os.sleep(10)
    end
end


function arolib.colortps(tps) -- Prints out TPS in according color
    if tps > 15 then
        gpu.setForeground(colors.green)
    elseif tps > 5 then
        gpu.setForeground(colors.orange)
    else
        gpu.setForeground(colors.red)
    end
    print(tps)
    gpu.setForeground(colors.white)
end



return arolib
        