-- set state to 'not fishing'
GONEFISHING_isFishing = 0;

-- list of fishing poles, best pole first
GONEFISHING_rodlist = {
   "Knöcherne Angelrute",
   "Bone Fishing Pole",

   "Starke Angelrute",
   "Strong Fishing Pole",

   "Angelrute",
   "Fishing Pole",

   "Einfache Angelrute",
   "Basic Fishing Pole"
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
	 local i = 0;
	 local continue = 1;
	 
	 while continue == 1 do
	    
	    -- get item name from list
	    i = i + 1;
	    local itemname = GONEFISHING_rodlist[i];
	    
	    if itemname == nil then
	       
	       -- end of list
	       continue = 0;
	       
	    else
	       
	       -- equip fishing pole
	       EquipItemByName(itemname);
	       
	       -- did it work?
	       local newRightHandItemId = GetInventoryItemID("player", invSlotRightHand);
	       if newRightHandItemId ~= GONEFISHING_rightHandItemId then
		  continue = 0;
	       end
	       
	    end
	    
	 end
	 
	 -- change state to 'fishing'
	 GONEFISHING_isFishing = 1;
	 
      else
	 
	 -- restore saved equipment
	 EquipItemByName(GONEFISHING_rightHandItemId, invSlotRightHand);
	 EquipItemByName(GONEFISHING_leftHandItemId,  invSlotLeftHand);
	 
	 -- change state to 'not fishing'
	 GONEFISHING_isFishing = 0;
	 
      end
      
   end

