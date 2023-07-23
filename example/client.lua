--[[AddEventHandler('onClientResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    ccui.menu.create(1, 'Select Spawn')
    ccui.menu.addItem(1, 'item1', 'Paleto Bay', 1, 'ccui.menu.close(1)')
    ccui.menu.addItem(1, 'item2', 'Downtown Los Santos', 2, 'testFunction()')
    ccui.menu.addItem(1, 'item3', 'Vespucci', 3, 'testFunction()')
    ccui.menu.addItem(1, 'item4', 'East Los Santos', 4, 'testFunction()')
    ccui.menu.open(1)
    --dumpTable(database[1])
end)

function 
    testFunction() ccui.menu.close(1)
    print('Menu Closed') 
end]]


-- This example is a basic TP menu that opens with the keybind F5
Citizen.CreateThread(function()
    -- Define Menu
    ccui.menu.create(2, 'TP Menu Example')
    ccui.menu.addItem(2, 'item1', 'Paleto Bay', 1, 'SetEntityCoords(GetPlayerPed(-1), -1610.0,  6600.0, 20.0, false, false, false, true)')
    ccui.menu.addItem(2, 'item2', 'Downtown Los Santos', 2, 'SetEntityCoords(GetPlayerPed(-1),  250.0,  -1400.0, 30.0, false, false, false, true)')
    ccui.menu.addItem(2, 'item3', 'Vespucci', 3, 'SetEntityCoords(GetPlayerPed(-1), -1000.0, -1600.0, 10.0, false, false, false, true)')
    ccui.menu.addItem(2, 'item4', 'East Los Santos', 4, 'SetEntityCoords(GetPlayerPed(-1), 980.0,  -950.0, 43.0, false, false, false, true)')
    
    local isMenuActive = false
    while true do 
        Citizen.Wait(0)
        if IsControlJustPressed(0, 318) then  -- F5
            -- Toggle Menu
            if isMenuActive == false then
                ccui.menu.open(2)
            else
                ccui.menu.close(2)
            end
            isMenuActive = not isMenuActive
        end
    end
end)