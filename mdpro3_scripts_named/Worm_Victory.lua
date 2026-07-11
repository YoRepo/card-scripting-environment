--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:43
-- Source DB: cards.cdb
-- Card: Worm Victory  (ID: 2088870)
-- Type: Monster / Effect / Flip
-- Attribute: LIGHT
-- Race: Reptile
-- Level: 7
-- ATK 0 | DEF 2500
-- Setcode: 0x3e
-- Scope: OCG / TCG
--
-- Effect Text:
-- FLIP: Destroy all face-up monsters on the field, except Reptile-Type "Worm" monsters.
-- This card gains 500 ATK for each Reptile-Type "Worm" monster in your Graveyard.
--[[ __CARD_HEADER_END__ ]]

--ワーム・ヴィクトリー
function c2088870.initial_effect(c)
	--flip
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FLIP+EFFECT_TYPE_SINGLE)
	e1:SetCategory(CATEGORY_DESTROY)
	e1:SetTarget(c2088870.destg)
	e1:SetOperation(c2088870.desop)
	c:RegisterEffect(e1)
	--atkup
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_MZONE)
	e2:SetValue(c2088870.atkval)
	c:RegisterEffect(e2)
end
function c2088870.filter(c)
	return c:IsFaceup() and not (c:IsSetCard(0x3e) and c:IsRace(RACE_REPTILE))
end
function c2088870.destg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	local g=Duel.GetMatchingGroup(c2088870.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,g:GetCount(),0,0)
end
function c2088870.desop(e,tp,eg,ep,ev,re,r,rp)
	local g=Duel.GetMatchingGroup(c2088870.filter,tp,LOCATION_MZONE,LOCATION_MZONE,nil)
	Duel.Destroy(g,REASON_EFFECT)
end
function c2088870.vfilter(c)
	return c:IsSetCard(0x3e) and c:IsRace(RACE_REPTILE)
end
function c2088870.atkval(e,c)
	return Duel.GetMatchingGroupCount(c2088870.vfilter,c:GetControler(),LOCATION_GRAVE,0,nil)*500
end
