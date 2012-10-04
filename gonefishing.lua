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

-- register command handler
SlashCmdList["GoneFishing"] =
   function()

      -- get slot IDs
      local invSlotRightHand, textureName = GetInventorySlotInfo("MainHandSlot");
      local invSlotLeftHand,  textureName = GetInventorySlotInfo("SecondaryHandSlot");
      local invSlotHead,      textureName = GetInventorySlotInfo("HeadSlot");
      local invSlotFeet,      textureName = GetInventorySlotInfo("FeetSlot");

      -- fishing rod in hand?
      local rightHandItemName = GetItemInfo( GetInventoryItemID("player", invSlotRightHand) );
      local isFishing = tContains( GONEFISHING_polelist, rightHandItemName );

      -- swap according to fishing state
      if isFishing == nil or isFishing == 0 then
	 
	 -- remember items in hand
	 GONEFISHING_rightHandItemId = GetInventoryItemID("player", invSlotRightHand);
	 GONEFISHING_leftHandItemId  = GetInventoryItemID("player", invSlotLeftHand);
	 GONEFISHING_headItemId      = GetInventoryItemID("player", invSlotHead);
	 GONEFISHING_feetItemId      = GetInventoryItemID("player", invSlotFeet);
	 
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
	 EquipItemByName(GONEFISHING_rightHandItemId, invSlotRightHand);
	 EquipItemByName(GONEFISHING_leftHandItemId,  invSlotLeftHand);
	 EquipItemByName(GONEFISHING_headItemId,      invSlotHead);
	 EquipItemByName(GONEFISHING_feetItemId,      invSlotFeet);
	 
	 print("Gonefishing: equip restored");

      end;
      
   end;

print("Gonefishing: initialized");
