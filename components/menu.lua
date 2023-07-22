local ccui = {
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
        database[id].data[itemid]['function'] = itemFunction
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