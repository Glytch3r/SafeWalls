----------------------------------------------------------------
-----  ▄▄▄   ▄    ▄   ▄  ▄▄▄▄▄   ▄▄▄   ▄   ▄   ▄▄▄    ▄▄▄  -----
----- █   ▀  █    █▄▄▄█    █    █   ▀  █▄▄▄█  ▀  ▄█  █ ▄▄▀ -----
----- █  ▀█  █      █      █    █   ▄  █   █  ▄   █  █   █ -----
-----  ▀▀▀▀  ▀▀▀▀   ▀      ▀     ▀▀▀   ▀   ▀   ▀▀▀   ▀   ▀ -----
----------------------------------------------------------------
--                                                            --
--   Project Zomboid Modding Commissions                      --
--   https://steamcommunity.com/id/glytch3r/myworkshopfiles   --
--                                                            --
--   ▫ Discord  ꞉   glytch3r                                  --
--   ▫ Support  ꞉   https://ko-fi.com/glytch3r                --
--   ▫ Youtube  ꞉   https://www.youtube.com/@glytch3r         --
--   ▫ Github   ꞉   https://github.com/Glytch3r               --
--                                                            --
----------------------------------------------------------------
----- ▄   ▄   ▄▄▄   ▄   ▄   ▄▄▄     ▄      ▄   ▄▄▄▄  ▄▄▄▄  -----
----- █   █  █   ▀  █   █  ▀   █    █      █      █  █▄  █ -----
----- ▄▀▀ █  █▀  ▄  █▀▀▀█  ▄   █    █    █▀▀▀█    █  ▄   █ -----
-----  ▀▀▀    ▀▀▀   ▀   ▀   ▀▀▀   ▀▀▀▀▀  ▀   ▀    ▀   ▀▀▀  -----
----------------------------------------------------------------

SafeWalls = SafeWalls or {}

function SafeWalls.stopFire(sq)
    local plNum = getPlayer():getPlayerNum()
    if plNum and sq:isCouldSee(plNum) then       
        if sq:Is(IsoFlagType.burning) then
            sq:transmitStopFire()
            sq:stopFire()
        end		
    end
end

function SafeWalls.isSquareToExtinguish(sq)
	if not sq then return false	end
	if sq:Is(IsoFlagType.burning) then
		for i = 1, sq:getObjects():size() do
			local fire = sq:getObjects():get(i - 1)
			if instanceof(fire, "IsoFire") and not fire:isPermanent() then
				return true
			end
		end
	end
	return false
end


function SafeWalls.fireHandler(fire)
    local isProtectFromFire = SandboxVars.SafeWalls.ProtectFromFire
    if not isProtectFromFire then return end
    local sq = fire:getSquare()
    if sq and SafeWalls.isSquareToExtinguish(sq) then
        SafeWalls.stopFire(sq)   
    end
end
Events.OnNewFire.Remove(SafeWalls.fireHandler)
Events.OnNewFire.Add(SafeWalls.fire)



-----------------------            ---------------------------
--[[ 
function SafeWalls.stopFire(sq)
    local plNum = getPlayer():getPlayerNum()
    if plNum and sq:isCouldSee(plNum) then       
        if sq:Is(IsoFlagType.burning) then
            sq:transmitStopFire()
            sq:stopFire()
        end		
    end
end

function SafeWalls.isSquareToExtinguish(sq)
	if not sq then return false	end
	if sq:Is(IsoFlagType.burning) then
		for i = 1, sq:getObjects():size() do
			local fire = sq:getObjects():get(i - 1)
			if instanceof(fire, "IsoFire") and not fire:isPermanent() then
				return true
			end
		end
	end
	return false
end


function SafeWalls.fireHandler(fire)
    local isProtectFromFire = SandboxVars.SafeWalls.ProtectFromFire
    if not isProtectFromFire then return end
    local sq = fire:getSquare()
    if sq and SafeWalls.isSquareToExtinguish(sq) then
        SafeWalls.stopFire(sq)   
    end
end
Events.OnNewFire.Remove(SafeWalls.fireHandler)
Events.OnNewFire.Add(SafeWalls.fire)

 ]]