--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:42
-- Source DB: cards.cdb
-- Card: Doggy Diver  (ID: 1003028)
-- Type: Monster / Effect
-- Attribute: DARK
-- Race: Warrior
-- Level: 4
-- ATK 1000 | DEF 1000
-- Scope: OCG / TCG
--
-- Effect Text:
-- If your opponent controls a monster and all face-up monsters you control (min. 1) are Level 4, you
-- can Special Summon this card (from your hand).
-- You can only Special Summon "Doggy Diver" once per turn this way.
-- This card cannot be used as an Xyz Material for an Xyz Summon, except for the Xyz Summon of a
-- Warrior-Type monster.
--[[ __CARD_HEADER_END__ ]]

--トラブル・ダイバー
function c1003028.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,1003028+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c1003028.spcon)
	c:RegisterEffect(e1)
	--xyzlimit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_CANNOT_BE_XYZ_MATERIAL)
	e2:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e2:SetValue(c1003028.xyzlimit)
	c:RegisterEffect(e2)
end
function c1003028.cfilter(c)
	return c:IsFaceup() and not c:IsLevel(4)
end
function c1003028.spcon(e,c)
	if c==nil then return true end
	local tp=c:GetControler()
	return Duel.GetLocationCount(tp,LOCATION_MZONE)>0
		and Duel.GetFieldGroupCount(tp,LOCATION_MZONE,0)>0
		and Duel.GetFieldGroupCount(tp,0,LOCATION_MZONE)>0
		and not Duel.IsExistingMatchingCard(c1003028.cfilter,tp,LOCATION_MZONE,0,1,nil)
end
function c1003028.xyzlimit(e,c)
	if not c then return false end
	return not c:IsRace(RACE_WARRIOR)
end
