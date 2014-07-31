Aquasync-Backend-Ruby
===================

A backend for [Aquasync protocol](https://github.com/AQAquamarine/aquasync-protocol) implemented in Ruby with Sinatra.

Endpoints
---

The backend respond to POST /deltas for push and GET /deltas/from::ust for pull.

###POST /deltas

Receives a [DeltaPack](https://github.com/AQAquamarine/aquasync-protocol/blob/master/deltapack.md) in request body and returns a result.

`example: POST /deltas`

```json
// EXAMPLE RESULT
{
  "result": "200"
  "id": "SUCCESS"
}
```

###GET /deltas/from::ust

`example: GET /deltas/from:123456789`

Returns a [DeltaPack](https://github.com/AQAquamarine/aquasync-protocol/blob/master/deltapack.md) with `Content-Type:application/json;`

```json
// EXAMPLE RESULT
{
  "_id": "0f72fa94-dae3-4d3c-8528-af25df5ff7c9",
  "Book": [
    {
      "id": "0f72fa94-d0e3-497c-8528-af25df5ff7c9",
      "name": "The Little Prince",
      "author_name": "Taro Tanaka"
    },
    {
      "id": "1f72fa94-d0e3-497c-8528-af25df5ff7c9",
      "name": "Alice in Wonderland",
      "author_name": "Bob Dylan"
    },
    {
      "id": "2f72fa94-d0e3-497c-8528-af25df5ff7c9",
      "name": "Harry Potter",
      "author_name": "Charles Schwab"
    }
  ],
  "Author": [
    {
      "id": "2c72fa94-d0e3-497c-8528-af25df5ff7c9",
      "name": "Taro Tanaka"
    }
  ]
}
```