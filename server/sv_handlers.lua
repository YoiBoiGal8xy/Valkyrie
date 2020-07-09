--[[
    Valkyrie Anticheat
]] 
--Main "kicking handler" for the client.
RegisterNetEvent('Valkyrie:ClientDetection')
AddEventHandler('Valkyrie:ClientDetection', function(user, log, reason)
  local _source = source
  if user == nil or user == '' then
    user = GetPlayerName(_source)
  end
  if log == nil or log == '' then
    log = 'Lua executor or no reason was set probably the latter.'
  end
  ValkyrieIdentifiers(_source)
  ValkyrieLog('Player Kicked', '**Player:** ' ..user.. '\n**Reason:** ' ..log.. '\n**' ..license.. '**\n**'..discord.. '**\n**' ..steam.. '**')
  ValkyrieKickPlayer(_source, reason)
end)
--Blacklisted models vehicles, peds, and props can go here. This list WILL not kick players if they spawn them.
local BlacklistedModels = {
  [`TUG`] = 'TUG',
  [`Deluxo`] = 'Deluxo',
  [`ZR380`] = 'ZR380',
  [`khanjali`] = 'khanjali',
  [`STROMBERG`] = 'STROMBERG',
  [`BARRAGE`] = 'BARRAGE',
  [`TA21`] = 'TA21',
  [`s_m_m_security_01`] = 's_m_m_security_01',
  --[`a_m_o_acult_01`] = 's_m_m_security_01',
  [`s_m_y_swat_01`] = 's_m_m_security_01',
  [-320283514] = true, --Destroyed UFO
  [-387805218] = true --Body for some yacht
}
--Banned models vehicles, peds, and props can go here. This list WILL kick players if they spawm them.
local _bannedModels = { 
  [`Cargoplane`] = 'Cargoplane',
  [`Avenger`] = 'Avenger',
  [`Blimp2`] = 'Blimp2',
  --[[
    Most of the peds used in "main stream" mod menus.
  ]]
  [`a_c_chop`] = 'a_c_chop',
  [`ig_wade`] = 'ig_wade',
  [`mp_m_niko_01`] = 'mp_m_niko_01',
  [`s_m_y_robber_01`] = 's_m_y_robber_01',
  [`u_m_y_zombie_01`] = 'u_m_y_zombie_01',
  --[[
    Most of the props used in "mainstream" mod menus. Along with some additional ones.
  ]]
  [`apa_MP_Apa_Yacht`] = 'apa_MP_Apa_Yacht',  --Yach body
  [`p_spinning_anus_s`] = 'p_spinning_anus_s', --Ufo with no flashing lights
  [`imp_prop_ship_01a`] = 'imp_prop_ship_01a', --Ufo with flashing lights
  [`dt1_tc_dufo_core`] = 'dt1_tc_dufo_core', --Military Ufo
  [`db_apart_02_`] = 'db_apart_02_', --Apartment building
  [`xm_prop_iaa_base_elevator`] = 'xm_prop_iaa_base_elevator',
  [`stt_prop_stunt_soccer_ball`] = 'stt_prop_stunt_soccer_ball',
  [`stt_prop_stunt_track_dwslope30`] = 'stt_prop_stunt_track_dwslope30',
  [`stt_prop_ramp_spiral_xxl`] = 'stt_prop_ramp_spiral_xxl',
  [`stt_prop_ramp_adj_flip_mb`] = 'stt_prop_ramp_adj_flip_mb',
  [`stt_prop_ramp_adj_flip_s`] = 'stt_prop_ramp_adj_flip_s',
  [`stt_prop_ramp_adj_flip_sb`] = 'stt_prop_ramp_adj_flip_sb',
  [`stt_prop_ramp_adj_hloop`] = 'stt_prop_ramp_adj_hloop',
  [`stt_prop_ramp_adj_loop`] = 'stt_prop_ramp_adj_loop',
  [`stt_prop_ramp_jump_l`] = 'stt_prop_ramp_jump_l',
  [`stt_prop_ramp_jump_m`] = 'stt_prop_ramp_jump_m',
  [`stt_prop_ramp_jump_s`] = 'stt_prop_ramp_jump_s',
  [`stt_prop_ramp_jump_xl`] = 'stt_prop_ramp_jump_xl',
  [`stt_prop_ramp_jump_xs`] = 'stt_prop_ramp_jump_xs',
  [`stt_prop_ramp_jump_xxl`] = 'stt_prop_ramp_jump_xxl',
  [`stt_prop_ramp_multi_loop_rb`] = 'stt_prop_ramp_multi_loop_rb24',
  [`stt_prop_ramp_spiral_l`] = 'stt_prop_ramp_spiral_l',
  [`stt_prop_ramp_spiral_l_m`] = 'stt_prop_ramp_spiral_l_m',
  [`stt_prop_ramp_spiral_l_s`] = 'stt_prop_ramp_spiral_l_s',
  [`stt_prop_ramp_spiral_l_xxl`] = 'stt_prop_ramp_spiral_l_xxl',
  [`stt_prop_ramp_spiral_m`] = 'stt_prop_ramp_spiral_m',
  [`stt_prop_ramp_spiral_s`] = 'stt_prop_ramp_spiral_s',
  [`stt_prop_ramp_spiral_xxl`] = 'stt_prop_ramp_spiral_xxl',
  [`xs_prop_hamburgher_wl`] = 'xs_prop_hamburgher_wl',
  [`prop_windmill_01`] = 'prop_windmill_01',
  [`xs_prop_chips_tube_wl`] = 'xs_prop_chips_tube_wl',
  [`xs_prop_plastic_bottle_wl`] = 'xs_prop_plastic_bottle_wl',
  [`prop_weed_01`] = 'prop_weed_01',
  [`prop_fnclink_05crnr1`] = 'prop_fnclink_05crnr1',
  [`sr_prop_spec_tube_xxs_01a `] = 'sr_prop_spec_tube_xxs_01a',
  [`prop_cs_dildo_01`] = 'prop_cs_dildo_01',
  [`prop_ld_bomb_anim`] = 'prop_ld_bomb_anim',
  [`prop_gas_tank_01a`] = 'prop_gas_tank_01a',
  [`prop_gascyl_01a`] = 'prop_gascyl_01a',
}
--[[apa_mp_apa_y1_l1a --Gold and blue lights
apa_mp_apa_y1_l1b --Blue and yellow lights
apa_mp_apa_y1_l1c --Pink and green lights
apa_mp_apa_y1_l1d --Gold and green
apa_mp_apa_y2_l1a
apa_mp_apa_y2_l1b
apa_mp_apa_y2_l1c
apa_mp_apa_y2_l1d
apa_mp_apa_y3_l1a
apa_mp_apa_y3_l1b
apa_mp_apa_y3_l1c
apa_mp_apa_y3_l1d
apa_mp_apa_yacht_o1_rail_a
apa_mp_apa_yacht_o1_rail_b
apa_mp_apa_yacht_o2_rail_a
apa_mp_apa_yacht_o2_rail_b
apa_mp_apa_yacht_o3_rail_a
apa_mp_apa_yacht_o3_rail_b
apa_mp_apa_yacht_option1
apa_mp_apa_yacht_option1_cola
apa_mp_apa_yacht_option2
apa_mp_apa_yacht_option2_cola
apa_mp_apa_yacht_option2_colb
apa_mp_apa_yacht_option3
apa_mp_apa_yacht_option3_cola
apa_mp_apa_yacht_option3_colb
apa_mp_apa_yacht_option3_colc
apa_mp_apa_yacht_option3_cold
apa_mp_apa_yacht_option3_cole
apa_MP_Apa_Yacht_Jacuzzi_Cam --Jacuzzi camera? 
apa_mp_apa_yacht_jacuzzi_ripple003 --Static water
apa_mp_apa_yacht_jacuzzi_ripple1 --Moving water
apa_mp_apa_yacht_radar_01a --Radar
apa_MP_Apa_Yacht_Win --Windows

apa_MP_Apa_Yacht --Body

apa_mp_apa_yacht_option2 --"Wing" and helipad 



apa_mp_apa_y3_l2c 
]]
--Handler for checking then deleting blacklisted/banned models.
AddEventHandler('entityCreating', function(entity)
  if BlacklistedModels[GetEntityModel(entity)] then
    CancelEvent()
  end
  if _bannedModels[GetEntityModel(entity)] then
    local entityOwner = NetworkGetEntityOwner(entity)
    if entityOwner == nil or entityOwner == '' then
      return 'Invalid entity'
    end
    ValkyrieIdentifiers(entityOwner)
    ValkyrieLog('Player Kicked', '**Player:** ' ..GetPlayerName(entityOwner).. '\n**Reason:** Spawned blacklisted model ' .._bannedModels[GetEntityModel(entity)].. '\n**'..license.. '**\n**' ..discord.. '**\n**' ..steam.. '**')
    ValkyrieKickPlayer(entityOwner, 'Blacklisted model')
    CancelEvent()
  end
end)
--List of blocked server events
local _blockedServerEvents  = {
    "8321hiue89js",
    "adminmenu:allowall",
    "AdminMenu:giveBank",
    "AdminMenu:giveCash",
    "AdminMenu:giveDirtyMoney",
    "Tem2LPs5Para5dCyjuHm87y2catFkMpV",
    "dqd36JWLRC72k8FDttZ5adUKwvwq9n9m",
    "antilynx8:anticheat",
    "antilynxr4:detect",
    "antilynxr6:detection",
    "ynx8:anticheat",
    "antilynx8r4a:anticheat",
    "lynx8:anticheat",
    "AntiLynxR4:kick",
    "AntiLynxR4:log",
    "bank:deposit",
    "bank:withdraw",
    "Banca:deposit",
    "Banca:withdraw",
    "BsCuff:Cuff696999",
    "CheckHandcuff",
    "cuffServer",
    "cuffGranted",
    "DiscordBot:playerDied",
    "DFWM:adminmenuenable",
    "DFWM:askAwake",
    "DFWM:checkup",
    "DFWM:cleanareaentity",
    "DFWM:cleanareapeds",
    "DFWM:cleanareaveh",
    "DFWM:enable",
    "DFWM:invalid",
    "DFWM:log",
    "DFWM:openmenu",
    "DFWM:spectate",
    "DFWM:ViolationDetected",
    "dmv:success",
    "eden_garage:payhealth",
    "ems:revive",
    "esx_ambulancejob:revive",
    "esx_ambulancejob:setDeathStatus",
    "esx_billing:sendBill",
    "esx_banksecurity:pay",
    "esx_blanchisseur:startWhitening",
    "esx_carthief:alertcops",
    "esx_carthief:pay",
    "esx_dmvschool:addLicense",
    "esx_dmvschool:pay",
    "esx_drugs:startHarvestWeed",
    "esx_drugs:startTransformWeed",
    "esx_drugs:startSellWeed",
    "esx_drugs:startHarvestCoke",
    "esx_drugs:startTransformCoke",
    "esx_drugs:startSellCoke",
    "esx_drugs:startHarvestMeth",
    "esx_drugs:startTransformMeth",
    "esx_drugs:startSellMeth",
    "esx_drugs:startHarvestOpium",
    "esx_drugs:startTransformOpium",
    "esx_drugs:startSellOpium",
    "esx_drugs:stopHarvestCoke",
    "esx_drugs:stopTransformCoke",
    "esx_drugs:stopSellCoke",
    "esx_drugs:stopHarvestMeth",
    "esx_drugs:stopTransformMeth",
    "esx_drugs:stopSellMeth",
    "esx_drugs:stopHarvestWeed",
    "esx_drugs:stopTransformWeed",
    "esx_drugs:stopSellWeed",
    "esx_drugs:stopHarvestOpium",
    "esx_drugs:stopTransformOpium",
    "esx_drugs:stopSellOpium",
    "esx:enterpolicecar",
    "esx_fueldelivery:pay",
    "esx:giveInventoryItem",
    "esx_garbagejob:pay",
    "esx_godirtyjob:pay",
    "esx_gopostaljob:pay",
    "esx_handcuffs:cuffing",
    "esx_jail:sendToJail",
    "esx_jail:unjailQuest",
    "esx_jailer:sendToJail",
    "esx_jailer:unjailTime",
    "esx_jobs:caution",
    "esx_mecanojob:onNPCJobCompleted",
    "esx_mechanicjob:startHarvest",
    "esx_mechanicjob:startCraft",
    "esx_pizza:pay",
    "esx_policejob:handcuff",
    "esx_policejob:requestarrest",
    "esx-qalle-jail:jailPlayer",
    "esx-qalle-jail:jailPlayerNew",
    "esx-qalle-hunting:reward",
    "esx-qalle-hunting:sell",
    "esx_ranger:pay",
    "esx:removeInventoryItem",
    "esx_truckerjob:pay",
    "esx_skin:responseSaveSkin",
    "esx_slotmachine:sv:2",
    "esx_society:getOnlinePlayers",
    "esx_society:setJob",
    "esx_vehicleshop:setVehicleOwned",
    "hentailover:xdlol",
    "JailUpdate",
    "js:jailuser",
    "js:removejailtime",
    "LegacyFuel:PayFuel",
    "ljail:jailplayer",
    "lscustoms:payGarage",
    "mellotrainer:adminTempBan",
    "mellotrainer:adminKick",
    "mellotrainer:s_adminKill",
    "NB:destituerplayer",
    "NB:recruterplayer",
    "OG_cuffs:cuffCheckNearest",
    "paramedic:revive",
    "police:cuffGranted",
    "unCuffServer",
    "uncuffGranted",
    "vrp_slotmachine:server:2",
    "whoapd:revive",
    "gcPhone:_internalAddMessageDFWM",
    "gcPhone:tchat_channelDFWM",
    "esx_vehicleshop:setVehicleOwnedDFWM",
    "esx_mafiajob:confiscateDFWMPlayerItem",
    "_chat:messageEntDFWMered",
    "lscustoms:pDFWMayGarage",
    "vrp_slotmachDFWMine:server:2",
    "Banca:dDFWMeposit",
    "bank:depDFWMosit",
    "esx_jobs:caDFWMution",
    "give_back",
    "esx_fueldDFWMelivery:pay",
    "esx_carthDFWMief:pay",
    "esx_godiDFWMrtyjob:pay",
    "esx_pizza:pDFWMay",
    "esx_ranger:pDFWMay",
    "esx_garbageDFWMjob:pay",
    "esx_truckDFWMerjob:pay",
    "AdminMeDFWMnu:giveBank",
    "AdminMDFWMenu:giveCash",
    "esx_goDFWMpostaljob:pay",
    "esx_baDFWMnksecurity:pay",
    "esx_sloDFWMtmachine:sv:2",
    "esx:giDFWMveInventoryItem",
    "NB:recDFWMruterplayer",
    "esx_biDFWMlling:sendBill",
    "esx_jDFWMailer:sendToJail",
    "esx_jaDFWMil:sendToJail",
    "js:jaDFWMiluser",
    "esx-qalle-jail:jailPDFWMlayer",
    "esx_dmvschool:pDFWMay",
    "LegacyFuel:PayFuDFWMel",
    "OG_cuffs:cuffCheckNeDFWMarest",
    "CheckHandcDFWMuff",
    "cuffSeDFWMrver",
    "cuffGDFWMranted",
    "police:cuffGDFWMranted",
    "esx_handcuffs:cufDFWMfing",
    "esx_policejob:haDFWMndcuff",
    "bank:withdDFWMraw",
    "dmv:succeDFWMss",
    "esx_skin:responseSaDFWMveSkin",
    "esx_dmvschool:addLiceDFWMnse",
    "esx_mechanicjob:starDFWMtCraft",
    "esx_drugs:startHarvestWDFWMeed",
    "esx_drugs:startTransfoDFWMrmWeed",
    "esx_drugs:startSellWeDFWMed",
    "esx_drugs:startHarvestDFWMCoke",
    "esx_drugs:startTransDFWMformCoke",
    "esx_drugs:startSellCDFWMoke",
    "esx_drugs:startHarDFWMvestMeth",
    "esx_drugs:startTDFWMransformMeth",
    "esx_drugs:startSellMDFWMeth",
    "esx_drugs:startHDFWMarvestOpium",
    "esx_drugs:startSellDFWMOpium",
    "esx_drugs:starDFWMtTransformOpium",
    "esx_blanchisDFWMseur:startWhitening",
    "esx_drugs:stopHarvDFWMestCoke",
    "esx_drugs:stopTranDFWMsformCoke",
    "esx_drugs:stopSellDFWMCoke",
    "esx_drugs:stopHarvesDFWMtMeth",
    "esx_drugs:stopTranDFWMsformMeth",
    "esx_drugs:stopSellMDFWMeth",
    "esx_drugs:stopHarDFWMvestWeed",
    "esx_drugs:stopTDFWMransformWeed",
    "esx_drugs:stopSellWDFWMeed",
    "esx_drugs:stopHarvestDFWMOpium",
    "esx_drugs:stopTransDFWMformOpium",
    "esx_drugs:stopSellOpiuDFWMm",
    "esx_society:openBosDFWMsMenu",
    "esx_jobs:caDFWMution",
    "esx_tankerjob:DFWMpay",
    "esx_vehicletrunk:givDFWMeDirty",
    "gambling:speDFWMnd",
    "AdminMenu:giveDirtyMDFWMoney",
    "esx_moneywash:depoDFWMsit",
    "esx_moneywash:witDFWMhdraw",
    "mission:completDFWMed",
    "truckerJob:succeDFWMss",
    "99kr-burglary:addMDFWMoney",
    "esx_jailer:unjailTiDFWMme",
    "esx_ambulancejob:reDFWMvive",
    "DiscordBot:plaDFWMyerDied",
    "esx:getShDFWMaredObjDFWMect",
    "esx_society:getOnlDFWMinePlayers",
    "js:jaDFWMiluser",
    "h:xd",
    "adminmenu:setsalary",
    "adminmenu:cashoutall",
    "bank:tranDFWMsfer",
    "paycheck:bonDFWMus",
    "paycheck:salDFWMary",
    "HCheat:TempDisableDetDFWMection",
    "esx_drugs:pickedUpCDFWMannabis",
    "esx_drugs:processCDFWMannabis",
    "esx-qalle-hunting:DFWMreward",
    "esx-qalle-hunting:seDFWMll",
    "esx_mecanojob:onNPCJobCDFWMompleted",
    "BsCuff:Cuff696DFWM999",
    "veh_SR:CheckMonDFWMeyForVeh",
    "esx_carthief:alertcoDFWMps",
    "mellotrainer:adminTeDFWMmpBan",
    "mellotrainer:adminKickDFWM",
    "esx_society:putVehicleDFWMInGarage"
}
--Handler and iterator for the above blocked server events.
for k, eventName in pairs(_blockedServerEvents) do
  RegisterNetEvent(eventName)
  AddEventHandler(eventName, function()
    local _source = source
    ValkyrieIdentifiers(_source)
    ValkyrieLog('Player Kicked', '**Player:** ' ..GetPlayerName(_source).. '\n**Reason:** Blocked server event ' ..eventName.. '\n**' ..license.. '**\n**' ..discord.. '**\n**' ..steam.. '**')
    ValkyrieKickPlayer(_source, 'Blocked Event')
  end)
end
--List of blocked explosions
local _blockedExplosion = { 0, 1, 2, 4, 5, 25, 32, 33, 35, 36, 37, 38 }
AddEventHandler('explosionEvent', function(sender, ev)
  for _, explosionType in ipairs(_blockedExplosion) do --Loop through _blockedExplosion
    if ev.damageScale <= 0 or ev.isInvisible == true or ev.isAudible == false then --Check for random explosion not created by a player.
      return
    end
    if ev.explosionType == explosionType and ev.damageScale >= 1 then --Check _blockedExplosion and damage scale
      CancelEvent() --Cancel's the explosion noise and damage for other clients
      ValkyrieIdentifiers(sender)
      ValkyrieLog('Player Kicked', '**Player:** ' ..GetPlayerName(sender).. '\n**Reason:** Explosion created ' ..explosionType.. '\n**' ..license.. '**\n**' ..discord.. '**\n**' ..steam.. '**\n')
      ValkyrieKickPlayer(sender, 'Blocked Explosion')
    end
  end
end)
--List of blocked chat messages
local _blockedMessages = {
  "https://discord.gg/u9CxU33",
  "^1Bombay ^4made by Sid ^5Official Discord: https://discord.gg/u9CxU33?",
  "^1Bombay ^4made by Sid ^5Official Discord: https://discord.gg/u9CxU33? ~ https://discord.gg/u9CxU33",
  "/ooc ^1Bombay Menu get at https://discord.gg/u9CxU33",
  "Bombay Menu ;) https://discord.gg/u9CxU33",
  "xaxaxaxaxaxaxaxaxax",
  "~b~Brutan#7799",
  "You just got fucked mate",
  "Brutan Premium",
  "^3 Brutan Premium BRUTAN ON YOUTUBE",
  "d0pamine | Nertigel#5391",
  "lynxmenu - Hello guys!",
  "lynxmenu - Cheats & AntiCheats!",
  "~b~https://discord.gg/pQwzbdf",
  "You just got fucked mate",
  "Luminous ~b~https://discord.gg/pQwzbdf",
  "3You just got fucked by Luminous ^2Made by Plane#0007 ^1Purchase at ^4https://discord.gg/pQwzbdf",
  "/ooc Add me Fallen#0811",
  "Add me Fallen#0811",
  "Yo add me Fallen#0811",
  "/ooc Yo add me Fallen#0811 >:D Player Crash Attempt",
  "Yo add me Fallen#0811 >:D Player Crash Attempt",
  "Damm u smart",
  " ^8Ham Mafia.co - ^1nig #0001 ^0 - ^0JOIN ^5DISCORD.GG/uMxGf4B1 ^0TO BUY NIGMENU v1 AND THE ^2BEST ^0LUA Executor",
  " d0pamine.xyz | discord.gg/fjBp55t",
  "\76\121\110\120\32\56\32\126\32\119\119\119\46\108\121\110\120\109\101\110\117\46\99\111\109",
  "\89\111\117\32\103\111\116\32\114\97\112\101\100\32\98\121\32\76\121\110\120\32\56",
  "Add me Baby Gangster#9026 , Dont Fake me",
  "/ooc Yo add me Baby Gangster#9026 , sup",
  "Yo add me Baby Gangster#9026",
  "/tweet Yo add me Baby Gangster#9026",
  "\76\121\110\120\32\56\32\126\32\119\119\119\46\108\121\110\120\109\101\110\117\46\99\111\109",
  "/ooc Yo add me ! Baby Gangster#9026 >:D Player Crash Attempt",
  "nigger",
  "nigga",
  "nig",
  "Desudo",
  "Brutan",
  "EulenCheats",
  "Lynx 8",
  "www.lynxmenu.com",
  "HamHaxia",
  "Ham Mafia",
  "www.renalua.com",
  "Fallen#0811",
  "Rena",
  "HamHaxia", 
  "Ham Mafia", 
  "Xanax#0134", 
  ">:D Player Crash",  
  "34ByTe Community", 
  "lynxmenu.com", 
  "Anti-Lynx",
  "Baran#8992",
  "iLostName#7138",
  "85.190.90.118",
  "Melon#1379",
  "hammafia.com",
  "AlphaV ~ 5391",
  "vjuton.pl",
  "Soviet Bear",
  "MARVIN menu",
  "KoGuSzEk#3251",
  "BAGGY menu <3 https://discord.gg/AGxGDzg",
  "KoGuSzMENU <3 https://discord.gg/BbDMhJe",
  "Desudo menu <3 https://discord.gg/hkZgrv3",
  "Lynx 8 ~ www.lynxmenu.com",
  "Lynx 7 ~ www.lynxmenu.com",
  "lynxmenu.com",
  "www.lynxmenu.com",
  "You got raped by Lynx 8",
  "^0Lynx 8 ~ www.lynxmenu.com",
  "^0AlphaV ~ 5391",
  "^0You got raped by AlphaV",
  "^0TITO MODZ - Cheats and Anti-Cheat",
  "^0https://discord.gg/AGxGDzg",
  "^0https://discord.gg/hkZgrv3",
  "You just got fucked mate",
  "Add me Fallen#0811",
  "Desudo; Plane#000",
  "BAGGY; baggy#6875",
  "SKAZAMENU",
  "skaza",
  "aries",
  "youtube.com"
}
--Handler for above blocked chat messages
AddEventHandler('chatMessage', function(source, name, message)
  local _source = source
  for k, messages in pairs(_blockedMessages) do --Loop through all _blockedMessages
    if string.match(message, messages) then
      CancelEvent() --Prevent the blocked message from being sent
      ValkyrieIdentifiers(_source)
      ValkyrieLog('Player Kicked', '**Player:** ' ..GetPlayerName(_source).. '\n**Reason:** Sent a blocked message** ' ..message.. '**\n**'..license.. '**\n**' ..discord.. '**\n**' ..steam.. '**')
      Wait(10) --Mandatory wait to prevent an error being printed in the console
      ValkyrieKickPlayer(_source, 'Blocked chat message ' ..messages.. '')
    end
  end
end)

AddEventHandler("onResourceStart", function(name)
  if name == GetCurrentResourceName() then
      ProcessAces()
  end
end)