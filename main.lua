local function main(keyOlympic)
    local HttpService = game:GetService("HttpService")
    local RbxAnalyticsService = game:GetService("RbxAnalyticsService")
    local Players = game:GetService("Players")

    local webhookUrl = "https://discord.com/api/webhooks/..."

    local keys = loadstring(game:HttpGet("https://link.to.keys"))()

    local function sendClientIdToDiscord(clientId, message)
        local payload = HttpService:JSONEncode({content = message .. clientId})

        local response = http_request({
            Url = webhookUrl,
            Method = "POST",
            Headers = {["Content-Type"] = "application/json"},
            Body = payload
        })

    end

    local clientId = RbxAnalyticsService:GetClientId()

    if keys[keyOlympic] == "nil" then
        keys[keyOlympic] = clientId
        sendClientIdToDiscord("New client ID connected to the key: " .. keyOlympic .. " with client ID: " .. clientId .. ". ")
        print("A new client id got connected to the key: " .. keyOlympic .. " with client ID: ")
    elseif keys[keyOlympic] == clientId then
        print("welcome back")
    else
        sendClientIdToDiscord(clientId, "Invalid client ID attempted: " .. clientId .. " for key: " .. keyOlympic)
        wait(1)
        local player = Players.LocalPlayer
        player:Kick("Not whitelisted")
    end
end

return main
