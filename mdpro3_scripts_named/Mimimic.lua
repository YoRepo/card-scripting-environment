--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Mimimic  (ID: 45651298)
-- Type: Monster / Effect
-- Attribute: EARTH
-- Race: Machine
-- Level: 3
-- ATK 300 | DEF 300
-- Scope: OCG / TCG
--
-- Effect Text:
-- If your opponent controls a monster and you control a Level 3 monster, you can Special Summon this
-- card (from your hand).
-- You can only Special Summon "Mimimic" once per turn this way.
--[[ __CARD_HEADER_END__ ]]

--ミミミック
function c45651298.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,45651298+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c45651298.spcon)
	c:RegisterEffect(e1)
end
function c45651298.filter(c)
	return c:IsFaceup() and c:IsLevel(3)
end
function c45651298.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
		and Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c45651298.filter,tp,LOCATION_MZONE,0,1,nil)
end
