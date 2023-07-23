ccui = {
    menu = {}
}

local database = {}
local activeMenu = nil

function ccui.menu.create(id, title, description, color)
    if not database[id] then
        database[id] = {
            title = title,
            description = description or '',
            color = color or 'blue',
            data = {}
        }
    else
        print('Error trying to create a menu with an id that already exists ('..id..')')
    end
end
function ccui.menu.addItem(id, itemid, name, priority, itemFunction)
    if database[id] and database[id].data then
        if not database[id].data[itemid] then
            database[id].data[itemid] = {}
            database[id].data[itemid]['name'] = name
            database[id].data[itemid]['priority'] = priority
        end
        database[id].data[itemid]['itemFunction'] = itemFunction
    end
end

function ccui.menu.open(id)
    if not activeMenu then 
        Citizen.Wait(100) -- Mandatory Wait
        SendNUIMessage({
            id = id;
            data = database[id];
            task = 'menu-open';
            active = 1;
        })
        activeMenu = id
    else
        print('There is already an active menu (' .. activeMenu .. ')')
    end
end

local selectedItem = nil
local ItemCount = nil

function ccui.menu.close(id)
    if not activeMenu then 
        -- No menu to close
    elseif activeMenu == id then
        Citizen.Wait(100) -- Mandatory Wait
        SendNUIMessage({
            id = id;
            task = 'menu-close';
        })
        activeMenu = nil
    end
    selectedItem = nil
    ItemCount = nil
end

function HandleArrowKeys(key)
    if not selectedItem then
        selectedItem = 1
    end
    if not ItemCount then
        ItemCount = 0
        for k in pairs(database[activeMenu].data) do
            ItemCount = ItemCount + 1
        end
    end

    local oldSelectedItem = selectedItem
    
    if key == "UP" then
      selectedItem = selectedItem - 1
      if selectedItem < 1 then
        selectedItem = ItemCount
      end
    elseif key == "DOWN" then
      selectedItem = selectedItem + 1
      if selectedItem > ItemCount then
        selectedItem = 1
      end
    elseif key == "FOWARD" then
        local itemFunctionTable = nil
        for k, v in pairs(database[activeMenu].data) do
            if v.priority == selectedItem then
                local loadedFunction, errorMessage = load("return " .. v.itemFunction)
                if loadedFunction then
                    -- Execute the function
                    local success, result = pcall(loadedFunction)
                
                    if not success then
                        print("Error executing the function:", result)
                    end
                else
                    print("Error loading the function:", errorMessage)
                end
            end
        end
    elseif key == "BACK" then

    end
    setSelectedMenuItem(oldSelectedItem, selectedItem)
end

function setSelectedMenuItem(oldSelectedItem, selectedItem)
    Citizen.Wait(100)
    SendNUIMessage({
        id = id;
        data = database[id];
        task = 'menu-update-selection';
        oldSelectedItem = oldSelectedItem;
        selectedItem = selectedItem;

    })
end
  

Citizen.CreateThread(function()
    while true do 
        Citizen.Wait(0)
        if activeMenu then
            if IsControlJustPressed(0, 172) then  -- ARROW UP
                HandleArrowKeys("UP")
            end
            if IsControlJustPressed(0, 173) then  -- ARROW DOWN
                HandleArrowKeys("DOWN")
            end
            if IsControlJustPressed(0, 18) then  -- ENTER / LEFT MOUSE BUTTON / SPACEBAR
                HandleArrowKeys("FOWARD")
            end
            if IsControlJustPressed(0, 177) then  -- BACKSPACE / ESC / RIGHT MOUSE BUTTON
                HandleArrowKeys("BACK")
            end
        end
    end
end)

-- DUMPER
function table_dump(tbl, indent)
    if not indent then
        indent = 0
    end

    for k, v in pairs(tbl) do
        local formatting = string.rep("  ", indent) .. k .. ": "
        if type(v) == "table" then
            print(formatting)
            table_dump(v, indent + 1)
        else
            print(formatting .. tostring(v))
        end
    end
end