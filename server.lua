local QBCore = exports['qb-core']:GetCoreObject()

local Webhook = "WEBHOOK"
local Webhook2 = "WEBHOOK"



-- Command
RegisterCommand('me', function(source, args)
	local player = QBCore.Functions.GetPlayer(source)
	local adsoyad = player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname
    local text = "" .. Languages[Config.language].prefix .. table.concat(args, " ") .. ""
	local sendtext = "``".. adsoyad .. " (" .. source .. ") ``" .. " adlı oyuncu bunu yazdı: " .. "**" .. text .. "**"
	TriggerClientEvent('3dme:shareDisplay', -1, text, source)

	TriggerClientEvent("sendProximityMessageMe", -1, source, adsoyad, table.concat(args, " "))
	TriggerEvent('ria-logs:server:CreateLog', 'melog', '**[ME LOG]**', 'red', sendtext, 'adlı oyuncu me emotunu kullandı içerik: ', text, true)
	TriggerEvent('ayazwai:me', name, adsoyad, text)
	
end)

RegisterCommand('do', function(source, args)
	local player = QBCore.Functions.GetPlayer(source)
	local adsoyad = player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname
    local text = "" .. Languages[Config.language].prefix .. table.concat(args, " ") .. ""
	local sendtext = "``".. adsoyad .. " (" .. source .. ") |" .. " Citizen ID = " .. player.PlayerData.citizenid ..  "``" .. " adlı oyuncu me kullandı: " .. "**" .. text .. "**"
    TriggerClientEvent('3dme:shareDisplayDo', -1, text, source)
	TriggerClientEvent("sendProximityMessageDo", -1, source, adsoyad, table.concat(args, " "))
	TriggerEvent('ria-logs:server:CreateLog', 'dolog', '**[DO LOG]**', 'red', sendtext, 'adlı oyuncu do emotunu kullandı içerik: ', text, false)
	TriggerEvent('ayazwai:do', name, adsoyad, text)
	
end)

RegisterServerEvent('zarataq')
AddEventHandler('zarataq', function(text)
	local player = QBCore.Functions.GetPlayer(source)
	local adsoyad = player.PlayerData.charinfo.firstname .. ' ' .. player.PlayerData.charinfo.lastname
	TriggerClientEvent('3dme:shareDisplayDo', -1, text, source)
	TriggerClientEvent("sendProximityMessageZar", -1, source, adsoyad, text)
	TriggerEvent('SB:discordLog',"chat","/zarat " .. text,source)

end)

RegisterServerEvent("f4st:xme")
AddEventHandler("f4st:xme", function(name, message)
	TriggerClientEvent('chat:addMessage', src, {
        type = "ME",
        typeColor = '#c79408',
        multiline = true,
        header =  {"" ..name..''},
        args = {message}
    })
end)

-- RegisterCommand('meslek', function(source, args)
-- 	local xPlayer = ESX.GetPlayerFromId(source)
-- 	--print(xPlayer.job.grade_label)
-- 	local text = "" ..	xPlayer.job.label.. " - " ..xPlayer.job.grade_label..""

-- 	TriggerClientEvent("dombili:meslek", -1, source, text)


-- end)


-- function getIdentity(source)
-- 	local identifier = GetPlayerIdentifiers(source)[1]
-- 	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
-- 	if result[1] ~= nil then
-- 		local identity = result[1]

-- 		return {
-- 			identifier = identity['identifier'],
-- 			firstname = identity['firstname'],
-- 			lastname = identity['lastname'],
-- 			dateofbirth = identity['dateofbirth'],
-- 			sex = identity['sex'],
-- 			height = identity['height']
-- 		}
-- 	else
-- 		return nil
-- 	end
-- end


-- RegisterNetEvent("esx_policejob:message")
-- AddEventHandler("esx_policejob:message",function()
-- 	print("Chatte duyuru atiyor sag tarafta ismide bu oçun : "..GetPlayerName(source))
-- end)


RegisterServerEvent("ayazwai:me")
AddEventHandler("ayazwai:me", function(name, adsoyad, text)
    local player = QBCore.Functions.GetPlayer(source)
    
    local ts = os.time()
    local time = os.date('%Y-%m-%d %H:%M:%S', ts)
    desc = "\n **Kullanıcı Adı: **" ..adsoyad.. "\n **Oyuncu ID : " ..source.. " **\n ** Yazdığı Mesaj : **" ..text
    -- Rest of your code
					local icerik = {
					{
						["color"] = 2332290,
						["title"] = "/ME Logu",
						["description"] = desc,
						["footer"] = {
							["text"] = "                             " ..time,
							["icon_url"] = "https://cdn.discordapp.com/attachments/1064709704900689921/1202451517605675088/logo.png",
						},
					}
    }
	PerformHttpRequest(Webhook, function(err, text, headers) end, 'POST', json.encode({username = "ME LOG", embeds = icerik}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent("ayazwai:do")
AddEventHandler("ayazwai:do", function(name, adsoyad, text)
	local player = QBCore.Functions.GetPlayer(source)
	
					local ts = os.time()
					local time = os.date('%Y-%m-%d %H:%M:%S', ts)
					desc = "\n **Kullanıcı Adı: **" ..adsoyad.. "\n **Oyuncu ID : " ..source.. "**\n ** Yazdığı Mesaj : **" ..text
					local icerik = {
					{
						["color"] = 9459134,
						["title"] = "/DO Logu",
						["description"] = desc,
						["footer"] = {
							["text"] = "                             " ..time,
							["icon_url"] = "https://cdn.discordapp.com/attachments/1064709704900689921/1202451517605675088/logo.png",
						},
					}
    }
	PerformHttpRequest(Webhook2, function(err, text, headers) end, 'POST', json.encode({username = "DO LOG", embeds = icerik}), { ['Content-Type'] = 'application/json' })
end)

RegisterServerEvent('SB:sendDiceResultTo3DDO')
AddEventHandler('SB:sendDiceResultTo3DDO',function(message)
    if Config.debugSystem == 1 then
        TriggerEvent('SB:debugSystem',source,"sb_3ddo","SB:sendDiceResultTo3DDO",0,"server")
    end
    TriggerClientEvent('3ddo:shareDisplay',-1,message,source)
end)
