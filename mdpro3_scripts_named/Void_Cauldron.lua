--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:46
-- Source DB: cards.cdb
-- Card: Void Cauldron  (ID: 45313724)
-- Type: Trap / Continuous
-- Setcode: 0xc5
-- Scope: OCG / TCG
--
-- Effect Text:
-- This card is sent to the GY if you have any cards in your hand.
-- If an "Infernity" monster(s) and/or a Level 8 DARK Dragon Synchro Monster(s) you control would be
-- destroyed by your opponent's card effect, you can banish 1 "Infernity" card from your GY instead.
--[[ __CARD_HEADER_END__ ]]

--煉獄の釜
function c45313724.initial_effect(c)
	Duel.EnableGlobalFlag(GLOBALFLAG_SELF_TOGRAVE)
	--activate
	local e0=Effect.CreateEffect(c)
	e0:SetType(EFFECT_TYPE_ACTIVATE)
	e0:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e0)
	--destroy replace
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_DESTROY_REPLACE)
	e1:SetRange(LOCATION_SZONE)
	e1:SetTarget(c45313724.desreptg)
	e1:SetValue(c45313724.desrepval)
	c:RegisterEffect(e1)
	--to grave
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_SINGLE)
	e2:SetCode(EFFECT_SELF_TOGRAVE)
	e2:SetProperty(EFFECT_FLAG_SINGLE_RANGE)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCondition(c45313724.sdcon)
	c:RegisterEffect(e2)
end
function c45313724.repfilter(c,tp)
	return c:IsFaceup() and c:IsControler(tp) and c:IsLocation(LOCATION_MZONE)
		and (c:IsSetCard(0xb) or c:IsRace(RACE_DRAGON) and c:IsAttribute(ATTRIBUTE_DARK) and c:IsLevel(8) and c:IsType(TYPE_SYNCHRO))
		and c:IsReason(REASON_EFFECT) and not c:IsReason(REASON_REPLACE) and c:GetReasonPlayer()==1-tp
end
function c45313724.desfilter(c)
	return c:IsSetCard(0xb) and c:IsAbleToRemove()
end
function c45313724.desreptg(e,tp,eg,ep,ev,re,r,rp,chk)
	local c=e:GetHandler()
	if chk==0 then return eg:IsExists(c45313724.repfilter,1,nil,tp)
		and Duel.IsExistingMatchingCard(c45313724.desfilter,tp,LOCATION_GRAVE,0,1,nil) end
	if Duel.SelectEffectYesNo(tp,c,96) then
		Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_DESREPLACE)
		local g=Duel.SelectMatchingCard(tp,c45313724.desfilter,tp,LOCATION_GRAVE,0,1,1,nil)
		Duel.Remove(g,POS_FACEUP,REASON_EFFECT+REASON_REPLACE)
		return true
	else return false end
end
function c45313724.desrepval(e,c)
	return c45313724.repfilter(c,e:GetHandlerPlayer())
end
function c45313724.sdcon(e)
	return Duel.GetFieldGroupCount(e:GetHandlerPlayer(),LOCATION_HAND,0)~=0
end
