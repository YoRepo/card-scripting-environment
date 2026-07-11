--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Mystical Sheep #1  (ID: 30451366)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Beast
-- Level: 3
-- ATK 1150 | DEF 900
-- Scope: OCG / TCG
--
-- Effect Text:
-- You can substitute this card for any 1 Fusion-Material Monster.
-- When you do this, the other Fusion-Material Monster(s) must be the correct one(s).
--[[ __CARD_HEADER_END__ ]]

--イリュージョン・シープ
function c30451366.initial_effect(c)
	--fusion substitute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_FUSION_SUBSTITUTE)
	e1:SetCondition(c30451366.subcon)
	c:RegisterEffect(e1)
end
function c30451366.subcon(e)
	return e:GetHandler():IsLocation(LOCATION_HAND+LOCATION_MZONE+LOCATION_GRAVE)
end
