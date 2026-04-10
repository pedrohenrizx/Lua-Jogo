local class = require('middleclass')

--- @class Entity
--- @field id number The unique identifier of the entity.
--- @field name string The name of the entity.
--- @field description string A description of the entity.
local Entity = class('Entity')

local nextId = 1

--- Constructor for Entity
--- @param name string The name of the entity.
--- @param description string A description of the entity.
function Entity:initialize(name, description)
    self.id = nextId
    nextId = nextId + 1
    self.name = name or "Unknown"
    self.description = description or "An entity."
end

--- Returns a string representation of the entity.
--- @return string
function Entity:__tostring()
    return string.format("Entity[%d]: %s", self.id, self.name)
end

return Entity
