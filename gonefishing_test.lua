#!/usr/bin/lua
-- Unit-Tests for gone fishing

-- Gone Fishing - fishing pole swapper addon for World of Warcraft
-- Copyright (C) 2013  Christian Garbs <mitch@cgarbs.de>
-- 
-- This program is free software: you can redistribute it and/or modify
-- it under the terms of the GNU General Public License as published by
-- the Free Software Foundation, either version 3 of the License, or
-- (at your option) any later version.
--
-- This program is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU General Public License for more details.
--
-- You should have received a copy of the GNU General Public License
-- along with this program.  If not, see <http://www.gnu.org/licenses/>.
--
--------------------------------------------------------------------------
-- helper functions

function toString(var)
   if var == nil then
      return "nil"
   end
   if var == true then
      return "true"
   end
   if var == false then
      return "false"
   end
   return var
end

function list2string(list)
   local newlist = {}
   for k,v in pairs(list) do
      table.insert(newlist, toString(v))
   end
   return "{" .. table.concat(newlist, ", ") .. "}"
end

function listPos(list, value)
   for k,v in pairs(list) do
      if value == v then
	 return k
      end
   end
   return 0
end

--------------------------------------------------------------------------
-- Test framework

function fail(reason, level)
   if level == nil then
      level = 0
   end
   error("\n\n >>> TEST FAILURE\n >>> " .. reason .. "\n", level + 2)
end

function assertNotNull(arg, reason)
   if arg == nil then
      if reason == nil then
	 reason = "argument is nil"
      end
      fail(reason, 1)
   end
end

function assertEqualsList(listExpected, listActual, reason, level)

   local bork = false
   for i,v in ipairs(listExpected) do
      if listActual[i] ~= v then
	 bork = true
      end
   end
   for i,v in ipairs(listActual) do
      if listExpected[i] ~= v then
	 bork = true
      end
   end

   if bork then
      if reason == nil then
	 reason = "list content differs"
      end
      if level == nil then
	 level = 0
      end
      fail(reason .. ", expected: " .. list2string(listExpected) .. ", actual: " .. list2string(listActual), level + 1)
   end
end

function assertEquals(expected, actual, reason, level)

   if expected ~= actual then
      if reason == nil then
	 reason = "list content differs"
      end
      if level == nil then
	 level = 0
      end
      fail(reason .. ", expected: " .. toString(expected) .. ", actual: " .. toString(actual), level + 1)
   end
end

function assertTrue(boolean, reason, level)

   if reason == nil then
      reason = "assertion not true"
   end
   if level == nil then
      level = 0
   end
   return assertEquals(true, boolean, reason, level + 1)

end

--------------------------------------------------------------------------
-- WOW Framework test hooks/injection/introspection

SlashCmdList = {}
TEST_locale = ""
TEST_slots = {
   ["MainHandSlot"] = 1,
   ["SecondaryHandSlot"] = 2,
   ["HeadSlot"] = 3,
   ["FeetSlot"] = 4
}
TEST_equip = {}
TEST_bags = {}
TEST_itemslot = { 
   [1] = 1,
   [2] = 2,
   [3] = 3,
   [4] = 4,
   [5] = 0,
}

function checkEquip(list)
   assertEqualsList(list, TEST_equip, "wrong equipment", 1)
end

function checkBags(list)
   assertEqualsList(list, TEST_bags, "wrong bag content", 1)
end

function addItemSlots(list, slot)
   for k,v in pairs(list) do
      TEST_itemslot[v] = slot
   end
end

function debug()
   print()
   print("bags:  " .. list2string(TEST_bags))
   print("equip: " .. list2string(TEST_equip))
   print("orig:  " .. list2string(
	    {
		GONEFISHING_rightHandItemID,
		GONEFISHING_leftHandItemID,
		GONEFISHING_headItemID,
		GONEFISHING_feetItemID
	    }
      ))
   print();
end

--------------------------------------------------------------------------
-- WOW Framework imitation

function GetLocale() return TEST_locale end

function GetInventorySlotInfo(slot) return TEST_slots[slot] end

function GetAddOnMetadata(addon, tag) return "unittest" end

function SecureCmdOptionParse(argv) return argv end

function GetInventoryItemID(who, slot)
   if who ~= "player" then
      return nil
   end
   if TEST_equip[slot] == 0 then
      return nil
   else
      return TEST_equip[slot]
   end   
end

function tContains(table, item)
   for k,v in pairs(table) do
      if ( item == v ) then
	 return 1
      end
   end
   return nil
end

function EquipItemByName(itemid, slot)
   assertNotNull(slot, "slot id not given", 1) -- we want this, it's more precose (should work without as well)
   assertEquals( 1, tContains( TEST_slots, slot ), "unknown slot id", 1)

   -- if dual-hand item is wielded, offhand actions are blocked
   if slot == 2 and TEST_equip[1] and TEST_equip[1] > 0 and TEST_itemslot[TEST_equip[1]] == 0 then
      return
   end

   if itemid then
      local TEST_slot = TEST_itemslot[itemid]
      assertNotNull(TEST_slot, "item slot unknown for itemid " .. itemid, 1)
      -- special case: dual hand (slot 0) can be equipped to mainhand (slot 1)
      if not ( TEST_slot == 0 and slot == 1 ) then
	 assertEquals(TEST_slot, slot, "given slot is wrong for itemid " .. itemid, 1)
      end

      -- equip item
      local bagPos = listPos(TEST_bags, itemid)
      if bagPos > 0 then
	 if TEST_slot > 0 then
	    if TEST_equip[slot] and TEST_equip[slot] > 0 then
	       table.insert( TEST_bags, TEST_equip[slot] )
	    end
	    table.remove( TEST_bags, bagPos )
	    TEST_equip[slot] = itemid
	 else
	    -- dual hand
	    if TEST_equip[1] and TEST_equip[1] > 0 then
	       table.insert( TEST_bags, TEST_equip[1] )
	    end
	    if TEST_equip[2] and TEST_equip[2] > 0 then
	       table.insert( TEST_bags, TEST_equip[2] )
	    end
	    table.remove( TEST_bags, bagPos )
	    TEST_equip[1] = itemid
	    TEST_equip[2] = 0
	 end
      end

   else
      -- equip nothing
      if TEST_equip[slot] and TEST_equip[slot] > 0 then
	 table.insert( TEST_bags, TEST_equip[slot] )
      end
      TEST_equip[slot] = 0

   end
end

--------------------------------------------------------------------------
-- Import code to test

dofile("gonefishing.lua")

addItemSlots(GONEFISHING_hoodlist, 3)
addItemSlots(GONEFISHING_bootlist, 4)
addItemSlots(GONEFISHING_polelist, 0)

--------------------------------------------------------------------------
-- Run Test cases

-- check macro
gonefishing = SlashCmdList["GoneFishing"]
assertNotNull(gonefishing)
run_test = function ()
	      gonefishing("")
	   end
reset_test = function ()
		GONEFISHING_rightHandItemID = nil
		GONEFISHING_leftHandItemID  = nil
		GONEFISHING_headItemID      = nil
		GONEFISHING_feetItemID      = nil
	     end

-- naked character -> empty result
print("Test 1 ::")
reset_test()
TEST_bags = {}
TEST_equip = {}
run_test()
checkBags( {} )
checkEquip( {} )
run_test()
checkBags( {} )
checkEquip( {} )


-- naked character with full bags -> empty result
print("Test 2 ::")
reset_test()
TEST_bags = { 1, 2, 3, 4, 5 }
TEST_equip = {}
run_test()
checkBags( { 1, 2, 3, 4, 5 } )
checkEquip( {} )
run_test()
checkBags( { 1, 2, 3, 4, 5 } )
checkEquip( {} )


-- naked, but rod in bag -> equip and unequip again
print("Test 3 ::")
reset_test()
TEST_bags = { 6265 }
TEST_equip = { 0, 0, 0, 0 }
run_test()
checkBags( {} )
checkEquip( { 6265, 0, 0, 0  } )
run_test()
checkBags( { 6265 } )
checkEquip( { 0, 0, 0, 0 } )

-- fully equipped character
print("Test 4 ::")
reset_test()
TEST_bags = { 6265 }
TEST_equip = { 1, 2, 3, 4 }
run_test()
checkBags( { 1, 2 } )
checkEquip( { 6265, 0, 3, 4 } )
run_test()
checkBags( { 6265 } )
checkEquip( { 1, 2, 3, 4} )

-- half equipped, dual hand, boots in bag
print("Test 5 ::")
reset_test()
TEST_bags = { 6365, 7996, 1234 }
TEST_equip = { 5, 0, 0, 4 }
run_test()
checkBags( { 1234, 5 } )
checkEquip( { 6365, 0, 7996, 4 } )
run_test()
checkBags( { 1234, 6365, 7996 } )
checkEquip( { 5, 0, 0, 4} )

