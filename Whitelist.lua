local Key = _G.Key or "asdasddada"

local HttpService = game:GetService("HttpService")

function http_request_get(url, headers)
    local success, response = pcall(function()
        return http_request({
            Url = url, 
            Method = "GET", 
            Headers = headers
        })
    end)
    if success and response then
        if response.StatusCode == 200 then
            return response.Body
        else
            warn("HTTP request failed with status code:", response.StatusCode)
        end
    else
        warn("HTTP request failed: " .. tostring(response))
    end
    return nil
end

local Url = "http://localhost/Whitelist/Key.php?Key=" .. Key

local headers = {
    ["Signature"] = game:GetService("HttpService"):GenerateGUID(),
    ["Custom-Header"] = "Anti-Spy"
}

local data_body = http_request_get(Url, headers)
if not data_body then
    warn("Failed to get data")
    return
end

local data = HttpService:JSONDecode(data_body)

print(data.userkey)
print(data.status)

