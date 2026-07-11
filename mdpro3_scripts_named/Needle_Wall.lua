--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:45
-- Source DB: cards.cdb
-- Card: Needle Wall  (ID: 38299233)
-- Type: Trap / Continuous
-- Scope: OCG / TCG
--
-- Effect Text:
-- Once per turn, during your Standby Phase: Roll a six-sided die.
-- Treat your opponent's Main Monster Zones as numbers 1-5, counting from your right, and destroy the
-- monster that is in the same Main Monster Zone as the result.
-- If the result is 6, roll again.
--[[ __CARD_HEADER_END__ ]]

--ニードル・ウォール
function c38299233.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetHintTiming(0,TIMING_END_PHASE)
	c:RegisterEffect(e1)
	--roll and destroy
	local e2=Effect.CreateEffect(c)
	e2:SetDescription(aux.Stringid(38299233,0))
	e2:SetCategory(CATEGORY_DICE+CATEGORY_DESTROY)
	e2:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_F)
	e2:SetRange(LOCATION_SZONE)
	e2:SetCountLimit(1)
	e2:SetCode(EVENT_PHASE+PHASE_STANDBY)
	e2:SetCondition(c38299233.rdcon)
	e2:SetTarget(c38299233.rdtg)
	e2:SetOperation(c38299233.rdop)
	c:RegisterEffect(e2)
end
function c38299233.rdcon(e,tp,eg,ep,ev,re,r,rp)
	return tp==Duel.GetTurnPlayer()
end
function c38299233.mzfilter(c)
	return c:GetSequence()<5
end
function c38299233.rdtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return true end
	Duel.SetOperationInfo(0,CATEGORY_DICE,nil,0,tp,1)
	local g=Duel.GetMatchingGroup(c38299233.mzfilter,tp,0,LOCATION_MZONE,nil)
	if #g>=5 then
		Duel.SetOperationInfo(0,CATEGORY_DESTROY,g,1,0,0)
	end
end
function c38299233.rdop(e,tp,eg,ep,ev,re,r,rp)
	local d1=6
	while d1==6 do
		d1=Duel.TossDice(tp,1)
	end
	if d1>5 then return end
	local tc=Duel.GetFieldCard(1-tp,LOCATION_MZONE,d1-1)
	if tc then
		Duel.Destroy(tc,REASON_EFFECT)
	end
end
