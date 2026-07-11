--[[ __CARD_HEADER_START__ ]]
-- Generated: 2026-07-12T02:17:51
-- Source DB: cards.cdb
-- Card: Spirit Elimination  (ID: 69832741)
-- Type: Spell
-- Scope: OCG / TCG
--
-- Effect Text:
-- When monsters in the Graveyard are removed from play, remove monsters on your side of the field from
-- play as substitutes.
-- This card remains active until the end of the turn that it is activated.
-- The substitutes remain removed from play.
--[[ __CARD_HEADER_END__ ]]

--霊魂消滅
--not fully implemented
function c69832741.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	e1:SetOperation(c69832741.activate)
	c:RegisterEffect(e1)
end
function c69832741.activate(e,tp,eg,ep,ev,re,r,rp)
	local e1=Effect.CreateEffect(e:GetHandler())
	e1:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_CONTINUOUS)
	e1:SetCode(EFFECT_SEND_REPLACE)
	e1:SetTarget(c69832741.reptg)
	e1:SetValue(c69832741.repval)
	e1:SetReset(RESET_PHASE+PHASE_END)
	Duel.RegisterEffect(e1,tp)
end
function c69832741.repfilter(c)
	return c:IsLocation(LOCATION_GRAVE) and c:GetDestination()==LOCATION_REMOVED and c:IsType(TYPE_MONSTER)
end
function c69832741.reptg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then
		local count=eg:FilterCount(c69832741.repfilter,nil)
		return Duel.IsExistingMatchingCard(Card.IsAbleToRemove,tp,LOCATION_MZONE,0,count,nil)
	end
	local count=eg:FilterCount(c69832741.repfilter,nil)
	Duel.Hint(HINT_SELECTMSG,tp,aux.Stringid(69832741,0))
	local rg=Duel.SelectMatchingCard(tp,Card.IsAbleToRemove,tp,LOCATION_MZONE,0,count,count,nil)
	Duel.Remove(rg,POS_FACEUP,REASON_EFFECT)
	return true
end
function c69832741.repval(e,c)
	return c69832741.repfilter(c)
end
