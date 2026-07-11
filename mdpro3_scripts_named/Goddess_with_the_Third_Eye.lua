--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Goddess with the Third Eye  (ID: 53493204)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 4
-- ATK 1200 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can be used as a substitute for any 1 Fusion Material mentioned by name on the Fusion
-- Monster Card, but the other material(s) must be correct.
--[[ __CARD_HEADER_END__ ]]

--心眼の女神
function c53493204.initial_effect(c)
	--fusion substitute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_FUSION_SUBSTITUTE)
	e1:SetCondition(c53493204.subcon)
	c:RegisterEffect(e1)
end
function c53493204.subcon(e)
	return e:GetHandler():IsLocation(LOCATION_HAND+LOCATION_MZONE+LOCATION_GRAVE)
end
