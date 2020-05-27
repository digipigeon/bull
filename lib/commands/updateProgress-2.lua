--[[
  Update job progress

     Input:
        KEYS[1] Job id key
        KEYS[2] progress event key
      
        ARGV[1] progress
        ARGV[2] event data
        ARGV[3] event logdata

      Event:
        progress(jobId, progress)
]]
redis.call("HSET", KEYS[1], "progress", ARGV[1])
if ARGV[3] ~= "" then
	local logdata = redis.call('HGET', KEYS[1], "log")
	if logdata == false then logdata = "" else logdata = logdata .. "\n" end
	redis.call("HSET", KEYS[1], "log", logdata .. ARGV[3])
end
redis.call("PUBLISH", KEYS[2], ARGV[2] .. "|" .. ARGV[1] .. "|" .. ARGV[3])
