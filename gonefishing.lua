-- list of fishing hoods, best hood last
GONEFISHING_hoodlist = {

   -- +5

   "Glücksangelhut",

   "Alter abgewetzter Angelhut",

   "Nats Hut",

   "Wettergegerbter Angelhut"

};


-- list of fishing boots, best boot last
GONEFISHING_bootlist = {

   -- +5

   "Nat Pagles Extremanglerstiefel",

   -- +15

   "Stiefel der Bucht"

};


-- list of fishing poles, best pole last
GONEFISHING_polelist = {

   -- +0 (TODO: check this)

   "Einfache Angelrute",
   "Basic Fishing Pole",

   "Angelrute",
   "Fishing Pole",

   -- +3

   "Angelrute der Familie Blump",

   "Jonathans Angelrute",

   "Staats Angelrute",

   -- +5

   "Starke Angelrute",
   "Strong Fishing Pole",

   -- +10

   "Pandarenangelrute",

   -- +15

   "Dunkelholzangelrute",

   -- +20
   
   "Seths Grafitangelrute",
   "Seth's Graphite Fishing Pole",

   "Nat Pagles Extremangler FC-5000",

   "Große Eisenangelrute",

   -- +25

   "Nats Glücksangel",

   -- +30

   "Meisterliche Angelrute der Kalu'ak",

   "Drachenangel",

   "Juwelenbesetzte Angelrute",

   "Knöcherne Angelrute",
   "Bone Fishing Pole",

   -- +40

   "Arkanitangelrute"

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
      local rightHandItemName = GetItemInfo( GetInventoryItemID("player", GONEFISHING_invSlotRightHand) );
      local isFishing = tContains( GONEFISHING_polelist, rightHandItemName );

      -- swap according to fishing state
      if isFishing == nil or isFishing == 0 then
	 
	 -- remember items in hand
	 GONEFISHING_rightHandItemId = GetInventoryItemID("player", GONEFISHING_invSlotRightHand);
	 GONEFISHING_leftHandItemId  = GetInventoryItemID("player", GONEFISHING_invSlotLeftHand);
	 GONEFISHING_headItemId      = GetInventoryItemID("player", GONEFISHING_invSlotHead);
	 GONEFISHING_feetItemId      = GetInventoryItemID("player", GONEFISHING_invSlotFeet);
	 
	 -- iterate over pole list
	 local i, itemname;
	 for i, itemname in ipairs( GONEFISHING_polelist ) do

	    -- equip fishing pole
	    EquipItemByName(itemname);
	       
	 end;
	 
	 -- iterate over hood list
	 local i, itemname;
	 for i, itemname in ipairs( GONEFISHING_hoodlist ) do

	    -- equip fishing hood
	    EquipItemByName(itemname);
	       
	 end;
	 
	 -- iterate over boot list
	 local i, itemname;
	 for i, itemname in ipairs( GONEFISHING_bootlist ) do

	    -- equip fishing boots
	    EquipItemByName(itemname);
	       
	 end;
	 
	 print("Gonefishing: pole equipped");
	
      else
	 
	 -- restore saved equipment
	 EquipItemByName(GONEFISHING_rightHandItemId, GONEFISHING_invSlotRightHand);
	 EquipItemByName(GONEFISHING_leftHandItemId,  GONEFISHING_invSlotLeftHand);
	 EquipItemByName(GONEFISHING_headItemId,      GONEFISHING_invSlotHead);
	 EquipItemByName(GONEFISHING_feetItemId,      GONEFISHING_invSlotFeet);
	 
	 print("Gonefishing: equip restored");

      end;
      
   end;

print("Gonefishing: initialized");
