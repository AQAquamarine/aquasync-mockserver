aquasync_model
===================

[![Gem Version](https://badge.fury.io/rb/aquasync_model.svg)](http://badge.fury.io/rb/aquasync_model)

A module to mixin [Aquasync Model](https://github.com/AQAquamarine/aquasync-protocol/blob/master/aquasync-model.md) requirements.

### Example

```rb
require 'aquasync_model'

class Book
  include Aquasync::Base

  field :name
end
```

Then it automatically mixin fields, callbacks, validators to satisfy [Aquasync Model](https://github.com/AQAquamarine/aquasync-protocol/blob/master/aquasync-model.md) requirement.

### Fields

```rb
# should be UNIX timestamp
# @example 1406697904
field :ust, type: Integer
# should be UNIX timestamp
# @example 1406697904
field :localTimestamp, type: Integer
# should be UUIDv1
# @example 550e8400-e29b-41d4-a716-446655440000
field :gid, type: String
# should be UUIDv1
# @example 550e8400-e29b-41d4-a716-446655440000
field :deviceToken, type: String
# for paranoid deletion
# @example false
field :isDeleted, type: Boolean
```

### Callbacks

```rb
before_validation do
  downcase_gid
  downcase_device_token
  set_ust
end
```

### Validations

```rb
validates_presence_of :gid
validates_format_of :gid, with: /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/
validates_presence_of :ust
validates_presence_of :deviceToken
validates_format_of :deviceToken, with: /[0-9a-f]{8}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{4}-[0-9a-f]{12}/
validates_presence_of :localTimestamp
```

### Aquasync DeltasAggregator methods

```rb
def aq_deltas(ust)
    where(:ust.gt => ust)
end

def aq_commit_deltas(deltas)
    deltas.each {|delta| commit_delta(delta) }
end
```

### Aquasync DeltaPack methods

```rb
def to_h
  serializable_hash.delete_if {|key| key == "_id" or key == "ust"}
end
```