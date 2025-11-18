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

function SafeWalls.context(player, context, worldobjects, test)

	local pl = getSpecificPlayer(player)
	local obj = nil
    local sq
    if luautils.stringStarts(getCore():getVersion(), "42") then
        sq = ISWorldObjectContextMenu.fetchVars.clickedSquare
    else
        sq = clickedSquare
    end
    if not sq then return end

    local isProtectBarricade = SandboxVars.SafeWalls.ProtectBarricade    
	if isProtectBarricade and not SafeWalls.isAdm() then
        local tip = ISWorldObjectContextMenu.addToolTip()
		context:removeOptionByName(getText("ContextMenu_Unbarricade"))
        local optTip = opt:addOption(getText("ContextMenu_Unbarricade"), worldobjects, nil)
        local tip = ISWorldObjectContextMenu.addToolTip()
        tip.description = "Disabled by SafeWalls Mod"
		optTip.notAvailable = true
    end
end
Events.OnFillWorldObjectContextMenu.Remove(SafeWalls.context)
Events.OnFillWorldObjectContextMenu.Add(SafeWalls.context)

--[[ 
ISWorldObjectContextMenu.onUnbarricade = function(worldobjects, window, player)
    local playerObj = getSpecificPlayer(player)
	if luautils.walkAdjWindowOrDoor(playerObj, window:getSquare(), window) then
		if ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), predicateRemoveBarricade, true) then
			ISTimedActionQueue.add(ISUnbarricadeAction:new(playerObj, window, (200 - (playerObj:getPerkLevel(Perks.Woodwork) * 5))))
		end
	end
end

ISWorldObjectContextMenu.onUnbarricadeMetal = function(worldobjects, window, player)
    local playerObj = getSpecificPlayer(player)
    if luautils.walkAdjWindowOrDoor(playerObj, window:getSquare(), window) then
        ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), predicateBlowTorch, true);
        ISTimedActionQueue.add(ISUnbarricadeAction:new(playerObj, window, 120));
    end
end

ISWorldObjectContextMenu.onUnbarricadeMetalBar = function(worldobjects, window, player)
    local playerObj = getSpecificPlayer(player)
    if luautils.walkAdjWindowOrDoor(playerObj, window:getSquare(), window) then
        ISWorldObjectContextMenu.equip(playerObj, playerObj:getPrimaryHandItem(), predicateBlowTorch, true);
        ISTimedActionQueue.add(ISUnbarricadeAction:new(playerObj, window, 120));
    end
end

 ]]