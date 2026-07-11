--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:52
-- Source DB: cards.cdb
-- Card: Boost Warrior  (ID: 80457744)
-- Type: Monster / Effect
-- Attribute: FIRE
-- Race: Warrior
-- Level: 1
-- ATK 300 | DEF 200
-- Setcode: 0x66
-- Scope: OCG / TCG
--
-- Effect Text:
-- If you control a Tuner, you can Special Summon this card (from your hand) in Defense Position.
-- All Warrior monsters you control gain 300 ATK.
--[[ __CARD_HEADER_END__ ]]

--ブースト・ウォリアー
function c80457744.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_SPSUM_PARAM)
	e1:SetTargetRange(POS_FACEUP_DEFENSE,0)
	e1:SetRange(LOCATION_HAND)
	e1:SetCondition(c80457744.spcon)
	c:RegisterEffect(e1)
	--atk
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetRange(LOCATION_MZONE)
	e2:SetTargetRange(LOCATION_MZONE,0)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetTarget(aux.TargetBoolFunction(Card.IsRace,RACE_WARRIOR))
	e2:SetValue(300)
	c:RegisterEffect(e2)
end
function c80457744.filter(c)
	return c:IsFaceup() and c:IsType(TYPE_TUNER)
end
function c80457744.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0 and
		Duel.IsExistingMatchingCard(c80457744.filter,c:GetControler(),LOCATION_MZONE,0,1,nil)
end
