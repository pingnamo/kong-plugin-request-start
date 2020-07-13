local helpers = require "spec.helpers"

for _, strategy in helpers.each_strategy() do
  describe("Plugin: request-start(access) [#" .. strategy .. "]", function()
    local client

    lazy_setup(function()
      local bp = helpers.get_db_utils(strategy, nil, { "request-start" })

      local route1 = bp.routes:insert({
        hosts = { "test1.com" },
      })

      bp.plugins:insert {
        name = "request-start",
        route = { id = route1.id },
        config = {},
      }

      assert(helpers.start_kong({
        database = strategy,
        plugins = "bundled, request-start",
        nginx_conf = "spec/fixtures/custom_nginx.template",
      }))
    end)

    lazy_teardown(function()
      helpers.stop_kong()
    end)

    before_each(function()
      client = helpers.proxy_client()
    end)

    after_each(function()
      if client then client:close() end
    end)

    describe("request", function()
      it("gets a 'X-Request-Start' header", function()
        local r = assert(client:send {
          method = "GET",
          path = "/request",
          headers = {
            host = "test1.com"
          }
        })
        assert.response(r).has.status(200)
        assert.request(r).has.header("X-Request-Start")
      end)
    end)
  end)
end
