-- set state to 'not fishing'
GONEFISHING_isFishing = 0;

-- set slash command
SLASH_GoneFishing1 = "/gonefishing";

-- register command handler
SlashCmdList["GoneFishing"] = function()

				 -- get slot IDs
				 local invSlotRightHand, textureName = GetInventorySlotInfo("MainHandSlot");
				 local invSlotLeftHand,  textureName = GetInventorySlotInfo("SecondaryHandSlot");

				 if GONEFISHING_isFishing == nil or GONEFISHING_isFishing == 0 then

				    -- remember items in hand
				    rightHandItemId = GetInventoryItemID("player", invSlotRightHand);
				    leftHandItemId  = GetInventoryItemID("player", invSlotLeftHand);

				    -- equip fishing rod
				    EquipItemByName("Starke Angelrute");

				    -- change state to 'fishing'
				    GONEFISHING_isFishing = 1;

				 else
				    
				    -- restore saved equipment
				    EquipItemByName(rightHandItemId, invSlotRightHand);
				    EquipItemByName(leftHandItemId,  invSlotLeftHand);

				    -- change state to 'not fishing'
				    GONEFISHING_isFishing = 0;

				 end

			      end

