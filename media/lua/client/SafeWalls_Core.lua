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


function SafeWalls.isAdm()
    local pl = getPlayer()
    return ((pl and string.lower(pl:getAccessLevel()) == "admin") or (isClient() and isAdmin())) and pl:isBuildCheat()
end


function SafeWalls.isProtected(obj)

    if not obj then return false end

    local isProtectWalls = SandboxVars.SafeWalls.ProtectWalls
    local isProtectBarricade = SandboxVars.SafeWalls.ProtectBarricade
    if isProtectBarricade and (instanceof(obj, "IsoBarricade") or (obj.isBarricaded and obj:isBarricaded())) then
        return true    
    elseif isProtectWalls and ((instanceof(obj, "IsoWall") or (obj.isWall and obj:isWall()))) then      
        return true
    end

    return false
end

function SafeWalls.attack(char, wpn, obj)
    if instanceof(obj, "IsoThumpable") then  
        if not SafeWalls.isProtected(obj) then
            local hp = obj:getHealth()
            local max = obj:getMaxHealth()
            if hp and max and hp < max then        
                obj:setHealth(max)
            end        
        end
    end
end
Events.OnWeaponHitThumpable.Remove(SafeWalls.attack)
Events.OnWeaponHitThumpable.Add(SafeWalls.attack)

--[[ 
function SafeWalls.isProtected(obj)

    if not obj then return end
    local isProtectWalls = SandboxVars.SafeWalls.ProtectWalls
    local isProtectBarricade = SandboxVars.SafeWalls.ProtectBarricade

    if instanceof(obj, "IsoBarricade") or instanceof(obj, "IsoWall") then
        if (obj.isWall and obj:isWall()) or (obj.isBarricaded and obj:isBarricaded())  then
        --if obj:isDismantable() then  obj:setIsDismantable(false) 
        end
        return true
    end
    if not obj then return end
    if isProtectBarricade and ((instanceof(obj, "IsoBarricade") or (obj.isWall and obj:isWall())))  then
    end
    if isProtectWalls and ((instanceof(obj, "IsoWall") or (obj.isWall and obj:isWall())))  then
        --if obj:isDismantable() then  obj:setIsDismantable(false) 
        return true
    end


    return false
end
 ]]




