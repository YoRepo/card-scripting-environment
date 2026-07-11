--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:54
-- Source DB: cards.cdb
-- Card: Beastking of the Swamps  (ID: 99426834)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Aqua
-- Level: 4
-- ATK 1000 | DEF 1100
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can be used as a substitute for any 1 Fusion Material mentioned by name on the Fusion
-- Monster Card, but the other material(s) must be correct.
--[[ __CARD_HEADER_END__ ]]

--沼地の魔獣王
function c99426834.initial_effect(c)
	--fusion substitute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_FUSION_SUBSTITUTE)
	e1:SetCondition(c99426834.subcon)
	c:RegisterEffect(e1)
end
function c99426834.subcon(e)
	return e:GetHandler():IsLocation(LOCATION_HAND+LOCATION_MZONE+LOCATION_GRAVE)
end
