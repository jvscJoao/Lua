local hplayersthativendiessamerdadaledeledeledole = {"Nome Player"}
	local spamchacked = false
	function msgError()
		error("You need to get your acess to this script!")
	end
	
	macro(5000, function()
		if (spamchacked) then
			msgError()
		end
	end)
	if (table.contains(hplayersthativendiessamerdadaledeledeledole, player:getName())) then
	local rerollPanelName = "rerollPanelSystem"
local ui = setupUI([[
Panel
  height: 19

  BotSwitch
    id: title
    anchors.top: parent.top
    anchors.left: parent.left
    text-align: center
    width: 130
    !text: tr('[Status]: Reroll')

  Button
    id: config
    anchors.top: prev.top
    anchors.left: prev.right
    anchors.right: parent.right
    margin-left: 3
    height: 17
    text: Config

]], addTab("Tools"))
		ui:setId(rerollPanelName)

		if not storage[rerollPanelName] then
			storage[rerollPanelName] = {
				enabled = false,
				dmgReroll = 100,
				speedReroll = 100,
				regenReroll = 100,
				hpmpReroll = 100,
				status = "", 
			}
		end
		
		local Rerolls = {22721, 22724, 22723, 22722}
		local Total, Dmg, Speed, Regen, HpMp
		local modelMsg = {"You have (%d+) total attribute points,", "(%d+) points into damage,", "(%d+) points into speed,", "(%d+) points into regen,", "(%d+) points into max health and mana."}
		if storage[rerollPanelName].status == "" then
			if use(Rerolls[1]) then return true
			elseif use(Rerolls[2]) then return true
			elseif use(Rerolls[3]) then return true
			elseif use(Rerolls[4]) then return true
			end
		end
		onTextMessage(function(mode, text)
			if mode ~= 4  then
				return false
			end
			if (string.find(text, modelMsg[1])) then
				storage[rerollPanelName].status = text
				print(storage[rerollPanelName].status)
			end
		end)

		ui.title:setOn(storage[rerollPanelName].enabled)
		ui.title.onClick = function(widget)
			storage[rerollPanelName].enabled = not storage[rerollPanelName].enabled
			widget:setOn(storage[rerollPanelName].enabled)
		end

		rootWidget = g_ui.getRootWidget()
		if rootWidget then
			rerollWindow = g_ui.createWidget('RerollWindow', rootWidget)
			rerollWindow:hide()

			rerollWindow.closeButton.onClick = function(widget)
				rerollWindow:hide()
			end
			
			function Attributes()
				return tonumber(string.match(storage[rerollPanelName].status, modelMsg[1])) - (storage[rerollPanelName].dmgReroll + storage[rerollPanelName].speedReroll + storage[rerollPanelName].regenReroll + storage[rerollPanelName].hpmpReroll)
			end
			
			rerollWindow.quantity:setText("Missing: ".. Attributes() .. " attribute.")
			
			rerollWindow.dmgReroll.onTextChange = function(widget, text)
				if string.find(text, "(%d+)") then
					getValue = string.match(text, "(%d+)")
					storage[rerollPanelName].dmgReroll = tonumber(getValue)
					rerollWindow.dmgReroll:setText("Damage: ".. storage[rerollPanelName].dmgReroll)
					rerollWindow.quantity:setText("Missing: ".. Attributes() .. " attribute.")
				elseif not (string.find(text, "Damage: (%d+)")) then
					storage[rerollPanelName].dmgReroll = 0
					rerollWindow.dmgReroll:setText("Damage: ".. storage[rerollPanelName].dmgReroll)
					rerollWindow.quantity:setText("Missing: ".. Attributes() .. " attribute.")
				end
			end
			rerollWindow.dmgReroll:setText("Damage: ".. storage[rerollPanelName].dmgReroll)
			
			rerollWindow.speedReroll.onTextChange = function(widget, text)
				if string.find(text, "(%d+)") then
					getValue = string.match(text, "(%d+)")
					storage[rerollPanelName].speedReroll = tonumber(getValue)
					rerollWindow.speedReroll:setText("Speed: ".. storage[rerollPanelName].speedReroll)
					rerollWindow.quantity:setText("Missing: ".. Attributes() .. " attribute.")
				elseif not (string.find(text, "Speed: (%d+)")) then
					storage[rerollPanelName].speedReroll = 0
					rerollWindow.speedReroll:setText("Speed: ".. storage[rerollPanelName].speedReroll)
					rerollWindow.quantity:setText("Missing: ".. Attributes() .. " attribute.")
				end
			end
			rerollWindow.speedReroll:setText("Speed: ".. storage[rerollPanelName].speedReroll)
			
			rerollWindow.regenReroll.onTextChange = function(widget, text)
				if string.find(text, "(%d+)") then
					getValue = string.match(text, "(%d+)")
					storage[rerollPanelName].regenReroll = tonumber(getValue)
					rerollWindow.regenReroll:setText("Regen: ".. storage[rerollPanelName].regenReroll)
					rerollWindow.quantity:setText("Missing: ".. Attributes() .. " attribute.")
				elseif not (string.find(text, "Regen: (%d+)")) then
					storage[rerollPanelName].regenReroll = 0
					rerollWindow.regenReroll:setText("Regen: ".. storage[rerollPanelName].regenReroll)
					rerollWindow.quantity:setText("Missing: ".. Attributes() .. " attribute.")
				end
			end
			rerollWindow.regenReroll:setText("Regen: ".. storage[rerollPanelName].regenReroll)
			
			rerollWindow.hpmpReroll.onTextChange = function(widget, text)
				if string.find(text, "(%d+)") then
					getValue = string.match(text, "(%d+)")
					storage[rerollPanelName].hpmpReroll = tonumber(getValue)
					rerollWindow.hpmpReroll:setText("Hp/Mp: ".. storage[rerollPanelName].hpmpReroll)
					rerollWindow.quantity:setText("Missing: ".. Attributes() .. " attribute.")
				elseif not (string.find(text, "Hp/Mp: (%d+)")) then
					storage[rerollPanelName].hpmpReroll = 0
					rerollWindow.hpmpReroll:setText("Hp/Mp: ".. storage[rerollPanelName].hpmpReroll)
					rerollWindow.quantity:setText("Missing: ".. Attributes() .. " attribute.")
				end
			end
			rerollWindow.hpmpReroll:setText("Hp/Mp: ".. storage[rerollPanelName].hpmpReroll)

			macro(200, function()
				if not storage[rerollPanelName].enabled then return false end
				Total = tonumber(string.match(storage[rerollPanelName].status, modelMsg[1]))
				Dmg = tonumber(string.match(storage[rerollPanelName].status, modelMsg[2]))
				Speed = tonumber(string.match(storage[rerollPanelName].status, modelMsg[3]))
				Regen = tonumber(string.match(storage[rerollPanelName].status, modelMsg[4]))
				HpMp = tonumber(string.match(storage[rerollPanelName].status, modelMsg[5]))
				CheckPTotal = (storage[rerollPanelName].dmgReroll + storage[rerollPanelName].speedReroll + storage[rerollPanelName].regenReroll + storage[rerollPanelName].hpmpReroll)
				if (Total < (CheckPTotal)) then
					storage[rerollPanelName].enabled = not storage[rerollPanelName].enabled
					ui.title:setOn(storage[rerollPanelName].enabled)
					return false
				elseif (Total > (CheckPTotal)) then 
					storage[rerollPanelName].enabled = not storage[rerollPanelName].enabled
					ui.title:setOn(storage[rerollPanelName].enabled)
					return false
				end
				if (Dmg > storage[rerollPanelName].dmgReroll) then
					use(Rerolls[1])
				end
				if (Speed > storage[rerollPanelName].speedReroll) then
					use(Rerolls[2])
				end
				if (Regen > storage[rerollPanelName].regenReroll) then
					use(Rerolls[3])
				end
				if (HpMp > storage[rerollPanelName].hpmpReroll) then
					use(Rerolls[4])
				end
				if (Dmg == storage[rerollPanelName].dmgReroll and Speed == storage[rerollPanelName].speedReroll and Regen == storage[rerollPanelName].regenReroll and HpMp == storage[rerollPanelName].hpmpReroll
					and storage[rerollPanelName].enabled) then
					storage[rerollPanelName].enabled = not storage[rerollPanelName].enabled
					ui.title:setOn(storage[rerollPanelName].enabled)
				end
			end)
		end

		ui.config.onClick = function(widget)
		  rerollWindow:show()
		  rerollWindow:raise()
		  rerollWindow:focus()
		end
		else
			spamchacked = true
			msgError()
	end