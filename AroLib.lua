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

local gpu = compontent.gpu
local rs = component.redstone

-- Functions

function help()
    print("tps() - calculates TPS")
    print("farmsControl() - outputs redstone in the front if TPS > 15")
    print("help() - shows this list")
end


function tps() -- TPS function by Nex4rius

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



function farmsControl() -- Outputs redstone from the front, when tps > 15, else stops the signal. Checks every 10 seconds.
    while true do
        local tps = tps()
        if tps > 15 then
            print("TPS status nominal, farms running. " + tps)
            rs.setOutput(sides.front, 15)
        else
            print("TPS are too low, farm are not running! "  + tps)
            rs.setOutput(sides.front, 0)
        end
        os.sleep(10)
    end
end
        