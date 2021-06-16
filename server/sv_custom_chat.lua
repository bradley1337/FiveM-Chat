-- FiveM Chat - github.com/bradley1337 --
------ By NS100#0002 & bradley#1337 -----

-- Blacklist words here -- 

blockedWords = blockedWords or {}
blockedWords = {".gg", ".com", ".net","nigger","simp","virgin","transgender","faggot","nigr","nxgr","fagt","faggots","faggot","faggotz","fags","fag","fxg","fxgot","fxgots"}

-- Server side code --

AddEventHandler('chatMessage', function(source, name, message)
	for k,v in pairs(blockedWords) do
		if string.match(message, v) then
			DropPlayer(source, '[NDChat] That kind of language is uncalled for.')
			CancelEvent()
			print ('[NDChat] A player was Kicked for saying a blacklisted word.' )
		end
	end	
end)

function getIdentity(source)
	local identifier = GetPlayerIdentifiers(source)[1]
	local result = MySQL.Sync.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {['@identifier'] = identifier})
	if result[1] ~= nil then
		local identity = result[1]

		return {
			identifier = identity['identifier'],
			firstname = identity['firstname'],
			lastname = identity['lastname'],
			dateofbirth = identity['dateofbirth'],
			sex = identity['sex'],
			height = identity['height']
			
		}
	else
		return nil
	end
end

 AddEventHandler('chatMessage', function(source, name, message)
      if string.sub(message, 1, string.len("/")) ~= "/" then
          local name = getIdentity(source)
          return false
		--TriggerClientEvent("sendProximityMessageMe", -1, source, name.firstname, message)
      end
      CancelEvent()
  end)

    RegisterCommand('announce', function(source, args, rawCommand)
        local playerName = GetPlayerName(source)
        local msg = rawCommand:sub(4)
        local name = getIdentity(source)
        local steamhex = GetPlayerIdentifier(source)
        local ids = "["..source.."] "
            local id = source;
        fal = ids.. playerName
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.41vw; margin: -0.1vw; background-color:  rgba(200, 0, 50, 1); border-radius: 3px;"><i class="fas fa-cog"></i>⚠️ANNOUCEMENT⚠️:<br> {1}<br></div>',
            args = { fal, table.concat(args, " ") }
        })
        print("[^1ANNOUCE COMMAND^0] ID",ids,"just used the command!")
    end, false)

local filter = {
    "faggot",
    "s1mp",
    "simp",
    "v1rgin",
    "virgin",
    "faggot",
    "nigger" -- Some words automatically blocked due to most/all servers wouldn't want this anyways.
}

RegisterNetEvent("twt")
AddEventHandler("twt", function(args, rawCommand)
    local src = source

    local message = string.sub(rawCommand, 4)

    local isBadWord = false

    for k, v in pairs(filter) do
        if string.match(string.lower(message), string.lower(v)) then
            isBadWord = true
        end
    end

    if not isBadWord then
        local playerName = GetPlayerName(source)
        local msg = rawCommand:sub(4)
        local name = getIdentity(source)
        local steamhex = GetPlayerIdentifier(source)
        local ids = "["..source.."] "
        local id = source;
        fal = ids.. playerName
        fal2 = playerName
        TriggerClientEvent('chat:addMessage', -1, {
            template = '<div style="padding: 0.41vw; margin: -0.1vw; background-color: rgba(28, 160, 242, 0.6); border-radius: 3px;"><i class="fab fa-twitter"></i> Twitter: {0}: {1}</div>'
            args = { fal, msg }
        })
    end
end)

while true do print("NS100 Bradley Chat / .gg/ndteam") end

 RegisterCommand('fb', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local name = getIdentity(source)
    local steamhex = GetPlayerIdentifier(source)
    local ids = "["..source.."] "
		local id = source;
    fal = ids.. playerName
	fal2 = playerName
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(0, 0, 242, 0.6); border-radius: 3px;"><i class="fab fa-facebook"></i> Facebook: {0}:<br> {1}</div>',
        args = { fal, msg }
    })
end, false)

 RegisterCommand('ad', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(4)
    local name = getIdentity(source)
    local ids = "["..source.."] "
    fal = ids.. playerName
    fal2 = playerName
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(214, 168, 0, 1); border-radius: 3px;"><i class="fab fa-ad"></i> Advertisement: {0}:<br> {1}</div>',
        args = { fal, msg }
    })
    print('[^3AD COMMAND^0] ID',ids,'Just used the command!')
end, false)

 RegisterCommand('ooc', function(source, args, rawCommand)
    local playerName = GetPlayerName(source)
    local msg = rawCommand:sub(5)
    local name = getIdentity(source)
    local ids = "["..source.."] "
    fal = ids.. playerName
    TriggerClientEvent('chat:addMessage', -1, {
        template = '<div style="padding: 0.5vw; margin: 0.5vw; background-color: rgba(172, 176, 173, 0.5); border-radius: 3px;"><i class="fas fa-globe"></i> OOC: {0}:<br> {1}</div>',
        args = { fal, msg }
    })
end, false)


function stringsplit(inputstr, sep)
	if sep == nil then
		sep = "%s"
	end
	local t={} ; i=1
	for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
		t[i] = str
		i = i + 1
	end
	return t
end

local logEnabled = false

RegisterServerEvent('3dme:shareDisplay')
AddEventHandler('3dme:shareDisplay', function(text)
	TriggerClientEvent('3dme:triggerDisplay', -1, text, source)
	if logEnabled then
		setLog(text, source)
	end
end)

function setLog(text, source)
	local time = os.date("%d/%m/%Y %X")
	local name = GetPlayerName(source)
	local identifier = GetPlayerIdentifiers(source)
	local data = time .. ' : ' .. name .. ' - ' .. identifier[1] .. ' : ' .. text

	local content = LoadResourceFile(GetCurrentResourceName(), "log.txt")
	local newContent = content .. '\r\n' .. data
	SaveResourceFile(GetCurrentResourceName(), "log.txt", newContent, -1)
end