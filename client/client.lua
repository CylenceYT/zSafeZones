local currentPos = GetEntityCoords(ped)
local txd = GetPedheadshotTxdString(handle)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(0)
            local letSleep = true
            local playerPed = PlayerPedId()
            local playerPos = GetEntityCoords(playerPed)
            if #(playerPos - vector3(cfg.sz.x, cfg.sz.y, cfg.sz.z)) < 20 then
                letSleep = false
                DrawMarker(27, cfg.sz.x, cfg.sz.y, cfg.sz.z, 0.0, 0.0, 0.0, 0.0, 180.0, 0.0, 40.0, 40.0, 40.0, 255, 0, 0, 50, false, true, 2, nil, nil, false)
								DisablePlayerFiring(playerPed, false)
           end
           if isInvincible then
             SetPlayerInvincible(playerPed, isInvincible)
           end
           if letSleep then
               Citizen.Wait(500)
           end
    end
end)

local blip = AddBlipForCoord(-415.41, 1154.11)
SetBlipSprite(blip, 364)
SetBlipDisplay(blip, 6)
SetBlipScale(blip, 0.9)
BeginTextCommandSetBlipName("STRING")
AddTextComponentString("Safe Zone")
EndTextCommandSetBlipName(blip)

RegisterCommand('sz', function()
	SetEntityCoords(ped, cfg.tp.x, cfg.tp.y, cfg.tp.x, false, false, false, true)
		TriggerEvent("chat:addMessage", {
            		args={"You have been sent to a ^2Safe Zone"}
		})
	Wait(100)
end)

Citizen.CreateThread(function()
    Holograms()
end)

function Holograms()
		while true do
			Citizen.Wait(0)
				-- Hologram No. 1
		if GetDistanceBetweenCoords( -423.41, 1130.95, 325.85, GetEntityCoords(GetPlayerPed(-1))) < 10.0 then -- Make sure all these coords are the same and make sure you DONT add a comma...
			Draw3DText( -423.41, 1130.95, 325.85  -1.400, cfg.txttop, 4, 0.1, 0.1)   -- Make sure all these coords are the same and make sure you DONT add a comma...
			Draw3DText( -423.41, 1130.95, 325.85  -1.600, cfg.txtmid, 4, 0.1, 0.1)   -- Make sure all these coords are the same and make sure you DONT add a comma...
			Draw3DText( -423.41, 1130.95, 325.85  -1.800, cfg.txtbtm, 4, 0.1, 0.1)   -- Make sure all these coords are the same and make sure you DONT add a comma...
		end
	end
end

-------------------------------------------------------------------------------------------------------------------------
function Draw3DText(x,y,z,textInput,fontId,scaleX,scaleY)
         local px,py,pz=table.unpack(GetGameplayCamCoords())
         local dist = GetDistanceBetweenCoords(px,py,pz, x,y,z, 1)
         local scale = (1/dist)*20
         local fov = (1/GetGameplayCamFov())*100
         local scale = scale*fov
         SetTextScale(scaleX*scale, scaleY*scale)
         SetTextFont(fontId)
         SetTextProportional(1)
         SetTextColour(250, 250, 250, 255)
         SetTextDropshadow(1, 1, 1, 1, 255)
         SetTextEdge(2, 0, 0, 0, 150)
         SetTextDropShadow()
         SetTextOutline()
         SetTextEntry("STRING")
         SetTextCentre(1)
         AddTextComponentString(textInput)
         SetDrawOrigin(x,y,z+2, 0)
         DrawText(0.0, 0.0)
         ClearDrawOrigin()
        end


TriggerEvent('chat:addSuggestion', '/sz', 'Teleport to the Safe Zone')
