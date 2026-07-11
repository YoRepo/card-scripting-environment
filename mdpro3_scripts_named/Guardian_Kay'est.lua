--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:53
-- Source DB: cards.cdb
-- Card: Guardian Kay'est  (ID: 9633505)
-- Type: Monster / Effect
-- Attribute: WATER
-- Race: Sea Serpent
-- Level: 4
-- ATK 1000 | DEF 1800
-- Setcode: 0x52
-- Scope: OCG / TCG
--
-- Effect Text:
-- Cannot be Summoned unless you control a face-up "Rod of Silence - Kay'est".
-- This card is unaffected by Spell effects and cannot be targeted for attacks, but does not prevent
-- your opponent from attacking you directly.
--[[ __CARD_HEADER_END__ ]]

--ガーディアン・ケースト
function c9633505.initial_effect(c)
	--sum limit
	local e1=Effect.CreateEffect(c)
	e1:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e1:SetType(EFFECT_TYPE_SINGLE)
	e1:SetCode(EFFECT_CANNOT_SUMMON)
	e1:SetCondition(c9633505.sumcon)
	c:RegisterEffect(e1)
	local e2=e1:Clone()
	e2:SetCode(EFFECT_CANNOT_FLIP_SUMMON)
	c:RegisterEffect(e2)
	local e3=Effect.CreateEffect(c)
	e3:SetType(EFFECT_TYPE_SINGLE)
	e3:SetProperty(EFFECT_FLAG_CANNOT_DISABLE+EFFECT_FLAG_UNCOPYABLE)
	e3:SetCode(EFFECT_SPSUMMON_CONDITION)
	e3:SetValue(c9633505.sumlimit)
	c:RegisterEffect(e3)
	--immune spell
	local e4=Effect.CreateEffect(c)
	e4:SetType(EFFECT_TYPE_SINGLE)
	e4:SetCode(EFFECT_IMMUNE_EFFECT)
	e4:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e4:SetRange(LOCATION_MZONE)
	e4:SetValue(c9633505.efilter)
	c:RegisterEffect(e4)
	--atk
	local e5=Effect.CreateEffect(c)
	e5:SetType(EFFECT_TYPE_SINGLE)
	e5:SetCode(EFFECT_IGNORE_BATTLE_TARGET)
	e5:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e5:SetRange(LOCATION_MZONE)
	e5:SetValue(1)
	c:RegisterEffect(e5)
end
function c9633505.cfilter(c)
	return c:IsFaceup() and c:IsCode(95515060)
end
function c9633505.sumcon(e)
	return not Duel.IsExistingMatchingCard(c9633505.cfilter,e:GetHandlerPlayer(),LOCATION_ONFIELD,0,1,nil)
end
function c9633505.sumlimit(e,se,sp,st,pos,tp)
	return Duel.IsExistingMatchingCard(c9633505.cfilter,sp,LOCATION_ONFIELD,0,1,nil)
end
function c9633505.efilter(e,te)
	return te:IsActiveType(TYPE_SPELL)
end
