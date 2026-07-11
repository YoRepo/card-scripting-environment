--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Versago the Destroyer  (ID: 50259460)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 3
-- ATK 1100 | DEF 900
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can be used as a substitute for any 1 Fusion Material mentioned by name on the Fusion
-- Monster Card, but the other material(s) must be correct.
--[[ __CARD_HEADER_END__ ]]

--破壊神 ヴァサーゴ
function c50259460.initial_effect(c)
	--fusion substitute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_FUSION_SUBSTITUTE)
	e1:SetCondition(c50259460.subcon)
	c:RegisterEffect(e1)
end
function c50259460.subcon(e)
	return e:GetHandler():IsLocation(LOCATION_HAND+LOCATION_MZONE+LOCATION_GRAVE)
end
