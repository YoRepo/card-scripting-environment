--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Light Effigy  (ID: 54766667)
-- Type: Monster / Effect
-- Attribute: LIGHT
-- Race: Fairy
-- Level: 4
-- ATK 1500 | DEF 0
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you Tribute Summon a LIGHT Normal Monster, you can treat this 1 monster as 2 Tributes.
--[[ __CARD_HEADER_END__ ]]

--ホーリーフレーム
function c54766667.initial_effect(c)
	--double tribute
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_DOUBLE_TRIBUTE)
	e1:SetValue(c54766667.condition)
	c:RegisterEffect(e1)
end
function c54766667.condition(e,c)
	return c:IsAttribute(ATTRIBUTE_LIGHT) and c:IsType(TYPE_NORMAL)
end
