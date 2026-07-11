--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:48
-- Source DB: cards.cdb
-- Card: Jawsman  (ID: 50532786)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Beast-Warrior
-- Level: 6
-- ATK 2600 | DEF 1600
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be Special Summoned.
-- If you Tribute Summon this card, all Tributes must be WATER.
-- This card gains 300 ATK for each face-up WATER monster you control, except this card.
--[[ __CARD_HEADER_END__ ]]

--ジョーズマン
function c50532786.initial_effect(c)
	--cannot special summon
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_SPSUMMON_CONDITION)
	c:RegisterEffect(e1)
	--tribute limit
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_TRIBUTE_LIMIT)
	e2:SetValue(c50532786.tlimit)
	c:RegisterEffect(e2)
	--atkup
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e3:SetRange(LOCATION_MZONE)
	e3:SetCode(EFFECT_UPDATE_ATTACK)
	e3:SetValue(c50532786.atkup)
	c:RegisterEffect(e3)
end
function c50532786.tlimit(e,c)
	return not c:IsAttribute(ATTRIBUTE_WATER)
end
function c50532786.atkfilter(c)
	return c:IsFaceup() and c:IsAttribute(ATTRIBUTE_WATER)
end
function c50532786.atkup(e,c)
	return Duel.GetMatchingGroupCount(c50532786.atkfilter,c:GetControler(),LOCATION_MZONE,0,c)*300
end
