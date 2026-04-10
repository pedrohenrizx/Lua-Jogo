local Entity = require('src.models.Entity')
local Inventory = require('src.models.Inventory')

--- @class Room : Entity
--- @field exits table<string, Room> Links to other rooms by direction (e.g., "north", "south").
--- @field inventory Inventory The items present in the room.
--- @field characters table<number, Character> Characters currently in the room.
local Room = Entity:subclass('Room')

--- Constructor for Room
--- @param name string The name of the room.
--- @param description string A description of the room.
function Room:initialize(name, description)
    Entity.initialize(self, name, description)
    self.exits = {}
    self.inventory = Inventory() -- Unlimited weight for a room's inventory
    self.characters = {}
end

--- Connects this room to another room in a specific direction.
--- @param direction string The direction to the other room (e.g., "north", "east").
--- @param room Room The destination room.
--- @param twoWay boolean|nil If true, creates a reverse connection.
function Room:addExit(direction, room, twoWay)
    self.exits[direction] = room
    if twoWay then
        local opposites = {
            north = "south", south = "north",
            east = "west", west = "east",
            up = "down", down = "up"
        }
        local reverseDir = opposites[direction]
        if reverseDir then
            room.exits[reverseDir] = self
        end
    end
end

--- Gets the room connected in the specified direction.
--- @param direction string The direction to check.
--- @return Room|nil The connected room, or nil if no exit exists.
function Room:getExit(direction)
    return self.exits[direction]
end

--- Adds a character to the room.
--- @param character Character The character to add.
function Room:addCharacter(character)
    self.characters[character.id] = character
end

--- Removes a character from the room.
--- @param characterId number The ID of the character to remove.
--- @return Character|nil The removed character, or nil if not found.
function Room:removeCharacter(characterId)
    local char = self.characters[characterId]
    if char then
        self.characters[characterId] = nil
        return char
    end
    return nil
end

--- Returns a string representation of the room.
--- @return string
function Room:__tostring()
    local exitDirs = {}
    for dir in pairs(self.exits) do
        table.insert(exitDirs, dir)
    end
    local exitStr = #exitDirs > 0 and table.concat(exitDirs, ", ") or "None"
    
    local charCount = 0
    for _ in pairs(self.characters) do charCount = charCount + 1 end

    return string.format("Room[%d]: %s (Exits: %s, Items: %d, Characters: %d)", self.id, self.name, exitStr, self.inventory:getItemCount(), charCount)
end

return Room
