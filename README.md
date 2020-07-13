# Kong request start plugin

## Synopsis

This plugin adds the `X-Request-Start` header to the request sent by a client on Kong, before hitting the upstream server. The header containers the value of nginx request start timestamp.
It is useful for monitoring the request queueing.

## Configuration

### Enabling the plugin on a Service

Configure this plugin on a Service by making the following request:

```bash
$ curl -X POST http://kong:8001/services/{service}/plugins \
    --data "name=request-start"
```

`service`: the `id` or `name` of the Service that this plugin configuration will target.

### Enabling the plugin on a Route

Configure this plugin on a Route with:

```bash
$ curl -X POST http://kong:8001/routes/{route_id}/plugins \
    --data "name=request-start"
```

`route_id`: the `id` of the Route that this plugin configuration will target.

### Enabling the plugin on a Consumer
You can use the `http://localhost:8001/plugins` endpoint to enable this plugin on specific Consumers:

```bash
$ curl -X POST http://kong:8001/plugins \
    --data "name=request-start" \
    --data "consumer_id={consumer_id}"
```

Where `consumer_id` is the `id` of the Consumer we want to associate with this plugin.
