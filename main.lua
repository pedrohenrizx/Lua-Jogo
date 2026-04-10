local inspect = require('inspect')

-- Load core and models
local Item = require('src.models.Item')
local Character = require('src.models.Character')
local Room = require('src.models.Room')
local Game = require('src.core.Game')

-- Instantiate items
local sword = Item("Iron Sword", "A trusty, slightly rusted sword.", 5.5, 15)
local potion = Item("Health Potion", "Restores 50 HP.", 0.5, 25)
local goldCoin = Item("Gold Coin", "A shiny gold coin.", 0.1, 1)
local heavyArmor = Item("Heavy Plate Armor", "Very protective, very heavy.", 45.0, 200)

-- Instantiate characters
local hero = Character("Hero", "The brave adventurer.", 150, 50.0)
local goblin = Character("Goblin", "A sneaky little creature.", 30, 10.0)

-- Give the goblin an item
goblin.inventory:addItem(goldCoin)

-- Instantiate rooms
local townSquare = Room("Town Square", "A bustling center of commerce.")
local darkForest = Room("Dark Forest", "Tall trees block out the sun.")
local deepCave = Room("Deep Cave", "A damp, dark cave.")

-- Add items to rooms
townSquare.inventory:addItem(potion)
darkForest.inventory:addItem(sword)
darkForest.inventory:addItem(heavyArmor)

-- Add goblin to forest
darkForest:addCharacter(goblin)

-- Connect rooms
townSquare:addExit("north", darkForest, true)
darkForest:addExit("east", deepCave, true)

-- Initialize game
local game = Game()
game:addRoom(townSquare)
game:addRoom(darkForest)
game:addRoom(deepCave)

-- Set player and starting location
game:setPlayer(hero)
game:setStartingRoom(townSquare)

print("--- Game Started ---")
print("Initial Location: " .. tostring(game.currentRoom))

-- Simulate some actions
print("\n--- Actions ---")
game:pickupItem(potion.id)
game:movePlayer("north")
game:pickupItem(sword.id)
game:pickupItem(heavyArmor.id) -- Should fail due to weight
game:dropItem(potion.id)

print("\n--- Final Game State Inspection ---")
-- We filter out class methods and meta-tables to keep output clean, focusing on the data
local filter_class_stuff = function(item, path)
  if path[#path] == 'class' or path[#path] == '__index' or type(item) == 'function' then return nil end
  return item
end

print(inspect({
    player = {
        name = hero.name,
        health = hero.health,
        inventory_weight = hero.inventory.currentWeight,
        items = hero.inventory:getItems()
    },
    currentRoom = {
        name = game.currentRoom.name,
        items = game.currentRoom.inventory:getItems(),
        characters = game.currentRoom.characters
    }
}, { process = filter_class_stuff }))

print("\n--- Entities string output ---")
print(tostring(hero))
print(tostring(game.currentRoom))
