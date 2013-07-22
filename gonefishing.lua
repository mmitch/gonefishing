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

};

-- set slash command
SLASH_GoneFishing1 = "/gonefishing";

-- get slot IDs
local textureName;
GONEFISHING_invSlotRightHand, textureName = GetInventorySlotInfo("MainHandSlot");
GONEFISHING_invSlotLeftHand,  textureName = GetInventorySlotInfo("SecondaryHandSlot");
GONEFISHING_invSlotHead,      textureName = GetInventorySlotInfo("HeadSlot");
GONEFISHING_invSlotFeet,      textureName = GetInventorySlotInfo("FeetSlot");

-- register command handler
SlashCmdList["GoneFishing"] =
   function()

      -- fishing rod in hand?
      local rightHandItemId = GetInventoryItemID("player", GONEFISHING_invSlotRightHand);
      local isFishing = tContains( GONEFISHING_polelist, rightHandItemId );

      -- swap according to fishing state
      if isFishing == nil or isFishing == 0 then
	 
	 print("Gonefishing: equipping fishing pole");
	
	 -- remember items in hand
	 GONEFISHING_rightHandItemId = GetInventoryItemID("player", GONEFISHING_invSlotRightHand);
	 GONEFISHING_leftHandItemId  = GetInventoryItemID("player", GONEFISHING_invSlotLeftHand);
	 GONEFISHING_headItemId      = GetInventoryItemID("player", GONEFISHING_invSlotHead);
	 GONEFISHING_feetItemId      = GetInventoryItemID("player", GONEFISHING_invSlotFeet);
	 
	 -- iterate over pole list
	 local i, itemid;
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
	 
	 print("Gonefishing: restoring saved equipment");

	 -- restore saved equipment
	 EquipItemByName(GONEFISHING_rightHandItemId, GONEFISHING_invSlotRightHand);
	 EquipItemByName(GONEFISHING_leftHandItemId,  GONEFISHING_invSlotLeftHand);
	 EquipItemByName(GONEFISHING_headItemId,      GONEFISHING_invSlotHead);
	 EquipItemByName(GONEFISHING_feetItemId,      GONEFISHING_invSlotFeet);
	 
      end;
      
   end;

print("Gonefishing: initialized");
