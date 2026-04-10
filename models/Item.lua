local Entity = require('src.models.Entity')

--- @class Item : Entity
--- @field weight number The weight of the item.
--- @field value number The value of the item.
local Item = Entity:subclass('Item')

--- Constructor for Item
--- @param name string The name of the item.
--- @param description string A description of the item.
--- @param weight number The weight of the item.
--- @param value number The value of the item.
function Item:initialize(name, description, weight, value)
    Entity.initialize(self, name, description)
    self.weight = weight or 1.0
    self.value = value or 0
end

--- Returns a string representation of the item.
--- @return string
function Item:__tostring()
    return string.format("Item[%d]: %s (Weight: %.1f, Value: %d)", self.id, self.name, self.weight, self.value)
end

return Item
