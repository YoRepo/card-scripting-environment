--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Ally of Justice Cosmic Gateway  (ID: 8822710)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Machine
-- Level: 8
-- ATK 2400 | DEF 1200
-- Setcode: 0x1
-- Scope: OCG / TCG
--
-- Effect Text:
-- If your opponent controls 2 or more monsters including a LIGHT monster, you can Special Summon this
-- card (from your hand).
--[[ __CARD_HEADER_END__ ]]

--A・O・J コズミック・クローザー
function c8822710.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c8822710.spcon)
	c:RegisterEffect(e1)
end
function c8822710.spfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_LIGHT)
end
function c8822710.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(c:GetControler(),0,LOCATION_MZONE)>1
		and	Duel.IsExistingMatchingCard(c8822710.spfilter,c:GetControler(),0,LOCATION_MZONE,1,nil)
end
