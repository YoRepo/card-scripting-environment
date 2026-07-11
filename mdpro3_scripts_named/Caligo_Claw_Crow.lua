--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Caligo Claw Crow  (ID: 67692580)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Winged Beast
-- Level: 2
-- ATK 900 | DEF 600
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a DARK monster, you can Special Summon this card (from your hand).
-- You can only Special Summon "Caligo Claw Crow" once per turn this way.
--[[ __CARD_HEADER_END__ ]]

--クロクロークロウ
function c67692580.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,67692580+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c67692580.spcon)
	c:RegisterEffect(e1)
end
function c67692580.filter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_DARK)
end
function c67692580.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c67692580.filter,tp,LOCATION_MZONE,0,1,nil)
end
