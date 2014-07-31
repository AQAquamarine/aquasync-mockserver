Aquasync-Backend-Ruby
===================

A backend for [Aquasync protocol](https://github.com/AQAquamarine/aquasync-protocol) implemented in Ruby with Sinatra.

Endpoints
---

The backend respond to POST /deltas for push and GET /deltas/from::ust for pull.

###POST /deltas

Receives a DeltaPack in request body and returns a result.

```json
{
  "result": "200"
  "id": "SUCCESS"
}
```

###GET /deltas/from::ust

`example: GET /deltas/from:123456789`

Returns a DeltaPack with `Content-Type:application/json;`