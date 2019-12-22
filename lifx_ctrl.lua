--[[
Latest: December 22, 2019
Created by JoeK and distributed to the GetVera Community for use.
Link:

Initial Release Date: March 20, 2016
Link: http://forum.micasaverde.com/index.php?topic=36961.0


The LUA code lifx_ctrl() provides ability to control LIFX lights via Vera U17.
The implementation uses the LIFX API (RESTful) and therefore an internet connection is
required for network access to LIFX servers. The LIFX control provides a basic framework, 
so can easily be modified to enhance its functionality. It's implemented as a LUA 
function and the function can be called by other LUA code or from LUUP within a 
scene on the Vera.

The "token" variable below must be updated with your private API token from LIFX:
	https://cloud.lifx.com/settings

More info on installation and setup here:
	

Enjoy!  :-)
--]]

	https = require("ssl.https")
	ltn12 = require("ltn12")
    --json = require ("dkjson")

function lifx_ctrl(selector, mode, color, bright, cycles, period)
	https.TIMEOUT = 5
	--local selcolor = '"#ffffff"' -- white
	local resp = {}
	local payload = ''
	local selmethod, selurl, key, value, stat, power, connected, err
	local token = "xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx" -- private token - do not share

	-- Default values
	local color = color or "#00ff00" -- if color nil or false then use green at brightest
	local bright = bright or .2  -- if bright nil or false then use .2
	local period = period or 1  -- if period nil or false then use 1
	local cycles = cycles or 1  -- if period nil or false then use 1
		
	if mode == "pulse" then
		selmethod = "POST"
		selurl = "https://api.lifx.com/v1/lights/" .. selector .. "/effects/pulse"
		payload = '{"cycles": ' .. cycles .. ', "power_on": true, "persist": false, "color": "'
					.. color .. ' brightness:' .. bright .. '", "period": ' .. period .. '}'
	elseif mode == "breathe" then
		selmethod = "POST"
		selurl = "https://api.lifx.com/v1/lights/" .. selector .. "/effects/breathe"
		payload = '{"cycles": ' .. cycles .. ', "power_on": true, "persist": false, "color": "'
					.. color .. ' brightness:' .. bright .. '", "period": ' .. period .. '}'	
	elseif mode == "on" then
		selmethod = "PUT"
		selurl = "https://api.lifx.com/v1/lights/" .. selector .. "/state"
		payload = '{"power": "on", "color": "' .. color .. '", "brightness": ' .. bright .. '}'
	elseif mode == "off" then
		selmethod = "PUT"
		selurl = "https://api.lifx.com/v1/lights/" .. selector .. "/state"
		payload = '{"power": "off"}'
	elseif mode == "toggle" then
		selmethod = "POST"
		selurl = "https://api.lifx.com/v1/lights/" .. selector .. "/toggle"
		payload = ''
	elseif mode == "list" then
		selmethod = "GET"
		selurl = "https://api.lifx.com/v1/lights/" .. selector
		payload = ''
	elseif mode == "scene" then
		selmethod = "PUT"
		selurl = "https://api.lifx.com/v1/scenes/" .. selector .. "/activate"
		payload = ''
	end

	local body, code, headers, status = https.request {
		url = selurl,
		method = selmethod,
		headers = {
				   ["Accept"] = "*/*",
				   ["Authorization"] = "Bearer " .. token,
				   ["Content-Type"] = "application/json",
				   ["accept-encoding"] = "gzip, deflate",
				   ["Content-Length"] = payload:len() },
		protocol = "tlsv1_2",
		source = ltn12.source.string(payload),
		sink = ltn12.sink.table(resp)
	 }
end
