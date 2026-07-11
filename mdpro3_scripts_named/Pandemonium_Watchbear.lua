--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Pandemonium Watchbear  (ID: 75375465)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Beast
-- Level: 4
-- ATK 1300 | DEF 1800
-- Scope: OCG / TCG
--
-- Effect Text:
-- As long as this card remains face-up on your side of the field, "Pandemonium" on your side of the
-- field is not destroyed by your opponent's card effects.
--[[ __CARD_HEADER_END__ ]]

--地獄の番熊
function c75375465.initial_effect(c)
	aux.AddCodeList(c,94585852)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_ONFIELD,0)
	e1:SetTarget(c75375465.indtg)
	e1:SetValue(c75375465.indval)
	c:RegisterEffect(e1)
end
function c75375465.indtg(e,c)
	return c:IsFaceup() and c:IsCode(94585852)
end
function c75375465.indval(e,re,tp)
	return e:GetHandler():GetControler()~=tp
end
