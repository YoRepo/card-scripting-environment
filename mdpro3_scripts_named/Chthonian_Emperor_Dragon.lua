--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-11-19T23:32:31
-- Source DB: cards.cdb
-- Card: Chthonian Emperor Dragon  (ID: 95888876)
-- Type: Monster / Effect / Gemini
-- Attribute: FIRE
-- Race: Dragon
-- Level: 6
-- ATK 2400 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is treated as a Normal Monster while face-up on the field or in the GY.
-- While this card is a Normal Monster on the field, you can Normal Summon it to have it become an
-- Effect Monster with this effect.
-- ● Can make a second attack during each Battle Phase.
--[[ __CARD_HEADER_END__ ]]

--ヘルカイザー・ドラゴン
function c95888876.initial_effect(c)
	aux.EnableDualAttribute(c)
	--double atk
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_EXTRA_ATTACK)
	e1:SetValue(1)
	e1:SetCondition(aux.IsDualState)
	c:RegisterEffect(e1)
end
