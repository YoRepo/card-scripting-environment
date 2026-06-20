--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:37
-- Card: 花狼  (ID: 95952802)
-- Type: Monster / Fusion
-- Attribute: EARTH
-- Race: Beast
-- Level 5
-- ATK 1800 | DEF 1400
--
-- Effect Text:
-- 「银牙狼」＋「魔界之棘」
--[[ __CARD_HEADER_END__ ]]

--フラワー・ウルフ
function c95952802.initial_effect(c)
	--fusion material
	c:EnableReviveLimit()
	aux.AddFusionProcCode2(c,90357090,43500484,true,true)
end
