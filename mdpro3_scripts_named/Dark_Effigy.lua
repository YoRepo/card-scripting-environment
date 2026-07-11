--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Dark Effigy  (ID: 81755371)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level: 4
-- ATK 1500 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you Tribute Summon a DARK Normal Monster, you can treat this 1 monster as 2 Tributes.
--[[ __CARD_HEADER_END__ ]]

--ダークフレーム
function c81755371.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(c81755371.condition)
	c:RegisterEffect(e1)
end
function c81755371.condition(e,c)
	return c:IsAttribute(ATTRIBUTE_DARK) and c:IsType(TYPE_NORMAL)
end
