-- set state to 'not fishing'
GONEFISHING_isFishing = 0;

-- list of fishing poles, best pole last
GONEFISHING_polelist = {

   "Einfache Angelrute",
   "Basic Fishing Pole",

   "Angelrute",
   "Fishing Pole",

   "Starke Angelrute",
   "Strong Fishing Pole",

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
      
      if GONEFISHING_isFishing == nil or GONEFISHING_isFishing == 0 then
	 
	 -- remember items in hand
	 GONEFISHING_rightHandItemId = GetInventoryItemID("player", invSlotRightHand);
	 GONEFISHING_leftHandItemId  = GetInventoryItemID("player", invSlotLeftHand);
	 
	 -- iterate over pole list
	 local i, itemname;
	 for i, itemname in ipairs( GONEFISHING_polelist ) do

	    -- equip fishing pole
	    EquipItemByName(itemname);
	       
	 end;
	 
	 -- change state to 'fishing'
	 GONEFISHING_isFishing = 1;
	 
      else
	 
	 -- restore saved equipment
	 EquipItemByName(GONEFISHING_rightHandItemId, invSlotRightHand);
	 EquipItemByName(GONEFISHING_leftHandItemId,  invSlotLeftHand);
	 
	 -- change state to 'not fishing'
	 GONEFISHING_isFishing = 0;
	 
      end;
      
   end;

