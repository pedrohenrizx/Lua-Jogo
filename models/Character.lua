local Entity = require('src.models.Entity')
local Inventory = require('src.models.Inventory')

--- @class Character : Entity
--- @field health number The current health of the character.
--- @field maxHealth number The maximum health of the character.
--- @field inventory Inventory The character's inventory.
local Character = Entity:subclass('Character')

--- Constructor for Character
--- @param name string The name of the character.
--- @param description string A description of the character.
--- @param maxHealth number The maximum health of the character.
--- @param carryCapacity number The maximum weight the character can carry.
function Character:initialize(name, description, maxHealth, carryCapacity)
    Entity.initialize(self, name, description)
    self.maxHealth = maxHealth or 100
    self.health = self.maxHealth
    self.inventory = Inventory(carryCapacity or 50.0)
end

--- Damages the character, reducing their health.
--- @param amount number The amount of damage to take.
function Character:takeDamage(amount)
    self.health = math.max(0, self.health - amount)
end

--- Heals the character, increasing their health up to the maximum.
--- @param amount number The amount of health to restore.
function Character:heal(amount)
    self.health = math.min(self.maxHealth, self.health + amount)
end

--- Checks if the character is alive.
--- @return boolean
function Character:isAlive()
    return self.health > 0
end

--- Returns a string representation of the character.
--- @return string
function Character:__tostring()
    return string.format("Character[%d]: %s (HP: %d/%d) - %s", self.id, self.name, self.health, self.maxHealth, tostring(self.inventory))
end

return Character
