
-- ## Variables
local pedDisplaying = {}

-- ## Functions

-- OBJ : draw text in 3d
-- PARAMETERS :
--      - coords : world coordinates to where you want to draw the text
--      - text : the text to display
local function DrawText3D(coords, text)
    local camCoords = GetGameplayCamCoord()
    local dist = #(coords - camCoords)
    
    -- Experimental math to scale the text down
    local scale = 200 / (GetGameplayCamFov() * dist)

    -- Format the text
    local c = Config.visual.color
    SetTextColour(c.r, c.g, c.b, c.a)
    SetTextScale(0.0, Config.visual.scale * scale)
    SetTextFont(Config.visual.font)
    SetTextDropshadow(0, 0, 0, 0, 55)
    SetTextDropShadow()
    SetTextCentre(true)

    -- Diplay the text
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    SetDrawOrigin(coords, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()

end

local function DrawText3Ds(coords, text)
    local camCoords = GetGameplayCamCoord()
    local dist = #(coords - camCoords)
    
    -- Experimental math to scale the text down
    local scale = 200 / (GetGameplayCamFov() * dist)

    -- Format the text
    local c = Config.visuals.color
    SetTextColour(c.r, c.g, c.b, c.a)
    SetTextScale(0.0, Config.visuals.scale * scale)
    SetTextFont(Config.visuals.font)
    SetTextDropshadow(0, 0, 0, 0, 55)
    SetTextDropShadow()
    SetTextCentre(true)

    -- Diplay the text
    BeginTextCommandDisplayText("STRING")
    AddTextComponentSubstringPlayerName(text)
    SetDrawOrigin(coords, 0)
    EndTextCommandDisplayText(0.0, 0.0)
    ClearDrawOrigin()

end

-- OBJ : handle the drawing of text above a ped head
-- PARAMETERS :
--      - coords : world coordinates to where you want to draw the text
--      - text : the text to display
local function Display(ped, text)

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local pedCoords = GetEntityCoords(ped)
    local dist = #(playerCoords - pedCoords)

    if dist <= Config.visual.dist then

        pedDisplaying[ped] = (pedDisplaying[ped] or 1) + 1

        -- Timer
        local display = true

        Citizen.CreateThread(function()
            Wait(Config.visual.time)
            display = false
        end)

        -- Display
        local offset = 0.8 + pedDisplaying[ped] * 0.1
        while display do
            if HasEntityClearLosToEntity(playerPed, ped, 17 ) then
                local x, y, z = table.unpack(GetEntityCoords(ped))
                z = z + offset
                DrawText3D(vector3(x, y, z), text)
            end
            Wait(0)
        end

        pedDisplaying[ped] = pedDisplaying[ped] - 1

    end
end

local function DisplayDo(ped, text)

    local playerPed = PlayerPedId()
    local playerCoords = GetEntityCoords(playerPed)
    local pedCoords = GetEntityCoords(ped)
    local dist = #(playerCoords - pedCoords)

    if dist <= Config.visual.dist then

        pedDisplaying[ped] = (pedDisplaying[ped] or 1) + 1

        -- Timer
        local display = true

        Citizen.CreateThread(function()
            Wait(Config.visual.time)
            display = false
        end)

        -- Display
        local offset = 0.8 + pedDisplaying[ped] * 0.1
        while display do
            if HasEntityClearLosToEntity(playerPed, ped, 17 ) then
                local x, y, z = table.unpack(GetEntityCoords(ped))
                z = z + offset
                DrawText3Ds(vector3(x, y, z), text)
            end
            Wait(0)
        end

        pedDisplaying[ped] = pedDisplaying[ped] - 1

    end
end

-- ## Events

-- Share the display of 3D text
RegisterNetEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text, serverId)
    local player = GetPlayerFromServerId(serverId)
    if player ~= -1 then
        local ped = GetPlayerPed(player)
        Display(ped, text)
    end
end)

RegisterNetEvent('3dme:shareDisplayDo')
AddEventHandler('3dme:shareDisplayDo', function(text, serverId)
    local player = GetPlayerFromServerId(serverId)
    if player ~= -1 then
        local ped = GetPlayerPed(player)
        DisplayDo(ped, text)
    end
end)

local LANGUAGE = Config.language
TriggerEvent('chat:addSuggestion', '/' .. Languages[LANGUAGE].commandName, Languages[LANGUAGE].commandDescription, Languages[LANGUAGE].commandSuggestion)

-- ### CHAT MESSAGE


RegisterNetEvent('sendProximityMessageMe')
AddEventHandler('sendProximityMessageMe', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  local text = message 
  if pid == myId then
  local haveMask = false
  if GetPedDrawableVariation(GetPlayerPed(-1), 1) == 0 then
        haveMask = false
  else
        haveMask = true
  end 
  
  local mesaj = "ME - " .. name .. " "
  
  
  TriggerEvent('chat:addMessage',  {
    color = { 255, 255, 0, 0.8},
    multiline = true,
    args = {mesaj, text}
  })
  
  elseif pid ~= -1 and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 7.5 then
    local mesaj = "ME - " .. name .. " "
  
  
    TriggerEvent('chat:addMessage',  {
      color = { 255, 255, 0, 0.8},
      multiline = true,
      args = {mesaj, text}
    })
    
        -- local haveMask = false
        -- if GetPedDrawableVariation(GetPlayerPed(-1), 1) == 0 then
        --       haveMask = false
        -- else
        --       haveMask = true
        -- end
        -- TwoNa.TriggerServerCallback("2na_chat:registerRPText", { type = 'ME', typeColor = '#c79408', haveMask = haveMask, text = text })
    end
end)

RegisterNetEvent('sendProximityMessageDo')
AddEventHandler('sendProximityMessageDo', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  local text = message 
  if pid == myId then
    local haveMask = false
    if GetPedDrawableVariation(GetPlayerPed(-1), 1) == 0 then
          haveMask = false
    else
          haveMask = true
    end
    local mesaj = "DO - " .. name .. " "
    TriggerEvent('chat:addMessage', {
        color = {70, 101, 154, 0.8},
        multiline = true,
        args = {mesaj, text}
      
    })
  elseif pid ~= -1 and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 7.5 then
    local mesaj = "DO - " .. name .. " "
    TriggerEvent('chat:addMessage', {
        color = {70, 101, 154, 0.8},
        multiline = true,
        args = {mesaj, text}
      
    })
    -- local haveMask = false
    --     if GetPedDrawableVariation(GetPlayerPed(-1), 1) == 0 then
    --           haveMask = false
    --     else
    --           haveMask = true
    --     end
    --     TwoNa.TriggerServerCallback("2na_chat:registerRPText", { type = 'DO', typeColor = '#347deb', haveMask = haveMask, text = text })
  end
end)

RegisterNetEvent('sendProximityMessageZar')
AddEventHandler('sendProximityMessageZar', function(id, name, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 8px; margin: 8px; background-color: rgba(79, 210, 150, 1.0); border-radius: 6px;">Zar: <i class="fas fa-bell"style="font-size:15px"></i>^*{0}^r {1}</font></i></div>',
            args = { " " .. name , message }
			})
  elseif pid ~= -1 and GetDistanceBetweenCoords(GetEntityCoords(GetPlayerPed(myId)), GetEntityCoords(GetPlayerPed(pid)), true) < 7.5 then
    TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 8px; margin: 8px; background-color: rgba(79, 210, 150, 1.0); border-radius: 6px;">Zar: <i class="fas fa-bell"style="font-size:15px"></i>^*{0}^r {1}</font></i></div>',
            args = { " " .. name , message }
			})
  end
end)

RegisterNetEvent('dombili:meslek')
AddEventHandler('dombili:meslek', function(id, message)
  local myId = PlayerId()
  local pid = GetPlayerFromServerId(id)
  if pid == myId then
    print(message)
    TriggerEvent('chat:addMessage', {
			template = '<div style="padding: 8px; margin: 8px; background-color: rgba(79, 210, 150, 1.0); border-radius: 6px;"><i class="fas fa-bell"style="font-size:15px"></i> ^*({0})</font></i></b></div>',
            args = { message }
			})
  end
end)

RegisterNetEvent('3ddo:shareDisplay')
AddEventHandler('3ddo:shareDisplay', function(text, serverId)
    if Config.debugSystem == 1 then
        TriggerServerEvent('SB:debugSystem',false,"sb_3ddo","3ddo:shareDisplay",serverId,"client")
    end
    local player = GetPlayerFromServerId(serverId)
    if player ~= -1 then
        local ped = GetPlayerPed(player)
        Display(ped, text)
    end
end)

