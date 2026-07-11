--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Beelze Frog  (ID: 49522489)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level: 3
-- ATK 1200 | DEF 800
-- Setcode: 0x12
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card gains 300 ATK for each "T.A.D.P.O.L.E." in your Graveyard.
--[[ __CARD_HEADER_END__ ]]

--悪魔ガエル
function c49522489.initial_effect(c)
	--Special Summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_UPDATE_ATTACK)
	e1:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e1:SetRange(LOCATION_MZONE)
	e1:SetValue(c49522489.val)
	c:RegisterEffect(e1)
end
function c49522489.val(e,c)
	return Duel.GetMatchingGroupCount(Card.IsCode,c:GetControler(),LOCATION_GRAVE,0,nil,10456559)*300
end
