local RequestStartHandler = {
  VERSION  = "0.1",
  PRIORITY = 800, -- request-transformer is 801
}

function RequestStartHandler:access(conf)
  ngx.req.set_header("X-Request-Start", ngx.req.start_time())
end

return RequestStartHandler
