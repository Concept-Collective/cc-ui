AddEventHandler('onClientResourceStart', function(resourceName)
    if (GetCurrentResourceName() ~= resourceName) then
        return
    end

    ccui.menu.create(1, 'Select Spawn')
    ccui.menu.addItem(1, 'item1', 'Paleto Bay', '1', print("Function for Item1 in Menu 1"))
    ccui.menu.addItem(1, 'item2', 'Downtown Los Santos', '2', print("Function for Item1 in Menu 2"))
    ccui.menu.addItem(1, 'item3', 'Vespucci', '3', print("Function for Item1 in Menu 3"))
    ccui.menu.addItem(1, 'item4', 'East Los Santos', '4', print("Function for Item1 in Menu 3"))
    ccui.menu.open(1)
    --dumpTable(database[1])
end)