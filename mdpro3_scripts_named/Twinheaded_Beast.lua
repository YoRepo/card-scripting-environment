--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Twinheaded Beast  (ID: 82035781)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Beast
-- Level: 6
-- ATK 1700 | DEF 1900
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card can attack twice during the same Battle Phase.
--[[ __CARD_HEADER_END__ ]]

--ツインヘデッド・ビースト
function c82035781.initial_effect(c)
	--multi attack
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(1)
	c:RegisterEffect(e1)
end
