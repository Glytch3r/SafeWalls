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





function SafeWalls.init()

    SafeWalls.ISUnbarricadeAction_isValid = ISUnbarricadeAction.isValid
    function ISUnbarricadeAction:isValid()
        local isProtectBarricade = SandboxVars.SafeWalls.ProtectBarricade
        if isProtectBarricade then
            return false
        end
        return SafeWalls.ISUnbarricadeAction_isValid(self)
    end



    SafeWalls.ISDestroyCursor_canDestroy = ISDestroyCursor.canDestroy
    function ISDestroyCursor:canDestroy(obj)

        if SafeWalls.isAdm() then return SafeWalls.ISDestroyCursor_canDestroy(self, obj) end        
        if (obj and (SafeWalls.isProtected(obj) or obj:getModData()['isCantSledge'])) then
            return false
        end
        return SafeWalls.ISDestroyCursor_canDestroy(self, obj)
    end

    SafeWalls.ISMoveablesAction_isValid = ISMoveablesAction.isValid
    function ISMoveablesAction:isValid()

        local isProtectWalls = SandboxVars.SafeWalls.ProtectWalls
        local isProtectBarricade = SandboxVars.SafeWalls.ProtectBarricade

        if SafeWalls.isAdm() or not self.moveProps or (self.mode and not (self.mode == "scrap" or self.mode == "pickup")) then
            return SafeWalls.ISMoveablesAction_isValid(self)
        end
        local obj = self.moveProps.object
        if obj then
            if SafeWalls.isProtected(obj) then
                self:stop()
                return false
            end
        end
        return SafeWalls.ISMoveablesAction_isValid(self)
    end



end
Events.OnGameStart.Remove(SafeWalls.init)
Events.OnGameStart.Add(SafeWalls.init)


