-- list of fishing poles, best pole last
GONEFISHING_polelist = {

   "Einfache Angelrute",
   "Basic Fishing Pole",

   "Angelrute",
   "Fishing Pole",

   "Starke Angelrute",
   "Strong Fishing Pole",
   
   "Seths Grafitangelrute",
   "Seth's Graphite Fishing Pole",

   "Knöcherne Angelrute",
   "Bone Fishing Pole"

};

-- set slash command
SLASH_GoneFishing1 = "/gonefishing";

-- register command handler
SlashCmdList["GoneFishing"] =
   function()

      -- get slot IDs
      local invSlotRightHand, textureName = GetInventorySlotInfo("MainHandSlot");
      local invSlotLeftHand,  textureName = GetInventorySlotInfo("SecondaryHandSlot");

      -- fishing rod in hand?
      local rightHandItemName = GetItemInfo( GetInventoryItemID("player", invSlotRightHand) );
      local isFishing = tContains( GONEFISHING_polelist, rightHandItemName );

      -- swap according to fishing state
      if isFishing == nil or isFishing == 0 then
	 
	 -- remember items in hand
	 GONEFISHING_rightHandItemId = GetInventoryItemID("player", invSlotRightHand);
	 GONEFISHING_leftHandItemId  = GetInventoryItemID("player", invSlotLeftHand);
	 
	 -- iterate over pole list
	 local i, itemname;
	 for i, itemname in ipairs( GONEFISHING_polelist ) do

	    -- equip fishing pole
	    EquipItemByName(itemname);
	       
	 end;
	 
      else
	 
	 -- restore saved equipment
	 EquipItemByName(GONEFISHING_rightHandItemId, invSlotRightHand);
	 EquipItemByName(GONEFISHING_leftHandItemId,  invSlotLeftHand);
	 
      end;
      
   end;

print("Gonefishing initialized.");
