-- All redstone has the same behavior -> Redstone off === farm/thing off
-- BaseControl by Arothe, https://toastynetworks.net/

-- Utils
function spacer()
    print("-------- <<A>> --------")
end

function splitNumber(inputstr)
    sep = ","
    local t={}
    for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
            table.insert(t, tonumber(str))
    end
    return t
end


-- Initialize
print("Initiating base control.")
term.clear()

-- Mob Farming
function resetMobfarm()
    redstone.setBundledOutput(sides.west,   [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
    redstone.setBundledOutput(sides.north,  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
    redstone.setBundledOutput(sides.south,  [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
    redstone.setBundledOutput(sides.east,   [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
    redstone.setBundledOutput(sides.up,     [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
    redstone.setBundledOutput(sides.down,   [0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0])
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
    print("13: Pink slime      | 14: ")
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
        redstone.setBundledOutput(sides.down, {spawners = 15})
    end
    
end

