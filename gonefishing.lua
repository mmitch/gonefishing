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

-- BEGIN LOCALIZATION

if (GetLocale() == "deDE") then
   GONEFISHING_ERR_NOSAVEDGEAR  = "Gone Fishing ist verwirrt: keine ursprüngliche Ausrüstung gespeichert";
   GONEFISHING_ERR_RODSAVED     = "Gone Fishing ist verwirrt: ursprüngliche Ausrüstung enthält eine Angel";
   GONEFISHING_ERR_TELLME       = "Über 9000! Bitte kontaktiere den Autor von Gone Fishing author und verrate ihm, was Du gerade gemacht hast";
   GONEFISHING_MSG_EQUIP        = "Gone Fishing: lege Angelausrüstung an";
   GONEFISHING_MSG_RESTORE      = "Gone Fishing: lege ursprüngliche Ausrüstung an";
   GONEFISHING_MSG_STARTUP      = "Gone Fishing version %s initialisiert";
else
   GONEFISHING_ERR_NOSAVEDGEAR  = "Gone Fishing is confused: no original gear known";
   GONEFISHING_ERR_RODSAVED     = "Gone Fishing is confused: original gear contains a fishing rod";
   GONEFISHING_ERR_TELLME       = "You win 1000 Intarwebs: please contact the Gone Fishing author and tell him what you did just now";
   GONEFISHING_MSG_EQUIP        = "Gone Fishing: equipping fishing gear";
   GONEFISHING_MSG_RESTORE      = "Gone Fishing: restoring original gear";
   GONEFISHING_MSG_STARTUP      = "Gone Fishing version %s initialized";
end;

-- END LOCALIZATION

-- list of fishing hoods, best hood last
GONEFISHING_hoodlist = {

   -- +5
   19972, -- "Glücksangelhut",
   7996,  -- "Alter abgewetzter Angelhut",
   88710, -- "Nats Hut",
   33820, -- "Wettergegerbter Angelhut"

};


-- list of fishing boots, best boot last
GONEFISHING_bootlist = {

   -- +5
   19969, -- "Nat Pagles Extremanglerstiefel",

   -- +15
   50287, -- "Stiefel der Bucht"

};


-- list of fishing poles, best pole last
GONEFISHING_polelist = {

   -- +0 (not really needed any more…)
   45120, -- "Einfache Angelrute",
   6265,  -- "Angelrute",

   -- +3
   12225, -- "Angelrute der Familie Blump",
   52678, -- "Jonathans Angelrute",
   46337, -- "Staats Angelrute",

   -- +5
   6365,  -- "Starke Angelrute",

   -- +10
   84660, -- "Pandarenangelrute",

   -- +15
   6366,  -- "Dunkelholzangelrute",

   -- +20
   25978, -- "Seths Grafitangelrute",
   19022, -- "Nat Pagles Extremangler FC-5000",
   6367,  -- "Große Eisenangelrute",

   -- +25

   45858, -- "Nats Glücksangel",

   -- +30
   44050, -- "Meisterliche Angelrute der Kalu'ak",
   84661, -- "Drachenangel",
   45992, -- "Juwelenbesetzte Angelrute",
   45991, -- "Knöcherne Angelrute",

   -- +40
   19970, -- "Arkanitangelrute"

   -- +1000 (GM only)
   43651, -- "Pfiffis Angelrute"

};

-- set slash command
SLASH_GoneFishing1 = "/gonefishing";

-- get slot IDs
GONEFISHING_invSlotRightHand, _ = GetInventorySlotInfo("MainHandSlot");
GONEFISHING_invSlotLeftHand,  _ = GetInventorySlotInfo("SecondaryHandSlot");
GONEFISHING_invSlotHead,      _ = GetInventorySlotInfo("HeadSlot");
GONEFISHING_invSlotFeet,      _ = GetInventorySlotInfo("FeetSlot");

-- register command handler
SlashCmdList["GoneFishing"] =
   function(argv)

      -- check for modifiers
      argv, _ = SecureCmdOptionParse(argv);
      if argv == nil then
	 -- a modifier is in effect that has not been triggered
	 return;
      end;
      
      -- fishing rod in hand?
      local rightHandItemID = GetInventoryItemID("player", GONEFISHING_invSlotRightHand);
      local isFishing = tContains( GONEFISHING_polelist, rightHandItemID );

      -- swap according to fishing state
      if isFishing == nil or isFishing == 0 then
	 
	 print(GONEFISHING_MSG_EQUIP);
	
	 -- remember items in hand
	 GONEFISHING_rightHandItemID = GetInventoryItemID("player", GONEFISHING_invSlotRightHand);
	 GONEFISHING_leftHandItemID  = GetInventoryItemID("player", GONEFISHING_invSlotLeftHand);
	 GONEFISHING_headItemID      = GetInventoryItemID("player", GONEFISHING_invSlotHead);
	 GONEFISHING_feetItemID      = GetInventoryItemID("player", GONEFISHING_invSlotFeet);
	 
	 local i, itemid;
	 -- iterate over pole list
	 for i, itemid in ipairs( GONEFISHING_polelist ) do

	    -- equip fishing pole
	    EquipItemByName(itemid);
	       
	 end;
	 
	 -- iterate over hood list
	 for i, itemid in ipairs( GONEFISHING_hoodlist ) do

	    -- equip fishing hood
	    EquipItemByName(itemid);
	       
	 end;
	 
	 -- iterate over boot list
	 for i, itemid in ipairs( GONEFISHING_bootlist ) do

	    -- equip fishing boots
	    EquipItemByName(itemid);
	       
	 end;

      else
	 
	 print(GONEFISHING_MSG_RESTORE);

	 -- sanity checks
	 if GONEFISHING_rightHandItemID == nil then
	    print(GONEFISHING_ERR_NOSAVEDGEAR);
	    return;
	 end;

	 if tContains( GONEFISHING_polelist, GONEFISHING_rightHandItemID ) then
	    print(GONEFISHING_ERR_RODSAVED);
	    -- this really should not happen except for a coding error -_-;
	    print(GONEFISHING_ERR_TELLME);
	    return;
	 end;

	 -- restore saved equipment
	 EquipItemByName(GONEFISHING_rightHandItemID, GONEFISHING_invSlotRightHand);
	 EquipItemByName(GONEFISHING_leftHandItemID,  GONEFISHING_invSlotLeftHand);
	 EquipItemByName(GONEFISHING_headItemID,      GONEFISHING_invSlotHead);
	 EquipItemByName(GONEFISHING_feetItemID,      GONEFISHING_invSlotFeet);
	 
      end;
      
   end;

print( string.format(GONEFISHING_MSG_STARTUP, GetAddOnMetadata("gonefishing", "Version") ) );
