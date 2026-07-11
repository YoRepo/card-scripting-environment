--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:47
-- Source DB: cards.cdb
-- Card: Brotherhood of the Fire Fist - Coyote  (ID: 49785720)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Beast-Warrior
-- Level: 5
-- ATK 2000 | DEF 500
-- Setcode: 0x79
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a "Fire Formation" Spell/Trap, and no monsters, you can Special Summon this card
-- (from your hand).
--[[ __CARD_HEADER_END__ ]]

--機炎星－ゴヨウテ
function c49785720.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c49785720.spcon)
	c:RegisterEffect(e1)
end
function c49785720.filter(c)
	return c:IsFaceup() and c:IsSetCard(0x7c) and c:IsType(TYPE_SPELL+TYPE_TRAP)
end
function c49785720.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)==0
		and Duel.IsExistingMatchingCard(c49785720.filter,tp,LOCATION_SZONE,0,1,nil)
end
