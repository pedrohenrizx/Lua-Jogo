local class = require('middleclass')

--- @class Inventory
--- @field items table<number, Item> A table of items indexed by their ID.
--- @field maxWeight number The maximum weight the inventory can hold.
--- @field currentWeight number The current total weight of items in the inventory.
local Inventory = class('Inventory')

--- Constructor for Inventory
--- @param maxWeight number The maximum weight the inventory can hold.
function Inventory:initialize(maxWeight)
    self.items = {}
    self.maxWeight = maxWeight or math.huge
    self.currentWeight = 0
end

--- Adds an item to the inventory if weight permits.
--- @param item Item The item to add.
--- @return boolean success True if the item was added, false if it exceeds max weight.
function Inventory:addItem(item)
    if self.currentWeight + item.weight > self.maxWeight then
        return false
    end
    
    self.items[item.id] = item
    self.currentWeight = self.currentWeight + item.weight
    return true
end

--- Removes an item from the inventory by its ID.
--- @param itemId number The ID of the item to remove.
--- @return Item|nil The removed item, or nil if not found.
function Inventory:removeItem(itemId)
    local item = self.items[itemId]
    if item then
        self.items[itemId] = nil
        self.currentWeight = self.currentWeight - item.weight
        return item
    end
    return nil
end

--- Gets a list of all items in the inventory.
--- @return Item[] An array of items.
function Inventory:getItems()
    local list = {}
    for _, item in pairs(self.items) do
        table.insert(list, item)
    end
    return list
end

--- Gets the total value of all items in the inventory.
--- @return number
function Inventory:getTotalValue()
    local total = 0
    for _, item in pairs(self.items) do
        total = total + item.value
    end
    return total
end

--- Returns a string representation of the inventory.
--- @return string
function Inventory:__tostring()
    return string.format("Inventory(Weight: %.1f/%.1f, Items: %d)", self.currentWeight, self.maxWeight, self:getItemCount())
end

--- Gets the number of items in the inventory.
--- @return number
function Inventory:getItemCount()
    local count = 0
    for _ in pairs(self.items) do
        count = count + 1
    end
    return count
end

return Inventory
