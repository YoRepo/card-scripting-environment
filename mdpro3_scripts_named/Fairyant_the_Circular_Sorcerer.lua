--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:49
-- Source DB: cards.cdb
-- Card: Fairyant the Circular Sorcerer  (ID: 53416326)
-- Type: Monster / Effect / Tuner
-- Attribute: WIND
-- Race: Insect
-- Level: 3
-- ATK 800 | DEF 1500
-- Scope: OCG / TCG
--
-- Effect Text:
-- If an Insect or Plant monster is in either GY, you can Special Summon this card (from your hand).
-- You can only Special Summon "Fairyant the Circular Sorcerer" once per turn this way.
-- If this card you control would be used as Synchro Material for an Insect or Plant monster, you can
-- treat it as a non-Tuner.
--[[ __CARD_HEADER_END__ ]]

--円喚師フェアリ
function c53416326.initial_effect(c)
	--special summon
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD)
	e1:SetCode(EFFECT_SPSUMMON_PROC)
	e1:SetProperty(EFFECT_FLAG_UNCOPYABLE)
	e1:SetRange(LOCATION_HAND)
	e1:SetCountLimit(1,53416326+EFFECT_COUNT_CODE_OATH)
	e1:SetCondition(c53416326.spcon)
	c:RegisterEffect(e1)
	--nontuner
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetCode(EFFECT_NONTUNER)
	e2:SetValue(c53416326.tnval)
	c:RegisterEffect(e2)
end
function c53416326.filter(c)
	return c:IsRace(RACE_PLANT+RACE_INSECT)
end
function c53416326.spcon(e,c)
	if c==nil then return true end
	return Duel.GetLocationCount(c:GetControler(),LOCATION_MZONE)>0
		and Duel.IsExistingMatchingCard(c53416326.filter,0,LOCATION_GRAVE,LOCATION_GRAVE,1,nil)
end
function c53416326.tnval(e,c)
	return e:GetHandler():IsControler(c:GetControler()) and c:IsRace(RACE_PLANT+RACE_INSECT)
end
