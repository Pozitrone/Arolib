-- All redstone has the same behavior -> Redstone off === farm/thing off
-- BaseControl by Arothe, https://toastynetworks.net/

-- Requirements
local term = require("term")
local component = require("component")
local gpu = compontent.gpu
local sides = require("sides")
local colors = require("colors")
local event = require("event")

-- Globals
runtime = true
entranceSid = sides.east
mobFarmSide = sides.north
laserDrillSide = sides.south
farmsSide = sides.west
width, height = gpu.getResolution()

-- Utils
function spacer()
    print("-------- <<A>> --------")
end


function colored(color, text)
    if color == "red" then
        print(gpu.setForeground(0xFF0000) .. text)
        gpu.setForeground(0xFFFFFF)
    elseif color == "blue" then
        print(gpu.setForeground(0x0000FF) .. text)
        gpu.setForeground(0xFFFFFF)
    elseif color == "green" then
        print(gpu.setForeground(0x0FF00) .. text)
        gpu.setForeground(0xFFFFFF)
    elseif color == "white" then
        print(gpu.setForeground(0xFFFFFF) .. text)
        gpu.setForeground(0xFFFFFF)
    elseif color == "black" then
        print(gpu.setForeground(0x000000) .. text)
        gpu.setForeground(0xFFFFFF)
    elseif color == "yellow" then
        print(gpu.setForeground(0xFFFF00) .. text)
        gpu.setForeground(0xFFFFFF)
    elseif color == "orange" then
        print(gpu.setForeground(0xFFAA00) .. text)
        gpu.setForeground(0xFFFFFF)
    end
end

    
function splitNumber(inputstr)
    sep = ","
    local t = {}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, tonumber(str))
    end
    return t
end


function tps() -- TPS function by Nex4rius
    local function time()
      local f = io.open("/tmp/TPS","w")
      f:write("test")
      f:close()
      return(require("filesystem").lastModified("/tmp/TPS"))
    end
    local realTimeOld = time()
    os.sleep(1)
    return 20000 / (time() - realTimeOld)
  end


function emergencyShutdown()
    redstone.setBundledOutput(sides.west,   [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
    redstone.setBundledOutput(sides.north,  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
    redstone.setBundledOutput(sides.south,  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
    redstone.setBundledOutput(sides.east,   [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
    redstone.setBundledOutput(sides.up,     [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
    redstone.setBundledOutput(sides.down,   [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,15]) -- Black on Down is emergency channel
    runtime = false
    term.clear()
    gpu.setForeground(0xFF0000)
    text = "!!! EMERGENCY SHUTDOWN !!!"
    gpu.set(width / 2 - #text / 2, height / 2, text)
    gpu.setForeground(0xFFFFFF)
end

table.reduce = function (list, fn) 
    local acc
    for k, v in ipairs(list) do
        if 1 == k then
            acc = v
        else
            acc = fn(acc, v)
        end 
    end 
    return acc 
end


function tableSum(table)
    return table.reduce({1, 2, 3}, 
        function (a, b)
            return a + b
        end
    )
end

-- Initialize
function initialize()
    print("Initiating base control.")
    spacer()

    print("Reseting Emergency channel...")
    redstone.setBundledOutput(sides.down, colors.black, 0)
    os.sleep(1)

    print("Reseting Laser Drills...")
    resetLaserDrills()
    os.sleep(1)

    print("Reseting Farms...")
    resetFarms()
    os.sleep(1)

    print("Reseting Mob farm...")
    resetMobfarm()

    spacer()
    os.sleep(5)
    term.clear()
end


-- Mob Farming
function resetMobfarm()
    redstone.setBundledOutput(mobFarmSide, [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
end

function spawnerSelection()
    print("Please, select spawners you want to toggle.")
    spacer()
    print(" 1: Skeleton        |  2: Zombie")
    print(" 3: Creeper         |  4: Witch")
    print(" 5: Enderman        |  6: Slime")
    print(" 7: Blaze           |  8: Shulker")
    print(" 9: Android         | 10: Pigman")
    print("11: Wither skeleton | 12: Cow")
    print("13: Pink slime      | 14: Maze slime")
    print("15:                 | 16: ")
    spacer()
    print("You can select up to three spawners by their IDs. Separate them by commas.")

    local input = io.read()
    input = input:gsub("% ", "")
    spawners = splitNumber(input)

    if #spawners == 0 then
        error("No spawners selected.")
    elseif #spawners > 3 then
        error("Too many spawners selected.")
    else
        resetMobfarm()
        for spawner in spawners do
            redstone.setBundledOutput(mobFarmSide, spawner, 15)
        end
    end
end

-- Laser drills
function resetLaserDrills()
    redstone.setOutput(laserDrillSide, 0)
end

function startLaserDrills()
    redstone.setOutput(laserDrillSide, 15)
end

-- Farms
function resetFarms()
    redstone.setOutput(farmsSide, 0)
end

function startFarms()
    redstone.setOutput(farmsSide, 15)
end


-- Main runtime
while runtime do
    local tps = tps()
    print("Current Ticks Per Second:")
    if tps > 15 then
        colored("green", tps)
    elseif tps > 10 then
        colored("yellow", tps)
    elseif tps > 5 then
        colored("orange", tps)
    else
        colored("red", tps)
    end

    spacer()
    print("Service status:")
    print("")
    print("Mob farm: ")
    if tableSum(redstone.getBundledOutput(mobFarmSide)) > 0 then
        colored("green", "Operational.")
    else
        colored("red", "Stopped.")

    print("Farms: ")
    if tableSum(redstone.getBundledOutput(farmsSide)) > 0 then
        colored("green", "Operational.")
    else
        colored("red", "Stopped.")

    print("Laser drills: ")
    if tableSum(redstone.getBundledOutput(laserDrillSide)) > 0 then
        colored("green", "Operational.")
    else
        colored("red", "Stopped.")
    

    if tps < 15 then
        colored("yellow", "TPS LOW, SHUTTING DOWN MOB FARM")
        resetMobfarm()
    end

    if tps < 10 then
        colored("orange", "TPS VERY LOW, SHUTTING DOWN FARMS")
        resetFarms()
    end

    if tps < 5 then
        colored("red", "TPS REALLY LOW, SHUTTING DOWN LASER DRILLS")
        resetLaserDrills()
    end

    if tps < 2 then
        colored("red", "TPS TOO LOW, INITIATING EMERGENCY SHUTDOWN IN")
        colored("red", "3")
        os.sleep(1)
        term.clearLine()
        colored("red", "2")
        os.sleep(1)
        term.clearLine()
        colored("red", "1")
        os.sleep(1)
        term.clearLine()
        emergencyShutdown()
    end

        os.sleep(10)
end

-- Emergency shutdown button
event.listen("redstone_changed", function(address, side, oldValue, newValue, color)
    if color == colors.black then
        emergencyShutdown()
    end
end
)

