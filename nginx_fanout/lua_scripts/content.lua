local http = require "resty.http"


local function http_fanout(i)
  local port = 8100 + i 
  local httpc = http.new()
  local res, err = httpc:request_uri("http://127.0.0.1:" .. tostring(port), {
    method = "GET",
    keepalive_timeout = 60,
    keepalive_pool = 10
  })

  if not res then
    ngx.say(i, ": failed to request: ", err)
    return 
  end

  ngx.status = res.status
  ngx.say(i, ": request status: ", res.status)
  ngx.say(res.body)

end

local threads = {
  ngx.thread.spawn(http_fanout, 1),
  ngx.thread.spawn(http_fanout, 2),
  ngx.thread.spawn(http_fanout, 3),
  ngx.thread.spawn(http_fanout, 4)
}

for i = 1, #threads do
  local ok, res = ngx.thread.wait(threads[i])
end








