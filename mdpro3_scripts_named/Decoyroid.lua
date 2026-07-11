--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:44
-- Source DB: cards.cdb
-- Card: Decoyroid  (ID: 25034083)
-- Type: Monster / Effect
-- Attribute: WIND
-- Race: Machine
-- Level: 2
-- ATK 300 | DEF 500
-- Setcode: 0x16
-- Scope: OCG / TCG
--
-- Effect Text:
-- While this card is face-up on your side of the field, your opponent cannot select a face-up monster
-- as an attack target except "Decoyroid".
--[[ __CARD_HEADER_END__ ]]

--デコイロイド
function c25034083.initial_effect(c)
	--cannot be battle target
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(0,LOCATION_MZONE)
	e1:SetCode(EFFECT_CANNOT_SELECT_BATTLE_TARGET)
	e1:SetValue(c25034083.atlimit)
	c:RegisterEffect(e1)
end
function c25034083.atlimit(e,c)
	return not c:IsCode(25034083) and c:IsFaceup()
end
