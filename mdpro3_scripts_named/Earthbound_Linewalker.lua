--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-06-20T18:14:32
-- Card: 地缚大神官  (ID: 67987302)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Fiend
-- Level 4
-- ATK 1200 | DEF 1900
-- Setcode: 33
--
-- Effect Text:
-- ①：只要这张卡在怪兽区域存在，「地缚神」怪兽不会被自身的效果破坏。
--[[ __CARD_HEADER_END__ ]]

--地縛大神官
function c67987302.initial_effect(c)
	--indes
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_INDESTRUCTABLE_EFFECT)
	e1:SetRange(LOCATION_MZONE)
	e1:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e1:SetTarget(aux.TargetBoolFunction(Card.IsSetCard,0x1021))
	e1:SetValue(c67987302.efilter)
	c:RegisterEffect(e1)
end
function c67987302.efilter(e,re,rp,c)
	return re:GetOwner()==c
end
