local class = require('middleclass')

--- @class Game
--- @field player Character The main character.
--- @field currentRoom Room The room the player is currently in.
--- @field rooms table<number, Room> All rooms in the game.
local Game = class('Game')

--- Constructor for Game
function Game:initialize()
    self.player = nil
    self.currentRoom = nil
    self.rooms = {}
end

--- Sets the main player character.
--- @param player Character
function Game:setPlayer(player)
    self.player = player
end

--- Adds a room to the game world.
--- @param room Room
function Game:addRoom(room)
    self.rooms[room.id] = room
end

--- Sets the starting room for the game.
--- @param room Room
function Game:setStartingRoom(room)
    self.currentRoom = room
    if self.player then
        self.currentRoom:addCharacter(self.player)
    end
end

--- Moves the player to another room.
--- @param direction string The direction to move in.
--- @return boolean success True if moved successfully, false otherwise.
function Game:movePlayer(direction)
    if not self.currentRoom or not self.player then return false end
    
    local nextRoom = self.currentRoom:getExit(direction)
    if nextRoom then
        self.currentRoom:removeCharacter(self.player.id)
        self.currentRoom = nextRoom
        self.currentRoom:addCharacter(self.player)
        print("Moved " .. direction .. " to " .. self.currentRoom.name)
        return true
    else
        print("Cannot move " .. direction .. " from here.")
        return false
    end
end

--- Makes the player pick up an item from the current room.
--- @param itemId number The ID of the item to pick up.
--- @return boolean success True if picked up successfully, false otherwise.
function Game:pickupItem(itemId)
    if not self.currentRoom or not self.player then return false end
    
    local item = self.currentRoom.inventory.items[itemId]
    if item then
        if self.player.inventory:addItem(item) then
            self.currentRoom.inventory:removeItem(itemId)
            print("Picked up " .. item.name)
            return true
        else
            print("Cannot pick up " .. item.name .. ": Inventory too heavy.")
            return false
        end
    else
        print("Item not found in the room.")
        return false
    end
end

--- Makes the player drop an item into the current room.
--- @param itemId number The ID of the item to drop.
--- @return boolean success True if dropped successfully, false otherwise.
function Game:dropItem(itemId)
    if not self.currentRoom or not self.player then return false end
    
    local item = self.player.inventory:removeItem(itemId)
    if item then
        self.currentRoom.inventory:addItem(item)
        print("Dropped " .. item.name)
        return true
    else
        print("You don't have that item.")
        return false
    end
end

return Game
