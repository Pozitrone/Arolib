-- All redstone has the same behavior -> Redstone off === farm/thing off
-- BaseControl by Arothe, https://toastynetworks.net/

-- Requirements
local term = require("term")
local component = require("component")
local gpu = compontent.gpu
local sides = require("sides")
local colors = require("colors")

-- Globals
runtime = true
mobFarmSide = sides.north;
laserDrillSide = 

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
    redstone.setBundledOutput(sides.down,   [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
    term.clear()
    colored("red","!!! EMERGENCY SHUTDOWN !!!");
    runtime = false
end


-- Initialize
function initialize()
    print("Initiating base control.")
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
        redstone.setBundledOutput(mobFarmSide, {spawners = 15})
    end
end

-- Laser drills
function resetLaserDrills()
    redstone.setOutput(laserDrillSide, 0)
end

function startLaserDrills()
    redstone.setOutput(laserDrillSide, 15)
end

-- Main runtime
while runtime do
    local tps = tps()

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

    if tps < 15 then
        colored("yellow", "TPS LOW, SHUTTING DOWN MOB FARM")
        resetMobfarm()
    end

    if tpx < 10 then
        colored("orange", "TPS VERY LOW, SHUTTING DOWN LASER DRILLS")

        os.sleep(10)
end

